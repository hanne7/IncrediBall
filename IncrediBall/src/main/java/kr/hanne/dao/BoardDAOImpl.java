package kr.hanne.dao;

import java.util.List;

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
	public List<String> getAttach(int idx) throws Exception {
		return session.selectList(namespace+".getAttach", idx);
	}
}
