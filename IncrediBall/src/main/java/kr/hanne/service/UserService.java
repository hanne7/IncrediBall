package kr.hanne.service;

import kr.hanne.domain.UserVO;
import kr.hanne.dto.LoginDTO;

public interface UserService {

	public UserVO login(LoginDTO dto) throws Exception;
	
	public void insertUser(UserVO vo) throws Exception;
	
	public UserVO selectUser(String userid) throws Exception;
	
	public void updateUser(UserVO vo) throws Exception;
}
