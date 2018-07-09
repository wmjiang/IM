package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FriendGroupDao;
import dao.UserDao;
import entity.User;

@WebServlet("/regist")
// 注册IM账号
public class Regist extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String nickname = request.getParameter("nickname");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		User user = new User();
		user.setNickname(nickname);
		user.setPassword(password);
		user.setPhone(phone);
		UserDao userDao = new UserDao();
		int id = userDao.insert(user);
		//注册时创建一个分组（我的好友）
		new FriendGroupDao().insertFriendGroup(id,"我的好友");
		request.getSession().setAttribute("id", id);
		response.sendRedirect("index.jsp");
	}

}
