package com.scit.project.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit.project.dao.MemberDAO;
import com.scit.project.vo.MemberVO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession session;
	
	public int memberJoin(MemberVO member) throws Exception {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int cnt = 0;
		try {
			cnt = mapper.memberJoin(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}
	
	public int memberSelectOneId(String member_id) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int cnt = 0;
		try {
			cnt = mapper.memberSelectOneId(member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int memberSelectOneEm(String member_email) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int cnt = 0;
		try {
			cnt = mapper.memberSelectOneEm(member_email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public MemberVO memberSelectOne(String member_id) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		MemberVO member = null;
		
		try {
			member = mapper.memberSelectOne(member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
	
}
