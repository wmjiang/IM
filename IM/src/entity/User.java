package entity;

import java.sql.Timestamp;

/*
 * CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `signature` varchar(150) DEFAULT NULL,
  `sex` bit(1) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `intro` varchar(255) DEFAULT NULL,
  `headportrait` varchar(100) DEFAULT NULL COMMENT '头像',
  `shengxiao` char(2) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `constellation` char(6) DEFAULT '' COMMENT '星座',
  `bloodtype` varchar(10) DEFAULT NULL,
  `school` varchar(50) DEFAULT NULL,
  `vocation` varchar(30) DEFAULT NULL,
  `adress` varchar(100) DEFAULT NULL,
  stateid int 
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100009 DEFAULT CHARSET=utf8mb4;
*/



public class User {
	private int id,age,stateid;
	private boolean sex;
	private String nickname,password,phone,signature,name,intro,email,
	headportrait,shengxiao,constellation,bloodtype,school,vocation,address;
	private Timestamp birthday;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public boolean isSex() {
		return sex;
	}
	public void setSex(boolean sex) {
		this.sex = sex;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getHeadportrait() {
		return headportrait;
	}
	public void setHeadportrait(String headportrait) {
		this.headportrait = headportrait;
	}
	public String getShengxiao() {
		return shengxiao;
	}
	public void setShengxiao(String shengxiao) {
		this.shengxiao = shengxiao;
	}
	public String getConstellation() {
		return constellation;
	}
	public void setConstellation(String constellation) {
		this.constellation = constellation;
	}
	public String getBloodtype() {
		return bloodtype;
	}
	public void setBloodtype(String bloodtype) {
		this.bloodtype = bloodtype;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getVocation() {
		return vocation;
	}
	public void setVocation(String vocation) {
		this.vocation = vocation;
	}
	public String getAdress() {
		return address;
	}
	public void setAdress(String address) {
		this.address = address;
	}
	public Timestamp getBirthday() {
		return birthday;
	}
	public void setBirthday(Timestamp birthday) {
		this.birthday = birthday;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getStateid() {
		return stateid;
	}
	public void setStateid(int stateid) {
		this.stateid = stateid;
	}
}
