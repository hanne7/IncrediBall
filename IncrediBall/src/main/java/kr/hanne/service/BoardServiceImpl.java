package kr.hanne.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.hanne.dao.BoardDAO;
import kr.hanne.domain.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDAO;
	
	@Override
	public void create(BoardVO vo) throws Exception {
		boardDAO.create(vo);
	}

	@Override
	public List<BoardVO> list() throws Exception {
		return boardDAO.list();
	}

}
