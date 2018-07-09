package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import entity.Friend;
import utils.DBHelper;

public class FriendDao {

	public Map<Integer, Friend> findFriends(int id) {
		Map<Integer, Friend> friendsMap=new HashMap<Integer,Friend>();
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="select id,friends.name,fgid,headportrait,signature,stateid from friends,user where myid="+id+" and friendid=id";
		    rs=st.executeQuery(sql);
			while(rs.next()) {
			    int friendid=rs.getInt(1);
				String nickname=rs.getString(2);
				int fgid=rs.getInt(3);
				String headportrait=rs.getString(4);
				String signature=rs.getString(5);
				int stateid=rs.getInt(6);
				friendsMap.put(friendid,new Friend(friendid, stateid, fgid, nickname, headportrait, signature));				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return friendsMap;
	}

	public void insertFriend(int myid, int friendid, String name, int fgid) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		PreparedStatement st=null;
		try {
			String sql="insert into friends values(?,?,?,?)";
		    st=con.prepareStatement(sql);
			st.setInt(1, myid);
			st.setInt(2, friendid);
			st.setString(3, name);
			st.setInt(4, fgid);	
			st.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
	}

	public void deleteFriend(int myid, int friendid) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		PreparedStatement st=null;
		try {
			String sql="delete from friends where myid=? and friendid=?";
		    st=con.prepareStatement(sql);
			st.setInt(1, myid);
			st.setInt(2, friendid);
			st.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
	}




}
