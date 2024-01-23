package com.kh.coddy.admin.board.hboard.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.coddy.admin.board.hboard.model.service.HboardAdminService;
import com.kh.coddy.board.job.model.service.HboardService;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.vo.Geo;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;

@Controller
public class HboardAdminController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired HboardAdminService hboardService;
	@Autowired HboardService hs;
	
	@GetMapping(value="adminList.hb") public String adminListViewHboard(HttpSession session) {
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "관리자만 접근가능합니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인 먼저 해주세요."); return "redirect:/"; }
		if(((Member)(session.getAttribute("loginMember"))).getMemberId().equals("admin")) { return "admin/board/hboard/adminListViewHboard"; }
		else { session.setAttribute("alertMsg", "관리자만 접근 가능합니다."); return "redirect:/"; }
	}
	@GetMapping(value="adminListLoad.hb", produces="text/html; charset=UTF-8") @ResponseBody public String adminListViewHboard(String page) {
		int listCount = hboardService.selectListCount();
		int pageLimit = 20; int boardLimit = 5;
		PageInfo pi = Pagination.getPageInfo(listCount, Integer.parseInt(page), pageLimit, boardLimit);
		if(pi.getMaxPage() == 0) { return "none"; }
		else if((Integer.parseInt(page) > pi.getMaxPage()) || (Integer.parseInt(page) <= 0)) { return "none"; }
		else {
			String str_return = "";
			ArrayList<Hboard> list = hboardService.selectList(pi);
			for(Hboard h: list) { if(h.getHboardDelete() != null) h.setHboardDelete("<button type='button' class='btn btn-info' onclick='onRestore(this, " + h.getHboardNo() + ");'>복원시키기</button>"); else h.setHboardDelete("<button type='button' class='btn btn-danger' onclick='onDelete(this, " + h.getHboardNo() + ");'>삭제시키기</button>"); h.setHboardLocation(Geo.getGeo(h.getHboardLocation()).getAddr()); str_return += "<tr><td style='border-top: 1px solid #5271FF;'>" + h.getHboardNo() + "</td><td style='border-top: 1px solid #5271FF;'>" + h.getHboardTitle() + "</td><td style='border-top: 1px solid #5271FF;'>" + h.getHboardContent() + "</td><td style='border-top: 1px solid #5271FF;'>" + h.getCompanyNo() + "</td><td style='border-top: 1px solid #5271FF;'>" + h.getHboardInsert() + "</td><td style='border-top: 1px solid #5271FF;'>" + h.getHboardDelete() + "</td><td style='border-top: 1px solid #5271FF;'>" + h.getHboardLocation() + "</td><td style='border-top: 1px solid #5271FF;'>" + h.getHboardViews() + "</td><td style='border-top: 1px solid #5271FF; padding: 4px;'>" + getSpan(hboardService.getTag(h.getHboardNo())) + "</td></tr>"; }
			return str_return;
		}
	}
	@PostMapping(value="adminDelete.hb", produces="text/html; charset=UTF-8") @ResponseBody public String adminDelete(String hboardNo) { if(hboardService.forceDelete(Integer.parseInt(hboardNo)) > 0) return "success"; else return "fail"; }
	@PostMapping(value="adminRestore.hb", produces="text/html; charset=UTF-8") @ResponseBody public String adminRestore(String hboardNo) { if(hboardService.forceRestore(Integer.parseInt(hboardNo)) > 0) return "success"; else return "fail"; }
	public String getSpan(String str) { String ret = ""; for(String s: str.split(",")) { ret+="<span class='tagList'>"+s+"</span>"; } return ret; }
}