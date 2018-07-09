package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReplyDao;
import entity.User;

@WebServlet("/reply")
public class Reply extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int comment_id=Integer.parseInt(request.getParameter("comment_id"));
		int to_uid=Integer.parseInt(request.getParameter("to_uid"));
		String content=request.getParameter("content");
		int from_id=((User)request.getSession().getAttribute("user")).getId();
		new ReplyDao().insert(comment_id,from_id,to_uid,content);
		int friendid=Integer.parseInt(request.getParameter("friendid"));
		response.sendRedirect("zone?uid="+friendid);
	}

}
