package entity;

import java.sql.Timestamp;

public class Message{
	private int msgid;
	private String content;
	private boolean status=false;
	private Timestamp time;
	private int typeid;//0,文本;1,图片;2,声音;3,视频;4,文件;
	private int senderid;
	private int reciverid;
	
	/**
	 * 
	 * 0  单聊消息，1 群消息  ，2自己发送的好友返回消息 ,
	 * 3 添加好友请求消息,4 添加好友回复消息
	 * 5 申请入群消息,6 申请入群回复消息
	 */
	private int type;
	
	
	
	public int getMsgid() {
		return msgid;
	}
	public void setMsgid(int msgid) {
		this.msgid = msgid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public int getTypeid() {
		return typeid;
	}
	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}
	public int getSenderid() {
		return senderid;
	}
	public void setSenderid(int senderid) {
		this.senderid = senderid;
	}
	public int getReciverid() {
		return reciverid;
	}
	public void setReciverid(int reciverid) {
		this.reciverid = reciverid;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
}
