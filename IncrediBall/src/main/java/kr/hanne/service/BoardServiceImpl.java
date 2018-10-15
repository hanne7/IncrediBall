package kr.hanne.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.hanne.dao.BoardDAO;
import kr.hanne.domain.BoardVO;
import kr.hanne.domain.Criteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDAO;
	
	@Transactional
	@Override
	public void create(BoardVO vo) throws Exception {
		boardDAO.create(vo);
		
		String[] files = vo.getFiles();
		
		if(files == null) {
			return;
		}
		
		for(String fileName : files) {
			boardDAO.addAttach(fileName);
		}		
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

	@Override
	public List<BoardVO> listCategory(Criteria cri) throws Exception {
		return boardDAO.listCategory(cri);
	}

	@Override
	public int countCategoryPaging(Criteria cri) throws Exception {
		return boardDAO.countCategoryPaging(cri);
	}

	@Override
	public List<BoardVO> listSearch(Criteria cri) throws Exception {
		return boardDAO.listSearch(cri);
	}

	@Override
	public int searchCountPaging(Criteria cri) throws Exception {
		return boardDAO.searchCountPaging(cri);
	}

	@Override
	public List<BoardVO> categorySearch(Criteria cri) throws Exception {
		return boardDAO.categorySearch(cri);
	}

	@Override
	public int categorySearchCount(Criteria cri) throws Exception {
		return boardDAO.categorySearchCount(cri);
	}

	@Override
	public List<String> getAttach(int idx) throws Exception {
		return boardDAO.getAttach(idx);
	}
}
