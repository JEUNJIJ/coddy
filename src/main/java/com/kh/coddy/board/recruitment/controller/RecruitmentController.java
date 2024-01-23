package com.kh.coddy.board.recruitment.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.kh.coddy.board.recruitment.model.service.RecruitmentService;
import com.kh.coddy.board.recruitment.model.vo.PlaceDto;
import com.kh.coddy.board.recruitment.model.vo.Prelation;
import com.kh.coddy.board.recruitment.model.vo.Profile;
import com.kh.coddy.board.recruitment.model.vo.Project;
import com.kh.coddy.board.recruitment.model.vo.Rattachment;
import com.kh.coddy.board.recruitment.model.vo.RecruitSearch;
import com.kh.coddy.board.recruitment.model.vo.Recruitment;
import com.kh.coddy.board.recruitment.model.vo.RecruitmentSearchDto;
import com.kh.coddy.board.recruitment.model.vo.RecruitmentState;
import com.kh.coddy.board.recruitment.model.vo.RecruitmentWishList;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.chat.model.service.ChatService;
import com.kh.coddy.common.chat.model.vo.ChatMember;
import com.kh.coddy.common.tag.ReadTag;
import com.kh.coddy.common.tag.controller.TagsController;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller @Slf4j
public class RecruitmentController {
	
	@Autowired
	RecruitmentService rService;
	
	@Autowired
	ChatService cService;
	
	@Autowired
	TagsController tagsController;
	
