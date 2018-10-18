package kr.hanne.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.hanne.dao.BoardDAO;
import kr.hanne.dao.ReplyDAO;
import kr.hanne.domain.Criteria;
import kr.hanne.domain.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDAO;
	
	@Inject
	private BoardDAO boardDAO;
	
	@Override
	public List<ReplyVO> list(int bno) throws Exception {
		return replyDAO.list(bno);
	}

	@Transactional
	@Override
	public void create(ReplyVO vo) throws Exception {
		replyDAO.create(vo);
		boardDAO.updateReplyCnt(vo.getBno(), 1);
	}

	@Override
	public void modify(ReplyVO vo) throws Exception {
		replyDAO.modify(vo);
	}

	@Transactional
	@Override
	public void delete(int rno) throws Exception {
		int bno = replyDAO.getBno(rno);
		replyDAO.delete(rno);
		boardDAO.updateReplyCnt(bno, -1);
	}

	@Override
	public List<ReplyVO> listPage(int bno, Criteria cri) throws Exception {
		return replyDAO.listPage(bno, cri);
	}

	@Override
	public int countPage(int bno) throws Exception {
		return replyDAO.countPage(bno);
	}

}
