package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {

	public MemberVO read(String userid);
	
	public void insert(MemberVO me);
}
