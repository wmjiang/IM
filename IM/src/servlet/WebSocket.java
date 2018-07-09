package servlet;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import dao.FriendDao;
import dao.FriendGroupDao;
import dao.GroupItemDao;
import dao.MessageDao;
import dao.UserDao;
import entity.GroupItem;
import entity.Message;
import entity.User;


@ServerEndpoint(value="/chatserver/{sid}")
public class WebSocket{
	Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
	//用ConcurrentHashMap记录每个登录的用户
	private static ConcurrentHashMap<Integer, WebSocket> wsMap=new ConcurrentHashMap<Integer, WebSocket>();
	// 与某个客户端的连接会话，需要通过它来给客户端发送数据
	private Session session;
	private int id;
	@OnOpen
	public void onOpen(@PathParam("sid") String sid, Session session) throws IOException{
		this.session=session;
		Integer id=Integer.parseInt(sid);
		this.id=id;
		//如果已经登录，则踢以前的同名用户下线
		if(wsMap.containsKey(id)) {
			WebSocket old=wsMap.get(id);
			//关闭旧的websocket session
			old.session.close();
		}
		
		//map存放当前用户的id 和 WebSocket对象
		wsMap.put(id,this);
	
	}
	
	@OnClose  
    public void onClose(Session session){  
		UserDao dao=new UserDao();
		dao.updateState(id, 7);
		dao.updateLastMsgTime(id);
    }  
  
    @OnMessage  
    public void onMessage(String str) throws IOException {  
    	//消息存入数据库
    	Message message=gson.fromJson(str,Message.class);
    	switch (message.getType()) {
		case 0://发给好友
			//判断好友是否在线
			int reciverid=message.getReciverid();
			boolean status=false;
			if(wsMap.containsKey(reciverid)) {
				//好友在线 ,消息状态已读 status=ture;
				status=true;
			}
			//从数据库中获取更新的message
			message=saveFriendMesage(message,status);
			//消息回显 type=2;
	    	message.setType(2);
	    	session.getBasicRemote().sendText(gson.toJson(message));
			if(wsMap.containsKey(reciverid)) {
				//好友在线 ,发送消息给该好友
				message.setType(0);
				wsMap.get(reciverid).session.getBasicRemote().sendText(gson.toJson(message));
			}
			break;
		case 3:
			/**
			 * 加好友消息
			 * 判断好友是否在线
			 * status
			 * 0 发送申请对方未接收；
			 * 1发送申请对方已接收；
			 */
			int reciverid1=message.getReciverid();
			boolean status1=false;
			if(wsMap.containsKey(reciverid1)) {
				//好友在线 ,申请消息状态已读 status=true;
				status1=true;
			}
			//从数据库中获取更新的message
			message=saveApplyFriendMesage(message,status1);
			if(wsMap.containsKey(reciverid1)) {
				//好友在线 ,发送申请消息给该好友
				wsMap.get(reciverid1).session.getBasicRemote().sendText(gson.toJson(message));
			}
			break;
		case 4:
			//加好友对方同意消息
			int friendid=message.getReciverid();
			//添加对方好友
			User user=new UserDao().findUserInfo(friendid);
			new FriendDao().insertFriend(message.getSenderid(),friendid,user.getNickname(),message.getTypeid());
	    	
			if(wsMap.containsKey(message.getSenderid())) {
				//好友在线 ,发送申请消息给该好友
				wsMap.get(message.getSenderid()).session.getBasicRemote().sendText(gson.toJson(message));
			}
			break;
			
		case 5:
			/**
			 * 申请入群消息
			 * 判断群主是否在线
			 * status
			 * 0 发送申请对方未接收；
			 * 1发送申请对方已接收；
			 */
			int reciverid2=message.getReciverid();
			boolean status2=false;
			if(wsMap.containsKey(reciverid2)) {
				//群主在线 ,申请消息状态已读 status=1;
				status2=true;
			}
			//从数据库中获取更新的message
			message=saveJoinGroupMesage(message,status2);
			if(wsMap.containsKey(reciverid2)) {
				//群主在线 ,发送申请消息给群主
				wsMap.get(reciverid2).session.getBasicRemote().sendText(gson.toJson(message));
			}
			break;
		case 6:
			//申请入群群主同意消息
			if(wsMap.containsKey(message.getSenderid())) {
				//申请者在线 ,发送申请同意消息给申请者
				wsMap.get(message.getSenderid()).session.getBasicRemote().sendText(gson.toJson(message));
			}
			break;
			
		default://发给群
			message=saveGroupMesage(message);
			List<Integer> arr= findGroupOnlineFriend(message.getReciverid());
			message.setType(1);
			for(Integer key:arr) {
				wsMap.get(key).session.getBasicRemote().sendText(gson.toJson(message));
			}
			break;
		}	
    }  
 
	@OnError  
    public void onError(Session session, Throwable error) {  
        error.printStackTrace();  
    }  
  
	private Message saveGroupMesage(Message message) {
		
		return new MessageDao().insertGroupMsg(message);
	}
   
    private Message saveFriendMesage(Message message, boolean status) {
    	return new MessageDao().insertFriendMsg(message,status);
	}
    
    private List<Integer> findGroupOnlineFriend(int groupid) {
		return new FriendGroupDao().findGroupOnlineFriend(groupid);
	}
    private Message saveApplyFriendMesage(Message message, Boolean status) {
    	return new MessageDao().insertApplyFriendMsg(message,status);
	}
    private Message saveJoinGroupMesage(Message message, boolean status) {
    	return new MessageDao().insertJoinGroupMsg(message,status);
	}
}
