package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import dao.GroupDao;
import entity.Group;

@WebServlet("/getGroupInfo")
public class GetGroupInfo extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd").create(); 
		int id=Integer.parseInt(request.getParameter("id"));
		Group group=new GroupDao().findGroupInfo(id);
		String groupJson=gson.toJson(group);
		response.getWriter().print(groupJson);
	}
}
