package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);
	public String auth(String userid);
	public String code();
	
	public void insert(MemberVO me);
	public void insert_auth_user(String userid);
	public void insert_auth_admin(String userid);
	public void codeupdate(String codeupdate);
}
