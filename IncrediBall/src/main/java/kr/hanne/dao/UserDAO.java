package kr.hanne.dao;

import java.util.Date;

import kr.hanne.domain.UserVO;
import kr.hanne.dto.LoginDTO;

public interface UserDAO {
	
	public UserVO login(LoginDTO dto) throws Exception;
	
	public void insertUser(UserVO vo) throws Exception;
	
	public UserVO selectUser(String userid) throws Exception;
	
	public void updateUser(UserVO vo) throws Exception;
	
	public void keepLogin(String userId, String sessionId, Date next);
	
	public UserVO checkUserWithSessionKey(String value);
}
