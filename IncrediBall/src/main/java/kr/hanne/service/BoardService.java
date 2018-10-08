package kr.hanne.service;

import java.util.List;

import kr.hanne.domain.BoardVO;

public interface BoardService {
	
	public void create(BoardVO vo) throws Exception;
	
	public List<BoardVO> list() throws Exception;
	
	public BoardVO read(int bno) throws Exception;
	
	public void modify(BoardVO vo) throws Exception;
	
	public void delete(int bno) throws Exception;
}
