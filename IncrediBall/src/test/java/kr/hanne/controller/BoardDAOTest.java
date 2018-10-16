package kr.hanne.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import kr.hanne.dao.BoardDAO;
import kr.hanne.domain.BoardVO;
import kr.hanne.domain.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
public class BoardDAOTest {

	@Inject
	private BoardDAO dao;
	
	private static Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Autowired 
	private ServletContext servletContext;

	@Test
	public void test() throws Exception {
//		logger.info(dao.read(3).toString());
//		BoardVO vo = new BoardVO();
//		vo.setTitle("새글 테스트");
//		vo.setContent("새글 입니다");
//		vo.setUseridx(1);
//		dao.create(vo);
		logger.info(servletContext.getRealPath("/"));

	}
	
	@Test
	public void testListCri() throws Exception{
		Criteria cri = new Criteria();
		cri.setPage(2);
		cri.setPerPageNum(20);
		
		List<BoardVO> list = dao.list(cri);
		
		for (BoardVO vo : list) {
			logger.info(vo.getBno() + ":" + vo.getTitle());
		}
	}
	
	

	

}
