package com.kh.coddy.member.controller;

import java.io.File;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.coddy.board.job.controller.HboardController;
import com.kh.coddy.board.job.model.service.HboardService;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.board.job.model.vo.Hrelation;
import com.kh.coddy.common.Keys;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.auth.model.vo.Auth;
import com.kh.coddy.common.vo.Geo;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.service.CompanyService;
import com.kh.coddy.member.model.service.MemberService;
import com.kh.coddy.member.model.vo.Company;

@Controller
public class CompanyController {
	private Logger log = LoggerFactory.getLogger(getClass());
	@Autowired private CompanyService companyService;
	@Autowired private MemberService memberService;
	@Autowired private HboardService hboardService;
	@Autowired private PasswordEncoder pbkdf2;
	private SecureRandom sr = new SecureRandom();
	private final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	@Autowired private JavaMailSender mailSender;
	private final int[] AUTH_KEY = { 1, 3, 7, 1, 3, 7, 1, 3, 5 };
	
	@GetMapping(value="loginPage.cp") public String loginPageCompany(HttpSession session) { if(session.getAttribute("loginMember") != null && session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "로그아웃후 이용해주세요."); return "redirect:/"; } else { return "company/login"; } }
	@GetMapping(value="signupPage.cp") public String signupPageCompany(HttpSession session) { 
		if((session.getAttribute("loginMember") != null) || (session.getAttribute("loginCompany") != null)) { session.setAttribute("alertMsg", "로그아웃후 이용해주세요."); return "redirect:/"; } 
		else { 
			String gKey = "";
			try { gKey = Keys.read(new ClassPathResource("keys/recaptcha2.json").getURL().getPath(), "key"); }
			catch (IOException | ParseException e) { e.printStackTrace(); }
			session.setAttribute("gKey", gKey);
			return "company/signup"; 
		} 
	}
	@RequestMapping(value="companyCheck.cp", produces="text/html; charset=UTF-8") @ResponseBody public String companyCheck(String id) { int count = companyService.companyCheck(id); if(count > 0) { return "NNNNN"; } else { return "NNNNY"; } }
	@PostMapping(value="companyBnoCheck.cp", produces="text/html; charset=UTF-8") @ResponseBody public String companyBnoCheck(String companyBno) {
		int numberAuth = 0;
		/*
		try { Integer.valueOf(companyBno); }
		catch(Exception e) { e.printStackTrace(); return "not a number"; }
		*/
		for(int i=0; i<9; i++) { numberAuth += AUTH_KEY[i] * Integer.valueOf(companyBno.charAt(i) - '0'); }
		numberAuth += (int)((Integer.valueOf(companyBno.charAt(8) - '0') * AUTH_KEY[8]) / 10);
		if(10 - (numberAuth % 10) != Integer.valueOf(companyBno.charAt(9) - '0')) { return "not a valid"; }
		else { return "success"; }
	}
	@PostMapping(value="companyEmailCheck.cp", produces="text/html; charset=UTF-8") @ResponseBody public String companyEmailCheck(String companyEmail) {
		int r = (int)(Math.random() * 90000000 + 10000000);
		int isSuccess = memberService.authMake(new Auth("", String.valueOf(r), companyEmail));
		if(isSuccess > 0) { 
			SimpleMailMessage message = new SimpleMailMessage(); message.setTo(companyEmail);
			message.setCc("coddy@coddy.com"); message.setSubject("Coddy 사이트 인증번호."); message.setText("인증번호 : " + r); mailSender.send(message);
			return String.valueOf(r); 
		}
		else { return "failed"; }
	}
	@PostMapping(value="signup.cp") public String signup(Company c, HttpSession session, Model model) {
		if((session.getAttribute("loginMember") != null) || (session.getAttribute("loginCompany") != null)) { session.setAttribute("alertMsg", "로그아웃후 이용해주세요."); return "redirect:/"; } 
		else { c.setCompanyPwd(pbkdf2.encode(c.getCompanyPwd()));
			int result = 0;
			try { result = companyService.insertCompany(c); } catch (Exception e) { model.addAttribute("errorMsg", "설명이 2000자를 넘음"); return "common/errorPage"; }
			if(result > 0) { log.info("insertCompanyId={}", c.getCompanyId()); session.setAttribute("alertMsg", "성공적으로 회원가입이 완료되었습니다. 로그인을 진행해주세요."); return "redirect:/loginPage.cp"; } 
			else { model.addAttribute("errorMsg", "회원가입 실패"); return "common/errorPage"; } } }
	@PostMapping(value="login.cp") public String login(Company c, HttpSession session, Model model, HttpServletRequest request) {
		if((session.getAttribute("loginMember") != null) || (session.getAttribute("loginCompany") != null)) { session.setAttribute("alertMsg", "로그아웃후 이용해주세요."); return "redirect:/"; } 
		else {
			Company loginCompany = companyService.login(c);
			if((loginCompany==null) || !(pbkdf2.matches(c.getCompanyPwd(), loginCompany.getCompanyPwd()))) { model.addAttribute("errorMsg","로그인 실패!"); return "common/errorPage"; }
			else {
				session.setAttribute("loginCompany", loginCompany);
				session.setAttribute("alertMsg", "기업 로그인 성공");
				log.info("loginCompany={}, ip={}", loginCompany, request.getRemoteAddr());
				return "redirect:/";
			}
		}
	}
	@GetMapping(value="logout.cp") public String logout(HttpSession session) { 
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "이미 로그인된 회원이 있습니다."); }
		else if(session.getAttribute("loginCompany") != null) { session.removeAttribute("loginCompany"); session.setAttribute("alertMsg", "로그아웃됨"); }
		else { session.setAttribute("alertMsg", "잘못된 요청입니다."); }
		return "redirect:/";
	}
	@GetMapping(value="findPassword.cp") public String findPasswordPage(HttpSession session) { if(session.getAttribute("loginMember") != null || session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "로그아웃후 이용해주세요."); return "redirect:/"; } else { return "company/findPasswordPage"; } }
	@PostMapping(value="findIdAccess.cp") public String findIdAccess(Company c, HttpSession session, HttpServletRequest req) {
		String companyId = companyService.findIdAccess(c);
		SimpleMailMessage message = new SimpleMailMessage();
		message.setSubject("Coddy 사이트 요청하신 결과입니다.");
		if(req.getParameter("plusId").equals("true")) { sr.setSeed(System.currentTimeMillis()); StringBuffer sb = new StringBuffer();
			for(int i=0; i<10; i++) { sb.append(chars.charAt(sr.nextInt(chars.length()))); } 
			message.setText("아이디는 " + companyId + "이며, 새비밀번호는 " + sb.toString() + "입니다."); 
			Company newCompany = new Company(); newCompany.setCompanyPwd(pbkdf2.encode(sb.toString())); newCompany.setCompanyEmail(c.getCompanyEmail()); newCompany.setCompanyBno(c.getCompanyBno());
			int answer = companyService.setNewPassword(newCompany);
			if(answer <= 0) { session.setAttribute("alertMsg", "요청 실패"); return "redirect:/loginPage.cp"; } }
		else { message.setText("아이디는 " + companyId + "입니다"); }
		message.setTo(c.getCompanyEmail()); mailSender.send(message);
		session.setAttribute("alertMsg", "요청 성공");
		return "redirect:/loginPage.cp";
	}
	@GetMapping(value="myPage.cp") public String myPage(HttpSession session) { if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "기업전용 메뉴입니다."); return "redirect:/"; } if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "비로그인 상태입니다."); return "redirect:/"; } int result = companyService.countWritten(((Company)(session.getAttribute("loginCompany"))).getCompanyNo()); session.setAttribute("howManyWritten", result); return "company/myPage"; }
	@PostMapping(value="uploadFile.cp", produces="text/html; charset=UTF-8") @ResponseBody public String uploadFile(HttpSession session, HttpServletRequest req, MultipartFile uploadFiles) {
		String path = req.getRealPath("resources\\file_upload\\company\\");
		File file = new File(path, String.format("%08d", ((Company)(session.getAttribute("loginCompany"))).getCompanyNo()) + ".jpg");
		try { 
			uploadFiles.transferTo(file); 
			if(companyService.uploadFile(((Company)(session.getAttribute("loginCompany"))).getCompanyNo()) > 0) { 
				Company myCompany = ((Company)(session.getAttribute("loginCompany")));
				myCompany.setCompanyPhotoExtend("jpg"); session.setAttribute("loginCompany", myCompany);
				return "이미지 업로드 성공"; 
			}
			else { return "이미지 업로드 실패"; }
		}
		catch (IllegalStateException | IOException e) { e.printStackTrace(); return "이미지 업로드 실패"; }
	}
	@PostMapping(value="uploadFileBg.cp", produces="text/html; charset=UTF-8") @ResponseBody public String uploadFileBg(HttpSession session, HttpServletRequest req, MultipartFile uploadFiles) {
		String path = req.getRealPath("resources\\file_upload\\company_bg\\");
		File file = new File(path, String.format("%08d", ((Company)(session.getAttribute("loginCompany"))).getCompanyNo()) + ".jpg");
		try { 
			uploadFiles.transferTo(file); 
			return "이미지 업로드 성공"; 
		}
		catch (IllegalStateException | IOException e) { e.printStackTrace(); return "이미지 업로드 실패"; }
	}
	@GetMapping(value="updateForm.cp") public String updateForm(HttpSession session) { 
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "허용되지않는 접근"); return "redirect:/"; } 
		if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "허용되지않는 접근"); return "redirect:/loginPage.cp"; } 
		else { int result = companyService.countWritten(((Company)(session.getAttribute("loginCompany"))).getCompanyNo()); session.setAttribute("howManyWritten", result); return "company/companyUpdateForm"; } }
	@GetMapping(value="myPageInfo.cp") public String myPageInfo(HttpSession session) { 
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "허용되지않는 접근"); return "redirect:/"; } 
		if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "허용되지않는 접근"); return "redirect:/loginPage.cp"; } 
		else { int result = companyService.countWritten(((Company)(session.getAttribute("loginCompany"))).getCompanyNo()); session.setAttribute("howManyWritten", result); return "company/companyInfoPage"; } }
	@PostMapping(value="update.cp") public String updateCompany(HttpSession session, Model model, Company c, String companyNewPwd) { 
		if(pbkdf2.matches(c.getCompanyPwd(), companyService.getPassword(c.getCompanyId()))) { 
			if(!companyNewPwd.equals("")) { c.setCompanyPwd(pbkdf2.encode(companyNewPwd)); }
			else { c.setCompanyPwd(((Company)(session.getAttribute("loginCompany"))).getCompanyPwd()); }
			int result = 0;
			try { result = companyService.updateCompany(c); } catch (Exception e) { model.addAttribute("errorMsg", "설명이 2000자를 넘음"); return "common/errorPage"; }
			if(result > 0) { session.setAttribute("alertMsg", "성공적으로 변경에 성공함. 다시 로그인 해주세요."); session.removeAttribute("loginCompany"); return "redirect:/loginPage.cp"; } 
			else { session.setAttribute("alertMsg", "변경 실패."); return "redirect:/updateForm.cp"; } }
		else { model.addAttribute("errorMsg","인증 실패"); return "common/errorPage"; } }
	@GetMapping(value="deleteForm.cp") public String deleteForm(HttpSession session) { 
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "허용되지않는 접근"); return "redirect:/"; } 
		if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "허용되지않는 접근"); return "redirect:/loginPage.cp"; }
		else { return "company/companyDeleteForm"; }
	}
	@PostMapping(value="delete.cp") public String deleteCompany(HttpSession session, Model model, String companyPwd) { 
		if(pbkdf2.matches(companyPwd, companyService.getPassword(((Company)(session.getAttribute("loginCompany"))).getCompanyId()))) {
			int result = companyService.deleteCompany(((Company)(session.getAttribute("loginCompany"))).getCompanyNo());
			if(result > 0) { session.setAttribute("alertMsg", "탈퇴가 완료되었습니다. 재가입시 1:1 문의해주세요."); session.removeAttribute("loginCompany"); return "redirect:/"; }
			else { model.addAttribute("errorMsg", "DB 연동 실패"); return "common/errorPage"; }
		}
		else { model.addAttribute("errorMsg", "인증 실패"); return "common/errorPage"; }
	}
	@GetMapping(value="myPage.hb") public String myBoard(@RequestParam(value="cpage", defaultValue="1") int currentPage, HttpSession session, Model model) { 
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "허용되지않는 접근"); return "redirect:/"; } 
		if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "허용되지않는 접근"); return "redirect:/loginPage.cp"; } 
		int listCount = hboardService.selectListCount(((Company)session.getAttribute("loginCompany")).getCompanyNo());
		int pageLimit = 5; int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		if((currentPage > pi.getMaxPage()) || (currentPage <= 0)) { model.addAttribute("errorMsg", "잘못된 페이지"); return "common/errorPage"; }
		if(pi.getMaxPage() == 0) { model.addAttribute("errorMsg", "아직 작성한 게시판이 없습니다."); return "common/errorPage"; }
		else {
			ArrayList<Hboard>list = hboardService.selectList(pi, ((Company)session.getAttribute("loginCompany")).getCompanyNo());
			ArrayList<String> tg_list = new ArrayList<String>();
			for(Hboard h:list) { 
				String temp = "";
				h.setHboardInsert(h.getHboardInsert().split(" ")[0]);
				h.setHboardStart(h.getHboardStart().split(" ")[0]);
				h.setHboardEnd(h.getHboardEnd().split(" ")[0]);
				h.setHboardLocation(new Geo().getGeo(h.getHboardLocation()).getAddr());
				for(Hrelation hr: hboardService.getTagInfo(h)) { temp += hr.getTagsNo() + ","; }
				tg_list.add(getSpan(temp.substring(0, temp.length() - 1)));
			}
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("tg_list", tg_list);
			
			return "company/myBoard";
		}
	}
	@PostMapping(value="/uploadSummernoteImageFile.cp", produces="text/html; charset=UTF-8") @ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest req) {
		String path = req.getRealPath("resources\\file_upload\\company\\content\\");
		UUID uuid = UUID.randomUUID();
		
		File file = new File(path, uuid + "_" + multipartFile.getOriginalFilename());
		try { multipartFile.transferTo(file); return "resources\\file_upload\\company\\content\\" + uuid + "_" + multipartFile.getOriginalFilename(); }
		catch (IOException e) { FileUtils.deleteQuietly(file); e.printStackTrace(); }
		return null;
	}
	public String getSpan(String str) { String ret = ""; for(String s: str.split(",")) { ret+="<span class='tagList'>"+s+"</span>"; } return ret; }
}