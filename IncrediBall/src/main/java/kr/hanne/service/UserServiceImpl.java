package kr.hanne.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.hanne.dao.UserDAO;
import kr.hanne.domain.UserVO;
import kr.hanne.dto.LoginDTO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO userDAO;
	
	@Override
	public void insertUser(UserVO vo) throws Exception {
		userDAO.insertUser(vo);
	}

	@Override
	public UserVO selectUser(String userid) throws Exception {
		return userDAO.selectUser(userid);
	}

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return userDAO.login(dto);
	}

	@Override
	public void updateUser(UserVO vo) throws Exception {
		userDAO.updateUser(vo);
	}

}
