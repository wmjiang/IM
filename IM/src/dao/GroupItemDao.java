package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import entity.GroupItem;
import utils.DBHelper;

public class GroupItemDao {

	public Map<Integer,GroupItem> findGroupItems(int id) {
		Map<Integer,GroupItem>  groupItemMap=new HashMap<Integer,GroupItem>();
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="select group.groupid,name,headportrait from group_user,im.group where userid="+id+" and group.groupid=group_user.groupid";
		    rs=st.executeQuery(sql);
			while(rs.next()) {
				int groupid=rs.getInt(1);
				String name=rs.getString(2);
				String headportrait=rs.getString(3);
				groupItemMap.put(groupid,new GroupItem(groupid, name, headportrait));				
			}
			rs.close();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return groupItemMap;
	}

	public List<GroupItem> findByNickname(String id) {
		List<GroupItem> list=new ArrayList<GroupItem>();
		GroupItem groupItem=null;
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		String sql;
		try {
				Pattern pattern = Pattern.compile("[0-9]*");
				Matcher isNum = pattern.matcher(id);
				if(isNum.matches())
					sql="select groupid,name,headportrait from im.group where name like '%"+id+"%' or groupid="+id;
				else
					sql="select groupid,name,headportrait from im.group where name like '%"+id+"%'";
				st=con.createStatement();
			    rs=st.executeQuery(sql);
			    while (rs.next()) {
			    	groupItem=new GroupItem(rs.getInt(1),rs.getString(2),rs.getString(3));
			    	list.add(groupItem);
				}
			    
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return list;
	}

}
