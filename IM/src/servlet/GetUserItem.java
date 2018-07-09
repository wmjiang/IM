package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.UserDao;
import entity.UserItem;

@WebServlet("/getUserItem")

public class GetUserItem extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Gson gson=new Gson();
		int id=Integer.parseInt(request.getParameter("id"));
		UserItem userItem=new UserDao().findById(id);
		String userItemJson=gson.toJson(userItem);
		response.getWriter().print(userItemJson);
	}

}
