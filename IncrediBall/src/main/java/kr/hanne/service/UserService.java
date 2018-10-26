package kr.hanne.service;

import java.util.Date;

import kr.hanne.domain.UserVO;
import kr.hanne.dto.LoginDTO;

public interface UserService {

	public UserVO login(LoginDTO dto) throws Exception;
	
	public void insertUser(UserVO vo) throws Exception;
	
	public UserVO selectUser(String userid) throws Exception;
	
	public void updateUser(UserVO vo) throws Exception;
	
	public void keepLogin(String userId, String sessionId, Date next) throws Exception;
	
	public UserVO checkUserWithSessionKey(String value);
	
	public void deleteUser(int idx) throws Exception;
	
	public void updateImg(UserVO vo) throws Exception;
}
