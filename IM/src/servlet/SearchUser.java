package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.UserDao;
import entity.UserItem;

@WebServlet("/searchUser")
public class SearchUser extends HttpServlet{
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		doPost(req, resp);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
		Gson gson=new Gson();
		String id=request.getParameter("id");
		UserDao userDao=new UserDao();
		List<UserItem> userItemList=userDao.findByNickname(id);
		String userItemListJson=gson.toJson(userItemList);
		response.getWriter().print(userItemListJson);
	}
}
