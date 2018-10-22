package kr.hanne.service;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
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
		
		System.out.println(Arrays.toString(files));
		
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

	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(int bno) throws Exception {
		boardDAO.updateViewCnt(bno);
		return boardDAO.read(bno);
	}

	@Transactional
	@Override
	public void modify(BoardVO vo) throws Exception {
		boardDAO.modify(vo);
		
		int bno = vo.getBno();
		boardDAO.deleteAttach(bno);
		
		String[] files = vo.getFiles();
		
		System.out.println(Arrays.toString(files));
		
		if(files == null) {return;}
		for(String fileName : files) {
			boardDAO.replaceAttach(fileName, bno);
		}
	}

	@Transactional
	@Override
	public void delete(int bno) throws Exception {
		// attach가 board 를 참조하기 때문에 attach관련 정보부터 먼저 삭제할것
		boardDAO.deleteAttach(bno);
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
	public List<String> getAttach(int bno) throws Exception {
		return boardDAO.getAttach(bno);
	}

	@Override
	public List<BoardVO> listPopular(Criteria cri) throws Exception {
		return boardDAO.listPopular(cri);
	}

}
