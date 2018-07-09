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
import entity.Comment;
import utils.DBHelper;

public class CommentDao {

	public List<Comment> findByid(int article_id) {
		List<Comment> comments=new ArrayList<Comment>();
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="select * from comment where article_id="+article_id;
		    rs=st.executeQuery(sql);
			while(rs.next()) {
				Comment comment=new Comment();
				comment.setId(rs.getInt(1));
				comment.setArticle_id(rs.getInt(2));
				comment.setFrom_uid(rs.getInt(3));
				comment.setContent(rs.getString(4));
				comment.setSendtime(rs.getTimestamp(5));
				comments.add(comment);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		for (Comment comment : comments) {
			comment.setReplyList(new ReplyDao().findByid(comment.getId()));
		}
		return comments;
	}

	public void insert(int article_id, int from_uid, String content) {
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		PreparedStatement st=null;
		try {
				String sql="insert into comment (article_id,from_uid,content,send_time) values (?,?,?,?)";
			    st= con.prepareStatement(sql);
			    st.setInt(1, article_id);
			    st.setInt(2, from_uid);
			    st.setString(3, content);
			    st.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
			    st.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
	}

}
