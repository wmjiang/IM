package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupDao;
@WebServlet("/joinGroup")
public class JoinGroup extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int groupid=Integer.parseInt(request.getParameter("groupid"));
		int userid=Integer.parseInt(request.getParameter("userid"));
		new GroupDao().insertGroupUser(groupid,userid);
	}
}
