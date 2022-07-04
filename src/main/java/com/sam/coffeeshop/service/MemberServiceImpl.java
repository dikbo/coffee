package com.sam.coffeeshop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sam.coffeeshop.domain.Member;
import com.sam.coffeeshop.mappers.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public void join(Member member) {
		// TODO Auto-generated method stub
		memberMapper.join(member);
	}

	@Override
	public int idCheck(String member_id) {
		// TODO Auto-generated method stub
		return memberMapper.idCheck(member_id);
	}


	@Override
	public void update(Member member) {
		// TODO Auto-generated method stub
		memberMapper.update(member);
	}

	@Override
	public void delete(String member_id) {
		// TODO Auto-generated method stub
		memberMapper.delete(member_id);
	}

	
	
	@Override
	public Member getMemberById(String member_id) {
		return memberMapper.getMemberById(member_id);
	}

	@Override
	public int emailCheck(String email) {
		// TODO Auto-generated method stub
		return memberMapper.emailCheck(email);
	}

	@Override
	public Member pwCheck(String password) {
		// TODO Auto-generated method stub
		return memberMapper.pwCheck(password);
	}

}
