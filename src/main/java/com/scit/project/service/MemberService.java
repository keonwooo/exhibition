package com.scit.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scit.project.dao.MemberDAO;
import com.scit.project.vo.MemberVO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO dao;
	
	
	public String memberJoin(MemberVO member) throws Exception {
		dao.memberJoin(member);
		return "redirect:/member/memberJoinForm";
	}
	
	public int idCheck(String member_id) {
		int cnt = dao.memberSelectOne(member_id);
		return cnt;
	}

}
