package com.kh.coddy.admin.common.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.coddy.admin.common.model.service.TagsAdminService;
import com.kh.coddy.common.tag.model.service.TagsService;
import com.kh.coddy.common.tag.model.vo.Tags;
import com.kh.coddy.member.model.vo.Member;

@Controller
public class TagsAdminController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired TagsAdminService tagService;
	@Autowired TagsService ts;
	
	@GetMapping(value="adminList.tg") public String adminListViewTags(HttpSession session) {
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "관리자만 접근가능합니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인 먼저 해주세요."); return "redirect:/"; }
		if(((Member)(session.getAttribute("loginMember"))).getMemberId().equals("admin")) { return "admin/tags/adminListViewTags"; }
		else { session.setAttribute("alertMsg", "관리자만 접근 가능합니다."); return "redirect:/"; }
	}
	@GetMapping(value="adminListLoad.tg", produces="text/html; charset=UTF-8") @ResponseBody public String adminListLoadTags() {
		ArrayList<Tags> tg = tagService.getTagsListAll();
		String str_return = "";
		if(tg != null) { for(Tags t: tg) { str_return += "<tr><td style='border-top: 1px solid #5271FF;'>" + t.getTagsNo() + "</td><td style='border-top: 1px solid #5271FF;'>" + t.getTagsName() + "</td><td style='border-top: 1px solid #5271FF;' class='tgType'>" + t.getTagsType() + "</td><td style='border-top: 1px solid #5271FF;' class='tgActive'>" + t.getTagsActive() + "</td></tr>"; } return str_return; }
		else { return "none"; }
	}
	@PostMapping(value="adminDelete.tg", produces="text/html; charset=UTF-8") @ResponseBody public String adminRemoveTags(String tagsNo) { if(tagService.adminRemoveTags(Integer.parseInt(tagsNo)) > 0) return "삭제에 성공함"; else return "삭제에 실패함"; }
	@PostMapping(value="adminRestore.tg", produces="text/html; charset=UTF-8") @ResponseBody public String adminRestoreTags(String tagsNo) { if(tagService.adminRestoreTags(Integer.parseInt(tagsNo)) > 0) return "복원에 성공함"; else return "복원에 실패함"; }
	@GetMapping(value="adminAdd.tg", produces="text/html; charset=UTF-8") @ResponseBody public String adminAddTags(String tagsName, String tagsType) {
		int tagsTypeReal = 0;
		if(tagsType.equals("0") || tagsType.equals("기술태그") || tagsType.equals("기술") || tagsType.equals("기술 태그") || tagsType.equals("0: 기술태그")) tagsTypeReal = 0;
		else if(tagsType.equals("1") || tagsType.equals("직군태그") || tagsType.equals("직군") || tagsType.equals("직군 태그") || tagsType.equals("1: 직군태그")) tagsTypeReal = 1;
		if(tagService.adminAddTags(new Tags(-1, tagsName, tagsTypeReal, 1)) > 0) return "추가에 성공함"; else return "추가에 실패함";
	}
}