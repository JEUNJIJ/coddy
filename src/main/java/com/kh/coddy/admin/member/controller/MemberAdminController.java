package com.kh.coddy.admin.member.controller;

import java.security.SecureRandom;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.coddy.admin.member.model.service.MemberAdminService;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.service.MemberService;
import com.kh.coddy.member.model.vo.Member;

@Controller
public class MemberAdminController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired private MemberAdminService memberService;
	@Autowired private MemberService ms;
	
	@Autowired private PasswordEncoder pbkdf2;
	private SecureRandom sr = new SecureRandom();
	private final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	
	@Autowired private JavaMailSender mailSender;
	
	@GetMapping(value="adminRegistForm.me") public String adminRegistMember(HttpSession session) { 
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "관리자만 접근가능합니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인 먼저 해주세요."); return "redirect:/"; }
		if(((Member)(session.getAttribute("loginMember"))).getMemberId().equals("admin")) { return "admin/member/adminRegistMember"; }
		else { session.setAttribute("alertMsg", "관리자만 접근 가능합니다."); return "redirect:/"; }
	}
	@PostMapping(value="insertForce.me", produces="text/html; charset=UTF-8") @ResponseBody public String insertMemberForce(Member m) {
		m.setMemberPwd(pbkdf2.encode(m.getMemberPwd()));
		int result = ms.insertMember(m);
		if(result > 0) { return "성공"; } else { return "실패"; }
	}
	@GetMapping(value="adminList.me") public String adminListViewMember(HttpSession session) { 
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "관리자만 접근가능합니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인 먼저 해주세요."); return "redirect:/"; }
		if(((Member)(session.getAttribute("loginMember"))).getMemberId().equals("admin")) { return "admin/member/adminListViewMember"; }
		else { session.setAttribute("alertMsg", "관리자만 접근 가능합니다."); return "redirect:/"; }
	}
	@GetMapping(value="adminListLoad.me", produces="text/html; charset=UTF-8") @ResponseBody public String adminListLoad(String page) {
		int listCount = memberService.selectListCount();
		int pageLimit = 20; int boardLimit = 20;
		PageInfo pi = Pagination.getPageInfo(listCount, Integer.parseInt(page), pageLimit, boardLimit);
		if(pi.getMaxPage() == 0) { return "none"; }
		else if((Integer.parseInt(page) > pi.getMaxPage()) || (Integer.parseInt(page) <= 0)) { return "none"; }
		else {
			String str_return = "";
			ArrayList<Member> me = memberService.selectList(pi);
			for(Member m: me) { if(m.getMemberId().equals("admin")) m.setMemberDelete("추방불가능"); else if(m.getMemberDelete() != null) m.setMemberDelete("<button type='button' class='btn btn-info' onclick='onRestore(this, " + m.getMemberNo() + ");'>복원시키기</button>"); else m.setMemberDelete("<button type='button' class='btn btn-danger' onclick='onDelete(this, " + m.getMemberNo() + ");'>탈퇴시키기</button>"); str_return += "<tr><td style='border-top: 1px solid #5271FF;'>" + m.getMemberNo() + "</td><td style='border-top: 1px solid #5271FF;'>" + m.getMemberId() + "</td><td style='border-top: 1px solid #5271FF;'>" + m.getMemberName() + "</td><td style='border-top: 1px solid #5271FF;'>" + m.getMemberEmail() + "</td><td style='border-top: 1px solid #5271FF;'>" + m.getMemberInfo() + "</td><td style='border-top: 1px solid #5271FF;'>" + m.getMemberInsert() + "</td><td style='border-top: 1px solid #5271FF;'>" + m.getMemberDelete() + "</td></tr>"; }
			return str_return;
		}
	}
	@PostMapping(value="adminDelete.me", produces="text/html; charset=UTF-8") @ResponseBody public String adminDelete(String memberNo) { if(memberService.forceDelete(Integer.parseInt(memberNo)) > 0) return "success"; else return "fail"; }
	@PostMapping(value="adminRestore.me", produces="text/html; charset=UTF-8") @ResponseBody public String adminRestore(String memberNo) { if(memberService.forceRestore(Integer.parseInt(memberNo)) > 0) return "success"; else return "fail"; }
}