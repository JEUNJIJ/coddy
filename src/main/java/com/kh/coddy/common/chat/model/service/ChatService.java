package com.kh.coddy.common.chat.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.coddy.board.recruitment.model.vo.Project;
import com.kh.coddy.common.chat.model.vo.ChatMember;
import com.kh.coddy.common.chat.model.vo.ChatMessage;
import com.kh.coddy.common.chat.model.vo.ChatRoom;


public interface ChatService {
	 /**
     * 방 번호를 선택하는 메소드
     * @param roomId
     * @return
     */
    ChatRoom selectChatRoom(String roomId);
 
    /**
     * 채팅 메세지 DB 저장
     * @param chatMessage
     * @return 
     */
    int insertMessage(ChatMessage chatMessage);
 
    /**
     * 메세지 내용 리스트 출력
     * @param roomId
     * @return
     */
    ArrayList<ChatMessage> messageList(int roomId);

    /**
     * 채팅 방 DB 저장
     * @param room
     * @return
     */
    int createChat(ChatRoom room);
 
    /**
     * DB에 채팅 방이 있는지 확인
     * @param room
     * @return
     */
    ChatRoom searchChatRoom(ChatRoom room);
 
    /**
     * 채팅 방 리스트 출력
     * @param userEmail
     * @return
     */
    List<ChatRoom> chatRoomList(String userEmail);
 
    /**
     * 채팅 읽지 않은 메세지 수 출력
     * @param message
     * @return
     */
    int selectUnReadCount(ChatMessage message);
 
    /**
     * 읽은 메세지 숫자 0으로 바꾸기
     * @param message
     * @return
     */
    int updateCount(ChatMessage message);
    
    /**
     * 채팅방 나갈시 채팅 인원 삭제
     * @param cm
     * @return
     */
    int outCaht(ChatMember cm);
    int getApply(ChatMember cm);
    ArrayList<Integer> getFixApply(ChatMember cm);
	int insertApply(ChatMember cm, int maxPersonnel);
	ArrayList<ChatMember> chatMemberList(int projectNo);
	Project getProject(int projectNo);
}
