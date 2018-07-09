package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import dao.FriendGroupDao;
import dao.GroupDao;
import entity.GroupItem;
@WebServlet("/createFriendGroup")
public class CreateFriendGroup extends HttpServlet{
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doPost(request, response);
		}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			Integer fguserid=Integer.parseInt(request.getParameter("id"));
			String fgname=request.getParameter("fgname");
			int fgid=new FriendGroupDao().insertFriendGroup(fguserid, fgname);
			JsonObject obj = new JsonObject();
			obj.addProperty("fgid", fgid);
			obj.addProperty("fgname", fgname);
			response.getWriter().print(obj.toString());
		}

}
