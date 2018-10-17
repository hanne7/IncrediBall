package kr.hanne.domain;

import java.util.Date;

public class ReplyVO {

	private int rno;
	private int bno;
	private int replyerIdx;
	private String replyText;
	private Date regdate;
	private Date moddate;
	private String username;
	private String userid;
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getReplyerIdx() {
		return replyerIdx;
	}
	public void setReplyerIdx(int replyerIdx) {
		this.replyerIdx = replyerIdx;
	}
	public String getReplyText() {
		return replyText;
	}
	public void setReplyText(String replyText) {
		this.replyText = replyText;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getModdate() {
		return moddate;
	}
	public void setModdate(Date moddate) {
		this.moddate = moddate;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	@Override
	public String toString() {
		return "ReplyVO [rno=" + rno + ", bno=" + bno + ", replyerIdx=" + replyerIdx + ", replyText=" + replyText
				+ ", regdate=" + regdate + ", moddate=" + moddate + ", username=" + username + ", userid=" + userid
				+ "]";
	}
}
