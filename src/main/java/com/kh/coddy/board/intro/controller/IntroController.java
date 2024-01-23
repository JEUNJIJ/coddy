package com.kh.coddy.board.intro.controller;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.kh.coddy.board.intro.model.service.IntroService;
import com.kh.coddy.board.intro.model.vo.IBoard;
import com.kh.coddy.board.intro.model.vo.Iattachment;
import com.kh.coddy.board.intro.model.vo.Ireply;
import com.kh.coddy.board.intro.model.vo.IreplyImage;
import com.kh.coddy.board.intro.model.vo.Likes;
import com.kh.coddy.board.recruitment.model.vo.Joins;
import com.kh.coddy.board.recruitment.model.vo.Prelation;
import com.kh.coddy.board.recruitment.model.vo.Profile;
import com.kh.coddy.board.recruitment.model.vo.Project;
import com.kh.coddy.board.recruitment.model.vo.Rattachment;
import com.kh.coddy.board.recruitment.model.vo.Recruitment;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.tag.controller.TagsController;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;


@Controller 
public class IntroController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired 
	private IntroService introService;
	
	@Autowired private TagsController tagsController;
	
	@GetMapping("introDetail.bo")
	public String selectBoard(HttpSession session,@RequestParam(value="ino") String iboardNo, Model model) {
		
		if(session.getAttribute("loginCompany") != null) { session.setAttribute("alertMsg", "기업은 이용 불가능한 서비스입니다."); return "redirect:/"; }
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "로그인부터 해주세요."); return "redirect:/"; }
		
		if(introService.plusView(Integer.parseInt(iboardNo)) < 1) {
			model.addAttribute("errorMsg", "페이지 찾기에 실패함"); return "common/errorPage"; 
		}
		
		IBoard ib = introService.selectBoard(Integer.parseInt(iboardNo));
		Iattachment it = introService.getThumb2(ib); // 대표 이미지
		int like = introService.countLike(ib);
		
		ArrayList<Project> projectlist = new ArrayList<Project>();
		projectlist.add(introService.selectPro(ib));
		ArrayList<Iattachment> thumList2 = introService.getAttachmentList3(ib); // 이미지 목록
		
		Recruitment r = introService.selectRecruitment3(Integer.parseInt(iboardNo));
		
		
		ArrayList<Prelation> tags = introService.getTagInfo2(r); // 태그정보
		Rattachment thumOne = introService.getThumbOne(r); // 대표이미지
		ArrayList<Rattachment> thumList = introService.getAttachmentList2(r); // 이미지 목록
		Project p = introService.getProject(r);
		ArrayList<Profile> fList = introService.getJoinMember(p.getProjectNo());
		ArrayList<Joins> joins = introService.getJoinInfo(p.getProjectNo());

		
		ib.setIboardInsert(ib.getIboardInsert().split(" ")[0]);
		p.setProjectEnd(p.getProjectEnd().split(" ")[0]);
		p.setProjectStart(p.getProjectStart().split(" ")[0]);
		
		model.addAttribute("joins", joins);
		model.addAttribute("r", r);
		model.addAttribute("tags",tags);
		model.addAttribute("thumOne",thumOne);
		model.addAttribute("thumList",thumList);
		model.addAttribute("p",p);
		
		model.addAttribute("ib", ib);
		model.addAttribute("it", it); // 대표 이미지
		model.addAttribute("like", like);
		model.addAttribute("thumList2", thumList2); // 이미지 목록
		model.addAttribute("fList", fList);
		
		return "board/intro/introDetailView"; 
	}
	
	@GetMapping("introlist.bo")	
	public String selectList(@RequestParam(value="cpage", defaultValue="1") int currentPage,
		@RequestParam(value="search", defaultValue="") String search,
		@RequestParam(value="tag", defaultValue="") String tag,
		@RequestParam(value="condition", defaultValue="new") String sort,
		Model model, HttpSession session) {
		if(session.getAttribute("loginMember") != null) {
		
		if(session.getAttribute("loginMember") != null) {
		ArrayList<Project> projectlist = new ArrayList<Project>();
		ArrayList<Recruitment> rlist = new ArrayList<Recruitment>();
		Member m = ((Member)(session.getAttribute("loginMember")));
		
		projectlist = introService.selectProject(m.getMemberNo());
		rlist = introService.selectRecruitment(projectlist);
		
		
		model.addAttribute("projectlist", projectlist);
		model.addAttribute("rlist", rlist);
		}
		}
		String tags = "";
		
		
		
		int listCount = introService.selectListCount();
		
		int pageLimit = 5;
		int boardLimit = 9;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		if(pi.getMaxPage() == 0) {
			return "board/intro/introListView";
		

		}
		else if((currentPage > pi.getMaxPage()) || (currentPage <= 0)) {
			model.addAttribute("errorMsg", "잘못된 페이지입니다.");
			return "common/errorPage"; 
		}
	
		else {
		ArrayList<IBoard> list = introService.selectList(pi);
		ArrayList<Iattachment> listi = new ArrayList<Iattachment>();
		ArrayList<Project> listp = new ArrayList<Project>();
		ArrayList<ArrayList<Prelation>>tg_list = new ArrayList<ArrayList<Prelation>>();
		ArrayList<Boolean>ws_list = new ArrayList<Boolean>();
		
		
		
		for(IBoard ib : list) { 
			listi.add(introService.selectattachment(ib));
			listp.add(introService.selectPro(ib));
			int like = introService.countLike(ib);
			// tg_list.add(introService.getTagInfo(ib));
			if(session.getAttribute("loginMember") != null) { ws_list.add(introService.getWishList(ib, ((Member)(session.getAttribute("loginMember"))).getMemberNo()));
			
			}
			
		model.addAttribute("like", like);	
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("listi", listi);
		model.addAttribute("listp", listp);
		model.addAttribute("ws_list", ws_list);
		}


		return "board/intro/introListView";
		}	
	}
		
		
	@GetMapping("introForm.bo")
	public String selectEnrollForm(HttpSession session,  @RequestParam(value="projectno") int projectNo, Model model
			) {
		
		Recruitment r = introService.selectRecruitment2(projectNo);
		
	
		ArrayList<Prelation> tags = introService.getTagInfo2(r); // 태그정보
		Rattachment thumOne = introService.getThumbOne(r); // 대표이미지
		ArrayList<Rattachment> thumList = introService.getAttachmentList2(r); // 이미지 목록
		Project p = introService.getProject(r);
		
		p.setProjectEnd(p.getProjectEnd().split(" ")[0]);
		p.setProjectStart(p.getProjectStart().split(" ")[0]);
		

		
		
		model.addAttribute("tags",tags);
		model.addAttribute("thumOne",thumOne);
		model.addAttribute("thumList",thumList);
		model.addAttribute("p", p);

		model.addAttribute("projectNo", projectNo);
		
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			return "redirect:/introlist.bo";
		}
		if(session.getAttribute("loginCompany") != null) {
			session.setAttribute("alertMsg", "기업회원은 이용 불가능합니다.");
			return "redirect:/introlist.bo";
		}
		return "board/intro/introEnrollForm";
	
	}
	
	@GetMapping("updateboard.io")
	public String selectupdateForm(HttpSession session, @RequestParam(value="projectno") int projectNo, Model model) {
		
		Recruitment r = introService.selectRecruitment2(projectNo);
		IBoard i = introService.iBoardUpdate(projectNo);
		ArrayList<Iattachment> ia = new ArrayList<Iattachment>();
		ia = introService.iAttachmentUpdate(i.getIboardNo());
		ArrayList<Iattachment> thumList2 = introService.getAttachmentList3(i); // 이미지 목록
		
		ArrayList<Prelation> tags = introService.getTagInfo2(r); // 태그정보
		Rattachment thumOne = introService.getThumbOne(r); // 대표이미지
		ArrayList<Rattachment> thumList = introService.getAttachmentList2(r); // 이미지 목록
		Project p = introService.getProject(r);
		
		i.setIboardInsert(i.getIboardInsert().split(" ")[0]);
		p.setProjectEnd(p.getProjectEnd().split(" ")[0]);
		p.setProjectStart(p.getProjectStart().split(" ")[0]);
		
		
		model.addAttribute("thumList2", thumList2);
		model.addAttribute("ia", ia);
		model.addAttribute("tags",tags);
		model.addAttribute("thumOne",thumOne);
		model.addAttribute("thumList",thumList);
		model.addAttribute("p", p);
		model.addAttribute("i", i);
		
		int result = introService.updateBoard(i);
		
		if(session.getAttribute("loginMember") == null) {
			session.setAttribute("alertMsg", "로그인 후 이용해 주세요.");
			return "redirect:/introlist.bo";
		}
		if(session.getAttribute("loginCompany") != null) {
			session.setAttribute("alertMsg", "기업회원은 이용 불가능합니다.");
			return "redirect:/introlist.bo";
		}
		return "board/intro/introUpdate";
		
	}
	
	/*
	@PostMapping("update.io")
	public String updateBoard(IBoard i,MultipartFile titleImg , ArrayList<MultipartFile> img, HttpSession session, Model model, HttpServletRequest request) {
		
		if(!titleImg.getOriginalFilename().equals("")) {
			
			if(i.get)
		}
		
			
			
			return null;
	}
	
	*/
	
	@RequestMapping(value="introinsert.bo")
	public String insertBoard(IBoard i, MultipartFile titleImg , ArrayList<MultipartFile> img, HttpSession session, Model model, HttpServletRequest request
			) {
		
		
		
		i.setIboardWriter(String.valueOf(((Member)(session.getAttribute("loginMember"))).getMemberNo()));

		// 게시글 insert
		int result = introService.insertBoard(i);
		// 해당 프로젝트 update로 다음번 리스트 안뜨게 하기
		int result2 = introService.updateReady(i);
		
		
		// 첨부파일 insert
		if(result > 0) {
			String path = request.getRealPath("resources\\file_upload\\iboard\\");			
			
			if(titleImg != null) {
				UUID uuid = UUID.randomUUID();
				File file = new File(path + "\\" + uuid + "_" + titleImg.getOriginalFilename());
				try { 
					titleImg.transferTo(file);
				}catch (IllegalStateException | IOException e) { 
					e.printStackTrace();
					model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일이잘못됨"); 
					return "common/errorPage";
				}
				Iattachment ia = new Iattachment();
				ia.setIAttachmentOrigin(titleImg.getOriginalFilename()); 
				ia.setIAttachmentLevel(0);
				ia.setIAttachmentChange(uuid + "_" + titleImg.getOriginalFilename()); 
				ia.setIAttachmentPath("resources\\file_upload\\iboard\\");
				int result3 = introService.insertImg(ia);
				session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
				
				
				
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
							model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일이 잘못됨"); 
							return "common/errorPage";
						}
						Iattachment ia = new Iattachment();
						ia.setIAttachmentOrigin(mf.getOriginalFilename()); 
						ia.setIAttachmentLevel(1);
						ia.setIAttachmentChange(uuid + "_" + mf.getOriginalFilename()); 
						ia.setIAttachmentPath("resources\\file_upload\\iboard\\");
						int result3 = introService.insertImg(ia);
						session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
					
					}
				}
				return "redirect:/introlist.bo";
			} 
		} 
		if(result > 0 && result2 > 0) {
			session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
			return "redirect:/introlist.bo";
			
		} else {			
			model.addAttribute("errorMsg", "게시글 등록 실패");
			return "common/errorPage";
		}
	}
	
	
	
	public String saveFile(MultipartFile upfile, HttpSession session, HttpServletRequest request) {

		String originName = upfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		int ranNum = (int)(Math.random() * 90000 + 10000);
		
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + ranNum + ext;
		String savePath = request.getRealPath("resources\\file_upload\\iboard\\");
		// String savePath = session.getServletContext().getRealPath("/resources/image/intro/");
		
		try {
			upfile.transferTo(new File(savePath + "\\" + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
	
	@PostMapping(value="deleteForm.ib")
	public String deleteForm(HttpSession session, Model model, int ino) {
		
		if(session.getAttribute("loginMember") == null) { 
			session.setAttribute("alertMsg", "로그인을 먼저해주세요."); 
			return "redirect:/"; 
		}
		int result = introService.deleteForm(ino);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "글이 삭제되었습니다.");
		}
		
			return "redirect:/introlist.bo";
		
	}
	
	@GetMapping(value="introWish.hb", produces="text/html; charset=UTF-8") 
	@ResponseBody 
	public String wish(HttpSession session, String iboardNo) {
		
		Likes iw = new Likes(((Member)session.getAttribute("loginMember")).getMemberNo(), Integer.parseInt(iboardNo));
		
		return (introService.getWish(iw) > 0) ? introService.deleteWish(iw) : introService.insertWish(iw);
	}
	
	@ResponseBody
	@RequestMapping(value = "ilist.bo", produces = "application/json; charset=UTF-8")
	public String ajaxSelectReplyList(int ino) {
		
		ArrayList<IreplyImage> list = introService.selectReplyList(ino);
		for(IreplyImage ir: list) {
			ir.setMemberNo(String.format("%08d" ,Integer.parseInt(ir.getMemberNo())));
		}
		
		return new Gson().toJson(list);
	}
	
	@ResponseBody @RequestMapping(value = "selectReplyListChild.bo", produces = "application/json; charset=UTF-8")
	public String selectReplyListChild(Ireply ir) {
		ArrayList<IreplyImage> list = introService.selectReplyListChild(ir);
		for(IreplyImage im: list) { im.setMemberNo(String.format("%08d" ,Integer.parseInt(im.getMemberNo()))); }
		return new Gson().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping(value = "iinsert.bo", produces = "text/html; charset=UTF-8")
	public String ajaxInsertReply(Ireply r) {
		
		int result = introService.insertReply(r);

		return (result > 0)? "success" : "fail";
		
	}
	
	@RequestMapping(value = "ireply.bo", produces = "text/html; charset=UTF-8") @ResponseBody
	public String insertReplyChild(Ireply r) {
		System.out.println(r);
		int result = introService.insertReply(r);

		return String.valueOf(result);
	}
	
	@ResponseBody
	@RequestMapping(value = "idelete.bo", produces = "text/html; charset=UTF-8")
	public String ajaxDeleteReply(int ireplyNo)	{
		
		
		int result = introService.deletereply(ireplyNo);
		
		return (result > 0)? "success" : "error";
	}
	
	
	@RequestMapping(value = "iupdate.bo")
	@ResponseBody
	public String ajaxUpdateReply(int ireplyNo, String ireplyContent) {

		Ireply r = new Ireply();
		r.setIreplyNo(ireplyNo);
		r.setIreplyContent(ireplyContent);
		
		int result = introService.updatereply(r);

		
		return (result > 0)? "success" : "error";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "topList.io", produces = "application/json; charset=UTF-8")
	public String ajaxTopBoardList() {
		
		ArrayList<IBoard> list = introService.selectTopList();
		
		return new Gson().toJson(list);
	}
	
	@GetMapping(value="recent.iec", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String recentList(){
		ArrayList<Iattachment> list = introService.selectRecent();
		return new Gson().toJson(list);
	}
	/*
	@GetMapping(value="search.bo")
	public String Search(@RequestParam(value="condition") String condition, @RequestParam(value="keyword") String keyword, @RequestParam(value="cpage", defaultValue="1") int currentPage,
			HttpSession session, Model model) {
		
		ISearch is = new ISearch(condition, keyword);  
		
		int searchCount = introService.selectSearchCount(is);
		
		int pageLimit = 5;
		int boardLimit = 9;
		
		
		
		PageInfo pi = Pagination.getPageInfo(searchCount,  currentPage,  pageLimit,  boardLimit);
		

			if(pi.getMaxPage() == 0) {
				return "board/intro/introListView";

			}
			
			else if((currentPage > pi.getMaxPage()) || (currentPage <= 0)) {
				model.addAttribute("errorMsg", "잘못된 페이지입니다.");
				return "common/errorPage"; 
			}
		
			else {
			ArrayList<IBoard> list = introService.selectSearchList(is,pi);
			ArrayList<Iattachment> listi = new ArrayList<Iattachment>();
			ArrayList<Project> listp = new ArrayList<Project>();
			ArrayList<Boolean>ws_list = new ArrayList<Boolean>();
			
			System.out.println(list);
			
			for(IBoard ib : list) { 
				listi.add(introService.selectattachment(ib));
				listp.add(introService.selectPro(ib));
				int like = introService.countLike(ib);
				if(session.getAttribute("loginMember") != null) { 
					ws_list.add(introService.getWishList(ib, ((Member)(session.getAttribute("loginMember"))).getMemberNo()));
				}
				
			model.addAttribute("like", like);	
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("listi", listi);
			model.addAttribute("listp", listp);
			model.addAttribute("ws_list", ws_list);
			
			}


			return "board/intro/introListView";
			}	
		}
		*/
}