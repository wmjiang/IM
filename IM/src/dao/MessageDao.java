package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import entity.Message;
import utils.DBHelper;

public class MessageDao {

	public List<Message> findOfflineMsg(int id) {
		List<Message> offlineMsgList = new ArrayList<Message>();
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		Statement st = null;
		try {
			st = con.createStatement();
			// 先查询 私聊离线 记录 reviverid=id and status=0;
			String sql = "select * from msg where reciverid='" + id + "' and status=0 order by time;";
			rs = st.executeQuery(sql);
			while (rs.next()) {
				Message message = new Message();
				message.setMsgid(rs.getInt(1));
				message.setContent(rs.getString(2));
				message.setTime(rs.getTimestamp(4));
				message.setTypeid(rs.getInt(5));
				message.setSenderid(rs.getInt(6));
				message.setReciverid(rs.getInt(7));
				message.setType(0);
				offlineMsgList.add(message);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
		return offlineMsgList;
	}

	public List<Message> findOfflineGroupMsg(int id) {
		List<Message> offlineMsgGroupList = new ArrayList<Message>();
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		Statement st = null;
		try {
			st = con.createStatement();
			// 在查询群离线消息 根据 useid=id 查 group_user表 有哪些群
			// 根据groupid 查 group_msg time>last_msgtime的记录
			String sql = "select msgid,content,time,type,senderid,group_user.groupid from group_user ,group_msg where group_user.userid="
					+ id
					+ " and group_user.groupid=group_msg.groupid and group_user.last_msgtime<group_msg.time order by time";
			rs = st.executeQuery(sql);
			while (rs.next()) {
				Message message = new Message();
				message.setMsgid(rs.getInt(1));
				message.setContent(rs.getString(2));
				message.setTime(rs.getTimestamp(3));
				message.setTypeid(rs.getInt(4));
				message.setSenderid(rs.getInt(5));
				message.setReciverid(rs.getInt(6));
				message.setType(1);
				offlineMsgGroupList.add(message);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
		return offlineMsgGroupList;
	}

	public Message insertGroupMsg(Message msg) {
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		PreparedStatement st = null;
		Message message = new Message();
		try {
			String sql = "insert into group_msg (groupid,senderid,time,content,type) values(?,?,?,?,?)";
			st = con.prepareStatement(sql);
			st.setInt(1, msg.getReciverid());
			st.setInt(2, msg.getSenderid());
			st.setTimestamp(3, new Timestamp(new Date().getTime()));
			st.setString(4, msg.getContent());
			st.setInt(5, msg.getTypeid());
			st.execute();
			st.close();
			sql = "select last_insert_id()";
			st = con.prepareStatement(sql);
			rs = st.executeQuery(sql);
			int msgid = 0;
			while (rs.next()) {
				msgid = rs.getInt(1);
			}
			rs.close();
			st.close();
			sql = "select * from group_msg where msgid= ? ";
			st = con.prepareStatement(sql);
			st.setInt(1, msgid);
			rs = st.executeQuery();
			while (rs.next()) {
				message.setMsgid(rs.getInt(1));
				message.setReciverid(rs.getInt(2));
				message.setSenderid(rs.getInt(3));
				message.setTime(rs.getTimestamp(4));
				message.setContent(rs.getString(5));
				message.setTypeid(rs.getInt(6));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
		return message;
	}

	public Message insertFriendMsg(Message msg, boolean status) {
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		PreparedStatement st = null;
		Message message = new Message();
		try {

			String sql = "insert into msg (content,status,time,typeid,senderid,reciverid) values(?,?,?,?,?,?)";
			st = con.prepareStatement(sql);
			st.setString(1, msg.getContent());
			st.setBoolean(2, status);
			st.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
			st.setInt(4, msg.getTypeid());
			st.setInt(5, msg.getSenderid());
			st.setInt(6, msg.getReciverid());
			st.execute();
			st.close();
			sql = "select last_insert_id()";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			int msgid = 0;
			while (rs.next()) {
				msgid = rs.getInt(1);
			}
			rs.close();
			st.close();
			sql = "select * from msg where msgid=?";
			st = con.prepareStatement(sql);
			st.setInt(1, msgid);
			rs = st.executeQuery();
			while (rs.next()) {
				message.setMsgid(rs.getInt(1));
				message.setContent(rs.getString(2));
				message.setStatus(rs.getBoolean(3));
				message.setTime(rs.getTimestamp(4));
				message.setTypeid(rs.getInt(5));
				message.setSenderid(rs.getInt(6));
				message.setReciverid(rs.getInt(7));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
		return message;
	}

	// 更新消息状态
	public void updateMsgStatus(int id) {
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		Statement st = null;
		try {
			st = con.createStatement();
			String sql = "update msg set  status=1 where reciverid=" + id;
			st.execute(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
	}

	public Message insertApplyFriendMsg(Message msg, boolean status) {
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		PreparedStatement st = null;
		try {

			String sql = "insert into apply_friend (senderid,reciverid,content,fgid,status) values(?,?,?,?,?)";
			st = con.prepareStatement(sql);
			st.setInt(1, msg.getSenderid());
			st.setInt(2, msg.getReciverid());
			st.setString(3, msg.getContent());
			st.setInt(4, msg.getTypeid());
			st.setBoolean(5, status);
			st.execute();
			st.close();
			sql = "select last_insert_id()";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			int msgid = 0;
			while (rs.next()) {
				msgid = rs.getInt(1);
			}
			msg.setMsgid(msgid);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
		return msg;
	}


	public List<Message> findOfflineApplyMsg(int id) {
		List<Message> offlineApplyMsgList = new ArrayList<Message>();
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		Statement st = null;
		try {
			st = con.createStatement();
			// 先查询 私聊离线 记录 reviverid=id and status=0;
			String sql = "select * from apply_friend where reciverid=" + id + " and status=0";
			rs = st.executeQuery(sql);
			while (rs.next()) {
				Message message = new Message();
				message.setMsgid(rs.getInt(1));
				message.setSenderid(rs.getInt(2));
				message.setReciverid(rs.getInt(3));
				message.setContent(rs.getString(4));
				message.setTypeid(rs.getInt(5));
				offlineApplyMsgList.add(message);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
		return offlineApplyMsgList;
	}

	public void updateApplyMsgStatus(int id) {
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		Statement st = null;
		try {
			st = con.createStatement();
			String sql = "update apply_friend set  status=1 where reciverid=" + id + " and status=0 ";
			st.execute(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
	}

	public Message insertJoinGroupMsg(Message msg, boolean status) {
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		PreparedStatement st = null;
		try {

			String sql = "insert into join_group (senderid,reciverid,groupid,content,status) values(?,?,?,?,?)";
			st = con.prepareStatement(sql);
			st.setInt(1, msg.getSenderid());
			st.setInt(2, msg.getReciverid());
			st.setInt(3, msg.getTypeid());
			st.setString(4, msg.getContent());	
			st.setBoolean(5, status);
			st.execute();
			st.close();
			sql = "select last_insert_id()";
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			int msgid = 0;
			while (rs.next()) {
				msgid = rs.getInt(1);
			}
			msg.setMsgid(msgid);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
		return msg;
	}

	

	public List<Message> findOfflineJoinMsg(int id) {
		List<Message> offlineJoinMsgList = new ArrayList<Message>();
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		Statement st = null;
		try {
			st = con.createStatement();
			// 先查询 私聊离线 记录 reviverid=id and status=0;
			String sql = "select * from join_group where reciverid=" + id + " and status=0";
			rs = st.executeQuery(sql);
			while (rs.next()) {
				Message message = new Message();
				message.setMsgid(rs.getInt(1));
				message.setSenderid(rs.getInt(2));
				message.setReciverid(rs.getInt(3));
				message.setTypeid(rs.getInt(4));
				message.setContent(rs.getString(5));
				offlineJoinMsgList.add(message);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
		return offlineJoinMsgList;
	}
	
	public void updateJoinMsgStatus(int id) {
		Connection con = DBHelper.getConnection();
		ResultSet rs = null;
		Statement st = null;
		try {
			st = con.createStatement();
			String sql = "update join_group set  status=1 where reciverid=" + id + " and status=0 ";
			st.execute(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBHelper.release(con, st, rs);
		}
	}
}
