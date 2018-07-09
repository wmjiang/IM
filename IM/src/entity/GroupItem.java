package entity;

public class GroupItem {
	private int groupid;
	private String name;
	private String headportrait;
	public GroupItem(int groupid, String name, String headportrait) {
		super();
		this.groupid = groupid;
		this.name = name;
		this.headportrait = headportrait;
	}
	public int getGroupid() {
		return groupid;
	}
	public void setGroupid(int groupid) {
		this.groupid = groupid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHeadportrait() {
		return headportrait;
	}
	public void setHeadportrait(String headportrait) {
		this.headportrait = headportrait;
	}
}
