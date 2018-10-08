package kr.hanne.dao;

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

}
