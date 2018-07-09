package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import dao.UserDao;
import entity.User;
@WebServlet("/getUserInfo")
public class GetUserInfo extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd").create(); 
		int id=Integer.parseInt(request.getParameter("id"));
		User user=new UserDao().findUserInfo(id);
		String userJson=gson.toJson(user);
		response.getWriter().print(userJson);
	}
}
