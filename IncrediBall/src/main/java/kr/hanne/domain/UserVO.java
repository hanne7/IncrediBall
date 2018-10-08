package kr.hanne.domain;

import java.util.Date;

public class UserVO {

	private int idx;
	private String userid;
	private String password;
	private String username;
	private String nickname;
	private String email;
	private String phone;
	private String address;
	private Date birthday;
	private String gender;
	private String job;
	private String userpoint;
	private int usergrade;
	private String favleague;
	private String favclubf;
	private String favclubd;
	private Date regdate;
	
	@Override
	public String toString() {
		return "UserVO [idx=" + idx + ", userid=" + userid + ", password=" + password + ", username=" + username
				+ ", nickname=" + nickname + ", email=" + email + ", phone=" + phone + ", address=" + address
				+ ", birthday=" + birthday + ", gender=" + gender + ", job=" + job + ", userpoint=" + userpoint
				+ ", usergrade=" + usergrade + ", favleague=" + favleague + ", favclubf=" + favclubf + ", favclubd="
				+ favclubd + ", regdate=" + regdate + "]";
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getUserpoint() {
		return userpoint;
	}
	public void setUserpoint(String userpoint) {
		this.userpoint = userpoint;
	}
	public int getUsergrade() {
		return usergrade;
	}
	public void setUsergrade(int usergrade) {
		this.usergrade = usergrade;
	}
	public String getFavleague() {
		return favleague;
	}
	public void setFavleague(String favleague) {
		this.favleague = favleague;
	}
	public String getFavclubf() {
		return favclubf;
	}
	public void setFavclubf(String favclubf) {
		this.favclubf = favclubf;
	}
	public String getFavclubd() {
		return favclubd;
	}
	public void setFavclubd(String favclubd) {
		this.favclubd = favclubd;
	}
}
