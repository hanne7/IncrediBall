package kr.hanne.dao;

import java.util.List;

import kr.hanne.domain.BoardVO;
import kr.hanne.domain.UserVO;

public interface BoardDAO {

	public void create(BoardVO vo) throws Exception;
	
	public List<BoardVO> list() throws Exception;
	
	public BoardVO read(int bno) throws Exception;
	
	public void modify(BoardVO vo) throws Exception;
	
	public void delete(int bno) throws Exception;
}
