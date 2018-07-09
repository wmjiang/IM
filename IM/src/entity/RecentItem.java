package entity;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class RecentItem implements Comparable<RecentItem>{
	private int type=0;//group ,friend
	private int id;
	private int count;
	private Timestamp lastTime;
	private String lastMsgContent;
	private List<Message> messageList=new ArrayList<Message>();
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Timestamp getLastTime() {
		return lastTime;
	}
	public void setLastTime(Timestamp lastTime) {
		this.lastTime = lastTime;
	}
	public String getLastMsgContent() {
		return lastMsgContent;
	}
	public void setLastMsgContent(String lastMsgContent) {
		this.lastMsgContent = lastMsgContent;
	}
	public RecentItem(int type, int id, int count, Timestamp lastTime, String lastMsgContent) {
		super();
		this.type = type;
		this.id = id;
		this.count = count;
		this.lastTime= lastTime;
		this.lastMsgContent = lastMsgContent;
	}
	@Override
	public int compareTo(RecentItem o) {
		return (int) (o.getLastTime().getTime()-this.getLastTime().getTime());
	}
	public List<Message> getMessageList() {
		return messageList;
	}
	public void setMessageList(List<Message> messageList) {
		this.messageList = messageList;
	}
	
}
