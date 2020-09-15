package com.scit.project.dao;

import com.scit.project.vo.MemberVO;

public interface MemberMapper {

	public int memberSelectOneId(String member_id);

	public int memberJoin(MemberVO member);

	public int memberSelectOneEm(String member_email);
	
}
