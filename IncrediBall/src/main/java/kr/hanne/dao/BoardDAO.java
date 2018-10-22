package kr.hanne.dao;

import java.util.List;

import kr.hanne.domain.BoardVO;
import kr.hanne.domain.Criteria;

public interface BoardDAO {
	
	public void create(BoardVO vo) throws Exception;
	
	public List<BoardVO> list(Criteria cri) throws Exception;
	
	public BoardVO read(int bno) throws Exception;
	
	public void modify(BoardVO vo) throws Exception;
	
	public void delete(int bno) throws Exception;
	
	public int countPaging(Criteria cri) throws Exception;
	
	public int countCategoryPaging(Criteria cri) throws Exception;
	
	public List<BoardVO> listCategory(Criteria cri) throws Exception;
	
	public List<BoardVO> listSearch(Criteria cri) throws Exception;
	
	public int searchCountPaging(Criteria cri) throws Exception;
	
	public List<BoardVO> categorySearch(Criteria cri) throws Exception;
	
	public int categorySearchCount(Criteria cri) throws Exception;
	
	public void addAttach(String fullname) throws Exception;
	
	public List<String> getAttach(int bno) throws Exception;
	
	public void deleteAttach(int bno) throws Exception;
	
	public void replaceAttach(String fullName, int bno) throws Exception;
	
	public void updateReplyCnt(int bno, int amount) throws Exception;
	
	public void updateViewCnt(int bno) throws Exception;
	
	public List<BoardVO> listPopular(Criteria cri) throws Exception;
}


