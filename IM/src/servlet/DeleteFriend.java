package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FriendDao;

@WebServlet("/deleteFriend")
public class DeleteFriend extends HttpServlet{
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int myid=Integer.parseInt(request.getParameter("myid"));
		int friendid=Integer.parseInt(request.getParameter("friendid"));
		new FriendDao().deleteFriend(myid,friendid);
	}
}
