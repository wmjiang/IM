package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.GroupDao;
import entity.Friend;
import entity.Group;

@WebServlet("/getGroupMembers")
public class GetGroupMembers extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Gson gson=new Gson(); 
		int groupid=Integer.parseInt(request.getParameter("groupid"));
		List<Friend> groupMembersList=new GroupDao().findGroupMembers(groupid);
		String groupMembersListJson=gson.toJson(groupMembersList);
		response.getWriter().print(groupMembersListJson);
	}
}
