package entity;

public class Friend {
	private int id,stateid,fgid;//fgid为所属分组
	private String nickname,headportrait,signature;//name为备注
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStateid() {
		return stateid;
	}
	public void setStateid(int stateid) {
		this.stateid = stateid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getHeadportrait() {
		return headportrait;
	}
	public void setHeadportrait(String headportrait) {
		this.headportrait = headportrait;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	
	public int getFgid() {
		return fgid;
	}
	public void setFgid(int fgid) {
		this.fgid = fgid;
	}
	public Friend(int id, int stateid, int fgid, String nickname, String headportrait, String signature) {
		super();
		this.id = id;
		this.stateid = stateid;
		this.nickname = nickname;
		this.headportrait = headportrait;
		this.signature = signature;
		this.fgid=fgid;
	}
	public Friend() {
		super();
	}
	
}
