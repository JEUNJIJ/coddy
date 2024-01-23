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

import com.kh.coddy.admin.member.model.service.CompanyAdminService;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.service.CompanyService;
import com.kh.coddy.member.model.vo.Company;
import com.kh.coddy.member.model.vo.Member;

@Controller
public class CompanyAdminController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired private CompanyAdminService companyService;
	@Autowired private CompanyService cs;
	
	@Autowired private PasswordEncoder pbkdf2;
	private SecureRandom sr = new SecureRandom();
	private final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	
	@Autowired private JavaMailSender mailSender;
	
	@GetMapping(value="adminRegistForm.cp") public String adminRegistFormCompany(HttpSession session) {
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "관리자만 접근가능합니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인 먼저 해주세요."); return "redirect:/"; }
		if(((Member)(session.getAttribute("loginMember"))).getMemberId().equals("admin")) { return "admin/member/adminRegistCompany"; }
		else { session.setAttribute("alertMsg", "관리자만 접근 가능합니다."); return "redirect:/"; }
	}
	@PostMapping(value="adminRegist.cp", produces="text/html; charset=UTF-8") @ResponseBody public String adminRegistCompany(HttpSession session, Company co) {
		co.setCompanyPwd(pbkdf2.encode(co.getCompanyPwd()));
		if(cs.insertCompany(co) > 0) return "기업 가입 성공"; else return "기업 가입 실패";
	}
	@GetMapping(value="adminList.cp") public String adminListViewCompany(HttpSession session) {
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "관리자만 접근가능합니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인 먼저 해주세요."); return "redirect:/"; }
		if(((Member)(session.getAttribute("loginMember"))).getMemberId().equals("admin")) { return "admin/member/adminListViewCompany"; }
		else { session.setAttribute("alertMsg", "관리자만 접근 가능합니다."); return "redirect:/"; }
	}
	@GetMapping(value="adminListLoad.cp", produces="text/html; charset=UTF-8") @ResponseBody public String adminListLoad(String page) {
		int listCount = companyService.selectListCount();
		int pageLimit = 20; int boardLimit = 10;
		PageInfo pi = Pagination.getPageInfo(listCount, Integer.parseInt(page), pageLimit, boardLimit);
		if(pi.getMaxPage() == 0) { return "none"; }
		else if((Integer.parseInt(page) > pi.getMaxPage()) || (Integer.parseInt(page) <= 0)) { return "none"; }
		else {
			String str_return = "";
			ArrayList<Company> co = companyService.selectList(pi);
			for (Company c: co) { if(c.getCompanyDelete() != null) c.setCompanyDelete("<button type='button' class='btn btn-info' onclick='onRestore(this, " + c.getCompanyNo() + ");'>복원시키기</button>"); else c.setCompanyDelete("<button type='button' class='btn btn-danger' onclick='onDelete(this, " + c.getCompanyNo() + ");'>탈퇴시키기</button>"); str_return += "<tr><td style='border-top: 1px solid #5271FF;'>" + c.getCompanyNo() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCompanyName() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCompanyOwner() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCompanyBno() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCompanyInfo() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCompanyId() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCompanyEmail() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCompanyInsert() + "</td><td style='border-top: 1px solid #5271FF; padding: 4px;'>" + c.getCompanyDelete() + "</td></tr>"; }
			return str_return;
		}
	}
	@PostMapping(value="adminDelete.cp", produces="text/html; charset=UTF-8") @ResponseBody public String adminDelete(String companyNo) { if(companyService.forceDelete(Integer.parseInt(companyNo)) > 0) return "success"; else return "fail"; }
	@PostMapping(value="adminRestore.cp", produces="text/html; charset=UTF-8") @ResponseBody public String adminRestore(String companyNo) { if(companyService.forceRestore(Integer.parseInt(companyNo)) > 0) return "success"; else return "fail"; }
}