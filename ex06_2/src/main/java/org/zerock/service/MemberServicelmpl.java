package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServicelmpl implements MemberService{
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Transactional
	@Override
	public void insert(MemberVO member) {

		log.info("insert......" + member);		
		MemberVO du = mapper.read(member.getUserid());
		if (du != null || member == null) {
			return;
		}
		mapper.insert(member);
		mapper.insert_auth(member.getUserid());
	}
	
	@Override
	public MemberVO read(String userid) {

		log.info("get......" + userid);

		return mapper.read(userid);

	}
}
