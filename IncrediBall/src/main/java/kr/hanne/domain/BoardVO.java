package kr.hanne.domain;

import java.util.Date;

public class BoardVO {

	private int bno;
	private String title;
	private String content;
	private int useridx;
	private int viewcnt;
	private int replycnt;
	private int categoryidx;
	private Date regdate;
	private Date moddate;
	private String userid;
	private String nickname;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getUseridx() {
		return useridx;
	}
	public void setUseridx(int useridx) {
		this.useridx = useridx;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getReplycnt() {
		return replycnt;
	}
	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}
	public int getCategoryidx() {
		return categoryidx;
	}
	public void setCategoryidx(int categoryidx) {
		this.categoryidx = categoryidx;
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
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", useridx=" + useridx
				+ ", viewcnt=" + viewcnt + ", replycnt=" + replycnt + ", categoryidx=" + categoryidx + ", regdate="
				+ regdate + ", moddate=" + moddate + ", userid=" + userid + ", nickname=" + nickname + "]";
	}	
}
