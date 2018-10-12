package kr.hanne.dao;

import java.util.List;

import kr.hanne.domain.Criteria;
import kr.hanne.domain.ProductVO;

public interface ShopDAO {

	public List<ProductVO> list(Criteria cri) throws Exception;
	
	public void read(int idx) throws Exception;
	
	public void create(ProductVO vo) throws Exception;
}
