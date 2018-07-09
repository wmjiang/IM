package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import entity.Friend;
import entity.Group;
import utils.DBHelper;

public class GroupDao {

	public Group findGroupInfo(int id) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		Group group=null;
		try {
		    st=con.createStatement();
			String sql="select * from im.`group` where groupid="+id;
			rs=st.executeQuery(sql);
			while(rs.next()) {
				group=new Group();
				group.setGroupid(rs.getInt(1));
				group.setName(rs.getString(2));
				group.setHeadportrait(rs.getString(3));
				group.setCreatetime(rs.getTimestamp(4));
				group.setAdminid(rs.getInt(5));
				group.setIntro(rs.getString(7));
				group.setNotice(rs.getString(6));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return group;
	}

	public List<Friend> findGroupMembers(int groupid) {
		List<Friend> list=new ArrayList<Friend>();
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="select id,nickname,headportrait,stateid,signature from group_user,user where groupid="+groupid+" and userid=id";
			rs=st.executeQuery(sql);
			while(rs.next()) {
				Friend friend=new Friend();
				friend.setId(rs.getInt(1));
				friend.setNickname(rs.getString(2));
				friend.setHeadportrait(rs.getString(3));
				friend.setStateid(rs.getInt(4));
				friend.setSignature(rs.getString(5));
				list.add(friend);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return list;
	}

	public void insertGroupUser(int groupid, int userid) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		PreparedStatement st=null;
		try {
			
				String sql="insert into group_user values(?,?,?)";
			    st= con.prepareStatement(sql);
			    st.setInt(1, groupid);
			    st.setInt(2, userid);
			    st.setTimestamp(3, new Timestamp(System.currentTimeMillis()));		    
			    st.execute();	
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
	}

	public void deleteGroupUser(int groupid, int userid) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		PreparedStatement st=null;
		try {
			
				String sql="delete from group_user where groupid=? and userid=?";
			    st= con.prepareStatement(sql);
			    st.setInt(1, groupid);
			    st.setInt(2, userid);	    
			    st.execute();	
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
	}

	public int insertGroup(String name, String headportrait, Integer adminid, String notice,String intro) {
		int groupid=0;
		Timestamp createtime;
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		PreparedStatement st=null;
		try {
			
				String sql="insert into im.`group` (name,headportrait,createtime,adminid,notice,intro) values (?,?,?,?,?,?)";
			    st= con.prepareStatement(sql);
			    st.setString(1, name);
			    st.setString(2, headportrait);
			    createtime=new Timestamp(System.currentTimeMillis());
			    st.setTimestamp(3, createtime);		    
			    st.setInt(4, adminid);
			    st.setString(5, notice);
			    st.setString(6, intro);
			    st.execute();
			    st.close();
				sql = "select last_insert_id()";
				st = con.prepareStatement(sql);
				rs = st.executeQuery();
				while (rs.next()) {
					groupid = rs.getInt(1);
				}
				st.close();
				sql = "insert into group_user values(?,?,?)";
				st = con.prepareStatement(sql);
				st.setInt(1, groupid);
				st.setInt(2, adminid);
				st.setTimestamp(3, createtime);
				st.execute();
				
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return groupid;
	}

}
