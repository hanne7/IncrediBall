package kr.hanne.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.hanne.dao.BoardDAO;
import kr.hanne.domain.BoardVO;
import kr.hanne.domain.Criteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDAO;
	
	@Override
	public void create(BoardVO vo) throws Exception {
		boardDAO.create(vo);
	}

	@Override
	public List<BoardVO> list(Criteria cri) throws Exception {
		return boardDAO.list(cri);
	}

	@Override
	public BoardVO read(int bno) throws Exception {
		return boardDAO.read(bno);
	}

	@Override
	public void modify(BoardVO vo) throws Exception {
		boardDAO.modify(vo);
	}

	@Override
	public void delete(int bno) throws Exception {
		boardDAO.delete(bno);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {
		return boardDAO.countPaging(cri);
	}
}
