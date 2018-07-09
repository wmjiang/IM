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
import entity.GroupItem;


@WebServlet("/createGroup")
public class CreateGroup extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer adminid=Integer.parseInt(request.getParameter("id"));
		String name=request.getParameter("name");
		String intro= request.getParameter("intro");
		String notice=  request.getParameter("notice");
		int groupid=new GroupDao().insertGroup(name, "group.jpg",adminid,notice,intro);
		GroupItem group=new GroupItem(groupid,name,"group.jpg");
		Gson gson=new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		response.getWriter().print(gson.toJson(group));
	}

}
