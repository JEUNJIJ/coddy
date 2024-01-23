package com.kh.coddy.common.chat.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.coddy.board.recruitment.model.vo.Project;
import com.kh.coddy.common.chat.model.vo.ChatMember;
import com.kh.coddy.common.chat.model.vo.ChatMessage;
import com.kh.coddy.common.chat.model.vo.ChatRoom;

@Repository
public class ChatDao {
	
	public ChatRoom selectChatRoom(SqlSessionTemplate sqlSession, String roomId) {
		return sqlSession.selectOne("chatMapper.selectChatRoom",roomId);
	}
	public int insertMessage(SqlSessionTemplate sqlSession, ChatMessage msg) {
		return sqlSession.insert("chatMapper.insertMessage",msg);
	}
	public ArrayList<ChatMessage> messageList(SqlSessionTemplate sqlSession, int roomId) {
		return (ArrayList)sqlSession.selectList("chatMapper.messageList",roomId);
	}
	public int createChat(SqlSessionTemplate sqlSession,ChatRoom room) {
		return sqlSession.insert("chatMapper.createChat",room);
	}
	public int outChat(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.delete("chatMapper.outChat",cm);
	}
	public int getApply(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.selectOne("chatMapper.getApply",cm);
	}
	public int insertApply(SqlSessionTemplate sqlSession, ChatMember cm) {
		return sqlSession.insert("chatMapper.insertApply",cm);
	}
	public ArrayList<ChatMember> chatMemberList(SqlSessionTemplate sqlSession, int projectNo){
		return (ArrayList)sqlSession.selectList("chatMapper.chatMemberList",projectNo);
	}
	public Project getProject(SqlSessionTemplate sqlSession, int projectNo) {
		return sqlSession.selectOne("chatMapper.getProject",projectNo);
	}
	public ArrayList<Integer> getFixApply(SqlSessionTemplate sqlSession, ChatMember cm) {
		return (ArrayList)sqlSession.selectList("chatMapper.getFixApply",cm);
	}
		
}
