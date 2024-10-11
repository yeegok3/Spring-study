package kr.board.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.board.entity.Member;
import kr.board.entity.MemberUser;
import kr.board.mapper.MemberMapper;

// UserDetailsSerive 인터페이스 구현함수
public class MemberUserDetailsService implements UserDetailsService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//		로그인 처리하기
		Member mvo = memberMapper.memLogin(username);
		if (mvo != null) {
			return new MemberUser(mvo);
		}else {
			throw new UsernameNotFoundException("로그인 아이디 : " + username + "은 없는 아이디입니다.");
		}
		
	}

}
