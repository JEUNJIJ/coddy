<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${ ib.iboardTitle }</title>
<style>
    
  .comment {
    margin-bottom: 20px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
  }

  .comment .author {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .comment .author-info {
    display: flex;
    align-items: center;
  }

  .comment .author img {
    width: 30px; /* 이미지 크기 조절 */
    height: 30px;
    border-radius: 50%; /* 이미지를 동그랗게 만들기 위한 속성 */
    margin-right: 10px;
  }

  .comment_child_tool { display: flex; margin-left: 20%; }
  .comment_child { width: 90%; }
  .comment_child_icon { width: 10%; }

  .imgprofile {
    width :100px;
    height : 100px;
  }

  .comment .author span {
    font-weight: bold;
    color: #333;
  }

  .comment .actions {
    display: flex;
  }

  .comment .actions a {
    margin-left: 10px;
  }

  .comment .content {
    margin-top: 5px;
    color: #555;
  }

  .comment .timestamp {
    font-size: 12px;
    color: #888;
  }

  .modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    justify-content: center;
    align-items: center;
  }

  .modal-content {
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    max-width: 400px; /* 모달 최대 너비 */
    width: 100%;
    box-sizing: border-box;
  }

  .modal-content2 {
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    max-width: 400px; /* 모달 최대 너비 */
    width: 100%;
    box-sizing: border-box;
  }

  /* 닫기 버튼 스타일 */
  .close-btn {
    cursor: pointer;
      position: absolute;	
    top: 10px;
    right: 10px;
    font-size: 18px;
  }
  
  #delete {
    width : 100%;
    text-align: center
  }
    
	.close-btn2 {
	  cursor: pointer;
	  position: absolute;
	  top: 10px;
	  right: 10px;
	  font-size: 24px; /* 조금 더 큰 크기로 변경 */
	  color: #333; /* 닫기 버튼 색상 변경 */
	}

  .close-btn3 {
	  cursor: pointer;
	  position: absolute;
	  top: 10px;
	  right: 10px;
	  font-size: 24px; /* 조금 더 큰 크기로 변경 */
	  color: #333; /* 닫기 버튼 색상 변경 */
	}

  #reply {
    width : 100%;
    text-align: center
  }
	
	/* 모달 스타일 */
	.modal {
	  display: none; /* 초기에는 화면에 표시하지 않음 */
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100%;
	  background: rgba(0, 0, 0, 0.5); /* 반투명한 배경 */
	}
	
	.modal-content1 {
	  background-color: #fff;
	  padding: 20px;
	  border-radius: 10px; /* 둥근 테두리로 변경 */
	  max-width: 400px;
	  width: 100%;
	  margin: 10% auto; /* 화면 중앙에 표시 */
	  box-sizing: border-box;
	  position: relative; /* 상대 위치 설정 */
	}
	
	textarea {
	  width: 100%;
	  height: 100px; /* 조절 가능한 높이 */
	  margin-bottom: 10px;
	  resize: none; /* 크기 조절 비활성화 */
	}
	
	/* 확인 버튼 스타일 */
	.btn-danger {
	  background-color: #d9534f;
	  color: #fff;
	  border: none;
	  padding: 10px 20px;
	  border-radius: 5px;
	  cursor: pointer;
	}

	/* 프로젝트 사진 스크롤 */
  .photo-scroll {
    margin-top: 80px;
    overflow-x: scroll;
    white-space: nowrap;
  }

  .photo-scroll-image {
    width: 300px;
    height: 200px;
    border-radius: 10px;
    margin: 0 12px;
    border: 1px solid lightgray;
  }

  /* 포지션 현황 */
  .position_status td{
      text-align: left;
  }
  .position_status{
      margin-left: 30px;
      margin-top: 30px;
  }

  .position_button {
    font-family: monospace;
    background-color: #f3f7fe;
    color: #3b82f6;
    border: none;
    border-radius: 8px;
    width: 80px;
    height: 32px;
    transition: .3s;
  }
  
  .position_button:hover {
    background-color: #3b82f6;
    box-shadow: 0 0 0 5px #3b83f65f;
    color: #fff;
  }

	.tag_card {
    width: 80%;
    height: 250px;
    margin: 30px;
    background: #EEF5FF;
    padding: 10px;
    display: flex;
    flex-wrap: wrap;
    color: #5271FF;
    border-radius: 15px;
    box-shadow: -20px 20px 0px -5px #5271FF;
  }
  .card__tags {
    overflow: auto;
    height: 80%;
  }
  .title {
    font-weight: 900;
    font-size: 1.7em;
  }

  .tag__name {
    display: inline-block;
    color: #fff;
    font-size: 1.1em;
    background-color: #5271FF;
    padding: 6px 23px 9px;
    border-radius: 70em;
    margin: 8px 6px 8px 0;
    margin-left: 0px;
    position: relative;
    text-transform: lowercase;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
  }

  .tag__name::before,
  .tag__name::after {
    content: "";
    display: inline-block;
    position: absolute;
    top: 40%;
    width: 7px;
    height: 7px;
    border-radius: 50%;
    background: #fff;
  }

  .tag__name::before {
    left: 7px;
  }

  .tag__name::after {
    right: 7px;
  }

  .tag__name:hover {
    transform: scale(1.1);
    background-color: #51572c;
  }

  .btn-container {
    display: flex;
    align-items: center;
    justify-content: flex-end;
  }
  .btn-container .btn {
    margin-right: 5px;
  }
    
    /* 멤버 프로필 */
  .content_5{
    margin-top: 80px;
	}

	.swiper{
    width: 100%;
  }
	.swiper-wrapper{
	  float: left;
	}
	
	.imgprofile {
    width :100px;
    height : 100px;
  }

  /* 멤버 프로필 */
  .content_5{
    margin-top: 80px;
	}

	.swiper{
    width: 100%;
  }
	.swiper-wrapper{
	  float: left;
	}
