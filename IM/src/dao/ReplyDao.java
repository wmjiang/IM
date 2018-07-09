package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import entity.Article;
import entity.Reply;
import utils.DBHelper;

public class ReplyDao {

	public List<Reply> findByid(int commentid) {
		List<Reply> replies=new ArrayList<Reply>();
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="select * from reply where comment_id="+commentid;
		    rs=st.executeQuery(sql);
			while(rs.next()) {
				Reply reply=new Reply();
				reply.setId(rs.getInt(1));
				reply.setComment_id(rs.getInt(2));
				reply.setFrom_uid(rs.getInt(3));
				reply.setTo_uid(rs.getInt(4));
				reply.setContent(rs.getString(5));
				reply.setSendtime(rs.getTimestamp(6));
				replies.add(reply);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return replies;
	}

	public void insert(int comment_id, int from_id, int to_uid, String content) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		PreparedStatement st=null;
		try {
				String sql="insert into reply (comment_id,from_uid,to_uid,content,send_time) values (?,?,?,?,?)";
			    st= con.prepareStatement(sql);
			    st.setInt(1, comment_id);
			    st.setInt(2, from_id);
			    st.setInt(3, to_uid);
			    st.setString(4, content);
			    st.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			    st.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
	}

}
