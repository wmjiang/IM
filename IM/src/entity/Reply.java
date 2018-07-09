package entity;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import utils.FaceMap;

public class Reply {
	int id;
	int comment_id;
	int from_uid;
	int to_uid;
	String content;
	Timestamp sendtime;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public int getFrom_uid() {
		return from_uid;
	}
	public void setFrom_uid(int from_uid) {
		this.from_uid = from_uid;
	}
	public int getTo_uid() {
		return to_uid;
	}
	public void setTo_uid(int to_uid) {
		this.to_uid = to_uid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		List<String> keys=new ArrayList<>();
		String patt="\\[[^\\]]+\\]";
		Pattern r = Pattern.compile(patt);
		Matcher matcher = r.matcher(content);
		while(matcher.find()) {
			String key=content.substring(matcher.start(),matcher.end());
			keys.add(key);
			
		}
		 for (String key : keys) {
			 content = content.replace(key, "<img src='./images/face/"+FaceMap.faceMap.get(key)+"'>");
	        }
		this.content = content;
	}
	public Timestamp getSendtime() {
		return sendtime;
	}
	public void setSendtime(Timestamp sendtime) {
		this.sendtime = sendtime;
	}
	
}
