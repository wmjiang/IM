package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDao;
import entity.User;


@WebServlet("/comment")
public class Comment extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int article_id=Integer.parseInt(request.getParameter("article_id"));
		int friend_id=Integer.parseInt(request.getParameter("friend_id"));
		String content=request.getParameter("content");
		int from_uid=((User)request.getSession().getAttribute("user")).getId();
		new CommentDao().insert(article_id,from_uid,content);
		response.sendRedirect("zone?uid="+friend_id);
	}

}
