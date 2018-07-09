package entity;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import utils.FaceMap;

public class Comment {
	int id;
	int article_id;
	int from_uid;
	String content;
	Timestamp sendtime;
	List<Reply> replyList=new ArrayList<>();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getArticle_id() {
		return article_id;
	}
	public void setArticle_id(int article_id) {
		this.article_id = article_id;
	}
	public int getFrom_uid() {
		return from_uid;
	}
	public void setFrom_uid(int from_uid) {
		this.from_uid = from_uid;
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
	public List<Reply> getReplyList() {
		return replyList;
	}
	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
	}
	
}
