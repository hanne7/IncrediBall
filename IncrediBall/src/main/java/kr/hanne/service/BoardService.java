package kr.hanne.service;

import java.util.List;

import kr.hanne.domain.BoardVO;
import kr.hanne.domain.Criteria;

public interface BoardService {
	
	public void create(BoardVO vo) throws Exception;
	
	public List<BoardVO> list(Criteria cri) throws Exception;
	
	public BoardVO read(int bno) throws Exception;
	
	public void modify(BoardVO vo) throws Exception;
	
	public void delete(int bno) throws Exception;
	
	public int countPaging(Criteria cri) throws Exception;
}
