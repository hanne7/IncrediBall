package kr.hanne.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.hanne.domain.Criteria;
import kr.hanne.domain.ProductVO;

@Repository
public class ShopDAOImpl implements ShopDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "kr.hanne.mapper.shopMapper";
	
	@Override
	public List<ProductVO> list(Criteria cri) throws Exception {
		return session.selectList(namespace+".list", cri);
	}

	@Override
	public ProductVO read(int idx) throws Exception {
		return session.selectOne(namespace+".readProduct", idx);
	}

	@Override
	public void create(ProductVO vo) throws Exception {
		session.insert(namespace+".create", vo);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {
		return session.selectOne(namespace+".countPaging", cri);
	}

	@Override
	public void modify(ProductVO vo) throws Exception {
		session.update(namespace+".modifyProduct", vo);		
	}

	@Override
	public void delete(int idx) throws Exception {
		session.delete(namespace+".deleteProduct",	idx);
	}

	@Override
	public void addAttach(String fullname) throws Exception {
		session.insert(namespace+".addAttach", fullname);
	}

	@Override
	public List<String> getAttach(int idx) throws Exception {
		return session.selectList(namespace+".getAttach", idx);
	}

	@Override
	public void deleteAttach(int idx) throws Exception {
		session.delete(namespace+".deleteAttach", idx);
	}

	@Override
	public void replaceAttach(String fullName, int idx) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("idx", idx);
		paramMap.put("fullname", fullName);
		
		session.insert(namespace+".replaceAttach", paramMap);
	}

	@Override
	public int countCategoryPaging(Criteria cri) throws Exception {
		return session.selectOne(namespace+".countCategoryPaging", cri);
	}

	@Override
	public List<ProductVO> listCategory(Criteria cri) throws Exception {
		return session.selectList(namespace+".listCategory", cri);
	}

	@Override
	public List<ProductVO> listSearch(Criteria cri) throws Exception {
		return session.selectList(namespace+".listSearch", cri);
	}

	@Override
	public int searchCountPaging(Criteria cri) throws Exception {
		return session.selectOne(namespace+".searchCountPaging", cri);
	}

	@Override
	public List<ProductVO> categorySearch(Criteria cri) throws Exception {
		return session.selectList(namespace+".categorySearch", cri);
	}

	@Override
	public int categorySearchCount(Criteria cri) throws Exception {
		return session.selectOne(namespace+".categorySearchCount", cri);
	}

}
