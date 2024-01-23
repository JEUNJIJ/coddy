package com.kh.coddy.member.controller;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.board.free.model.vo.Fboard;
import com.kh.coddy.board.intro.model.vo.IBoard;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.board.job.model.vo.Hwishlist;
import com.kh.coddy.board.recruitment.model.vo.Recruitment;
import com.kh.coddy.common.Keys;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.auth.model.vo.Auth;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.service.MemberService;
import com.kh.coddy.member.model.vo.Member;

@Controller
public class MemberController {
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private MemberService memberService;
	
	@Autowired private PasswordEncoder pbkdf2;
	
	private SecureRandom sr = new SecureRandom();
	
	private final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	
	@Autowired private JavaMailSender mailSender;
	
	@GetMapping(value="/kakaoLogin.me")
	public String KakakoLogin(String code, HttpSession session) {
		if((session.getAttribute("loginMember") != null) || (session.getAttribute("loginCompany") != null)) { session.setAttribute("alertMsg", "로그아웃후 이용해주세요."); return "redirect:/"; }
		String kakaoClientKey = "";
		try { kakaoClientKey = Keys.read(new ClassPathResource("keys/kakaoLogin.json").getURL().getPath(), "key.kakaoLogin"); }
		catch (IOException | ParseException e) { e.printStackTrace(); }
		String access_Token = getAccessToken(code, kakaoClientKey);
		Member kakaoMember = getUserInfo(access_Token, kakaoClientKey);
		Member checkMember = memberService.loginMember(kakaoMember);
		if(checkMember == null) {
			kakaoMember.setMemberPwd(pbkdf2.encode("000000"));
			int result = memberService.insertMember(kakaoMember);
			if(result > 0) { session.setAttribute("loginMember", memberService.loginMember(kakaoMember)); session.setAttribute("isKakao", "true"); session.setAttribute("alertMsg", kakaoMember.getMemberName() + "님 환영합니다! 최초 비밀번호는 000000입니다. 변경해주세요!"); return "redirect:/pwdChange.me"; }
			else { session.setAttribute("errorMsg", "카카오 로그인 실패"); return "common/errorPage"; }
		}
		else {
			session.setAttribute("loginMember", checkMember);
			session.setAttribute("isKakao", "true");
			session.setAttribute("alertMsg", checkMember.getMemberName() + "님 환영합니다!");
			return "redirect:/";
		}
	}
	
