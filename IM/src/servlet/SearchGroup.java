package servlet;
import java.io.IOException;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.GroupItemDao;
import entity.GroupItem;
@WebServlet("/searchGroup")
public class SearchGroup extends HttpServlet{
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
			doPost(req, resp);
		}
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
			Gson gson=new Gson();
			String id=request.getParameter("id");
			GroupItemDao groupItemDao=new GroupItemDao();
			List<GroupItem> groupItemList=groupItemDao.findByNickname(id);
			String groupItemListJson=gson.toJson(groupItemList);
			response.getWriter().print(groupItemListJson);
		}

}
