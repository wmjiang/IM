package entity;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.google.gson.Gson;

import utils.FaceMap;

public class Article {
	int id;
	int senderid;
	Timestamp sendtime;
	String content;
	String[] img;
	String[] voice;
	String[] video;
	List<Comment> commentList=new ArrayList<Comment>();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSenderid() {
		return senderid;
	}
	public void setSenderid(int senderid) {
		this.senderid = senderid;
	}
	public Timestamp getSendtime() {
		return sendtime;
	}
	public void setSendtime(Timestamp sendtime) {
		this.sendtime = sendtime;
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
			 if(FaceMap.faceMap.containsKey(key))
			 content = content.replace(key, "<img src='./images/face/"+FaceMap.faceMap.get(key)+"'>");
	        }
		 this.content=content;
	}
	
	public String[] getImg() {
		return img;
	}
	public  void setImg(String img) {
		String[] imgs=img.split("\\|");
		this.img = imgs;
	}
	public String[] getVoice() {
		return voice;
	}
	public void setVoice(String voice) {
		String[] voices=voice.split("\\|");
		this.voice = voices;
	}
	public String[] getVideo() {
		return video;
	}
	public void setVideo(String video) {
		String[] videos=video.split("\\|");
		this.video = videos;
	}
	public List<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	
}
