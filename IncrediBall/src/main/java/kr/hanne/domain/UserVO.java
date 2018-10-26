package kr.hanne.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class UserVO {

	private int idx;
	private String userid;
	private String password;
	private String username;
	private String nickname;
	private String email;
	private String phone;
	private String address;
	private String userpoint;
	private int usergrade;	
	private Date regdate;
	private MultipartFile imgFile;
	private String imgName;
	
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public MultipartFile getImgFile() {
		return imgFile;
	}
	public void setImgFile(MultipartFile imgFile) {
		this.imgFile = imgFile;
	}
	@Override
	public String toString() {
		return "UserVO [idx=" + idx + ", userid=" + userid + ", password=" + password + ", username=" + username
				+ ", nickname=" + nickname + ", email=" + email + ", phone=" + phone + ", address=" + address
				+ ", userpoint=" + userpoint + ", usergrade=" + usergrade + ", regdate=" + regdate + ", imgFile="
				+ imgFile + ", imgName=" + imgName + "]";
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
}
