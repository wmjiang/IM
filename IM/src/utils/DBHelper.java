package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBHelper {
   
	private static final String driver = "com.mysql.cj.jdbc.Driver";
	private static final String url="jdbc:mysql://localhost/im?characterEncoding=utf8&serverTimezone=UTC&useSSL=false";
	private static final String username="root";
	private static final String password="root";
    
	private static Connection conn=null;
	

	static 
	{
		try
		{
			Class.forName(driver);
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	
	public static Connection getConnection()
	{
		
			try {
				conn = DriverManager.getConnection(url, username, password);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return conn;
	}
	
	public static void main(String[] args) {
		
		try
		{
		   Connection conn = DBHelper.getConnection();
		   if(conn!=null)
		   {
			   System.out.println("连接成功");
		   }
		   else
		   {
			   System.out.println("连接失败");
		   }
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		
	}
	public static void release(Connection conn,Statement stat,ResultSet rs){
        if(rs != null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally{
                rs = null;
            }
        }
        if(stat != null){
            try {
                stat.close();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally{
                stat = null;
            }
        }
        if(conn != null){
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            } finally{
                conn = null;
            }
        }
        }
	
}
