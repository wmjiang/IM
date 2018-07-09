package servlet;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;



import dao.ArticleDao;
import entity.User;

@MultipartConfig
@WebServlet("/sendArticle")
public class SendArticle extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user=(User)request.getSession().getAttribute("user");
		int uid = user.getId();
		// 存储路径
		String savePath = request.getServletContext().getRealPath("/upload");
		// 内容
		String content = request.getParameter("content");
		String img = "|";
		String video = "|";
		String voice = "|";
		// 一次性上传多个文件
		Collection<Part> parts = request.getParts();
		for (Part part : parts) {// 循环处理上传的文件
			// 获取文件名
			if (part.getSubmittedFileName() != null && part.getSize() != 0) {
				String reName = createName(uid, part.getSubmittedFileName());
				// 获得文件类型
				switch (part.getName()) {
				case "uploadImg":
					img += reName + "|";
					break;
				case "uploadVoice":
					voice += reName + "|";
					break;
				case "uploadViedo":
					video += reName + "|";
					break;
				}
				part.write(savePath + File.separator + reName);
			}

		}
		int id = new ArticleDao().insertArticle(uid, content, img, voice, video);
		
		response.sendRedirect("zone?uid="+uid);
	}

	// 创建文件名--区分同名文件,在文件名前加上当前的时间
	private String createName(int uid, String name) {
		return uid + "_" + new SimpleDateFormat("yyyyMMddHHmmssSSS").format(Calendar.getInstance().getTime()) + "_"
				+ name;
	}

}