	@GetMapping(value="kakaoLogout.me")
	public String kakaoLogout(HttpSession session) {
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인후 이용해주세요."); return "redirect:/"; }
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "기업 로그아웃후 이용해주세요."); return "redirect:/"; }
		session.invalidate();
		return "redirect:/";				
	}
	
	@RequestMapping("myPage.me") // 마이페이지 수정화면 포워딩
	public String myPage(HttpSession session) {
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			return "redirect:/";
		}
		return "member/myPage";
	}
	
	@RequestMapping("myPage.se") // 마이페이지 화면 포워딩
	public String myPageSe(HttpSession session) {
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			
			return "redirect:/";
		}
		
		session.setAttribute("countSum", this.boardSum(session));
		return "member/myPage1";
	}
	
	@PostMapping(value="member.co", produces="text/html; charset=UTF-8") @ResponseBody public String uploadFile(HttpSession session, HttpServletRequest req, MultipartFile uploadFiles) {
		String path = req.getRealPath("resources\\image\\profile\\");
		File file = new File(path, String.format("%08d", ((Member)(session.getAttribute("loginMember"))).getMemberNo()) + ".jpg");
		try { 
			uploadFiles.transferTo(file); 
			if(memberService.uploadFile(((Member)(session.getAttribute("loginMember"))).getMemberNo()) > 0) { 
				Member myMember = ((Member)(session.getAttribute("loginMember")));
				myMember.setMemberPhotoExtend("jpg"); session.setAttribute("loginMember", myMember);
				return "이미지 업로드 성공"; 
			}
			else { return "이미지 업로드 실패"; }
		}
		catch (IllegalStateException | IOException e) { 
			e.printStackTrace(); return "이미지 업로드 실패";
		}
	}
	@PostMapping(value="member.mo", produces="text/html; charset=UTF-8") 
	@ResponseBody 
	public String uploadFileBg(HttpSession session, HttpServletRequest req, MultipartFile uploadFiles) {
		String path = req.getRealPath("resources\\image\\background\\");
		File file = new File(path, String.format("%08d", ((Member)(session.getAttribute("loginMember"))).getMemberNo()) + ".jpg");
		try { 
			uploadFiles.transferTo(file); 
			return "이미지 업로드 성공"; 
		}
		catch (IllegalStateException | IOException e) { e.printStackTrace(); return "이미지 업로드 실패"; }
	}
	
	@PostMapping("update.me") // 수정하기
	public String updateMember(Member m, MultipartFile[] upfile, HttpSession session, Model model) {
		
		
		/*
		// 전달된 파일이 있을 경우
		// => 파일명을 수정 후 서버로 업로드
		for(int i = 0; i < upfile.length; i++) {
		if(!upfile[i].getOriginalFilename().equals("")) {
			
			// 파일명 수정 작업 진행 후 서버로 업로드 시키기
			// 1. 원본파일명 뽑아오기
			
			// 4. 원본파일명으로 부터 확장자명을 뽑아오기
			// ".jpg" / ".png"
			
			// 5. 모두 이어 붙이기
			String changeName = String.format("%08d", m.getMemberNo()) + ".jpg";
			
			// 6. 업로드 하고자 하는 물리적인 경로 알아내기
			String savePath = session.getServletContext().getRealPath("/resources/image/profile/");
			String savePath2 = session.getServletContext().getRealPath("resources/image/background/");
			
			// 7. 경로와 수정파일명을 합체 후 파일을 업로드 해주기
			
			try{
				upfile[0].transferTo(new File(savePath + changeName));
				upfile[1].transferTo(new File(savePath2 + changeName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			// 8. 원본명, 서버에 업로드된 수정파일명을 Member m에 이어서 담기
			m.setMemberPhotoExtend("jpg");
		}
	}	
		// 이 시점 기준으로
		// 넘어온 첨부파일이 있었을 경우(if문을 거쳤기 때문) 
		// member m 에 내용들이 담김
		// 넘어온 첨부파일이 없었을 경우(if문을 거치지 않았기 때문)
		
		// 현재 넘어온 첨부파일 그 자체를 서버의 폴더에 저장시키는 역할
		*/
		
		int result = memberService.updateMember(m);
		
		if(result > 0) { // 수정 성공
		
			Member updateMem = memberService.loginMember(m);
		
			session.setAttribute("loginMember", updateMem);
		
			// 일회성 알람 문구
			session.setAttribute("alertMsg", "회원정보 변경 성공!");
			
			return "redirect:/myPage.me";
			
		} else { // 수정 실패
			
			model.addAttribute("errorMsg", "회원 정보 변경 실패");
			
			return "common/errorPage";
		}
}

	
	// 비밀번호 페이지만 보여주는거
	@RequestMapping("pwdChange.me")
	public String PwdChange(HttpSession session){
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			return "redirect:/";
		}
		if(session.getAttribute("loginCompany") != null) {
			session.setAttribute("alertMsg", "기업회원은 이용이 불가능합니다.");
			return "redirect:/";
		}
		return "member/PwdChange";
	}
	
	// 비밀번호 업데이트
	@PostMapping(value="pwd.me")
	public String PwdChangeForm(Member m, HttpSession session, HttpServletRequest request) throws Exception {
			
		String updatePwd = request.getParameter("updatePwd");
		String checkPwd = request.getParameter("checkPwd");
			
		String encPwd = ((Member)session.getAttribute("loginMember")).getMemberPwd();
			
		if(pbkdf2.matches(m.getMemberPwd(), encPwd) && updatePwd.equals(checkPwd)) { // memberPwd와 encPwd가 같을 경우
				
			// update 구문 진행
			m.setMemberPwd(pbkdf2.encode(updatePwd));
			int result = memberService.PwdChangeForm(m);
				
			if(result > 0) {
				session.removeAttribute("loginMember");
				session.setAttribute("alertMsg", "성공적으로 변경되었습니다. 다시 로그인 해주세요");
					
				return "redirect:/";
					
			} else {
					
				session.setAttribute("alertMsg", "변경을 하지 못했습니다.");
					
				return "redirect:/pwdChange.me";
			}
			
		}
		else {
				
			session.setAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
				
			return "redirect:/pwdChange.me";
		}
	}
	
