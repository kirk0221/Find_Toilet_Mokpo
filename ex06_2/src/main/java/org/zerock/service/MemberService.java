package org.zerock.service;


import org.zerock.domain.MemberVO;

public interface MemberService {

	public MemberVO read(String userid);
	public String coderead();
	public String readauth(String userid);
	
	public void insert(MemberVO me);
	public void insertadmin(String userid);
	public void codeupdate(String codeupdate);
}
