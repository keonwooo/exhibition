package com.scit.project.dao;

import com.scit.project.vo.MemberVO;

public interface MemberMapper {

	int memberSelectOne(String member_id);

	int memberJoin(MemberVO member);

}
