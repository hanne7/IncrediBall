package kr.hanne.dao;

import java.util.List;

import kr.hanne.domain.Criteria;
import kr.hanne.domain.ReplyVO;

public interface ReplyDAO {

	public List<ReplyVO> list(int bno) throws Exception;
	
	public void create(ReplyVO vo) throws Exception;
	
	public void modify(ReplyVO vo) throws Exception;
	
	public void delete(int rno) throws Exception;
	
	public List<ReplyVO> listPage(int bno, Criteria cri) throws Exception;
	
	public int countPage(int bno) throws Exception;
}
