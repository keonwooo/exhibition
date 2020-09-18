package com.scit.project.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scit.project.dao.MemberDAO;
import com.scit.project.vo.MemberVO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private HttpSession session;
	
	
	public String memberJoin(MemberVO member) throws Exception {
		dao.memberJoin(member);
		return "redirect:/";
	}
	
	public int idCheck(String member_id) {
		int cnt = dao.memberSelectOneId(member_id);
		return cnt;
	}

	public int emailCheck(String member_email) {
		int cnt = dao.memberSelectOneEm(member_email);
		return cnt;
	}

	public String memberLogin(MemberVO member) {
		MemberVO loginCheck = dao.memberSelectOne(member.getMember_id());
		String page = "";
		if(loginCheck != null && member.getMember_pw().equals(loginCheck.getMember_pw())){
			session.setAttribute("loginID", member.getMember_id());
			page = "redirect:/";
		}else {
			page = "redirect:/member/memberLoginForm";
		}
		return page;
	}

}
