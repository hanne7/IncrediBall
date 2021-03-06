package kr.hanne.dao;

import java.util.List;

import kr.hanne.domain.Criteria;
import kr.hanne.domain.ProductVO;

public interface ShopDAO {

	public List<ProductVO> list(Criteria cri) throws Exception;
	
	public ProductVO read(int idx) throws Exception;
	
	public void create(ProductVO vo) throws Exception;
	
	public void modify(ProductVO vo) throws Exception;
	
	public void delete(int idx) throws Exception;
	
	public int countPaging(Criteria cri) throws Exception;
	
	public int countCategoryPaging(Criteria cri) throws Exception;
	
	public List<ProductVO> listCategory(Criteria cri) throws Exception;
	
	public List<ProductVO> listSearch(Criteria cri) throws Exception;
	
	public int searchCountPaging(Criteria cri) throws Exception;
	
	public List<ProductVO> categorySearch(Criteria cri) throws Exception;
	
	public int categorySearchCount(Criteria cri) throws Exception;
	
	public void addAttach(String fullname) throws Exception;
	
	public List<String> getAttach(int idx) throws Exception;
	
	public void deleteAttach(int idx) throws Exception;
	
	public void replaceAttach(String fullName, int idx) throws Exception;
}
