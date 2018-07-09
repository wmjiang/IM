package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.FriendDao;
import dao.UserDao;
import entity.Friend;
import entity.User;

@WebServlet("/addFriend")
public class AddFriend extends HttpServlet{
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int myid=Integer.parseInt(request.getParameter("myid"));
		int friendid=Integer.parseInt(request.getParameter("friendid"));
		int fgid=Integer.parseInt(request.getParameter("fgid"));
		String name=request.getParameter("remark");
		User user=new UserDao().findUserInfo(friendid);
		if(name=="")
			name=user.getNickname();
		Friend friend=new Friend(friendid, user.getStateid(), fgid,name ,user.getHeadportrait(), user.getSignature());
		new FriendDao().insertFriend(myid,friendid,name,fgid);
		response.getWriter().print(new Gson().toJson(friend));
	}
}
