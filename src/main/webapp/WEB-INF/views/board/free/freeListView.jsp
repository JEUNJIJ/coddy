<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 목록보기</title>
<style>
	#fboardList {margin: 0 auto;}

    #pagingArea {width:fit-content; margin:auto;}
    
    #searchForm {
        width:80%;
        margin:auto;
    }
    #searchForm>* {
        float:left;
        margin:5px;
    }
    .select {width:20%;}
    .text {width:53%;}
    .searchBtn {width:20%;}
</style>
</head>
<body>

<jsp:include page="../../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h3 style="color:#5271FF;">자유게시판</h3>
            
           
            <br>
            <br>
            <thead>
            <div class="freeList" align="left">

			<!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
            <c:if test="${ not empty sessionScope.loginMember }"> 
	            <a class="btn" style="float:right; color:white; background:#5271FF; padding:6px;" 
	            							href="enrollForm.fr">
	            	글쓰기
	            </a>
	        </c:if>
			</div>
            <br>
                 
            <table id="fboardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th></th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="f" items="${ requestScope.list }">
	                    <tr>
	                        <td class="fno">${ f.fboardNo }</td>
	                        <td>${ f.fboardTitle }</td>
	                        <td>${ f.fboardWriter }</td>
	                        <td>${ f.fboardViews }</td>
	                        <td>${ f.fboardInsert }</td>
	                    </tr>
	            	</c:forEach>
                </tbody>
            </table>
            
            <br>
            
            <script>
            	$(function() {
            		
            		$("#fboardList>tbody>tr").click(function() {
            			
            			let fno = $(this).children(".fno").text();
            			
            			location.href = "detail.fr?fno=" + fno;
            		});
            	});
            </script>

            <div id="pagingArea">
                <ul class="pagination">
                
                	<c:choose>
                		<c:when test="${ requestScope.pi.currentPage eq 1 }">
	                    	<li class="page-item disabled">
	                    		<a class="page-link" href="#">Previous</a>
	                    	</li>
                    	</c:when>
                    	<c:otherwise>
	                    	<li class="page-item">
	                    		<a class="page-link" href="list.fr?cpage=${ requestScope.pi.currentPage - 1 }">Previous</a>
	                    	</li>
                    	</c:otherwise>
                    </c:choose>
                    
                    <c:forEach var="p" begin="${ requestScope.pi.startPage }" 
                    					 end="${ requestScope.pi.endPage }"
                    					step="1">
                    	<li class="page-item">
                    		<a class="page-link" href="list.fr?cpage=${ p }">${ p }</a>
                    	</li>
                    </c:forEach>
                    
                    <c:choose>
                    	<c:when test="${ requestScope.pi.currentPage eq requestScope.pi.maxPage }">
		                    <li class="page-item disabled">
		                    	<a class="page-link" href="#">Next</a>
		                    </li>
		                </c:when>
		                <c:otherwise>
		                    <li class="page-item">
		                    	<a class="page-link" href="list.fr?cpage=${ requestScope.pi.currentPage + 1 }">Next</a>
		                    </li>
		                </c:otherwise>
                	</c:choose>
                
                </ul>
            </div>

            <br clear="both"><br>


            <br><br>
        </div>
        <br><br>

    </div>

</body>
</html>