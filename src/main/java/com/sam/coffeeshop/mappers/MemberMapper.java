package com.sam.coffeeshop.mappers;

import org.apache.ibatis.annotations.Mapper;

import com.sam.coffeeshop.domain.Member;

@Mapper
public interface MemberMapper {
	// 회원가입
	public void join(Member member);

	// 중복체크
	public int idCheck(String member_id);

	// 회원수정
	public void update(Member member);

	// 회원삭제
	public void delete(String member_id);
	
	public Member getMemberById(String member_id);
	//이메일 체크
	public int emailCheck(String email);
	
	public Member pwCheck(String password);
}
