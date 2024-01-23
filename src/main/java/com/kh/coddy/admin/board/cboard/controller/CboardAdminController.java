package com.kh.coddy.admin.board.cboard.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.coddy.admin.board.cboard.model.service.CboardAdminService;
import com.kh.coddy.board.code.model.service.CboardService;
import com.kh.coddy.board.code.model.vo.Cboard;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;

@Controller
public class CboardAdminController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired CboardAdminService cboardService;
	@Autowired CboardService cs;
	
	@GetMapping(value="adminList.co") public String adminListViewCboard(HttpSession session) {
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "관리자만 접근가능합니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인 먼저 해주세요."); return "redirect:/"; }
		if(((Member)(session.getAttribute("loginMember"))).getMemberId().equals("admin")) { return "admin/board/cboard/adminListViewCboard"; }
		else { session.setAttribute("alertMsg", "관리자만 접근 가능합니다."); return "redirect:/"; }
	}
	@GetMapping(value="adminListLoad.co", produces="text/html; charset=UTF-8") @ResponseBody public String adminListViewCboard(String page) {
		int listCount = cboardService.selectListCount();
		int pageLimit = 20; int boardLimit = 5;
		PageInfo pi = Pagination.getPageInfo(listCount, Integer.parseInt(page), pageLimit, boardLimit);
		if(pi.getMaxPage() == 0) { return "none"; }
		else if((Integer.parseInt(page) > pi.getMaxPage()) || (Integer.parseInt(page) <= 0)) { return "none"; }
		else {
			String str_return = "";
			ArrayList<Cboard> list = cboardService.selectList(pi);
			for(Cboard c: list) { if(c.getCboardDelte() != null) c.setCboardDelte("<button type='button' class='btn btn-info' onclick='onRestore(this, " + c.getCboardNo() + ");'>복원시키기</button>"); else c.setCboardDelte("<button type='button' class='btn btn-danger' onclick='onDelete(this, " + c.getCboardNo() + ");'>삭제시키기</button>"); str_return += "<tr><td style='border-top: 1px solid #5271FF;'>" + c.getCboardNo() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCboardTitle() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCboardWriter() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCboardViews() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCboardInsert() + "</td><td style='border-top: 1px solid #5271FF;'>" + c.getCboardDelte() + "</td><td style='border-top: 1px solid #5271FF; padding: 4px;'>" + getSpan(cboardService.getTag(c.getCboardNo())) + "</td></tr>"; }
			return str_return;
		}
	}
	@PostMapping(value="adminDelete.co", produces="text/html; charset=UTF-8") @ResponseBody public String adminDelete(String cboardNo) { if(cboardService.forceDelete(Integer.parseInt(cboardNo)) > 0) return "success"; else return "fail"; }
	@PostMapping(value="adminRestore.co", produces="text/html; charset=UTF-8") @ResponseBody public String adminRestore(String cboardNo) { if(cboardService.forceRestore(Integer.parseInt(cboardNo)) > 0) return "success"; else return "fail"; }
	public String getSpan(String str) { String ret = ""; for(String s: str.split(",")) { ret+="<span class='tagList'>"+s+"</span>"; } return ret; }
}