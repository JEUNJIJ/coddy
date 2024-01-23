<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.kh.coddy.common.Keys"%>
<%@page import="org.springframework.core.io.ClassPathResource"%>
<%@page import="org.springframework.core.io.Resource"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% 
Resource resource = new ClassPathResource("keys/kakaoMap.json");
String kakaoMapKey = Keys.read(resource.getURL().getPath(), "key.kakaoMap");  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.min.js"></script>
<link href='${ pageContext.request.contextPath }/resources/css/main.min.css' rel='stylesheet' />
<script src='${ pageContext.request.contextPath }/resources/js/main.min.js'></script>
<!-- jQuery 라이브러리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- 부트스트랩에서 제공하고 있는 스타일 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%= kakaoMapKey%>&libraries=services"></script>
<link href="${ pageContext.request.contextPath }/resources/css/room.css" rel="stylesheet" />
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<script>
  
    </script>
</head>
<body>
    <header>
        <div>
           <i id="exit" style="margin-top: 20px; margin-left: 20px; cursor: pointer; " onclick="onClose();" class="fa fa-door-open"></i>
        </div>
    </header>
    <div class="sidebar_left">
    </div>

    <div class="chat_area">
        <div class="chat-card">
            <div class="chat-body" id="chat_body">
              <!-- 동적으로 메세지 로드 -->
            </div>
            <div class="chat-footer">
              <input placeholder="Type your message" type="text" id="chat_input">
              <button>Send</button>
            </div>
          </div>        
    </div>
    
    <div class="sidebar_right">
        <div style="font-size: 20px" id="countdown">
          
        </div>
        <div id="calendar_area">
            <button  id="calendar_modal" class="button">
              <i class="fa fa-calendar"></i>  
              일정관리
            </button>            
        </div>
        <div id="meeting_place"></div>
        <button id="map_button" class="button"><i class="fa fa-map"></i> 장소정하기</button>    
        <button id="start_button" class="button"><i class="fa fa-play"></i> 시작하기</button>  
    </div>

    <!-- 달력 모달 -->

    <div class="modal" id="calendarModal">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
      
            <!-- Modal Header -->
            <div class="modal-header">
              <h4 class="modal-title">Modal Heading</h4>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
      
            <!-- Modal body -->
            <div class="modal-body">
              <div id='calendar'></div>
            </div>
      
            <!-- Modal footer -->
            <div class="modal-footer">
              <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
      
          </div>
        </div>
      </div>
 
      <!-- 카카오맵 모달 -->
      <div class="modal" id="mapModal">
        <div class="modal-dialog">
          <div class="modal-content">
      
            <!-- Modal Header -->
            <div class="modal-header">
              <input type="search" id="searchBar">
              <button type="button" id="searchBtn">검색</button>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
      
            <!-- Modal body -->
            <div class="modal-body">
              <div id="map" style="width:100%; height:500px;"></div>
            </div>
      
            <!-- Modal footer -->
            <div class="modal-footer">
              <div id="search_result"></div>
              <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="updatePlace()">장소 확정</button>
            </div>
      
          </div>
        </div>
      </div>

      <script>
        window.onpageshow = function(event) {
            if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
              location.reload();
          }
        }

        // 메세지 타입
        // 1 : 일반메세지
        // 2 : 일정변경 메세지
        // 3 : 장소 변경 메세지
        // 4 : 입장 메세지
        // 5 : 퇴장 메세지

        let roomId = '${sessionScope.chatMember.projectNo}'; 

        let webSocket;
      
        function connect(){
          // 웹소켓 주소
          var wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chat.do";
          
          // 소켓 객체 생성
          webSocket = new WebSocket(wsUri);

          // 웹소켓에 이벤트가 발생했을때 호출될 함수
          webSocket.onopen = onOpen;
          webSocket.onmessage = onMessage;
          webSocket.onclose = onClose;

          return "true";
        }

        // 웹소켓에 연결되었을 때 호출될 함수
        function onOpen(){
          // ENTER-CHAT 이라는 메세지를 보내고 채팅방이 존재하지 않는다면 채팅방을 생성, 존재한다면 채팅방 입장
          const data = {
            "roomId" : roomId,
            "memberNo" : "${sessionScope.loginMember.memberNo}",
            "memberName" : "${sessionScope.loginMember.memberName}",
            "message": "ENTER-CHAT",
            "messageType" : 4
          };
          let jsonData = JSON.stringify(data);
          webSocket.send(jsonData);
          
        }

        //  메세지 전송 함수
        function sendMessage(message){
          const data={
            "roomId" : roomId,
            "memberNo" : "${sessionScope.loginMember.memberNo}",
            "memberName" : "${sessionScope.loginMember.memberName}",
            "message" : message,
            "messageType" : 1
          };
          let jsonData = JSON.stringify(data);
          webSocket.send(jsonData);
        }

        // 메세지 수신
        function onMessage(evt){

          let receive = evt.data.split(",");
          
          const data = {
            "memberNo" : receive[0],
            "memberName" : receive[1],
            "message" : receive[2],
            "messageType" : receive[3]
          };
          checkLR(data);
          updateMemberList();
          $('.chat-body').scrollTop($('.chat-body').prop('scrollHeight')); // 스크롤 아래로

          if(receive[0] == "${sessionScope.loginMember.memberNo}" && receive[2] == "EXILE-CHAT" && receive[3]==5){
            onClose();
            alert("추방당하셨습니다.");
          }


        }

        // 뒤로가기 클릭시 채팅방 나가기
        window.addEventListener('beforeunload', function(event) {
            const data = {
                "roomId": roomId,
                "memberNo": "${sessionScope.loginMember.memberNo}",
                "memberName" : "${sessionScope.loginMember.memberName}",
                "role": "${sessionScope.chatMember.role}",
                "message": "END-CHAT",
                "messageType": 5
            };

            let jsonData = JSON.stringify(data);
            webSocket.send(jsonData);
        });

        function onClose() {
           location.href = 'detail.rec?rno=' + roomId;
        }



        // 내가 보낸 메세지인지 확인
        function checkLR(data){ 
          let div;
          if("${loginMember.memberNo}" != data.memberNo && data.messageType == 1){ // 상대가 보낸 메세지
          div = $("<div class='message incoming'>"
                + "<div>"+ data.memberName + "</div>"
                    +"<p>"+ data.message +"</p>"
                  +"</div>");
          }else if("${loginMember.memberNo}" == data.memberNo && data.messageType == 1){ // 내가 보낸 메세지
            div = $("<div class='message outgoing'>"
                  + "<div>"+ data.memberName + "</div>"
                          +"<p>"+ data.message +"</p>"
                        +"</div>");
          }else if(data.messageType == 2){ // 맵이 변경되었을때
            let strArr = data.message.split("_");
            div = $("<div> [공지] '"+strArr[1]+"' 으로 장소가 변경되었습니다.</div>");
            $("#meeting_place").html("<div id='map_place'>"+strArr[0]+" "+strArr[1]+"</div> <a class='button' id='directions' href='https://map.kakao.com/link/to/"+strArr[2]+"'>길찾기</a>");
          }else if(data.messageType == 3){
            div = $("<div> [공지] "+data.message+"</div>");
          }
          $("#chat_body").append(div);
        }     
        
        // 메세지 입력해서 전송
        $(document).on("keydown", ".chat-footer>input", function(e){
            if(e.keyCode == 13 && !e.shiftKey){
              e.preventDefault();
              const message = $(this).val();

              let search3 = $('.chat-footer>input').val();
                  
              if(search3.replace(/\s|  /gi, "").length == 0){ // 문자 공백 확인
                    return false;
                    $('.chat-footer>input').focus();
              }
              
              sendMessage(message);
              clearText();
            }
        });
        
        // 메세지 지우기
        function clearText() {
              $('.chat-footer>input').val('');
              return false;
        };
        $(function(){

            if(connect()){
            
            updateMemberList();
            // 메세지 불러오기
            countDown();
            $.ajax({
                url:"room.rec",
                type:"get",
                data: {
                  roomId : roomId
                },
                success : function(data){
                  for(var i=0; i<data.length; i++){
                    checkLR(data[i]);
                  }
                  $('.chat-body').scrollTop($('.chat-body').prop('scrollHeight')); // 스크롤 아래로
                },
                error : function(){
                  console.log("메세지 불러오기 실패");
                }
              });  
            }
          });

          let memberList = new Array();

          // 참여한 인원 불러오기
          function updateMemberList() {
            $.ajax({
              url: "getMember.rec",
              data: {
                  roomId: roomId
              },
            success: function (result) {

              memberList = [];
            
              let newContent = $("<div></div>");

            for (let i = 0; i < result.length; i++) {
                let div = "";
                
                if(${requestScope.p.projectOwner} == ${sessionScope.loginMember.memberNo}){
                div = "<div class='card'>" +
                        "<div style='float:left' class='textBox'>" +        
                          "<div class='textContent'>" +
                        "<p class='h1'>" + result[i].memberName + "</p>" +
                        "<span class='span' id='exile' >추방하기</span>" +
                        "<div id='chatMemberNo' style='display:none'>"+result[i].memberNo+"</div>"+
                        "</div>" +
                        "<p class='p'>" + result[i].role + "</p>" +
                        "</div>" +
                        
                       
                      "</div>";
                
                if (result[i].memberNo == ${requestScope.p.projectOwner}) {
                  div = "<div class='card'>" +
                        "<div class='textBox'>" +
                        "<div class='textContent'>" +
                        "<p class='h1'>" + result[i].memberName + "</p>" +
                        "<span class='span'>방장</span>" +
                        "</div>" +
                        "<p class='p'>" + result[i].role + "</p>" +
                        "</div>" +
                        "</div>";
                }
              }else{
                div = "<div class='card'>" +
                        "<div style='float:left' class='textBox'>" +
                        "<div class='textContent'>" +
                        "<p class='h1'>" + result[i].memberName + "</p>" +
                        "<span class='span'></span>" +
                        "</div>" +
                        "<p class='p'>" + result[i].role + "</p>" +
                        "</div>" +
                        "</div>";
                
                if (result[i].memberNo == ${requestScope.p.projectOwner}) {
                  div = "<div class='card'>" +
                        "<div class='textBox'>" +
                        "<div class='textContent'>" +
                        "<p class='h1'>" + result[i].memberName + "</p>" +
                        "<span class='span'>방장</span>" +
                        "</div>" +
                        "<p class='p'>" + result[i].role + "</p>" +                       
                        "</div>" +
                        "</div>";
                }
              }
                
                newContent.append(div);
                memberList = result;
            }

            $(".sidebar_left").html(newContent.html());
        }
        });
      }
            

 
  $(function(){

    if(${requestScope.p.projectReady}>0){
        $("#start_button").text("프로젝트가 진행 중입니다.");
        $("#start_button").css("background-color","lightgray");
        $("#start_button").css("cursor","default")
    }

 // 달력 오픈
    $('#calendar_modal').click(function(){
      $("#calendarModal").modal();

      // 달력 열면 해당 프로젝트 일정 불러오기
      $.ajax({
        url:"selectSchedule.cal",
        type:"get",
        data:{pno : roomId},
        dataType:"json",
        success : function(data){
          open_fc(data);
        }
      });
    });

    // 카카오맵
    $('#map_button').click(function(){
      $('#mapModal').modal();

      // 마커리스트
      var markers = [];

      // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
      var infowindow = new kakao.maps.InfoWindow({zIndex:1});
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
          center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
          level: 3 // 지도의 확대 레벨
      };  
      // 지도를 생성합니다    
      var map = new kakao.maps.Map(mapContainer, mapOption); 

      // 장소 검색 객체를 생성합니다
      var ps = new kakao.maps.services.Places(); 

      // 키워드로 장소를 검색합니다
      $("#searchBtn").click(function search(){
          var keyword = document.getElementById("searchBar").value;
          ps.keywordSearch(keyword, placesSearchCB); 
          
          // 마커 초기화
          if(markers.length>0){
            for(let i =0; i<markers.length; i++){
              markers[i].setMap(null);
            }
          }
      });
    
    
      // 키워드 검색 완료 시 호출되는 콜백함수 입니다
      function placesSearchCB (data, status, pagination) {
          if (status === kakao.maps.services.Status.OK) {
      
              // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
              // LatLngBounds 객체에 좌표를 추가합니다
              var bounds = new kakao.maps.LatLngBounds();
      
              for (var i=0; i<data.length; i++) {
                  displayMarker(data[i]);    
                  bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
              }       
      
              // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
              map.setBounds(bounds);
          } 
      }
    
      // 지도에 마커를 표시하는 함수입니다
      function displayMarker(place) {
          // 마커를 생성하고 지도에 표시합니다
          var marker = new kakao.maps.Marker({
              map: map,
              position: new kakao.maps.LatLng(place.y, place.x) 
          });

          markers.push(marker);
      
          // 마커에 클릭이벤트를 등록합니다
          kakao.maps.event.addListener(marker, 'click', function() {
              // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다

              var full_place = (place.address_name +"_"+ place.place_name +"_"+place.id);
              infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name+ '</div>');
              infowindow.open(map, marker);
      
              // 검색한 결과를 result에 뿌리기
              var result = document.getElementById("search_result");
              result.innerHTML = full_place;
          });
      }    
    });
  });

  // 장소 변경
  function updatePlace(){
    if("${sessionScope.loginMember.memberNo}" == "${requestScope.p.projectOwner}"){
    let place = document.getElementById("search_result").innerText;
    
    if(place != ""){

    
      $.ajax({
        url:"updatePlace.rec",
        type:"get",
        data:{
          projectNo : roomId,
          place : place
        },
        success : function(){
          const data={
            "roomId" : roomId,
            "memberNo" : "${sessionScope.loginMember.memberNo}",
            "message" : place,
            "messageType" : 2
          };
          let jsonData = JSON.stringify(data);
          webSocket.send(jsonData);
        }
        
      })
    }else{
      alert("방장만 장소를 정할수있습니다.");
    }
  }else{
    alert("장소 확정을 눌러주세요.");
  }

  }


  // 일정 조회, 추가, 삭제
  function open_fc(data) {
        
        var calendarEl = document.getElementById('calendar');
    
        var calendar = new FullCalendar.Calendar(calendarEl, {
          headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
          },
          locale: 'ko', // 한국어 설정
          timeZone: 'Asia/Seoul',
          navLinks: true,
          selectable: true,
          droppable : true,
      
          // 드래그로 일정 추가
          select:function(info){
           
          if("${sessionScope.loginMember.memberNo}" == "${requestScope.p.projectOwner}"){
          let title = prompt('추가할 일정:');

          // title 값이 있을때, 화면에 calendar.addEvent() json형식으로 일정을 추가
          if (title) {
            calendar.addEvent({
              title: title,
              start: info.start,
              end: info.end,
              allDay: info.allDay,
              projectNo : roomId
            }); 
          }
          var allEvent = calendar.getEvents(); // .getEvents() 함수로 모든 이벤트를 Array 형식으로 가져온다

          var events = new Array(); // Json 데이터를 받기위한 배열 선언
        
            var obj = new Object(); // Json을 담기 위해 Object 선언
            obj.title = title;  // 이벤트 이름
            obj.start = info.start; // 이벤트 시작 날짜
            obj.end = info.end; // 이벤트 끝 날짜
            obj.pno = roomId; // 프로젝트 번호
            events.push(obj);
          

          var jsondata= JSON.stringify(events);
    

          $(function saveData(jsondata) {
              $.ajax({
                  url: "insertSchedule.cal",
                  method: "POST",
                  data: JSON.stringify(events),
                  contentType: 'application/json'
              })
              .done(function(){
                  console.log("sds");
                  const data={
                      "roomId" : roomId,
                      "memberNo" : "${sessionScope.loginMember.memberNo}",
                      "message" : "일정이 추가되었습니다.",
                      "messageType" : 3
                    };
                    
                    let jsonData = JSON.stringify(data);
                    webSocket.send(jsonData);
                })
             
              calendar.unselect();
          });
          }else{
            alert("방장만 일정을 추가할수있습니다.")
          }
        },
           
          // 이벤트 클릭해서 삭제
          eventClick: function (info){
          if("${sessionScope.loginMember.memberNo}" == "${requestScope.p.projectOwner}"){
          if(confirm("'"+info.event.title+ "'일정을 삭제하시겠습니까?'")){
            info.event.remove();
        
            var events = new Array(); // Json 데이터를 받기 위한 배열 선언
            var obj = new Object();
                obj.title = info.event._def.title;
                obj.start = info.event._instance.range.start;
                obj.end = info.event._instance.range.end;
                obj.pno = roomId
                events.push(obj);
            }
            $(function deleteData(){
                $.ajax({
                    url: "deleteSchedule.cal",
                    method: "DELETE",
                    data: JSON.stringify(events),
                    contentType: 'application/json'

                })
                .done(function(){
                  const data={
                          "roomId" : roomId,
                          "memberNo" : "${sessionScope.loginMember.memberNo}",
                          "memberName" : "${sessionScope.loginMember.memberName}",
                          "message" : "일정이 변경되었습니다.",
                          "messageType" : 3
                        };
                        
                        let jsonData = JSON.stringify(data);
                        webSocket.send(jsonData);
                })
                .fail(function (request, status, error) {
                      alert("에러 발생" + error);
                });
            })
          }else{
            alert("방장만 일정을 삭제할수있습니다.")
          }
          },
          // 조회해온 일정이 data로 넘어옴
          events : data
      });
      calendar.render();
    };


    // 카운트다운
   
    
    var startTime = new Date("${requestScope.p.projectStart}").getTime();
    var endTime = new Date("${requestScope.p.projectEnd}").getTime();
    var countdownEl = document.getElementById('countdown');
    
   

    function countDown(){ 
        
        var currentDate = new Date().getTime();
        if(startTime >= currentDate){
          var timeDiff = (startTime - currentDate) / 1000;
          var days = Math.floor(timeDiff / (24 * 60 * 60));
          countdownEl.innerHTML = days+"일 후에 프로젝트가 시작됩니다!"
        }else{
          var timeDiff = (endTime - startTime) / 1000;
          var days = Math.floor(timeDiff / (24 * 60 * 60));
          countdownEl.innerHTML =  "D - "+days;
          
     
          if (timeDiff < 0) {
              clearInterval(countdownInterval);
              countdownEl.innerHTML = "Expired";
          }

        }
      }

    var countdownInterval = setInterval( countDown(), 1000000); 
     
    // 시작버튼 클릭
    $("#start_button").click(function(){
      if(${sessionScope.loginMember.memberNo} == ${requestScope.p.projectOwner}){

        if(${requestScope.p.projectReady} == 0){
          if(confirm("현재 팀원들로 프로젝트를 시작하시겠습니까?")){
            console.log(memberList);
            $.ajax({
              url:"startProject.rec",
              type:"get",
              data:{
                memberList : JSON.stringify(memberList)
              },
              success : function(result){
                console.log("성공");
              }
            })
          }
        }else{
          $("#start_button").text("프로젝트가 진행 중입니다.");
          $("#start_button").css("background-color","lightgray");
        }
      }else{
        alert("방장만 시작할 수 있습니다.")
      }
    });

    // 추방하기
    
    $(document).on("click","#exile",function(e){
      let memberNo = $(this).next("#chatMemberNo").text();
        updateMemberList();
        const data={
                "roomId" : roomId,
                "memberNo" : memberNo,
                "memberName" : "",
                "message" : "EXILE-CHAT",
                "messageType" : 5
              };
              
              let jsonData = JSON.stringify(data);
              webSocket.send(jsonData);
  
    });
    

  </script>
</body>
</html>