public int boardSum(HttpSession session) {
		
		Member m = ((Member)(session.getAttribute("loginMember")));
		
		// recruitment
		int count1 = memberService.count1(m.getMemberNo());
		
		// cboard
		int count2 = memberService.count2(m.getMemberNo());
		
		// fboard
		int count3 = memberService.count3(m.getMemberNo());
		
		// iboard
		int count4 = memberService.count4(m.getMemberNo());
		
		int countSum = count1 + count2 + count3 + count4; 
		
		
		return countSum;
	}
	
	@RequestMapping("projecting.bo")
	public ModelAndView Projecting(HttpSession session, @RequestParam(value="cpage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		Member m = ((Member)(session.getAttribute("loginMember")));
		
		int listCount = memberService.projecting(m.getMemberNo());
		
		
		int pageLimit = 5;
		int boardLimit = 15;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Recruitment> list = memberService.selectListing(pi, m.getMemberNo());
		
		mv.addObject("list", list).addObject("pi", pi).addObject("listCount", listCount).setViewName("member/projecting");
		
		return mv;
	}
	
	// 상대방 프로필 뜨게하는 Form
	@RequestMapping("profile.me")
	public String yourPage(HttpSession session, @RequestParam(value="mno") int memberNo, Model model) {
		
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			return "redirect:/";
		}
		
		ArrayList<Member> list = new ArrayList<Member>();
		
		list = memberService.selectMember(memberNo);
		
				// recruitment
				int count1 = memberService.count1(memberNo);
				
				// cboard
				int count2 = memberService.count2(memberNo);
				
				// fboard
				int count3 = memberService.count3(memberNo);
				
				// iboard
				int count4 = memberService.count4(memberNo);
				
				int countSum = count1 + count2 + count3 + count4;
				
				
				model.addAttribute("countSum", countSum);
				model.addAttribute("list", list);
		
		
		return "member/yourPage";
	}
	
	
	@GetMapping("yourProjectIng.bo")
	public ModelAndView yourprojecting(HttpSession session, @RequestParam(value="cpage", defaultValue="1") int currentPage,
			ModelAndView mv, @RequestParam(value="mno") int memberNo) {
		
		int listCount = memberService.selectListyourCount(memberNo);
		
		int pageLimit = 5;
		int boardLimit = 15;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Recruitment> list = memberService.selectListyour(pi, memberNo);
	
		mv.addObject("list", list).addObject("pi", pi).addObject("listCount", listCount).setViewName("member/yourProjectIng");
		
		return mv;
	}
	
	@RequestMapping("delete.me")
	public String deleteId(HttpSession session) {
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			return "redirect:/";
		}
		if(session.getAttribute("loginCompany") != null) {
			session.setAttribute("alertMsg", "기업회원은 이용이 불가능합니다.");
			return "redirect:/";
		}
		return "member/deleteForm";
	}
	
	@RequestMapping("deleteForm.me")
	public String DeleteForm(String memberId, String memberPwd, HttpSession session, Model model) {
		String encPwd = ((Member)session.getAttribute("loginMember")).getMemberPwd();
	
		if(pbkdf2.matches(memberPwd, encPwd)) {
			int result = memberService.deleteMember(memberId); 
			
			if(memberId.equals("admin")) {
				result = 0;
			}

			if(result > 0) {

				session.removeAttribute("loginMember");
				session.setAttribute("alertMsg", "그동안 이용해주셔서 감사합니다.");
	
				return "redirect:/";
			} else {
				
				
				model.addAttribute("errorMsg", "회원 탈퇴에 실패했습니다.");
				
				if(memberId.equals("admin")) {
					model.addAttribute("errorMsg", "운영자는 탈퇴 안됨");
				}
				return "common/errorPage";
			}
		} else { 
			
			// 비밀번호가 일치하지 않을 경우
			session.setAttribute("alertMsg", "비밀번호를 잘 못 입력하였습니다.");
		
			return "redirect:/delete.me";
		}
	}
	
	
	@RequestMapping("written.me")
	public String Written(HttpSession session) {
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			return "redirect:/";
		}
		if(session.getAttribute("loginCompany") != null) {
			session.setAttribute("alertMsg", "기업회원은 이용이 불가능합니다.");
			return "redirect:/";
		}
		return "member/writtenBoard";
	}
	

	@GetMapping(value="written.io")
	public ModelAndView WrittenForm(HttpSession session, @RequestParam(value="cpage", defaultValue="1") int currentPage,
			ModelAndView mv)  {


		Member m = ((Member)(session.getAttribute("loginMember")));
		int listCount = memberService.selectListCounti(m.getMemberNo());
		
		int pageLimit = 5;
		int boardLimit = 15;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

			ArrayList<IBoard> list = memberService.selectListi(pi,m.getMemberNo());
			
			mv.addObject("list", list).addObject("pi", pi).addObject("listCount", listCount).setViewName("member/writtenBoardI");
			
			return mv;
		
	}
	
	@GetMapping(value="written.ro")
	public ModelAndView WrittenForm1(HttpSession session, @RequestParam(value="cpage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		Member m = ((Member)(session.getAttribute("loginMember")));
		
		int listCount = memberService.selectListCountr(m.getMemberNo());
		
		int pageLimit = 5;
		int boardLimit = 15;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Recruitment> list = memberService.selectListr(pi, m.getMemberNo());
	
		mv.addObject("list", list).addObject("pi", pi).addObject("listCount", listCount).setViewName("member/writtenBoardR");
		
		return mv;
	}
	
	@GetMapping(value="written.co")
	public ModelAndView WrittenForm2(HttpSession session, @RequestParam(value="cpage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		Member m = ((Member)(session.getAttribute("loginMember")));
		
		int listCount = memberService.selectListCountc(m.getMemberNo());
		
		int pageLimit = 5;
		int boardLimit = 15;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Recruitment> list = memberService.selectListc(pi, m.getMemberNo());
	
		mv.addObject("list", list).addObject("pi", pi).addObject("listCount", listCount).setViewName("member/writtenBoardC");
		
		return mv;
	}
	
	@GetMapping(value="written.fo")
	public ModelAndView WrittenForm3(HttpSession session, @RequestParam(value="cpage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		Member m = ((Member)(session.getAttribute("loginMember")));
		
		int listCount = memberService.selectListCountf(m.getMemberNo());
		
		int pageLimit = 5;
		int boardLimit = 15;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Fboard> list = memberService.selectListf(pi, m.getMemberNo());
	
		mv.addObject("list", list).addObject("pi", pi).addObject("listCount", listCount).setViewName("member/writtenBoardF");
		
		return mv;
	}
	
	
	@GetMapping(value="likedJob.me")
	public ModelAndView getLikedJobs(HttpSession session, @RequestParam(value="cpage", defaultValue="1") int currentPage,
	        ModelAndView mv) {
	    Member m = (Member) session.getAttribute("loginMember");

	    int likedJobCount = memberService.selectListCounth(m.getMemberNo());

	    int pageLimit = 5;
	    int boardLimit = 15;

	    PageInfo pi = Pagination.getPageInfo(likedJobCount, currentPage, pageLimit, boardLimit);

	    ArrayList<Hboard> likedJobs = memberService.selectListh(pi, m.getMemberNo());
	    System.out.println("ㅇㅅㅇ : " + likedJobs);
	    mv.addObject("list", likedJobs).addObject("pi", pi).addObject("likedJobCount", likedJobCount)
	            .setViewName("member/likedJob");

	    return mv;
	}
	
	
	@GetMapping(value="signup.me") public String signup(HttpSession session) {
		if((session.getAttribute("loginMember") != null) || (session.getAttribute("loginCompany") != null)) { session.setAttribute("alertMsg", "로그아웃후 이용해주세요."); return "redirect:/"; }
		try { session.setAttribute("googleKey", Keys.read(new ClassPathResource("keys/recaptcha2.json").getURL().getPath(), "key")); } 
		catch (IOException | ParseException e) { e.printStackTrace(); } 
		return "member/signupPage"; }

	@PostMapping(value="insert.me") public String insertMember(Member m, Model model, HttpSession session) {
		if((session.getAttribute("loginMember") != null) || (session.getAttribute("loginCompany") != null)) { session.setAttribute("alertMsg", "로그아웃후 이용해주세요."); return "redirect:/"; }
		m.setMemberPwd(pbkdf2.encode(m.getMemberPwd()));
		int result = memberService.insertMember(m); 
		if(result > 0) { log.info("insertMemberId={}", m.getMemberId()); session.setAttribute("alertMsg", "성공적으로 회원가입이 완료되었습니다. 로그인을 진행해주세요."); return "redirect:/"; } 
		else { model.addAttribute("errorMsg", "회원가입 실패"); return "common/errorPage"; } }

	@RequestMapping(value="memberCheck.me", produces="text/html; charset=UTF-8") @ResponseBody public String memberCheck(String checkIds) { int count = memberService.memberCheck(checkIds); if(count > 0) { return "NNNNN"; } else { return "NNNNY"; } }
	
	@PostMapping(value="/login.me")
	public String loginMember(@ModelAttribute Member m, Model model, HttpSession session, HttpServletRequest request) {
		if((session.getAttribute("loginMember") != null) || (session.getAttribute("loginCompany") != null)) { session.setAttribute("alertMsg", "로그아웃후 이용해주세요."); return "redirect:/"; }
		Member loginMember = memberService.loginMember(m);
		
		if((loginMember==null) || !(pbkdf2.matches(m.getMemberPwd(), loginMember.getMemberPwd()))) { model.addAttribute("errorMsg","로그인 실패!"); return "common/errorPage"; }
		else {
			session.setAttribute("loginMember", loginMember);
			session.setAttribute("alertMsg", loginMember.getMemberName() + "님! 로그인에 성공하셨습니다.");
			log.info("loginMember={}, ip={}",loginMember, request.getRemoteAddr());
			return "redirect:/";	
		}
	}
	
	@RequestMapping(value="logout.me") public String logoutMember(HttpSession session, HttpServletRequest request) { 
		if(session.getAttribute("loginMember") != null) { 
			log.info("logoutMember={}, ip={}",session.getAttribute("loginMember"), request.getRemoteAddr()); 
			session.invalidate(); } 
		else { session.setAttribute("alertMsg", "로그인된 유저만 가능해요!"); } 
		return "redirect:/";
	}
	
	@RequestMapping(value="authMake.me", produces="text/html; charset=UTF-8") @ResponseBody 
	public String authMake(String email) {
		int r = (int)(Math.random() * 900000 + 100000);
		if((memberService.authMake(new Auth("", String.valueOf(r), email))) > 0) {
			SimpleMailMessage message = new SimpleMailMessage(); message.setTo(email);
			message.setCc("coddy@coddy.com"); message.setSubject("Coddy 사이트 인증번호."); message.setText("인증번호 : " + r); mailSender.send(message);
			return String.valueOf(r); 
		}
		else { return authMake(email); }
	}
	
	@RequestMapping(value="authCheck.me", produces="text/html; charset=UTF-8") @ResponseBody
	public String authCheck(String email, String number) {
		if(email != null && number != null) {
			if(memberService.authCheck(new Auth("", number, email)) > 0) { return "Y"; }
			else { return "N"; }
		}
		else { return "N"; }
	}
	
	@GetMapping(value="findIdForm.me") public String findIdForm(HttpSession session) { 
		if((session.getAttribute("loginMember") != null) || (session.getAttribute("loginCompany") != null)) { session.setAttribute("alertMsg", "이미 로그인 되어있습니다."); return "redirect:/"; }
		else { return "member/findIdForm"; }
	}
	
	@RequestMapping(value="findId.me", produces="text/html; charset=UTF-8") @ResponseBody
	public String findId(String memberName, String memberEmail) { if(memberName.equals("운영자")) { return "권한이 없는 상태"; } Member findMember = new Member(); findMember.setMemberEmail(memberEmail); findMember.setMemberName(memberName); return memberService.findId(findMember); }

	@RequestMapping(value="findPwd.me", produces="text/html; charset=UTF-8") @ResponseBody
	public String findPwd(String memberName, String memberEmail) { if(memberName.equals("운영자")) { return "N"; } 
		Member findMember = new Member(); findMember.setMemberEmail(memberEmail); findMember.setMemberName(memberName); int result = memberService.findPwd(findMember);
		if(result > 0) { sr.setSeed(System.currentTimeMillis()); StringBuffer sb = new StringBuffer();
			for(int i=0; i<10; i++) { sb.append(chars.charAt(sr.nextInt(chars.length()))); }
			String to = memberService.findEmail(findMember);
			SimpleMailMessage message = new SimpleMailMessage(); message.setTo(to);
			message.setCc("coddy@coddy.com"); message.setSubject("Coddy 사이트 새 비밀번호 입니다."); message.setText("새 비밀번호는 " + sb.toString() + "입니다."); mailSender.send(message);
			Member newMember = new Member(); newMember.setMemberEmail(memberEmail); newMember.setMemberPwd(pbkdf2.encode(sb.toString()));
			int answer = memberService.setNewPassword(newMember);
			if(answer > 0) { return "Y"; } else { return "N"; } } 
		else { return "N"; } }
	
	// 메소드 기술
	public String getAccessToken(String code, String kkey) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		try {
			URL url = new URL(reqURL);
            
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
            
			sb.append("&client_id=" + kkey); //본인이 발급받은 key
			sb.append("&redirect_uri=http://127.0.0.1:8082/coddy/kakaoLogin.me"); // 본인이 설정한 주소
            
			sb.append("&code=" + code);
			bw.write(sb.toString());
			bw.flush();
            
			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			// System.out.println("responseCode : " + responseCode);
            
			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
            
			while ((line = br.readLine()) != null) { result += line; }
			System.out.println("response body : " + result);
            
			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
            
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();           
            
			br.close();
			bw.close();
		} catch (IOException e) { e.printStackTrace(); }
		return access_Token;
	}
	
	public Member getUserInfo(String access_Token, String kkey) {
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		Member kakaoMember = new Member();
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode();
			// System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) { result += line; }
			System.out.println("response body : " + result);
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			kakaoMember.setMemberName(nickname); kakaoMember.setMemberEmail(email); kakaoMember.setMemberId(element.getAsJsonObject().get("id").getAsString());
		} catch (IOException e) { e.printStackTrace(); }
		return kakaoMember;
	}
	
	@RequestMapping("myRank.me")
	public String myRank(HttpSession session) {
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			return "redirect:/";
		}
		if(session.getAttribute("loginCompany") != null) {
			session.setAttribute("alertMsg", "기업회원은 이용이 불가능합니다.");
			return "redirect:/";
		}
		return "member/myRank";
	}
	
	
	
	@RequestMapping("wroteReply.me")
	public String wroteReply(HttpSession session) {
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			return "redirect:/";
		}
		if(session.getAttribute("loginCompany") != null) {
			session.setAttribute("alertMsg", "기업회원은 이용이 불가능합니다.");
			return "redirect:/";
		}
		
		return "member/wroteReply";
	}
}