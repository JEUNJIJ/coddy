package com.kh.coddy.common.calendar.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.coddy.common.calendar.model.dao.CalendarDao;
import com.kh.coddy.common.calendar.model.vo.Schedule;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDao calDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Schedule> selectSchedule(int pno) {
		return calDao.selectSchedule(sqlSession, pno);
	}
	
	@Override
	public int insertSchedule(Schedule sc) {
		return calDao.insertSchedule(sqlSession, sc);
	}

	@Override
	public int deleteSchedule(Schedule sc) {
		return calDao.deleteSchedule(sqlSession, sc);
	}

	

	
}
