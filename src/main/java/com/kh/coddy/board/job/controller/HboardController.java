package com.kh.coddy.board.job.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.coddy.board.job.model.service.HboardService;
import com.kh.coddy.board.job.model.vo.HSearch;
import com.kh.coddy.board.job.model.vo.Hattachment;
import com.kh.coddy.board.job.model.vo.Hboard;
import com.kh.coddy.board.job.model.vo.Hrelation;
import com.kh.coddy.board.job.model.vo.Hwishlist;
import com.kh.coddy.common.Keys;
import com.kh.coddy.common.Pagination;
import com.kh.coddy.common.RemoveHTMLTag;
import com.kh.coddy.common.tag.ReadTag;
import com.kh.coddy.common.tag.controller.TagsController;
import com.kh.coddy.common.vo.Geo;
import com.kh.coddy.common.vo.PageInfo;
import com.kh.coddy.member.model.service.CompanyService;
import com.kh.coddy.member.model.vo.Company;
import com.kh.coddy.member.model.vo.Member;

@Controller
public class HboardController {
	private Logger log = LoggerFactory.getLogger(getClass());
	@Autowired private TagsController tagsController;
	@Autowired private HboardService hboardService;
	@Autowired private CompanyService companyService;
	@Autowired private PasswordEncoder pbkdf2;
	private String allowTags = "h4, h5, h6";

