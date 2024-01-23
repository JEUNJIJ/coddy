package com.kh.coddy.common.calendar.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.common.calendar.model.vo.Schedule;


@Repository
public class CalendarDao {
	
	public ArrayList<Schedule> selectSchedule(SqlSessionTemplate sqlSession, int pno) {
		return (ArrayList)sqlSession.selectList("calendarMapper.selectSchedule",pno);
	}
	
	public int insertSchedule(SqlSessionTemplate sqlSession, Schedule sc) {
		return sqlSession.insert("calendarMapper.insertSchedule",sc);
	}
	
	public int deleteSchedule(SqlSessionTemplate sqlSession, Schedule sc) {
		return sqlSession.delete("calendarMapper.deleteSchedule",sc);
	}
}
