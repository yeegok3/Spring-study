package kr.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.Auth;
import kr.board.entity.Member;
import kr.board.entity.MemberUser;
import kr.board.mapper.MemberMapper;
import kr.board.security.MemberUserDetailsService;

@Controller
public class MemberController {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	MemberUserDetailsService memberUserDetailsService;
	
	@Autowired
	PasswordEncoder pwEncoder;
	
	@RequestMapping("/memJoin.do")
	public String memJoin() {
		return "member/memJoin";
	}
	
	@RequestMapping("/memRegisterCheck.do")
	public @ResponseBody int memRegisterCheck(@RequestParam("memID") String memID) {
		
		Member m = memberMapper.registerCheck(memID);
		if (m != null || memID.trim().equals("")) {
			return 0;
		}
		return 1;
	}
	
//	회원가입 처리
	@RequestMapping("/memRegister.do")
	public String memRegister(Member m, String memPassword2, RedirectAttributes reattr, HttpSession session) {
		if (m.getMemID() == null || m.getMemID().trim().equals("") ||
				m.getMemPassword() == null || m.getMemPassword().trim().equals("") ||
				memPassword2 == null || memPassword2.trim().equals("") ||
				m.getMemName() == null || m.getMemName().trim().equals("") ||
				m.getMemAge() <= 10 || m.getMemAge() >= 100 ||
				m.getAuthList().size() == 0||
				m.getMemGender() == null || m.getMemGender().trim().equals("") ||
				m.getMemEmail() == null || m.getMemEmail().trim().equals("")) {
			reattr.addFlashAttribute("msgType", "실패 메세지");
			reattr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			return "redirect:/memJoin.do";
		}
		if (!m.getMemPassword().equals(memPassword2)) {
			reattr.addFlashAttribute("msgType", "실패 메세지");
			reattr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/memJoin.do";
		}
		m.setMemProfile("");
//		비밀번호 보안설정
		String encryptPw = pwEncoder.encode(m.getMemPassword());
		m.setMemPassword(encryptPw);
		int result = memberMapper.register(m);
		if (result == 1) {
//			권한 테이블에 회원 권한추가
			List<Auth> list = m.getAuthList();
			for (Auth authVO : list) {
				if (authVO.getAuth() != null) {
					Auth saveVO = new Auth();
					saveVO.setMemID(m.getMemID());
					saveVO.setAuth(authVO.getAuth());
					memberMapper.authInsert(saveVO);
				}
			}
			reattr.addFlashAttribute("msgType", "성공 메세지");
			reattr.addFlashAttribute("msg", "회원가입에 성공했습니다.");

			return "redirect:/memLoginForm.do";
		}else {
			reattr.addFlashAttribute("msgType", "실패 메세지");
			reattr.addFlashAttribute("msg", "이미 가입된 회원입니다.");
			return "redirect:/memJoin.do";
		}
		
	}
	
/*	@RequestMapping("/memLogout.do")
	public String memLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}*/
	
//	로그인폼 이동
	@RequestMapping("/memLoginForm.do")
	public String memLoginForm() {
		return "member/memLoginForm";
	}
	
//	로그인 기능 구현
/*	@RequestMapping("/memLogin.do")
	public String memLogin(Member m, RedirectAttributes reAttr, HttpSession session) {
		if (m.getMemID() == null || m.getMemID().trim().equals("") ||
				m.getMemPassword() == null || m.getMemPassword().trim().equals("")) {
			reAttr.addFlashAttribute("msgType", "실패 메세지");
			reAttr.addFlashAttribute("msg", "아이디와 비밀번호를 빠짐없이 입력해 주세요.");
			
			return "redirect:/memLoginForm.do";
		}
		Member mvo = memberMapper.memLogin(m.getMemID());
		if (mvo != null && pwEncoder.matches(m.getMemPassword(), mvo.getMemPassword())) {
			reAttr.addFlashAttribute("msgType", "성공 메세지");
			reAttr.addFlashAttribute("msg", "로그인에 성공했습니다.");
			session.setAttribute("mvo", mvo);
			return "redirect:/";
		}else {
			reAttr.addFlashAttribute("msgType", "실패 메세지");
			reAttr.addFlashAttribute("msg", "다시 로그인 해주세요.");
			return "redirect:/memLoginForm.do";
		}
		
	}*/
	
//	회원정보 수정화면가기
	@RequestMapping("/memUpdateForm.do")
	public String memUpdateForm() {
		return "member/memUpdateForm";
	}
	
//	회원정보 수정기능구현
	@RequestMapping("/memUpdate.do")
	public String memUpdate(Member m, RedirectAttributes reattr, String memPassword2, HttpSession session) {
		
		if (m.getMemID() == null || m.getMemID().trim().equals("") ||
				m.getMemPassword() == null || m.getMemPassword().trim().equals("") ||
				memPassword2 == null || memPassword2.trim().equals("") ||
				m.getMemName() == null || m.getMemName().trim().equals("") ||
				m.getMemAge() <= 10 || m.getMemAge() >= 100 ||
				m.getAuthList().size() == 0 ||
				m.getMemGender() == null || m.getMemGender().trim().equals("") ||
				m.getMemEmail() == null || m.getMemEmail().trim().equals("")) {
			reattr.addFlashAttribute("msgType", "실패 메세지");
			reattr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			return "redirect:/memUpdateForm.do";
		}
		if (!m.getMemPassword().equals(memPassword2)) {
			reattr.addFlashAttribute("msgType", "실패 메세지");
			reattr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/memUpdateForm.do";
		}

//		비밀번호 암호화 추가
		String encryptPw = pwEncoder.encode(m.getMemPassword());
		m.setMemPassword(encryptPw);
		int result = memberMapper.memUpdate(m);
		if (result == 1) {
//			기존권한을 삭제하고
			memberMapper.authDelete(m.getMemID());
//			새로운 권한 추가
			List<Auth> list = m.getAuthList();
			for (Auth authVO : list) {
				if (authVO.getAuth() != null) {
					Auth saveVO = new Auth();
					saveVO.setMemID(m.getMemID());
					saveVO.setAuth(authVO.getAuth());
					memberMapper.authInsert(saveVO);
				}
			}
			
			reattr.addFlashAttribute("msgType", "성공 메세지");
			reattr.addFlashAttribute("msg", "회원정보 수정에 완료되었습니다.");
			
			// 회원수정이 성공하면=>로그인처리하기
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
			MemberUser userAccount = (MemberUser) authentication.getPrincipal();
			SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication,userAccount.getMember().getMemID()));
			
