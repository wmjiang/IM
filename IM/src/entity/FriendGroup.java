package entity;

import java.util.ArrayList;
import java.util.List;

public class FriendGroup {
	private int fgid;
	private String fgname; 
	private int onlineCount;
	private List<Friend> friendList=new ArrayList<Friend>() ;
	public int getFgid() {
		return fgid;
	}
	public void setFgid(int fgid) {
		this.fgid = fgid;
	}
	public String getFgname() {
		return fgname;
	}
	public void setFgname(String fgname) {
		this.fgname = fgname;
	}
	
	public List<Friend> getFriendList() {
		return friendList;
	}
	public void setFriendList(List<Friend> friendSet) {
		this.friendList = friendSet;
	}
	
	public int getOnlineCount() {
		return onlineCount;
	}
	public void setOnlineCount(int onlineCount) {
		this.onlineCount = onlineCount;
	}
	public FriendGroup(int fgid, String fgname) {
		super();
		this.fgid = fgid;
		this.fgname = fgname;
	}
	
}