	@GetMapping(value="listView.hb") public String listView(HttpSession session, @RequestParam(value="cpage", defaultValue="1") int currentPage, 
			@RequestParam(value="search", defaultValue="") String search, @RequestParam(value="education", defaultValue="none") String education, 
			@RequestParam(value="career", defaultValue="none") String career, @RequestParam(value="sort", defaultValue="new") String sort, 
			@RequestParam(value="tag", defaultValue="") String tag, @RequestParam(value="viewOn", defaultValue="f") String active,
			@RequestParam(value="where", defaultValue="all") String where, Model model) {
		String tags = "";
		if(tag.equals("")) { tags = tagsController.getTagsNameString(); } 
		else { tags=tag; }
		HSearch hs = new HSearch(search, education.split(" "), career.split(" "), null, Arrays.stream(tags.split(",")).distinct().toArray(String[]::new), (active.equals("t"))?1:0, getAddressRangeByLocation(where).split(",")[0], getAddressRangeByLocation(where).split(",")[1]);
		if(career.equals("none")) { hs.setCareer(("none,intern,newcomer,junior,middle,senior").split(",")); }
		if(education.equals("none")) { hs.setEducation(("none,highSchool,juniorCollege,university,master,doctor,professor").split(",")); }
		if(sort.equals("new") || sort.equals("")) { hs.setSort("H.HBOARD_NO"); }
		else if(sort.equals("old")) { hs.setSort("HBOARD_END"); }
		else if(sort.equals("view")) { hs.setSort("HBOARD_VIEWS"); }
		else { hs.setSort("HBOARD_SALARY"); }
		int listCount = hboardService.selectListCount(hs);
		int pageLimit = 5; int boardLimit = 8;
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		if(pi.getMaxPage() == 0) { 
			ArrayList<Hboard>list = hboardService.selectList(pi, hs);
			ArrayList<Hattachment>at_list = new ArrayList<Hattachment>();
			ArrayList<ArrayList<Hrelation>>tg_list = new ArrayList<ArrayList<Hrelation>>();
			ArrayList<Boolean>ws_list = new ArrayList<Boolean>();
			for(Hboard h:list) { 
				h.setHboardLocation(getLocationByAddr(Integer.parseInt(h.getHboardLocation())));
				at_list.add(hboardService.getThumbOne(h));
				tg_list.add(hboardService.getTagInfo(h));
				if(session.getAttribute("loginMember") != null) { ws_list.add(hboardService.getWishList(h, ((Member)(session.getAttribute("loginMember"))).getMemberNo())); }
			}
			model.addAttribute("hs", hs);
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("at_list", at_list);
			model.addAttribute("tg_list", tg_list);
			model.addAttribute("ws_list", ws_list);
			model.addAttribute("tagAll", tagsController.getTagsNameList());
			return "board/job/hboardListView";
		}
		else if((currentPage > pi.getMaxPage()) || (currentPage <= 0)) { model.addAttribute("errorMsg", "잘못된 페이지"); return "common/errorPage"; }
		else {
			ArrayList<Hboard>list = hboardService.selectList(pi, hs);
			ArrayList<Hattachment>at_list = new ArrayList<Hattachment>();
			ArrayList<ArrayList<Hrelation>>tg_list = new ArrayList<ArrayList<Hrelation>>();
			ArrayList<Boolean>ws_list = new ArrayList<Boolean>();
			for(Hboard h:list) { 
				h.setHboardLocation(getLocationByAddr(Integer.parseInt(h.getHboardLocation())));
				at_list.add(hboardService.getThumbOne(h));
				tg_list.add(hboardService.getTagInfo(h));
				if(session.getAttribute("loginMember") != null) { ws_list.add(hboardService.getWishList(h, ((Member)(session.getAttribute("loginMember"))).getMemberNo())); }
			}
			model.addAttribute("hs", hs);
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("at_list", at_list);
			model.addAttribute("tg_list", tg_list);
			model.addAttribute("ws_list", ws_list);
			model.addAttribute("tagAll", tagsController.getTagsNameList());
			return "board/job/hboardListView";
		}
	}
	@GetMapping(value="insertForm.hb") public String insertBoardForm(HttpSession session, Model model) { 
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "기업에게만 제공되는 서비스입니다."); return "redirect:/"; } 
		if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "로그인을 먼저해주세요."); return "redirect:/loginPage.cp"; }
		model.addAttribute("tagAll", tagsController.getTagsNameList());
		return "board/job/hboardInsertForm";
	}
	@PostMapping(value="insert.hb") public String insertBoard(HttpSession session, Model model, HttpServletRequest request, Hboard h, String tagAllName, MultipartFile thumb, List<MultipartFile> files) {
		h.setHboardTitle(RemoveHTMLTag.allow(h.getHboardTitle(), allowTags));
		int result = 0;
		try { result = hboardService.insertBoard(h); } catch (Exception e) { model.addAttribute("errorMsg", "4000자를 넘겨버림"); return "common/errorPage"; }
		if(result > 0) {
			String path = request.getRealPath("resources\\file_upload\\hboard\\");
			if(!thumb.isEmpty()) {
				UUID uuid = UUID.randomUUID();
				File file = new File(path + "\\" + uuid + "_" + thumb.getOriginalFilename());
				try { thumb.transferTo(file); }
				catch (IllegalStateException | IOException e) { 
					e.printStackTrace();
					model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일 및 태그설정이 잘못됨"); 
					return "common/errorPage";
				}
				Hattachment ha = new Hattachment();
				ha.setHattachmentOrigin(thumb.getOriginalFilename()); ha.setHattachmentLevel(1);
				ha.setHattachmentChange(uuid + "_" + thumb.getOriginalFilename()); ha.setHattachmentPath("resources\\file_upload\\hboard\\");
				int f = hboardService.insertThumb(ha);
				if(f <= 0) { model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일 및 태그설정이 잘못됨"); return "common/errorPage"; }
			}
			if(files != null) {
				for (MultipartFile mf: files) { 
					if(!mf.isEmpty()) {
						UUID uuid = UUID.randomUUID();
						File file = new File(path + "\\" + uuid + "_" + mf.getOriginalFilename());
						try { mf.transferTo(file); }
						catch (IllegalStateException | IOException e) { 
							e.printStackTrace();
							model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일 및 태그설정이 잘못됨"); 
							return "common/errorPage";
						}
						Hattachment ha = new Hattachment();
						ha.setHattachmentOrigin(mf.getOriginalFilename()); ha.setHattachmentLevel(0);
						ha.setHattachmentChange(uuid + "_" + mf.getOriginalFilename()); ha.setHattachmentPath("resources\\file_upload\\hboard\\");
						int ha_insert = hboardService.insertThumb(ha);
						if(ha_insert <= 0) { model.addAttribute("errorMsg", "게시글은 작성하였으나 첨부파일 및 태그설정이 잘못됨"); return "common/errorPage"; }
					}
				}
			}
			if(tagAllName.equals("")) { log.info("hboardInsertNoTag={}, ip={}", (Company)(session.getAttribute("loginCompany")), request.getRemoteAddr()); }
			else { 
				String[] tags = ReadTag.read(tagAllName);
				for(String t:tags) { if(!hboardService.insertTag(new Hrelation(h.getHboardNo(), t))) { model.addAttribute("errorMsg", "게시글은 작성하였으나 태그 설정이 잘못됨"); return "common/errorPage"; } }
				log.info("hboardInsertTags={}, ip={}", (Company)(session.getAttribute("loginCompany")), request.getRemoteAddr());
			}
			session.setAttribute("alertMsg", "게시글 작성 성공");
			return "redirect:/listView.hb?cpage=1&search=&sort=new&career=none&education=none&tag=&where=all&viewOn=f";  
		}
		else { model.addAttribute("errorMsg", "게시글 작성 실패"); return "common/errorPage"; }
	}
	@GetMapping(value="boardWish.hb", produces="text/html; charset=UTF-8") @ResponseBody public String wish(HttpSession session, String hboardNo) {
		Hwishlist hw = new Hwishlist(((Member)session.getAttribute("loginMember")).getMemberNo(), Integer.parseInt(hboardNo));
		return (hboardService.getWish(hw) > 0) ? hboardService.deleteWish(hw): hboardService.insertWish(hw);
	}
	@GetMapping(value="boardDetail.hb") public String detailView(HttpSession session, @RequestParam(value="hno") String hboardNo, Model model) {
		if(hboardService.plusView(Integer.parseInt(hboardNo)) < 1) { model.addAttribute("errorMsg", "페이지 찾기에 실패함"); return "common/errorPage"; }
		Hboard hb = hboardService.selectBoard(Integer.parseInt(hboardNo));
		String where = getLocationByAddr(Integer.parseInt(hb.getHboardLocation()));
		Company co = companyService.getCompanyByNo(Integer.parseInt(hb.getCompanyNo()));
		Hattachment ht = hboardService.getThumbOne(hb);
		ArrayList<Hattachment> ha = hboardService.getAttachmentList(hb);
		ArrayList<Hrelation> hr = hboardService.getTagInfo(hb);
		Geo geo = Geo.getGeo(hb.getHboardLocation());
		session.setAttribute("hb", hb);
		session.setAttribute("ht", ht);
		session.setAttribute("ha", ha);
		session.setAttribute("co", co);
		session.setAttribute("where", where);
		session.setAttribute("hr", hr);
		session.setAttribute("geo", geo);
		session.setAttribute("wish", hboardService.getAllWish(hb.getHboardNo()));
		try { session.setAttribute("tmapKey", Keys.read(new ClassPathResource("keys/kakaoMap.json").getURL().getPath(), "key.kakaoMap")); }
		catch (IOException | ParseException e) { e.printStackTrace(); }
		return "board/job/hboardDetailView"; 
	}
	@PostMapping(value="addFile.hb", produces="text/html; charset=UTF-8") @ResponseBody public String addFile(HttpSession session, HttpServletRequest req, MultipartFile uploadFiles) {
		try {
			String path = req.getRealPath("resources\\file_upload\\hboard\\");
			int hno = ((Hboard)(session.getAttribute("hb"))).getHboardNo();
			UUID uuid = UUID.randomUUID();
			File file = new File(path, uuid + "_" + uploadFiles.getOriginalFilename());
			uploadFiles.transferTo(file);
			Hattachment ha = new Hattachment(-1, hno, uploadFiles.getOriginalFilename(), uuid + "_" + uploadFiles.getOriginalFilename(), "resources\\file_upload\\hboard\\", null, 0);
			if(hboardService.addFile(ha) <= 0) { return "파일 삽입 실패"; }
			else { return "파일 삽입 성공"; }
		}
		catch(Exception e) { e.printStackTrace(); return "이미지 삽입 실패"; }
	}
	@PostMapping(value="minusFile.hb", produces="text/html; charset=UTF-8") @ResponseBody public String minusFile(HttpSession session, HttpServletRequest req, String ano) {
		try { if(hboardService.minusFile(Integer.parseInt(ano)) > 0) { return "삭제 성공"; } else { return "삭제 실패"; } }
		catch (Exception e) { e.printStackTrace(); return "삭제 에러"; }
	}
	@PostMapping(value="updateForm.hb") public String updateForm(HttpSession session, Model model, Hboard h) {
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "기업에게만 제공되는 서비스입니다."); return "redirect:/"; } 
		if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "로그인을 먼저해주세요."); return "redirect:/loginPage.cp"; }
		if(((Company)(session.getAttribute("loginCompany"))).getCompanyNo() != Integer.parseInt(h.getCompanyNo())) { 
			session.setAttribute("errorMsg", "잘못된 접근");
			return "common/errorPage";
		}
		Hboard hb = hboardService.selectBoard(h.getHboardNo());
		ArrayList<Hrelation> hr = hboardService.getTagInfo(hb);
		Hattachment ha = hboardService.getThumbOne(hb);
		String tagList = "";
		if (!hr.isEmpty()) { for(Hrelation hrr:hr) { tagList += hrr.getTagsNo() + ","; } }
		session.setAttribute("hb", hb);
		session.setAttribute("tagList", tagList.substring(0, tagList.length()-1));
		session.setAttribute("ha", ha);
		model.addAttribute("tagAll", tagsController.getTagsNameList());
		return "board/job/hboardUpdateForm"; 
	}
	@PostMapping(value="update.hb") public String updateBoard(HttpSession session, Model model, HttpServletRequest request, Hboard h, String tagAllName, MultipartFile thumb) {
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "기업에게만 제공되는 서비스입니다."); return "redirect:/"; } 
		if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "로그인을 먼저해주세요."); return "redirect:/loginPage.cp"; }
		if(((Company)(session.getAttribute("loginCompany"))).getCompanyNo() != Integer.parseInt(h.getCompanyNo())) { 
			session.setAttribute("errorMsg", "잘못된 접근");
			return "common/errorPage";
		}
		h.setHboardTitle(RemoveHTMLTag.allow(h.getHboardTitle(), allowTags));
		int result = 0;
		try { result = hboardService.updateBoard(h); } catch (Exception e) { model.addAttribute("errorMsg", "4000자를 넘겨버림"); return "common/errorPage"; }
		if(result <= 0) { model.addAttribute("errorMsg", "게시글 수정 실패"); return "common/errorPage"; }
		if(hboardService.initTag(h.getHboardNo()) <= 0) { model.addAttribute("errorMsg", "태그 초기화 실패"); return "common/errorPage"; }
		if(tagAllName.equals("")) { log.info("hboardUpdateNoTag={}, ip={}", (Company)(session.getAttribute("loginCompany")), request.getRemoteAddr()); }
		else { 
			String[] tags = ReadTag.read(tagAllName);
			for(String t:tags) { if(!hboardService.insertTag2(new Hrelation(h.getHboardNo(), t))) { model.addAttribute("errorMsg", "게시글은 작성하였으나 태그 설정이 잘못됨"); return "common/errorPage"; } }
			log.info("hboardUpdateTags={}, ip={}", (Company)(session.getAttribute("loginCompany")), request.getRemoteAddr());
		}
		String path = request.getRealPath("resources\\file_upload\\hboard\\");
		if(!thumb.isEmpty()) {
			hboardService.rejectThumb(h.getHboardNo());
			UUID uuid = UUID.randomUUID();
			File file = new File(path + "\\" + uuid + "_" + thumb.getOriginalFilename());
			try { thumb.transferTo(file); }
			catch (Exception e) { 
				e.printStackTrace();
				model.addAttribute("errorMsg", "게시글 수정 및 첨부파일 제거에 성공했으나 새 첨부파일 저장에 실패함"); 
				return "common/errorPage";
			}
			Hattachment ha = new Hattachment();
			ha.setHattachmentOrigin(thumb.getOriginalFilename()); ha.setHattachmentLevel(1); ha.setHboardNo(h.getHboardNo());
			ha.setHattachmentChange(uuid + "_" + thumb.getOriginalFilename()); ha.setHattachmentPath("resources\\file_upload\\hboard\\");
			if(hboardService.insertThumb2(ha) <= 0) { model.addAttribute("errorMsg", "게시글 수정 및 첨부파일 제거에 성공했으나 새 첨부파일 저장에 실패함"); return "common/errorPage"; }
		}
		session.setAttribute("alertMsg", "게시글 수정 성공");
		return "redirect:/boardDetail.hb?hno=" + h.getHboardNo();
	}
	@PostMapping(value="deleteForm.hb") public String deleteForm(HttpSession session, Model model, Hboard h) {
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "기업에게만 제공되는 서비스입니다."); return "redirect:/"; } 
		if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "로그인을 먼저해주세요."); return "redirect:/loginPage.cp"; }
		if(((Company)(session.getAttribute("loginCompany"))).getCompanyNo() != Integer.parseInt(h.getCompanyNo())) { 
			model.addAttribute("errorMsg", "잘못된 접근");
			return "common/errorPage";
		}
		session.setAttribute("hb", h);
		return "board/job/hboardDeleteForm"; 
	}
	@PostMapping(value="delete.hb") public String deleteBoard(HttpSession session, Model model, Hboard h, String password) {
		if(session.getAttribute("loginMember") != null) { session.setAttribute("alertMsg", "기업에게만 제공되는 서비스입니다."); return "redirect:/"; } 
		if(session.getAttribute("loginCompany") == null) { session.setAttribute("alertMsg", "로그인을 먼저해주세요."); return "redirect:/loginPage.cp"; }
		if(((Company)(session.getAttribute("loginCompany"))).getCompanyNo() != Integer.parseInt(h.getCompanyNo())) { 
			model.addAttribute("errorMsg", "잘못된 접근");
			return "common/errorPage";
		}
		if(pbkdf2.matches(password, ((Company)(session.getAttribute("loginCompany"))).getCompanyPwd())) { 
			if(hboardService.deleteBoard(h.getHboardNo()) > 0) { session.setAttribute("alertMsg", "삭제완료"); return "redirect:/listView.hb?cpage=1&search=&sort=new&career=none&education=none&tag=&where=all&viewOn=f"; } 
			else { model.addAttribute("errorMsg", "처리 오류"); return "common/errorPage"; } 
		}
		else { model.addAttribute("errorMsg", "비밀번호 오류"); return "common/errorPage"; }
	}
	@PostMapping(value="/uploadSummernoteImageFile.hb", produces="text/html; charset=UTF-8") @ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest req) {
		String path = req.getRealPath("resources\\file_upload\\hboard\\content\\");
		UUID uuid = UUID.randomUUID();
		
		File file = new File(path, uuid + "_" + multipartFile.getOriginalFilename());
		try { multipartFile.transferTo(file); return "resources\\file_upload\\hboard\\content\\" + uuid + "_" + multipartFile.getOriginalFilename(); }
		catch (IOException e) { FileUtils.deleteQuietly(file); e.printStackTrace(); }
		return null;
	}
	public String getLocationByAddr(int address) { 
		if((address >= 1000) && (address <= 8866)) return "서울특별시";
		if((address >= 10000) && (address <= 18635)) return "경기도";
		if((address >= 21000) && (address <= 23136)) return "인천광역시";
		if((address >= 24000) && (address <= 26509)) return "강원도";
		if((address >= 27000) && (address <= 29167)) return "충청북도";
		if((address >= 30000) && (address <= 30154)) return "세종시";
		if((address >= 31000) && (address <= 33677)) return "충청남도";
		if((address >= 34000) && (address <= 35428)) return "대전광역시";
		if((address >= 36000) && (address <= 40240)) return "경상북도";
		if((address >= 41000) && (address <= 43024)) return "대구광역시";
		if((address >= 44000) && (address <= 45015)) return "울산광역시";
		if((address >= 46000) && (address <= 49527)) return "부산광역시";
		if((address >= 50000) && (address <= 53337)) return "경상남도";
		if((address >= 54000) && (address <= 56469)) return "전라북도";
		if((address >= 57000) && (address <= 59792)) return "전라남도";
		if((address >= 61000) && (address <= 62466)) return "광주광역시";
		if((address >= 63000) && (address <= 63644)) return "제주도";
		else { return "알수없음"; }
	 }
	 public String getAddressRangeByLocation(String where) {
		if(where.equals("all")) { return "01000,63644"; }
		if(where.equals("서울특별시")) { return "01000,08866"; }
		if(where.equals("경기도")) { return "10000,18635"; }
		if(where.equals("인천광역시")) { return "21000,23136"; }
		if(where.equals("강원도")) { return "24000,26509"; }
		if(where.equals("충청북도")) { return "27000,29167"; }
		if(where.equals("세종시")) { return "30000,30154"; }
		if(where.equals("충청남도")) { return "31000,33677"; }
		if(where.equals("대전광역시")) { return "34000,35428"; }
		if(where.equals("경상북도")) { return "36000,40240"; }
		if(where.equals("대구광역시")) { return "41000,43024"; }
		if(where.equals("울산광역시")) { return "44000,45015"; }
		if(where.equals("부산광역시")) { return "46000,49527"; }
		if(where.equals("경상남도")) { return "50000,53337"; }
		if(where.equals("전라북도")) { return "54000,56469"; }
		if(where.equals("전라남도")) { return "57000,59792"; }
		if(where.equals("광주광역시")) { return "61000,62466"; }
		if(where.equals("제주도")) { return "63000,63644"; }
		else { return "01000,63644"; }
	 }
	 public File convert(MultipartFile file) throws IOException {
		 File convFile = new File(URLDecoder.decode(file.getOriginalFilename(), "UTF-8"));
		 convFile.createNewFile();
		 FileOutputStream fos = new FileOutputStream(convFile);
		 fos.write(file.getBytes());
		 fos.close();
		 return convFile;
	 }
}