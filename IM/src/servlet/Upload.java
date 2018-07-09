package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.google.gson.Gson;


@MultipartConfig
@WebServlet("/upload")
public class Upload extends HttpServlet{
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		            //存储路径
		            String savePath = request.getServletContext().getRealPath("/upload");
		            //获取上传的文件集合
		            Collection<Part> parts= request.getParts();
		                //一次性上传多个文件
		                for (Part part : parts) {//循环处理上传的文件
		                    //获取文件名
		                    String fileName = part.getSubmittedFileName();
		                    //把文件写到指定路径
		                    part.write(savePath+File.separator+fileName);
		            }
		            PrintWriter out = response.getWriter();
		            out.println("发送成功!");
		            out.flush();
		            out.close();
		    } 
	}
	
		
