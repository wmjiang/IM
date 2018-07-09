package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.ArticleDao;
import dao.UserDao;
import entity.Article;
import entity.User;

@WebServlet("/zone")
public class Zone extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			int myid = Integer.parseInt(request.getParameter("myid"));
			user = new UserDao().findUserInfo(myid);
			request.getSession().setAttribute("user", user);

		}

		int uid = Integer.parseInt(request.getParameter("uid"));
		User friend = new UserDao().findUserInfo(uid);
		request.getSession().setAttribute("friend", friend);

		List<Article> articleList = new ArticleDao().findByid(friend.getId());
		request.getSession().setAttribute("articleList", articleList);
		response.setIntHeader("Refresh", 5);
		response.sendRedirect("zone.jsp");
	}

}
