package kr.board.mapper;


import org.apache.ibatis.annotations.Mapper;

import kr.board.entity.Auth;
import kr.board.entity.Member;

@Mapper
public interface MemberMapper {
	
	public Member registerCheck(String memID);
	
	public int register(Member mvo);
	
	public Member memLogin(Member mvo);
	
	public int memUpdate(Member mvo);
	
	public Member getMember(String memID);
	
	public void memProfileUpdate(Member mvo);

	public void authInsert(Auth saveVO);

	public void authDelete(String memID);
	
	
}



