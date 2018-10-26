package kr.hanne.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.hanne.domain.UserVO;
import kr.hanne.dto.LoginDTO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "kr.hanne.mapper.userMapper";
	
	@Override
	public void insertUser(UserVO vo) throws Exception {
		session.insert(namespace + ".insertUser", vo);		
	}

	@Override
	public UserVO selectUser(String userid) throws Exception {
		return session.selectOne(namespace + ".selectUser", userid);
	}

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return session.selectOne(namespace + ".login", dto);
	}

	@Override
	public void updateUser(UserVO vo) throws Exception {
		session.update(namespace + ".updateUser", vo);
	}

	@Override
	public void keepLogin(String userId, String sessionId, Date next) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("userId", userId);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next", next);
		
		session.update(namespace+".keepLogin", paramMap);
	}

	@Override
	public UserVO checkUserWithSessionKey(String value) {
		return session.selectOne(namespace+".checkUserWithSessionKey", value);
	}

	@Override
	public void deleteUser(int idx) throws Exception {
		session.delete(namespace+".deleteUser", idx);
	}

	@Override
	public void updateImg(UserVO vo) throws Exception {
		session.update(namespace+".updateImg", vo);
	}
}