			return "redirect:/";
		}else {
			reattr.addFlashAttribute("msgType", "실패 메세지");
			reattr.addFlashAttribute("msg", "회원정보 수정에 실패했습니다.");
			return "redirect:/memUpdateForm.do";
		}
	}
	
//	사용자 사진 등록화면
	@RequestMapping("/memImgForm.do")
	public String memImgForm() {
		return "member/memImgForm";
	}
	
//	회원사진 이미지 업로드 구현
	@RequestMapping("/memImgUpdate.do")
	public String memImgUpdate(HttpServletRequest request,  HttpSession session, RedirectAttributes reAttr) throws IOException {
//		파일업로드 API(cos.jar)
		MultipartRequest multi = null;
		int fileMaxSize = 40*1024*1024; //10MB
		String savePath = request.getRealPath("resources/upload");
		try {
//			이미지 업로드
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		}catch(Exception e) {
			e.printStackTrace();
			reAttr.addFlashAttribute("msgType", "실패 메세지");
			reAttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘지 못합니다.");
			return "redirect:/memImgForm.do";
		}
//		데이터베이스 테이블에 업로드 작업
		String memID = multi.getParameter("memID");
		String oldProfile = "";
		String newProfile = "";
		File file = multi.getFile("memProfile");
		if (file != null) {
			//이미지 파일 여부를 체크하고 아니면 삭제
			String ext = file.getName().substring(file.getName().lastIndexOf(".")+1);
			ext = ext.toLowerCase();
			if (ext.equals("jpg")) {
				//새로 업로드된 이미지와 DB에 있는 이미지를 교체 하고 삭제해준다.
				oldProfile = memberMapper.getMember(memID).getMemProfile();
				File oldFile = new File(savePath+"/"+oldProfile);
		
				if (oldFile.exists()) {
					oldFile.delete();
				}
				newProfile = file.getName();
			}else {
				if (file.exists()) {
					file.delete();
				}
				reAttr.addFlashAttribute("msgType", "실패 메세지");
				reAttr.addFlashAttribute("msg", "JPG 파일만 업로드 하세요.");
				return "redirect:/memImgForm.do";
			}
			
		}
		// 새로운 이미지를 테이블에 업데이트
		Member mvo = new Member();
		mvo.setMemID(memID);
		mvo.setMemProfile(newProfile);
		memberMapper.memProfileUpdate(mvo);
		
		// 스프링보안(새로운 인증 세션을 생성->객체바인딩)
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		MemberUser userAccount = (MemberUser) authentication.getPrincipal();
		SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication,userAccount.getMember().getMemID()));
		

		
		reAttr.addFlashAttribute("msgType", "성공 메세지");
		reAttr.addFlashAttribute("msg", "이미지 파일 업데이트 완료!.");
		
		return "redirect:/";
	}
	
	 // 스프링 보안(새로운 세션 생성 메서드)
	 // UsernamePasswordAuthenticationToken -> 회원정보+권한정보
	 protected Authentication createNewAuthentication(Authentication currentAuth, String username) {
		    UserDetails newPrincipal = memberUserDetailsService.loadUserByUsername(username);
		    UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
		    newAuth.setDetails(currentAuth.getDetails());	    
		    return newAuth;
	 }

	@GetMapping("/accessDenied")
	public String showAccessDenied() {
		return "accessDenied";
	}
	
	
	
}







































