package kr.hanne.service;

import java.util.List;

import kr.hanne.domain.BoardVO;

public interface BoardService {
	
	public void create(BoardVO vo) throws Exception;
	
	public List<BoardVO> list() throws Exception;
}
