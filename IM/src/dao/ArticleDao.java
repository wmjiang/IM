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
import entity.FriendGroup;
import utils.DBHelper;

public class ArticleDao {

	public int insertArticle(int senderid, String content, String img, String voice, String video) {
		int articleid=0;
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		PreparedStatement st=null;
		try {
			
				String sql="insert into article (senderid,sendtime,content,img,voice,video) values (?,?,?,?,?,?)";
			    st= con.prepareStatement(sql);
			    st.setInt(1, senderid);
			    st.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
			    st.setString(3, content);		    
			    st.setString(4, img);
			    st.setString(5, voice);
			    st.setString(6, video);
			    st.execute();
			    st.close();
				sql = "select last_insert_id()";
				st = con.prepareStatement(sql);
				rs = st.executeQuery();
				while (rs.next()) {
					articleid = rs.getInt(1);
				}
				
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		return articleid;
	}

	public List<Article> findByid(int uid) {
		List<Article> articles=new ArrayList<Article>();
		Connection con=DBHelper.getConnection();
		ResultSet rs=null;
		Statement st=null;
		try {
		    st=con.createStatement();
			String sql="select * from article where senderid="+uid+" order by id desc";
		    rs=st.executeQuery(sql);
			while(rs.next()) {
				Article article=new Article();
				article.setId(rs.getInt(1));
				article.setSenderid(rs.getInt(2));
				article.setSendtime(rs.getTimestamp(3));
				article.setContent(rs.getString(4));
				article.setImg(rs.getString(5));
				article.setVoice(rs.getString(6));
				article.setVideo(rs.getString(7));
				articles.add(article);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			DBHelper.release(con, st, rs);
		}
		for (Article article : articles) {
			article.setCommentList(new CommentDao().findByid(article.getId()));
		}
		return articles;
	}
}
