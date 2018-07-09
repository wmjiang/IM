package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entity.FriendGroup;
import utils.DBHelper;

public class FriendGroupDao {

	public List<FriendGroup> findFriendGroups(int id) {
		List<FriendGroup> friendGroupsList=new ArrayList<FriendGroup>();
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="select fgid,fgname from friend_group where fguserid="+id;
		    rs=st.executeQuery(sql);
			while(rs.next()) {
				int fgid=rs.getInt(1);
				String fgname=rs.getString(2);
				friendGroupsList.add(new FriendGroup(fgid, fgname));				
			}
			rs.close();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return friendGroupsList;
	}

	public List<Integer> findGroupOnlineFriend(int groupid) {
		List<Integer> list=new ArrayList<Integer>();
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="select user.id from group_user,user where groupid="+groupid+" and user.id=group_user.userid and stateid=1";
		    rs=st.executeQuery(sql);
			while(rs.next()) {
					list.add(rs.getInt(1));	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return list;
	}

	public int insertFriendGroup(int id, String string) {
		int fgid=0;
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="insert into friend_group (fgname,fguserid) values ('"+string+"',"+id+")";
		    st.execute(sql);
		    sql = "select last_insert_id()";
			rs = st.executeQuery(sql);
			while (rs.next()) {
				fgid = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return fgid;
	}



}
