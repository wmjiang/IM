package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import entity.User;
import entity.UserItem;
import utils.DBHelper;

public class UserDao {

	//注册用户
	public int insert(User user) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		int id=0;
		try {
		    st=con.createStatement();
			String sql="insert into user (nickname,password,phone) values ('"+user.getNickname()+
					"','"+user.getPassword()+"','"+user.getPhone()+"')";
			st.execute(sql);
			sql="select last_insert_id()";
		    rs=st.executeQuery(sql);
			while(rs.next()) {
				id= rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return id;
	}

	public User findById(int id, String password) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		User user=null;
		try {
		    st=con.createStatement();
			String sql="select * from user where id="+id+" and password='"+password+"'";
			rs=st.executeQuery(sql);
			while(rs.next()) {
				user=new User();
				user.setId(rs.getInt(1));
				user.setNickname(rs.getString(2));
				user.setPassword(rs.getString(3));
				user.setPhone(rs.getString(4));
				user.setSignature(rs.getString(5));
				user.setSex(rs.getBoolean(6));
				user.setBirthday(rs.getTimestamp(7));
				user.setName(rs.getString(8));
				user.setEmail(rs.getString(9));
				user.setIntro(rs.getString(10));
				user.setHeadportrait(rs.getString(11));
				user.setShengxiao(rs.getString(12));
				user.setAge(rs.getInt(13));
				user.setConstellation(rs.getString(14));
				user.setBloodtype(rs.getString(15));
				user.setSchool(rs.getString(16));
				user.setVocation(rs.getString(17));
				user.setAdress(rs.getString(18));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return user;
	}

	public void updateState(int id, int i) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="update user set stateid="+i+" where id="+id;
			st.executeUpdate(sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		
	}

	public void updateLastMsgTime(int userid) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		PreparedStatement st=null;
		try {
				String sql="update group_user set last_msgtime=? where userid=?";
			    st= con.prepareStatement(sql);
			    st.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
			    st.setInt(2, userid);
			    st.execute();	
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
	}

	public UserItem findById(int id) {
		UserItem userItem=null;
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
			
				String sql="select id ,nickname,headportrait from user where id="+id;
			    st=con.createStatement();
			    rs=st.executeQuery(sql);
			    while (rs.next()) {
			    	userItem=new UserItem();
			    	userItem.setId(rs.getInt(1));
			    	userItem.setNickname(rs.getString(2));
			    	userItem.setHeadportrait(rs.getString(3));
				}
			    
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return userItem;
	}

	public User findUserInfo(int id) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		User user=null;
		try {
		    st=con.createStatement();
			String sql="select * from user where id="+id;
			rs=st.executeQuery(sql);
			while(rs.next()) {
				user=new User();
				user.setId(rs.getInt(1));
				user.setNickname(rs.getString(2));
				user.setPhone(rs.getString(4));
				user.setSignature(rs.getString(5));
				user.setSex(rs.getBoolean(6));
				user.setBirthday(rs.getTimestamp(7));
				user.setName(rs.getString(8));
				user.setEmail(rs.getString(9));
				user.setIntro(rs.getString(10));
				user.setHeadportrait(rs.getString(11));
				user.setShengxiao(rs.getString(12));
				user.setAge(rs.getInt(13));
				user.setConstellation(rs.getString(14));
				user.setBloodtype(rs.getString(15));
				user.setSchool(rs.getString(16));
				user.setVocation(rs.getString(17));
				user.setAdress(rs.getString(18));
				user.setStateid(rs.getInt(19));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return user;
	}

	public List<UserItem> findByNickname(String id) {
		List<UserItem> list=new ArrayList<UserItem>();
		UserItem userItem=null;
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		String sql;
		try {
				Pattern pattern = Pattern.compile("[0-9]*");
				Matcher isNum = pattern.matcher(id);
				if(isNum.matches())
					sql="select id ,nickname,headportrait from user where nickname like '%"+id+"%' or id="+id;
			    else 
					sql="select id ,nickname,headportrait from user where nickname like '%"+id+"%'";
				st=con.createStatement();
			    rs=st.executeQuery(sql);
			    while (rs.next()) {
			    	userItem=new UserItem();
			    	userItem.setId(rs.getInt(1));
			    	userItem.setNickname(rs.getString(2));
			    	userItem.setHeadportrait(rs.getString(3));
			    	list.add(userItem);
				}
			    
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return list;
	}

}
