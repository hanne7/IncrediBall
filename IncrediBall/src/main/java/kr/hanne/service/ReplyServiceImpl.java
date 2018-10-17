package kr.hanne.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.hanne.dao.ReplyDAO;
import kr.hanne.domain.Criteria;
import kr.hanne.domain.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDAO;
	
	@Override
	public List<ReplyVO> list(int bno) throws Exception {
		return replyDAO.list(bno);
	}

	@Override
	public void create(ReplyVO vo) throws Exception {
		replyDAO.create(vo);
	}

	@Override
	public void modify(ReplyVO vo) throws Exception {
		replyDAO.modify(vo);
	}

	@Override
	public void delete(int rno) throws Exception {
		replyDAO.delete(rno);
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
