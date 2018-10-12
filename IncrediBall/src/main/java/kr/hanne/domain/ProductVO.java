package kr.hanne.domain;

import java.util.Date;

public class ProductVO {

	private int productidx;
	private String productname;
	private int productcategory;
	private String categoryname;
	private int quantity;
	private int cost;
	private Date regdate;
	private UserVO userVO;
	
	public String getCategoryname() {
		return categoryname;
	}
	public void setCategoryname(String categoryname) {
		this.categoryname = categoryname;
	}
	public UserVO getUserVO() {
		return userVO;
	}
	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}		
	public int getProductidx() {
		return productidx;
	}
	public void setProductidx(int productidx) {
		this.productidx = productidx;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public int getProductcategory() {
		return productcategory;
	}
	public void setProductcategory(int productcategory) {
		this.productcategory = productcategory;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "ProductVO [productidx=" + productidx + ", productname=" + productname + ", productcategory="
				+ productcategory + ", categoryname=" + categoryname + ", quantity=" + quantity + ", cost=" + cost
				+ ", regdate=" + regdate + ", userVO=" + userVO + "]";
	}
}
