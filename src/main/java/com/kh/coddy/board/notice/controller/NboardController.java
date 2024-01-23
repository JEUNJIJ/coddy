package com.kh.coddy.board.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.coddy.board.notice.model.service.NboardService;
import com.kh.coddy.board.notice.model.vo.Nboard;
import com.kh.coddy.board.notice.model.vo.Nattachment;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.vo.Member;

@Controller
public class NboardController {

	@Autowired NboardService nboardService;
	
	@GetMapping("list.no")
	public ModelAndView selectList(
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			ModelAndView mv) {
		
		int listCount = nboardService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, 
						currentPage, pageLimit, boardLimit);
		
		ArrayList<Nboard> list = nboardService.selectList(pi);
		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .setViewName("board/notice/noticeListView");
		
		System.out.println(list);
		System.out.println(pi);
		  
		return mv;
	}
	
	@GetMapping("detail.no")
	public ModelAndView selectBoard(int nno, 
									ModelAndView mv) {

			int result = nboardService.increaseCount(nno);
			
			if(result > 0) { // 성공
			
				Nboard n = nboardService.selectBoard(nno);
				
				mv.addObject("n", n)
				.setViewName("board/notice/noticeDetailView"); 
			
			} else { 
				mv.addObject("errorMsg", "게시글 상세조회 실패")
				.setViewName("common/errorPage");
			}
			
		return mv;
	}
	@GetMapping(value="enrollForm.no")
	public String enrollForm(HttpSession session) {
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "어드민만 접근가능합니다!"); return "redirect:/"; }
		if(!((Member)session.getAttribute("loginMember")).getMemberId().equals("admin")) { session.setAttribute("alertMsg", "어드민만 접근가능합니다!"); return "redirect:/"; }
		return "board/notice/noticeEnrollForm";
	}
	
	@PostMapping(value = "/resources/file_upload/nboard/upload")
	public ModelAndView image(MultipartHttpServletRequest request) throws Exception {
	    ModelAndView mav = new ModelAndView("jsonView");

	    try {
	        MultipartFile uploadFile = request.getFile("uploadFile");

	        if (uploadFile != null && !uploadFile.isEmpty()) {
	            String originalFileName = uploadFile.getOriginalFilename();
	            String ext = originalFileName.substring(originalFileName.indexOf("."));
	            String newFileName = UUID.randomUUID() + ext;

	            String savePath = System.getProperty("user.dir") + "/src/main/webapp/resources/file_upload/nboard/" + newFileName;

	            String uploadPath = "./nboard/" + newFileName;

	            File file = new File(savePath);

	            uploadFile.transferTo(file);

	            mav.addObject("uploaded", true);
	            mav.addObject("url", uploadPath);
	        } else {
	            mav.addObject("uploaded", false);
	            mav.addObject("message", "업로드된 파일이 없습니다.");
	        }
	    } catch (Exception e) {
	        mav.addObject("uploaded", false);
	        mav.addObject("message", "파일 업로드 중 오류가 발생했습니다.");
	        e.printStackTrace();
	    }

	    return mav;
	}
	
	@PostMapping("insert.no")
	public String insertBoard(Nboard n,
							  HttpSession session,
							  Model model) {
	  

	    int result = nboardService.insertBoard(n);

	    if(result > 0) { // 게시글 작성 성공
			
			session.setAttribute("alertMsg", "게시글이 등록되었습니다.");
			
			return "redirect:/list.no"; 
			
		} else { // 게시글 작성 실패
			
			model.addAttribute("errorMsg", "게시글 등록 실패");
			
			return "common/errorPage";
	    }
	}
	
	@PostMapping("updateForm.no")
	public String updateForm(HttpSession session, int nno, Model model) {
		if(session.getAttribute("loginMember") == null) { session.setAttribute("alertMsg", "어드민만 접근가능합니다!"); return "redirect:/"; }
		if(!((Member)session.getAttribute("loginMember")).getMemberId().equals("admin")) { session.setAttribute("alertMsg", "어드민만 접근가능합니다!"); return "redirect:/"; }
		Nboard n = nboardService.selectBoard(nno);
			
		model.addAttribute("n", n);
			
		return "board/notice/noticeUpdateForm";
		} 
	
	@PostMapping("update.no")
	public String updateBoard(Nboard n, 
	                          MultipartFile reupfile,
	                          HttpSession session,
	                          Model model) {
	    
	    // n.setNboardContent(String.valueOf(session.getAttribute("nboardContent")));
	    
	    if (reupfile != null && !reupfile.getOriginalFilename().equals("")) {
	        
	        if (n.getNboardChange() != null) {
	            
	            String realPath = session.getServletContext()
	                                .getRealPath(n.getNboardChange());
	            
	            new File(realPath).delete();
	        }
	        String nboardChange = saveFile(reupfile, session);
	        
	        n.setNboardOrigin(reupfile.getOriginalFilename());
	        n.setNboardChange("/resources/file_upload/nboard/upload/" + nboardChange);
	    }
	    
	    int result = nboardService.updateBoard(n);
	    
	    if (result > 0) { 
	        session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
	        
	        return "redirect:/detail.no?nno=" + n.getNboardNo();
	        
	    } else {
	        
	        model.addAttribute("errorMsg", "게시글 수정 실패");
	        
	        return "common/errorPage";
	    }   
	}
	
	public String saveFile(MultipartFile upfile,
			   HttpSession session) {

		String originName = upfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss")
												.format(new Date());
		
		int ranNum = (int)(Math.random() * 90000 + 10000);
		
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String nboardChange = currentTime + ranNum + ext;
		
		String savePath = session.getServletContext().getRealPath(File.separator + "resources" + File.separator + "file_upload" + File.separator + "nboard" + File.separator + "upload" + File.separator);
		
		try {
			
			upfile.transferTo(new File(savePath + nboardChange));
		
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return nboardChange;
	}

	
	@RequestMapping("delete.no")
	public String deleteBoard(int nno,
							  String filePath,
							  Model model,
							  HttpSession session) {
		
		int result = nboardService.deleteBoard(nno);
		
		if(result > 0) {
			if(!filePath.equals("")) {
				
				String realPath = session.getServletContext()
								.getRealPath(filePath);
				
				new File(realPath).delete();
			}
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			
			return "redirect:/list.no";
			
		} else { 
			
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			
			return "common/errorPage";
		}
	}	
	
}
