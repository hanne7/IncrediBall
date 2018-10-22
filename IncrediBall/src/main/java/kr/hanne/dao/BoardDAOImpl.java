package kr.hanne.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.hanne.domain.BoardVO;
import kr.hanne.domain.Criteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "kr.hanne.mapper.boardMapper";
	
	@Override
	public void create(BoardVO vo) throws Exception {
		session.insert(namespace + ".create", vo);
	}

	@Override
	public List<BoardVO> list(Criteria cri) throws Exception {	
		return session.selectList(namespace + ".list", cri);
	}

	@Override
	public BoardVO read(int bno) throws Exception {
		return session.selectOne(namespace+".read", bno);
	}

	@Override
	public void modify(BoardVO vo) throws Exception {
		session.update(namespace+".modify", vo);
	}

	@Override
	public void delete(int bno) throws Exception {
		session.delete(namespace+".delete",	bno);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {
		return session.selectOne(namespace+".countPaging", cri);
	}

	@Override
	public List<BoardVO> listCategory(Criteria cri) throws Exception {
		return session.selectList(namespace+".listCategory", cri);
	}

	@Override
	public int countCategoryPaging(Criteria cri) throws Exception {
		return session.selectOne(namespace+".countCategoryPaging", cri);
	}

	@Override
	public List<BoardVO> listSearch(Criteria cri) throws Exception {
		return session.selectList(namespace+".listSearch", cri);
	}

	@Override
	public int searchCountPaging(Criteria cri) throws Exception {
		return session.selectOne(namespace+".searchCountPaging", cri);
	}

	@Override
	public List<BoardVO> categorySearch(Criteria cri) throws Exception {
		return session.selectList(namespace+".categorySearch", cri);
	}

	@Override
	public int categorySearchCount(Criteria cri) throws Exception {
		return session.selectOne(namespace+".categorySearchCount", cri);
	}

	@Override
	public void addAttach(String fullname) throws Exception {
		session.insert(namespace+".addAttach", fullname);
	}

	@Override
	public List<String> getAttach(int bno) throws Exception {
		return session.selectList(namespace+".getAttach", bno);
	}

	@Override
	public void deleteAttach(int bno) throws Exception {
		session.delete(namespace+".deleteAttach", bno);
	}

	@Override
	public void replaceAttach(String fullName, int bno) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bno", bno);
		paramMap.put("fullname", fullName);
		
		session.insert(namespace+".replaceAttach", paramMap);
	}

	@Override
	public void updateReplyCnt(int bno, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("bno", bno);
		paramMap.put("amount", amount);
		
		session.update(namespace+".updateReplyCnt", paramMap);
	}

	@Override
	public void updateViewCnt(int bno) throws Exception {
		session.update(namespace+".updateViewCnt", bno);
	}

	@Override
	public List<BoardVO> listPopular(Criteria cri) throws Exception {
		return session.selectList(namespace+".listPopular", cri);
	}
}
