package kr.hanne.domain;

import java.util.Arrays;
import java.util.Date;

public class ProductVO {

	private int idx;
	private String productName;
	private int productCategory;
	private String categoryName;
	private int quantity;
	private int cost;
	private String status;
	private Date regdate;
	private UserVO userVO;
	private String[] files;
	private String fullname;

	@Override
	public String toString() {
		return "ProductVO [idx=" + idx + ", productName=" + productName + ", productCategory=" + productCategory
				+ ", categoryName=" + categoryName + ", quantity=" + quantity + ", cost=" + cost + ", status=" + status
				+ ", regdate=" + regdate + ", userVO=" + userVO + ", files=" + Arrays.toString(files) + ", fullname="
				+ fullname + "]";
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductCategory() {
		return productCategory;
	}
	public void setProductCategory(int productCategory) {
		this.productCategory = productCategory;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
	public UserVO getUserVO() {
		return userVO;
	}
	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}
}
