<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    table * {margin:5px;}
    table {width:100%;}
</style>
</head>
<body>
        
    <jsp:include page="../../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>게시글 상세보기</h2>
            <br>

            <a class="btn btn-secondary" style="float:right;" href="list.bo">목록으로</a>
            <br><br>

            <table id="contentArea" align="center" class="table">
                <tr>
                    <th>${ requestScope.b.cboardTitle }</th>
                </tr>
                <tr>
                    <th>${ requestScope.c.cboardWriter }</th>
                    <th>${ requestScope.c.cboardDelte }</th>
                    <th>${ requestScope.c.cboardViews }</th>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                    	<c:choose>
                    		<c:when test="${ empty requestScope.c.originName }">
                    			첨부파일이 없습니다.
                    		</c:when>
                    		<c:otherwise>
                        		<a href="${ requestScope.c.changeName }" 
                        		   download="${ requestScope.c.originName }">
                        			${ requestScope.c.originName }
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
	                    	${ requestScope.c.cboardContent }
	                    </p>
                    </td>
                </tr>
            </table>
            <br>

            <div align="center">
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
	            <c:if test="${ not empty sessionScope.loginUser and sessionScope.loginUser.userId eq requestScope.b.cboardWriter }">
	                <a class="btn btn-primary" onclick="postFormSubmit(1);">수정하기</a>
	                <a class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</a>
	                
	                <form id="postForm" action="" method="post">
	                	<input type="hidden" name="bno" 
	                				value="${ requestScope.c.cboardNo }">
	                	<input type="hidden" name="filePath" 
	                				value="${ requestScope.c.changeName }">
	                </form>
	                
	                <script>
	                	function postFormSubmit(num) {
	                		
	                		// num 값에 따라 위의 form 태그에 action 속성을 부여한 후
	                		// submit 시키기
	                		
	                		if(num == 1) { 
	                			// num == 1 일 경우 : 수정하기 버튼을 클릭한 상태
	                			
	                			$("#postForm").attr("action", "updateForm.bo").submit();
	                			
	                		} else {
	                			// num == 2 일 경우 : 삭제하기 버튼을 클릭한 상태
	                			
	                			$("#postForm").attr("action", "delete.bo").submit();
	                			
	                			// jQuery 의 submit() 메소드 : 해당 form 의 submit 버튼을 누르는 효과
	                		}
	                	}
	                </script>
            	</c:if>
            </div>
            <br><br>

            <!-- 댓글 기능은 나중에 ajax 배우고 나서 구현할 예정! 우선은 화면구현만 해놓음 -->
            <table id="replyArea" class="table" align="center">
                <thead>
                    <tr>
                    	<c:choose>
                    		<c:when test="${ empty sessionScope.loginUser }">
                    			<!-- 로그인 전 : 댓글창 막기 -->
                    			<th colspan="2">
		                            <textarea class="form-control" cols="55" rows="2" style="resize:none; width:100%;" readonly>로그인한 사용자만 이용 가능한 서비스입니다. 로그인 후 이용 바랍니다.</textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn btn-secondary" disabled>등록하기</button></th>
                    		</c:when>
                    		<c:otherwise>
		                        <th colspan="2">
		                            <textarea class="form-control" id="content" cols="55" rows="2" style="resize:none; width:100%;"></textarea>
		                        </th>
		                        <th style="vertical-align:middle"><button class="btn btn-secondary" onclick="addReply();">등록하기</button></th>
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
    
    <!--
    <script>
    	$(function() {
    		
    		// 댓글리스트 조회용 선언적 함수 호출
    		selectReplyList();
    		
    		// 만약, 댓글이 실시간으로 달리는걸 보고싶다면?
    		setInterval(selectReplyList, 1000);
    		
    	});
    	
    	function addReply() {
    		
    		// 댓글 작성 요청용 ajax 요청
    		
    		// 댓글내용이 있는지 먼저 검사 후
    		// 댓글 내용 중 공백 제거 후 길이가 0 이 아닌 경우
    		// => textarea 가 form 태그 내부에 있지 않음
    		//    (required 속성으로 필수 입력값임을 나타낼 수 없음)
    		if($("#content").val().trim().length != 0) {
    			
    			$.ajax({
    				url : "rinsert.bo",
    				type : "get",
    				data : { // Ajax 요청 또한 Spring 에서 커맨드 객체 방식 사용 가능
    					refBoardNo : ${ requestScope.c.cboardNo }, 
    					replyWriter : "${ sessionScope.loginUser.userId }", 
    					replyContent : $("#content").val()
    				},
    				success : function(result) { 
    					
    					if(result == "success") {
    						
    						// 댓글 작성 성공 시
    						selectReplyList();
    						$("#content").val("");
    						
    					}
    					
    				},
    				error : function() {
    					console.log("댓글 작성용 ajax 통신 실패!");
    				}
    			});
    			
    		} else {
    			
    			alertify.alert("Alert", "댓글 작성 후 등록을 요청해주세요.", function(){ alertify.success('Ok'); });	
    		}
    	}
    	
    	function selectReplyList() {
    		
    		// 해당 게시글에 딸린 댓글 조회 요청용 ajax 요청
    		$.ajax({
    			url : "rlist.bo",
    			type : "get",
    			data : {bno : ${ requestScope.c.cboardNo }},
    			success : function(result) {
    				
    				// console.log(result);
    				
    				let resultStr = "";
    				
    				for(let i = 0; i < result.length; i++) {
    					
    					resultStr += "<tr>"
    							   + 	"<th>" + result[i].replyWriter + "</th>"
    							   + 	"<td>" + result[i].replyContent + "</td>"
    							   +	"<td>" + result[i].createDate + "</td>"
    							   + "</tr>";
    				}
    				
    				$("#replyArea>tbody").html(resultStr);
    				$("#rcount").text(result.length);
    				
    			},
    			error : function() {
    				console.log("댓글리스트 조회용 ajax 통신 실패!");
    			}
    		});
    	}
    </script>
    -->
    
    
</body>
</html>