</style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>게시글 상세보기</h2>
            <br><br><br>

            <table id="contentArea" align="center" class="table" style="width:100%; margin:5px;">
                <tr>
                    <th>제목 : ${ib.iboardTitle}</th>
                    <th>조회수 : ${ib.iboardViews}</th>
                </tr>
                <tr>
                    <th>작성자 : ${ib.iboardWriter}</th>
                     <th>좋아요 :  ${requestScope.like}</th>
                </tr>
                <tr>
                    <th>작성일 : ${ib.iboardInsert}</th>
                     <td></td>
                </tr>
                <tr>
                	<th style="height:150px;">내용 :
	                    	${ib.iboardContent}
	                    </th>
                    <td colspan="4">
	                    
                    </td>
                </tr>
                <tr>
                	
                </tr>
                
            </table>

				<br><br><br>
				<h1>프로젝트 : ${p.projectName} </h1>

				<br><br>
      			<h4>프로젝트 기간 : ${p.projectStart} ~ ${p.projectEnd}</h4><hr>
      			<h4>위치 : ${r.recruitmentLocation}</h4><hr>

			  <br><br><br>
            
             <div class="content_right">
            <h2>기술/언어</h2>

            <div class="tag_card">
              <span class="title">All tags</span>
              <div class="card__tags">
                <ul class="tag">
                  <c:forEach var="tag" items="${requestScope.tags}" varStatus="status">
                    <li class="tag__name">${tag.tagsNo}</li>
                  </c:forEach>
                </ul>
              </div>
            </div>
            
      <div clas="content_3">
      	<br><br>
      	<h2>프로젝트 소개 스크린샷</h2>
          <div class="photo-scroll">
              <image class="photo-scroll-image" src="${requestScope.it.getIAttachmentPath()}/${requestScope.it.getIAttachmentChange()}"/>
              
              <c:forEach var="img" items="${requestScope.thumList2}" varStatus="status">
                <image class="photo-scroll-image" src="${img.getIAttachmentPath()}/${img.getIAttachmentChange()}"/>
              </c:forEach>
          </div>
          <br><br>
          <h2>기존 프로젝트 사진</h2>
           <div class="photo-scroll">
              <image class="photo-scroll-image" src="${requestScope.thumOne.getRAttachmentPath()}/${requestScope.thumOne.getRAttachmentChange()}"/>
              
              <c:forEach var="img" items="${requestScope.thumList}" varStatus="status">
                <image class="photo-scroll-image" src="${img.getRAttachmentPath()}/${img.getRAttachmentChange()}"/>
              </c:forEach>
          </div>
          <br>
      </div>
      
      <c:choose>
        <c:when test="${requestScope.p.projectReady ne 2}">
        <div class="content_5">  
          <h2>멤버</h2>
          <hr>
          
         <div class="swiper">
                <div class="swiper-wrapper">
                  <c:forEach var="f" items="${requestScope.fList}" varStatus="Status">
                    <div class="card swiper-slide">
                      <div class="card-border-top">
                      </div>
                      <div class="imgprofile">
                      	<img src='resources/image/profile/<fmt:formatNumber value='${joins[Status.index].memberNo}' pattern='00000000' />.jpg' style="width : 160px; height: 100px;" onerror="this.src='resources/image/company/signup-bg.jpg'">
                      </div>
                      <span style="text-align : center">${f.memberName}</span>
                      <p class="job" style="text-align : center">${f.role}</p>
                      <button onclick='location.href="profile.me?mno=" + ${f.memberNo}'>프로필</button>
                    </div>  
 
                  </c:forEach>    
                </div>
              <div class="swiper-button-prev"></div>
              <div class="swiper-button-next"></div>
            </div>
          </div>
       </c:when>
      </c:choose>
            <script>
            const swiper = new Swiper('.swiper', {
                //기본 셋팅
                //방향 셋팅 vertical 수직, horizontal 수평 설정이 없으면 수평
                direction: 'horizontal',
                //한번에 보여지는 페이지 숫자
                slidesPerView: 7,
                //페이지와 페이지 사이의 간격
                spaceBetween: 10,
                //드레그 기능 true 사용가능 false 사용불가
                debugger: true,
                //마우스 휠기능 true 사용가능 false 사용불가
                mousewheel: true,                
                // 마지막 여백
                slidesOffsetAfter: 120,
                //방향표
                navigation: {
                  //다음페이지 설정
                  nextEl: '.swiper-button-next',
                  //이전페이지 설정
                  prevEl: '.swiper-button-prev',
                },
            });
          </script>
          
      		<br><br><br>
      		<div style="width : 100%; text-align : center;">
            <a class="btn btn-secondary"href="introlist.bo">목록으로</a>
            </div>
            <br>

            <div align="right" class="btn1">
            	<div class="btn-group">
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
	        
					<!-- 
	                <a class="btn btn-primary" onclick="location.href='updateboard.io?projectno=${p.projectNo}&&ino=${ib.iboardNo}'">수정</a>
	            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	            	 -->
	                <form action="deleteForm.ib" method="post">
	                
	                		<input type="hidden" name="ino" value="${ib.iboardNo}">
							<input type="hidden" name="iboardWriter" value="${ib.iboardWriter}">	                	
	                	<button type="submit" class="btn btn-danger">삭제</button>
            		</form>
            	</div>	
            </div>
            <br><br><br><br>

            <!-- 댓글 기능은 나중에 ajax 배우고 나서 구현할 예정! 우선은 화면구현만 해놓음 -->
            <table id="replyArea" class="table" align="center">
                <thead>
                    <tr>
                    	<c:choose>
                    		<c:when test="${ empty sessionScope.loginMember }">
                    			<!-- 로그인 전 : 댓글창 막기 -->
                    			<th colspan="2">
		                            <textarea class="form-control" cols="55" rows="2" style="resize:none; width:95%;" readonly>로그인한 사용자만 이용 가능한 서비스입니다. 로그인 후 이용 바랍니다.</textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn btn-secondary" style="width: 80px;" disabled>등록</button></th>
                    		</c:when>
                    		<c:otherwise>
		                        <th colspan="2">
		                            <textarea class="form-control" id="content" cols="55" rows="2" style="resize:none; width:95%;"></textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button type="button" class="btn btn-secondary" style="width: 80px;"onclick="addreply();">등록</button></th>
                    		</c:otherwise>
                    	</c:choose>
                    </tr>
                    <tr>
                        <td colspan="3">댓글(<span id="rcount">0</span>)</td>
                    </tr>

                </thead>
                <tbody>           
						
                </tbody>
            </table>
        </div>
        <br><br>
  
        
    </div>
    
    <script>
   
    	
		$(function(){
			
			// 댓글리스트 조회용 선언적 함수 호출
			selectReplyList();
			// 댓글 실시간
			// setInterval(selectReplyList, 10000);
			
		});

		// 댓글 작성 요청용 ajax 요청
		function addreply(){
			if($("#content").val().trim().length != 0){
				
				$.ajax({
					url : "iinsert.bo",
					type : "get",
					data : {
						iboardNo : "${ib.iboardNo}",
						memberNo : "${sessionScope.loginMember.memberNo}",
						ireplyContent : $("#content").val()
					},
					success : function(result){
						
						if(result == "success"){
							
							selectReplyList();
							$("#content").val("");
						}
					},
					error : function(){
						console.log("댓글 작성용 ajax 통신 실패");
					}
				});
			} else {
				
				alertify.alert("Alert", "댓글 작성 후 등록을 요청해주세요.", function(){ alertify.success('Ok'); });
			}
		};
		
		// 대댓글 작성 요청용 ajax 요청
