<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<title>${ requestScope.f.fboardTitle }</title>
<style>
    table * {margin:5px;}
    table {width:100%;}
    
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
</style>
<script src="https://cdn.jsdelivr.net/npm/alertifyjs/build/alertify.min.js"></script>
</head>
<body>
        
    <jsp:include page="../../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h3 style="color:#5271FF;">상세보기</h3>
            <br>

            <a class="btn btn-secondary" style="float:right;" href="list.fr">목록으로</a>
            <br><br>

            <table id="contentArea" align="center" class="table" style="color:#5271FF;">

                <tr>
                    <th>제목 ${ requestScope.f.fboardTitle }</th>
                </tr>
                <tr>
                    <th>작성자 ${ requestScope.f.fboardWriter }</th>
                    <th>조회수 ${ requestScope.f.fboardViews }</th>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                    	<c:choose>
                    		<c:when test="${ empty requestScope.f.fboardOrigin }">
                    			첨부파일이 없습니다.
                    		</c:when>
                    		<c:otherwise>
                        		<a href="/coddy/${ requestScope.f.fboardChange }" 
                        		   download="${ requestScope.f.fboardOrigin }">
                        			${ requestScope.f.fboardOrigin }
                        		</a>
                        	</c:otherwise>
                    	</c:choose>
                    </td>
                </tr>                

                <tr>
                    <th>내용</th>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="4">
	                    <p style="height:150px;">
	                    	${ requestScope.f.fboardContent }
	                    </p>
                    </td>
                </tr>
            </table>
            <br>

            <div align="center">
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
					<c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberName eq requestScope.f.fboardWriter}">
    				<!-- 현재 로그인한 사용자와 게시글 작성자가 동일한 경우에만 수정 버튼 표시 -->
	                <button class="btn btn-primary" onclick="postFormSubmit(1);">수정하기</button>
	                <button class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</button>

	                <form id="postForm" action="update.fr" method="post">
	                	<input type="hidden" name="fno" 
	                				value="${ requestScope.f.fboardNo }">
	                	<input type="hidden" name="filePath" 
	                				value="${ requestScope.f.fboardChange }">			
	                </form>
	                
	                </c:if>

					<script>				    
					    function postFormSubmit(num) {
        					if(num == 1) { 
	                			
	                			$("#postForm").attr("action", "updateForm.fr").submit();
	                			
	                		} else {
	                			
	                			$("#postForm").attr("action", "delete.fr").submit();
	                			
	                		}
					    }

        			</script>
  
            </div>
            <br><br>

            <table id="replyArea" class="table" align="center">
                <thead>
                    <tr>
                    	<c:choose>
                    		<c:when test="${ empty sessionScope.loginMember }">
                    			<!-- 로그인 전 : 댓글창 막기 -->
                    			<th colspan="2">
		                            <textarea class="form-control" cols="55" rows="2" style="resize:none; width:100%;" readonly>로그인한 사용자만 이용 가능한 서비스입니다. 로그인 후 이용 바랍니다.</textarea>
		                        </th>
		                        <th style="vertical-align:middle" ><button class="btn" style="color:white; background:#5271FF; padding:6px;" disabled>등록하기</button></th>
                    		</c:when>
                    		<c:otherwise>
		                        <th colspan="2">
		                            <textarea class="form-control" id="content" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn" style="color:white; background:#5271FF; padding:6px;" onclick="addReply();">등록하기</button></th>
		                        
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
            
			<br><br>
			
		    <script>
		    $(function(){
				
				// 댓글리스트 조회용 선언적 함수 호출
				selectReplyList();
				// 댓글 실시간
				// setInterval(selectReplyList, 10000);
				
			});
		
			// 댓글 작성 요청용 ajax 요청
			function addReply(){
				if($("#content").val().trim().length != 0){
					
					$.ajax({
						url : "rinsert.fr",
						type : "get",
						data : {
							fboardNo : "${f.fboardNo}",
							memberNo : "${sessionScope.loginMember.memberNo}",
							freplyContent : $("#content").val()
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
				
			function selectReplyList(){
			// 댓글 조회 요청용 ajax 요청
			$.ajax({
				url : "rlist.fr",
				type : "get",
				data : { fno : "${f.fboardNo}"},
				success : function(result){
					
					let resultStr = "";
					
					for(let i = 0; i < result.length; i++){
						resultStr += "<div class='comment'>"
									+ "<div class='author'>"
									+ "<div class='author-info'>"
									+ "<img src='resources/image/profile/" + result[i].memberNo + ".jpg' onerror=\"this.src='resources/image/company/signup-bg.jpg'\">"
									+ "<span>" + result[i].memberNo + "</span>"
									+ "</div>"
									+ "<div class='actions'>";
						if("${sessionScope.loginMember.memberName}" ==  result[i].memberNo){
						resultStr += "<a href='#' class='edit-link' onclick='openModal2()'>수정하기</a>"
							+ "<a href='#' class='delete-link' onclick='openModal(" + result[i].freplyNo + ")'>삭제하기</a>"
							+ "<input type='hidden' value='" + result[i].freplyNo + "'>"
							
						} 		
									
						resultStr += "</div>"
									+ "</div>"
									+ "<div class='content'>" + result[i].freplyContent + "</div>"
									+ "</div>"
		
						}
					
					$("#replyArea>tbody").html(resultStr);
					$("#rcount").text(result.length);
					},
					error : function(){
						console.log("댓글리스트 조회용 ajax 통신 실패!");
					}
				});
			}
			
			function openModal() {
			    document.getElementById('deleteModal').style.display = 'flex';
			    
			    // console.log(window.event.target)
			    
			    let target = window.event.target; // 방금 클릭된 삭제하기 a태그
				let freplyNo = $(target).next().val(); // 댓글번호
	
				
				$("#freplyNo").val(freplyNo); 
			    
			}
			
			function closeModal() {
				    document.getElementById('deleteModal').style.display = 'none';
			}

			function replyDelete(){
				
				$.ajax({
					url : "rdelete.fr",
					type : "get",
					data : {freplyNo:$("#freplyNo").val()},
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
			
					let freplyNo = $(target).siblings("input").val(); // 댓글번호
					
					
					$("#freplyNo").val(freplyNo); 
				
			}
		
		
			function closeModal2() {
			    document.getElementById('updateModal').style.display = 'none';
		}
		
			
			function updateBtn() {
				console.log( $("#updateContent").val());
				$.ajax({
					url : "rupdate.fr",
					type : "get",
					data :  {freplyNo : $("#freplyNo").val(),
							freplyContent : $("#updateContent").val()},
					success : function(result){
							
							console.log(result);
							
							alert("댓글이 수정되었습니다.");
							$("#updateContent").val(result);
							
							  var none = document.getElementById('updateModal');
							  none.style.display = 'none';
						
							 selectReplyList();
		
					},
					error : function(error){
						console.log("ajax 수정 실패");
						alert("댓글 수정 실패");
					}	
					
				});
			};		
			
		</script>

			 <div id="deleteModal" class="modal">
			  <div class="modal-content">
			    <span class="close-btn" onclick="closeModal()">&times;</span>
			    <p>삭제하시겠습니까?</p>
			    <input type="hidden" id="freplyNo" value="">
			    <div id="delete">
			    <button class="btn" onclick="replyDelete()" style="color:white; background:#5271FF; padding:6px; width : 100px;">확인</button>
			    </div>
			  </div>
			</div>
			
			<div id="updateModal" class="modal">
			  <div class="modal-content1">
			    <span class="close-btn2" onclick="closeModal2()">&times;</span>
			    <textarea  id="updateContent" style="width : 95%; height : 80%;">${Scope.fr.content}</textarea>
			    <input type="hidden" id="freplyNo" value="">
			    <div id="delete">
		
			    <button class="btn" onclick="updateBtn()" style="color:white; background:#5271FF; padding:6px; width : 100px;">확인</button>
			    </div>
			  </div>
			</div>
			
			<jsp:include page="../../common/footer.jsp" />
    
</body>
</html>