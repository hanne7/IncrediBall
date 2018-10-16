package kr.hanne.service;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.hanne.dao.ShopDAO;
import kr.hanne.domain.Criteria;
import kr.hanne.domain.ProductVO;

@Service
public class ShopServiceImpl implements ShopService {

	@Inject
	private ShopDAO shopDAO;
	
	@Transactional
	@Override
	public void create(ProductVO vo) throws Exception {
		shopDAO.create(vo);
		
		String[] files = vo.getFiles();
		
		System.out.println(Arrays.toString(files));
		
		if(files == null) {
			return;
		}
		
		for(String fileName : files) {
			shopDAO.addAttach(fileName);
		}
	}

	@Override
	public List<ProductVO> list(Criteria cri) throws Exception {
		return shopDAO.list(cri);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {
		return shopDAO.countPaging(cri);
	}

	@Override
	public ProductVO read(int idx) throws Exception {
		return shopDAO.read(idx);
	}

	@Transactional
	@Override
	public void modify(ProductVO vo) throws Exception {
		shopDAO.modify(vo);
		
		int idx = vo.getIdx();
		shopDAO.deleteAttach(idx);
		
		String[] files = vo.getFiles();
		
		System.out.println(Arrays.toString(files));
		
		if(files == null) {return;}
		for(String fileName : files) {
			shopDAO.replaceAttach(fileName, idx);
		}
	}

	@Transactional
	@Override
	public void delete(int idx) throws Exception {
		shopDAO.deleteAttach(idx);
		shopDAO.delete(idx);
	}
	
	@Override
	public List<String> getAttach(int idx) throws Exception {
		return shopDAO.getAttach(idx);
	}

	@Override
	public int countCategoryPaging(Criteria cri) throws Exception {
		return shopDAO.countCategoryPaging(cri);
	}

	@Override
	public List<ProductVO> listCategory(Criteria cri) throws Exception {
		return shopDAO.listCategory(cri);
	}

	@Override
	public List<ProductVO> listSearch(Criteria cri) throws Exception {
		return shopDAO.listSearch(cri);
	}

	@Override
	public int searchCountPaging(Criteria cri) throws Exception {
		return shopDAO.searchCountPaging(cri);
	}

	@Override
	public List<ProductVO> categorySearch(Criteria cri) throws Exception {
		return shopDAO.categorySearch(cri);
	}

	@Override
	public int categorySearchCount(Criteria cri) throws Exception {
		return shopDAO.categorySearchCount(cri);
	}
}
