package com.kh.coddy.common.calendar.model.service;

import java.util.ArrayList;

import com.kh.coddy.common.calendar.model.vo.Schedule;

public interface CalendarService {
	ArrayList<Schedule> selectSchedule(int pno);
	int insertSchedule(Schedule sc);
	int deleteSchedule(Schedule sc);
	
}
