package com.kh.coddy.common.chat.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.kh.coddy.board.recruitment.model.vo.Project;
import com.kh.coddy.common.chat.model.service.ChatService;
import com.kh.coddy.common.chat.model.vo.ChatDto;
import com.kh.coddy.common.chat.model.vo.ChatMember;
import com.kh.coddy.common.chat.model.vo.ChatMessage;

import lombok.extern.slf4j.Slf4j;

@Controller @Slf4j
public class ChatController {    
	
	@Autowired
	private ChatService cService;

	
	
	@GetMapping(value="room.rec", params="pno")
	public String enterRoom(@RequestParam(name="pno") int pno, Model model) {
		log.info("enterRoom 호출됨");
		Project p = cService.getProject(pno);
		model.addAttribute("p",p);
		return "project/room";
	}
	
	
	@GetMapping(value = "room.rec", params="roomId")
	public void messageList(@RequestParam(name="roomId") int roomId, HttpServletResponse response) throws JsonIOException, IOException {		
		log.info("messageList 호출됨");					
		ArrayList<ChatMessage> mList = cService.messageList(roomId); 						
		response.setContentType("application/json; charset=utf-8");
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
        gson.toJson(mList,response.getWriter());
	}
	
	@GetMapping(value="getMember.rec", params="roomId")
	public void getMember(@RequestParam(name="roomId") int roomId, HttpServletResponse response, HttpSession session) throws JsonIOException, IOException {
		ArrayList<ChatMember> cList = cService.chatMemberList(roomId);
		log.info("cList={}",cList);
		response.setContentType("application/json; charset=utf-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
        gson.toJson(cList,response.getWriter());
	}
	
	
	
	
	@ResponseBody
	@GetMapping("getApply.rec")
	public String getApply(int projectNo, String position) {
		int result = cService.getApply(new ChatMember(projectNo,0,position,"",""));
		return String.valueOf(result);		
	}
	
	@ResponseBody
	@GetMapping("getFixApply.rec")
	public ArrayList<Integer> getFixApply(int projectNo, String position) {
		ArrayList<Integer> memberNoList = cService.getFixApply(new ChatMember(projectNo,0,position,"",""));
		return memberNoList;		
	}
	
	@GetMapping("insertApply.rec")
	@ResponseBody
	public String insertApply(int projectNo, int memberNo, String position, int maxPersonnel, HttpSession session, Model model) {		
		ChatMember cm = new ChatMember(projectNo,memberNo, position,"","");	
		session.setAttribute("chatMember", cm);
		session.setAttribute("maxPersonnel", maxPersonnel);
		return String.valueOf(projectNo);
	}
	

	
	
	

	
}  