package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import dao.FriendDao;
import dao.FriendGroupDao;
import dao.GroupItemDao;
import dao.MessageDao;
import dao.UserDao;
import entity.Friend;
import entity.FriendGroup;
import entity.GroupItem;
import entity.Message;
import entity.RecentItem;
import entity.User;

@WebServlet("/login")
// 登陆
public class Login extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String sid = request.getParameter("id");
		int id = 0;
		if (sid != null)
			id = Integer.parseInt(sid);
		String password = request.getParameter("password");
		UserDao userDao = new UserDao();
		User user = userDao.findById(id, password);
		if (user != null) {
			user.setPassword("");
			request.setAttribute("user", user);
			String userJson = gson.toJson(user);
			request.setAttribute("userJson", userJson);
			changeState(id, 1);
			/*
			 * 登录时拉取 离线消息(私聊消息，群聊消息)、好友列表、分组列表、群列表 其中 好友详情，群详情，群友列表，群友详情按需拉取 好友状态变更采用实时推送
			 * 
			 */

			// 离线消息(私聊消息)
			List<Message> offlineMsgList = getOfflineMsg(id);
			Map<Integer, RecentItem> recentItemFriendMap = new HashMap<Integer, RecentItem>();
			Map<Integer, RecentItem> recentItemGroupMap = new HashMap<Integer, RecentItem>();
			for (Message message : offlineMsgList) {
				int senderid = message.getSenderid();
				// recentItemMap 是否包含发送人id
				if (recentItemFriendMap.containsKey(senderid)) {
					RecentItem item = recentItemFriendMap.get(senderid);
					item.getMessageList().add(message);
					item.setCount(item.getCount() + 1);
					if (item.getLastTime().before(message.getTime())) {
						item.setLastTime(message.getTime());
						item.setLastMsgContent(message.getContent());
					}
				} else {
					RecentItem item = new RecentItem(0, senderid, 1, message.getTime(), message.getContent());
					item.getMessageList().add(message);
					recentItemFriendMap.put(senderid, item);
				}
			}
			// 更新离线消息状态
			updateMsgStatus(id);

			// 拉取离线加好友消息
			List<Message> offlineApplyMsgList = getOfflineApplyMsg(id);
			request.setAttribute("offlineApplyMsgList", offlineApplyMsgList);
			// 更新离线加好友消息状态
			updateApplyMsgStatus(id);

			// 拉取离线加群消息
			List<Message> offlineJoinMsgList = getOfflineJoinMsg(id);
			request.setAttribute("offlineJoinMsgList", offlineJoinMsgList);
			// 更新离线加群消息状态
			updateJoinMsgStatus(id);

			// 离线消息(群聊消息)
			List<Message> offlineGroupMsgList = getOfflineGroupMsg(id);
			for (Message message : offlineGroupMsgList) {
				int senderid = message.getReciverid();
				// recentItemMap 是否包含发送人id
				if (recentItemGroupMap.containsKey(senderid)) {
					RecentItem item = recentItemGroupMap.get(senderid);
					item.getMessageList().add(message);
					item.setCount(item.getCount() + 1);
					if (item.getLastTime().before(message.getTime())) {
						item.setLastTime(message.getTime());
						item.setLastMsgContent(message.getContent());
					}
				} else {
					RecentItem item = new RecentItem(1, senderid, 1, message.getTime(), message.getContent());
					item.getMessageList().add(message);
					recentItemGroupMap.put(senderid, item);
				}
			}
			List<RecentItem> recentItemList = new ArrayList<RecentItem>();
			for (RecentItem recentItem : recentItemFriendMap.values()) {
				recentItemList.add(recentItem);
			}
			for (RecentItem recentItem : recentItemGroupMap.values()) {
				recentItemList.add(recentItem);
			}
			String recentItemFriendMapJson = gson.toJson(recentItemFriendMap);
			request.setAttribute("recentItemFriendMapJson", recentItemFriendMapJson);
			String recentItemGroupMapJson = gson.toJson(recentItemGroupMap);
			request.setAttribute("recentItemGroupMapJson", recentItemGroupMapJson);
			Collections.sort(recentItemList);
			request.setAttribute("recentItemList", recentItemList);

			// 好友列表
			Map<Integer, Friend> friendsMap = getFriends(id);
			request.setAttribute("friendsMap", friendsMap);
			String friendsMapJson = gson.toJson(friendsMap);
			request.setAttribute("friendsMapJson", friendsMapJson);
			// 分组列表
			List<FriendGroup> friendsGroupList = getFriendGroups(id);
			for (FriendGroup FriendGroup : friendsGroupList) {
				int onlineCount = 0;
				for (Friend friend : friendsMap.values()) {
					if (FriendGroup.getFgid() == friend.getFgid()) {
						FriendGroup.getFriendList().add(friend);
						if (friend.getStateid() == 1) {
							onlineCount++;
						}
					}
				}
				FriendGroup.setOnlineCount(onlineCount);
			}
			request.setAttribute("friendsGroupList", friendsGroupList);
			// 群列表
			Map<Integer, GroupItem> groupItemMap = getGroupItems(id);
			String groupItemMapJson = gson.toJson(groupItemMap);
			request.setAttribute("groupItemMapJson", groupItemMapJson);
			request.setAttribute("groupItemMap", groupItemMap);
			request.getRequestDispatcher("chat.jsp").forward(request, response);
		} else {
			request.setAttribute("msg", "1");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}

	// 离线消息(私聊消息)
	private List<Message> getOfflineMsg(int id) {
		return new MessageDao().findOfflineMsg(id);
	}

	// 离线消息(群聊消息)
	private List<Message> getOfflineGroupMsg(int id) {
		return new MessageDao().findOfflineGroupMsg(id);
	}

	// 离线消息(加好友消息)
	private List<Message> getOfflineApplyMsg(int id) {
		return new MessageDao().findOfflineApplyMsg(id);
	}

	// 离线消息(加群消息)
	private List<Message> getOfflineJoinMsg(int id) {
		return new MessageDao().findOfflineJoinMsg(id);
	}

	// 好友列表
	private Map<Integer, Friend> getFriends(int id) {
		return new FriendDao().findFriends(id);
	}

	// 分组列表
	private List<FriendGroup> getFriendGroups(int id) {
		return new FriendGroupDao().findFriendGroups(id);
	}

	// 群列表
	private Map<Integer, GroupItem> getGroupItems(int id) {
		return new GroupItemDao().findGroupItems(id);
	}
	//更新用户状态
	private void changeState(int id, int i) {
		new UserDao().updateState(id, i);
	}

	// 更新离线消息状态
	private void updateMsgStatus(int id) {
		new MessageDao().updateMsgStatus(id);
	}

	// 更新离线加好友消息状态
	private void updateApplyMsgStatus(int id) {
		new MessageDao().updateApplyMsgStatus(id);
	}
	// 更新离线加群消息状态
	private void updateJoinMsgStatus(int id) {
		new MessageDao().updateJoinMsgStatus(id);
	}
}