	@GetMapping("detail.rec")
	public String recruitmentDetail(int rno, HttpSession session, Model model) {
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "기업은 이용 불가능한 서비스입니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인부터 해주세요."); return "redirect:/"; }
		int memberNo = ((Member)session.getAttribute("loginMember")).getMemberNo();
		if(rService.insertViewCount(rno)>0){	// 	조회수 증가	
		
		Recruitment r = rService.selectRecruitment(rno);
		ArrayList<Prelation> tags = rService.getTagInfo(r); // 태그정보
		ArrayList<RecruitmentState> state = rService.getState(r); // 지원 현황
		Rattachment thumOne = rService.getThumbOne(r); // 대표이미지
		ArrayList<Rattachment> thumList = rService.getAttachmentList(r); // 이미지 목록
		int wish = rService.getWish(new RecruitmentWishList(memberNo,rno)); // 좋아요 여부
		Project p = rService.getProject(r); // 프로젝트 정보
		
		int likeCount = rService.getLikeCount(rno); // 좋아요 조회
		int viewCount = rService.getViewCount(rno); // 조회수 조회
		log.info("viewCount={}",viewCount);
		
		
		if(p.getProjectReady() > 0) {
			ArrayList<Profile> fList = rService.getJoinMember(p.getProjectNo()); // 참여한 프로필
			model.addAttribute("fList",fList);
		}
		
		model.addAttribute("r",r);
		model.addAttribute("tags",tags);
		model.addAttribute("state",state);
		model.addAttribute("thumOne",thumOne);
		model.addAttribute("thumList",thumList);
		model.addAttribute("wish",wish);
		model.addAttribute("p",p);
		log.info("p={}",p);
		
		model.addAttribute("likeCount",likeCount);
		model.addAttribute("viewCount",viewCount);
		}else {
			model.addAttribute("errorMsg", "게시글 조회 실패"); 
			return "common/errorPage";
		}
		return "board/recruitment/recruitmentDetailView";
	}
	@GetMapping("enrollForm.rec")
	public String enrollForm(HttpSession session, Model model){
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "기업은 이용 불가능한 서비스입니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인부터 해주세요."); return "redirect:/"; }
		model.addAttribute("tagTech", tagsController.getTagsNameList(0));
		return "board/recruitment/recruitmentEnrollForm";
	}
	
	@PostMapping("insert.rec")
	public String recruitmentInsert(Recruitment r, MultipartFile titleImg ,ArrayList<MultipartFile> img, HttpServletRequest request, Model model, String tagTechName, String[] position, int[] personnelMax) {		
		// 게시글 insert
		int result = rService.insertRecruitment(r);

		// 첨부파일 insert
		if(result>0) {
			String path = request.getRealPath("resources\\file_upload\\recruitment\\");			
			
			if(titleImg != null) {
				UUID uuid = UUID.randomUUID();
				File file = new File(path + "\\" + uuid + "_" + titleImg.getOriginalFilename());
				try { 
					titleImg.transferTo(file);
				}catch (IllegalStateException | IOException e) { 
					e.printStackTrace();
					model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일 및 태그설정이 잘못됨"); 
					return "common/errorPage";
				}
				Rattachment ra = new Rattachment();
				ra.setRAttachmentOrigin(titleImg.getOriginalFilename()); 
				ra.setRAttachmentLevel(0);
				ra.setRAttachmentChange(uuid + "_" + titleImg.getOriginalFilename()); 
				ra.setRAttachmentPath("resources\\file_upload\\recruitment\\");
				int result2 = rService.insertImg(ra);
				if(result2 <= 0) { 
					model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일 및 태그설정이 잘못됨"); 
					return "common/errorPage"; 
				}
			}
			if(img != null) {
				for (MultipartFile mf: img) { 
					
					if(!mf.isEmpty()) {
						UUID uuid = UUID.randomUUID();
						File file = new File(path + "\\" + uuid + "_" + mf.getOriginalFilename());
						try { 
							mf.transferTo(file);
						}catch (IllegalStateException | IOException e) { 
							e.printStackTrace();
							model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일 및 태그설정이 잘못됨"); 
							return "common/errorPage";
						}
						Rattachment ra = new Rattachment();
						ra.setRAttachmentOrigin(mf.getOriginalFilename()); 
						ra.setRAttachmentLevel(1);
						ra.setRAttachmentChange(uuid + "_" + mf.getOriginalFilename()); 
						ra.setRAttachmentPath("resources\\file_upload\\recruitment\\");
						int result2 = rService.insertImg(ra);
						if(result2 <= 0) { 
							model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일 및 태그설정이 잘못됨"); 
							return "common/errorPage"; 
						}
					}
				}		
			}
			// 태그 insert
			if(!tagTechName.equals("")) {
				String[] tags = ReadTag.read(tagTechName);
				for(String tag : tags) {
					Prelation rel = new Prelation(r.getRecruitmentNo(),tag);
					rService.insertTag(rel);
				}				
			}
			// 모집인원 insert
			if(position != null && personnelMax !=null && position.length == personnelMax.length) {		
				
				for(int i=0; i<position.length; i++) {
					RecruitmentState state = new RecruitmentState(r.getRecruitmentNo(),position[i],personnelMax[i]);
					rService.insertState(state);
				}							
			}else {
				model.addAttribute("errorMsg","게시글 작성 실패");
				return "common/errorPage";
			}
			
			// 프로젝트 대기방 생성
			Project p = new Project();
			p.setProjectOwner(r.getRecruitmentWriter()); 
			p.setProjectName(r.getRecruitmentTitle());
			p.setProjectInfo(r.getRecruitmentContent());
			p.setProjectStart(r.getRecruitmentStart());
			p.setProjectEnd(r.getRecruitmentEnd());
			rService.createProject(p);

			return "redirect:list.rec";			
			
		}else {
			model.addAttribute("errorMsg","게시글 작성 실패");
			return "common/errorPage";
		}
	}
	

	@GetMapping("list.rec")
	public String recruitmentList(@RequestParam(value="rpage", defaultValue="1") int currentPage, Model model, HttpSession session){	

		int listCount = rService.selectListCount();
		int pageLimit = 5;
		int boardLimit = 20;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		Map<String,Integer> wishMap = new HashMap<>(); 		
		
		if(pi.getMaxPage()==0) {
			return "board/recruitment/recruitmentListView";			
		}
		else if((currentPage > pi.getMaxPage()) || (currentPage <= 0)) { 
			model.addAttribute("errorMsg", "잘못된 페이지"); 
			return "common/errorPage"; 
		}else {

			ArrayList<Recruitment> list = rService.selectList(pi);
			ArrayList<Rattachment>at_list = new ArrayList<Rattachment>();	
			ArrayList<ArrayList<Prelation>>tg_list = new ArrayList<ArrayList<Prelation>>();
			ArrayList<ArrayList<RecruitmentState>>pos_list = new ArrayList<>();
			ArrayList<Boolean>ws_list = new ArrayList<Boolean>();			
			
			for(Recruitment r:list) {
				
				Rattachment ra = rService.getThumbOne(r);
				at_list.add(ra);				
				ArrayList<Prelation> pr = rService.getTagInfo(r);
				tg_list.add(pr);
				ArrayList<RecruitmentState> rs = rService.getState(r);
				pos_list.add(rs);
				
				if(session.getAttribute("loginMember")!=null) {					
					wishMap.put("mno",((Member)session.getAttribute("loginMember")).getMemberNo());
					wishMap.put("rno",r.getRecruitmentNo());
					ws_list.add(rService.getWishList(wishMap));
					wishMap.clear();					
				}				
			}					
			model.addAttribute("tagTech", tagsController.getTagsNameList(0));
			model.addAttribute("tagCareer", tagsController.getTagsNameList(1));
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("at_list", at_list);
			model.addAttribute("tg_list", tg_list);
			model.addAttribute("ws_list", ws_list);
			model.addAttribute("pos_list", pos_list);					
			return "board/recruitment/recruitmentListView";				
		}	
	}
	
	 
	@GetMapping("boardWish.rec")
	@ResponseBody
	public String wish(HttpSession session, int recruitmentNo) {
		RecruitmentWishList rw = new RecruitmentWishList( ((Member)session.getAttribute("loginMember")).getMemberNo(),recruitmentNo );
		return (rService.getWish(rw) > 0) ? rService.deleteWish(rw): rService.insertWish(rw);
	}

	@GetMapping(value="popular.rec", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String popularList(){
		ArrayList<Recruitment> list = rService.selectPopular();
		return new Gson().toJson(list);
	}
	
	@GetMapping(value="recent.rec", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String recentList(){
		ArrayList<Rattachment> list = rService.selectRecent();
		return new Gson().toJson(list);
	}
	
	@GetMapping(value="updatePlace.rec")
	@ResponseBody
	public void updatePlace(int projectNo, String place) {
		rService.updatePlace(new PlaceDto(projectNo, place));
	}
	
	@GetMapping(value="startProject.rec", produces="application/json")
	@ResponseBody
	public int  startProject(@RequestParam Map<String, Object> paramMap, Model model) throws ParseException, JsonMappingException, JsonProcessingException {
		log.info("paramMap = {}",paramMap);
		String jsonData = paramMap.get("memberList").toString();
		ObjectMapper mapper = new ObjectMapper();
		
		ArrayList<ChatMember> memberList = mapper.readValue(jsonData, new TypeReference<ArrayList<ChatMember>>(){});
		log.info("memberList={}",memberList);
		
		return  rService.projectStart(memberList);
		
	}
	
	@GetMapping(value="exile.rec")
	@ResponseBody
	public int memberExile(int memberNo, int pno) {
		HashMap<String, Integer> map = new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("pno", pno);
		
		return rService.memberExile(map);
	}
	
	
	@GetMapping(value="search.rec")
	@ResponseBody
	public RecruitmentSearchDto searchList(@RequestParam(value="rpage", defaultValue="1") int currentPage, String keyword, String career, String tech, boolean recruit, HttpSession session) {
		
		System.out.println("호출되나?");
		
		String careers = "";
		if(career.equals("")) {
			careers = tagsController.getTagsNameString(1); 
		}else {
			careers = career;
		}
	
		String techs = "";
		if(tech.equals("")) { 
			techs = tagsController.getTagsNameString(0); 
		}else {
			techs = tech;
		}
		log.info("techs={}",techs);
		log.info("careers={}",careers);
		RecruitSearch rSearch = new RecruitSearch(keyword, Arrays.stream(techs.split(",")).distinct().toArray(String[]::new),Arrays.stream(careers.split(",")).distinct().toArray(String[]::new), recruit);
		
		log.info("rSearch = {}",rSearch);
		int listCount = rService.selectSearchCount(rSearch);
		log.info("listCount={}",listCount);
		int pageLimit = 5;
		int boardLimit = 20;
		Map<String,Integer> wishMap = new HashMap<>(); 	
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Recruitment>list = rService.selectSearchList(pi, rSearch);
		ArrayList<Rattachment>at_list = new ArrayList<Rattachment>();	
		ArrayList<ArrayList<Prelation>>tg_list = new ArrayList<ArrayList<Prelation>>();
		ArrayList<ArrayList<RecruitmentState>>pos_list = new ArrayList<>();
		ArrayList<Boolean>ws_list = new ArrayList<Boolean>();			
		
		for(Recruitment r:list) {
			
			Rattachment ra = rService.getThumbOne(r);
			at_list.add(ra);				
			ArrayList<Prelation> pr = rService.getTagInfo(r);
			tg_list.add(pr);
			ArrayList<RecruitmentState> rs = rService.getState(r);
			pos_list.add(rs);
			
			if(session.getAttribute("loginMember")!=null) {					
				wishMap.put("mno",((Member)session.getAttribute("loginMember")).getMemberNo());
				wishMap.put("rno",r.getRecruitmentNo());
				ws_list.add(rService.getWishList(wishMap));
				wishMap.clear();					
			}				
		}	
		return new RecruitmentSearchDto(pi,list,at_list,tg_list,pos_list,ws_list);
		
	}
}