/*
		function addreply(){
			if($("#content").val().trim().length != 0){
				
				$.ajax({
					url : "childreninsert.bo",
					type : "get",
					data : {
						iboardNo : "${ib.iboardNo}",
						memberNo : "${sessionScope.loginMember.memberNo}",
						ireplyContent : $("#content").val()
					},
					success : function(result){
						
						if(result == "success"){
							
							selectReplyList();
							$("#content").val("");
						}
					},
					error : function(){
						console.log("댓글 작성용 ajax 통신 실패");
					}
				});
			} else {
				
				alertify.alert("Alert", "댓글 작성 후 등록을 요청해주세요.", function(){ alertify.success('Ok'); });
			}
		};
		*/	
			
		function selectReplyList(){
      // 댓글 조회 요청용 ajax 요청
      $.ajax({
        url : "ilist.bo",
        type : "get",
        data : { ino : "${ ib.iboardNo}"},
        success : function(result){
          let resultStr = "";
          for(let i = 0; i < result.length; i++){
            resultStr += "<div class='comment'>"
                  + "<div class='author'>"
                  + "<div class='author-info'>"
                  + "<img src='resources/image/profile/" + result[i].memberNo + ".jpg' onerror=\"this.src='resources/image/company/signup-bg.jpg'\">"
                  + "<span>" + result[i].memberName + "</span>"
                  + "</div>"
                  + "<div class='actions'>";
            if("${not empty sessionScope.loginMember}") resultStr += "<a href='#' class='edit-link' onclick='openModal3(" + result[i].ireplyNo + ")'>답글달기</a>"
            if("${sessionScope.loginMember.memberNo}" ==  parseInt(result[i].memberNo)){
              resultStr += "<a href='#' class='edit-link' onclick='openModal2()'>수정하기</a>"
                + "<a href='#' class='delete-link' onclick='openModal()'>삭제하기</a>"
                + "<input type='hidden' value='" + result[i].ireplyNo + "'>"
                
            } 		
                  
            resultStr += "</div>"
                  + "</div>"
                  + "<div class='content'>" + result[i].ireplyContent + "</div>"
                  + "<div class='timestamp'>" + result[i].ireplyInsert + "</div>"
                  + "</div>"
            if(selectReplyListChild(result[i].ireplyNo) !== "") { resultStr += selectReplyListChild(result[i].ireplyNo); }
          }
          
          $("#replyArea>tbody").html(resultStr);
          $("#rcount").text(result.length);
        },
        error : function(){
          console.log("댓글리스트 조회용 ajax 통신 실패!");
        }
      });
		}

    function selectReplyListChild(rno) {
      let resultStr = "";
      $.ajax({
        url : "selectReplyListChild.bo",
        type : "get",
        async: false, 
        data : { ireplyNo : rno, iboardNo : "${ ib.iboardNo}"},
        success : function(result){
          for(let i = 0; i < result.length; i++){
            resultStr += "<div class='comment_child_tool'><div class='comment_child_icon'><i class='fa fa-sort-down' style='width=100%;'></i></div>"
                  + "<div class='comment comment_child'>"
                  + "<div class='author'>"
                  + "<div class='author-info'>"
                  + "<img src='resources/image/profile/" + result[i].memberNo + ".jpg' onerror=\"this.src='resources/image/company/signup-bg.jpg'\">"
                  + "<span>" + result[i].memberName + "</span>"
                  + "</div>"
                  + "<div class='actions'>";
            if("${sessionScope.loginMember.memberNo}" ==  parseInt(result[i].memberNo)){
              resultStr += "<a href='#' class='edit-link' onclick='openModal2()'>수정하기</a>"
                + "<a href='#' class='delete-link' onclick='openModal()'>삭제하기</a>"
                + "<input type='hidden' value='" + result[i].ireplyNo + "'>"
                
            } 		
                  
            resultStr += "</div>"
                  + "</div>"
                  + "<div class='content'>" + result[i].ireplyContent + "</div>"
                  + "<div class='timestamp'>" + result[i].ireplyInsert + "</div>"
                  + "</div></div>"
          }
        },
        error : function(){
          console.log("댓글리스트 조회용 ajax 통신 실패!");
        }
      });
      return resultStr;
    }
		
		function openModal() {
		  document.getElementById('deleteModal').style.display = 'flex';
		    
		  let target = window.event.target; // 방금 클릭된 삭제하기 a태그
			let ireplyNo = $(target).next().val(); // 댓글번호
			$("#ireplyNo").val(ireplyNo); // 삭제하기 모달창의 input type="hidden" id="ireplyNo" 의 밸류로 넣어버린것  
		}
		
		function closeModal() {
			document.getElementById('deleteModal').style.display = 'none';
		}
		
		function replydelete(){
			$.ajax({
				url : "idelete.bo",
				type : "get",
				data : {ireplyNo:$("#ireplyNo").val()},
				success : function(result){
					alert("댓글이 삭제되었습니다.");
					selectReplyList();
					closeModal();
				},
			 	error : function(error){
			 		console.log("ajax 댓글 삭제 실패");
			 	}
			});
		}
		  
		function openModal2(){
			document.getElementById('updateModal').style.display = 'flex';
			    
      // console.log(window.event.target)
        
      let target = window.event.target; // 방금 클릭된 삭제하기 a태그
  
      let ireplyNo = $(target).siblings("input").val(); // 댓글번호
      
      $("#ireplyNo").val(ireplyNo); // 모달창의 input type="hidden" id="ireplyNo" 의 밸류로 넣어버린것
			
		}

		function closeModal2() {
		  document.getElementById('updateModal').style.display = 'none';
	  }
		
		function updateBtn() {
			$.ajax({
				url : "iupdate.bo",
				type : "get",
				data :  {ireplyNo : $("#ireplyNo").val(),
						ireplyContent : $("#updateContent").val()},
				success : function(result){
          alert("댓글이 수정되었습니다.");
          $("#updateContent").val(result);
          
          var none = document.getElementById('updateModal');
          none.style.display = 'none';
        
          selectReplyList();
				},
				error : function(error){
					alert("댓글 수정 실패");
				}	
			});
		};

    function openModal3(ireplyChild) { document.getElementById('replyModal').style.display = 'flex'; $("#ireplyNo").val(ireplyChild); }
    function closeModal3() { document.getElementById('replyModal').style.display = 'none'; }
    function replyBtn() {
			$.ajax({
				url : "ireply.bo",
				type : "get",
				data : { ireplyParent : $("#ireplyNo").val(), ireplyContent : $("#replyContent").val(), memberNo : "${sessionScope.loginMember.memberNo}", iboardNo : "${ib.iboardNo}" },
				success : function(result){
						var none = document.getElementById('replyModal');
						none.style.display = 'none';

            if(result <= 0) alert("댓글 답변 실패");
						selectReplyList();
				},
				error : function() { alert("댓글 답변 실패"); }	
			});
		};

    </script>    
		  <div id="deleteModal" class="modal">
        <div class="modal-content">
          <span class="close-btn" onclick="closeModal()">&times;</span>
          <p>삭제하시겠습니까?</p>
          <input type="hidden" id="ireplyNo" value="">
          <div id="delete">
            <button class="btn btn-danger" onclick="replydelete()" style=" width : 100px;">확인</button>
          </div>
        </div>
      </div>
		
		<div id="updateModal" class="modal">
		  <div class="modal-content1">
		    <span class="close-btn2" onclick="closeModal2()">&times;</span>
		    <textarea  id="updateContent" style="width : 95%; height : 80%;">${Scope.r.content}</textarea>
		    <input type="hidden" id="ireplyNo" value="">
		    <div id="delete">
		      <button class="btn btn-danger" onclick="updateBtn()" style=" width : 100px;">확인</button>
		    </div>
		  </div>
		</div>

    <div id="replyModal" class="modal">
		  <div class="modal-content2">
		    <span class="close-btn3" onclick="closeModal3()">&times;</span>
		    <textarea  id="replyContent" style="width : 95%; height : 80%;"></textarea>
        <input type="hidden" id="ireplyNo" value="">
		    <div id="reply">
		      <button class="btn btn-info" onclick="replyBtn()" style=" width : 100px;">확인</button>
		    </div>
		  </div>
		</div>
		
    <jsp:include page="../../common/footer.jsp" />
</body>
</html>