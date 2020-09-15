package com.scit.project.dao;

import com.scit.project.vo.MemberVO;

public interface MemberMapper {

	public int memberSelectOne(String member_id);

	public int memberJoin(MemberVO member);
	
}
