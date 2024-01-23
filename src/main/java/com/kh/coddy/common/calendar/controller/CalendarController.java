package com.kh.coddy.common.calendar.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.coddy.common.calendar.model.service.CalendarService;
import com.kh.coddy.common.calendar.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Slf4j @Controller
public class CalendarController {
	
	@Autowired
	public CalendarService calService;

	@GetMapping("selectSchedule.cal")
	@ResponseBody
	public List<Map<String, Object>> selectSchedule(int pno){
		
		HashMap<String, Object> map = new HashMap<>();
		ArrayList<Schedule> list = calService.selectSchedule(pno);
		
		JSONObject jsonObj;
		JSONArray jsonArr = new JSONArray();
		
		log.info("list = {}",list);
		for(Schedule schedule : list) {
			map.put("title", schedule.getEventTitle());
			map.put("start",schedule.getStartDate());
			map.put("end", schedule.getEndDate());
		
			jsonObj = new JSONObject(map);
			jsonArr.add(jsonObj);
		}
		
		 log.info("jsonArrCheck: {}", jsonArr);
        return jsonArr;		
	}
	
	@PostMapping("insertSchedule.cal")
	@ResponseBody
	public String inserSchedule(@RequestBody List<Map<String, Object>> param) {
	    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);
	    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm", Locale.KOREA);

	    for (Map<String, Object> list : param) {
	        String eventName = (String) list.get("title");
	        String startDateString = (String) list.get("start");
	        log.info("start={}", startDateString);
	        String endDateString = (String) list.get("end");
	        int pno = Integer.parseInt((String) list.get("pno")); 
	        
	        LocalDateTime startDateUTC = LocalDateTime.parse(startDateString, inputFormatter);
	        LocalDateTime endDateUTC = LocalDateTime.parse(endDateString, inputFormatter);
	        
	        String formattedStartDate = startDateUTC.format(outputFormatter);
	        String formattedEndDate = endDateUTC.format(outputFormatter);	        	        	        

	        Schedule sc = new Schedule(eventName, formattedStartDate, formattedEndDate, pno);
	        log.info("sc={}", sc);
	        calService.insertSchedule(sc);
	    }
	    return "insertSchedule.cal";
	}
	
	@DeleteMapping("deleteSchedule.cal")
	@ResponseBody
	public String  deleteSchedule(@RequestBody List<Map<String, Object>> param){
		DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.KOREA);
	    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm", Locale.KOREA);
	    
	    for (Map<String, Object> list : param) {
	        String eventName = (String) list.get("title");
	        String startDateString = (String) list.get("start");
	        log.info("start={}", startDateString);
	        String endDateString = (String) list.get("end");
	        int pno = Integer.parseInt((String) list.get("pno")); 
	        
	        LocalDateTime startDateUTC = LocalDateTime.parse(startDateString, inputFormatter);
	        LocalDateTime endDateUTC = LocalDateTime.parse(endDateString, inputFormatter);
	        
	        String formattedStartDate = startDateUTC.format(outputFormatter);
	        String formattedEndDate = endDateUTC.format(outputFormatter);	        	        	        

	        Schedule sc = new Schedule(eventName, formattedStartDate, formattedEndDate, pno);
	        log.info("sc={}", sc);
	        calService.deleteSchedule(sc);
	    }
	    
	    return "deleteSchedule.cal";

	}
}



