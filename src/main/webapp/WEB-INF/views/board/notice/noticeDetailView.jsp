<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<title>Insert title here</title>
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

            <a class="btn btn-secondary" style="float:right;" href="list.no">목록으로</a>
            <br><br>

            <table id="contentArea" align="center" class="table" style="color:#5271FF;">

                <tr>
                    <th>제목 ${ requestScope.n.nboardTitle }</th>
                </tr>
                <tr>
                    <th>작성자 ADMIN </th>
                    <th>조회수 ${ requestScope.n.nboardViews }</th>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                    	<c:choose>
                    		<c:when test="${ empty requestScope.n.nboardOrigin }">
                    			첨부파일이 없습니다.
                    		</c:when>
                    		<c:otherwise>
                        		<a href="${ requestScope.n.nboardChange }" 
                        		   download="${ requestScope.n.nboardOrigin }">
                        			${ requestScope.n.nboardOrigin }
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
	                    	${ requestScope.n.nboardContent }
	                    </p>
                    </td>
                </tr>
            </table>
            <br>

            <div align="center">
                <!-- 수정하기, 삭제하기 버튼은 이 글이 본인이 작성한 글일 경우에만 보여져야 함 -->
					<c:if test="${not empty sessionScope.loginMember}">
    				 <c:if test="${sessionScope.loginMember.memberId eq 'admin'}">
		                <!-- 관리자 역할을 가진 사용자에게만 글 작성 권한 부여 -->

		                <button class="btn btn-danger" onclick="postFormSubmit(2);">삭제하기</button>
		             </c:if>

	                <form id="postForm" action="update.no" method="post">
	                	<input type="hidden" name="nno" 
	                				value="${ requestScope.n.nboardNo }">
	                	<input type="hidden" name="filePath" 
	                				value="${ requestScope.n.nboardChange }">			
	                </form>
	                
	                </c:if>

					<script>				    
					    function postFormSubmit(num) {
        					if(num == 1) { 
	                			
	                			$("#postForm").attr("action", "updateForm.no").submit();
	                			
	                		} else {
	                			
	                			$("#postForm").attr("action", "delete.no").submit();
	                			
	                		}
					    }

        			</script>
  
            </div>
            <br><br>

			<br><br>

			<jsp:include page="../../common/footer.jsp" />
    
</body>
</html>