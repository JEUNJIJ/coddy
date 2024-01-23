<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코드리뷰</title>
<style>
	#cboardList {margin: 0 auto;}

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
	.tagss { width:80%; margin:auto; }
	.tagss>* { margin:5px; width: 88%; }
    
    .tags {
    	background-color : lightgray;
    	border-radius : 5px;
    	display : inline-block;
    }
</style>
</head>
<body>

<jsp:include page="../../common/header.jsp" />

    <div class="content">
        <div class="innerOuter" style="padding:5% 10%;">
            <h3 style="color:#5271FF;">코드리뷰</h3>
            
            <br>
            <br>
            <thead>
            <div>
			   <!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
            <c:if test="${ not empty sessionScope.loginMember }"> 
	            <a class="btn" style="float:right; color:white; background:#5271FF; padding:6px;" 
	            							href="enrollForm.co">
	            	글쓰기
	            </a>
	        </c:if>
			</div>
            <br>
            <br>
                 
            <table id="cboardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="c" items="${ requestScope.list }">
	                    <tr>
	                        <td class="cno">${ c.cboardNo }</td>
	                        <td>${ c.cboardTitle } &nbsp;&nbsp;&nbsp;&nbsp;
           						<c:forEach var="t" items="${ c.tags }">
           							<span class="tags">&nbsp;#${ t }&nbsp;</span>
           						</c:forEach>
	                        </td>
	                        <td>${ c.cboardWriter }</td>
	                        <td>${ c.cboardViews }</td>
	                        <td>${ c.cboardInsert }</td>
	                        <td>
	                        	<c:if test="${ not empty c.originName }">
	                        		★
	                        	</c:if>
	                        </td>
	                    </tr>
	            	</c:forEach>
                </tbody>
            </table>
            
            <br>
            
            <script>
            	$(function() {
            		
            		$("#cboardList>tbody>tr").click(function() {
            			
            			let cno = $(this).children(".cno").text();
            			
            			location.href = "detail.co?cno=" + cno;
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
	                    		<a class="page-link" onclick="onSearch('${ requestScope.pi.currentPage - 1 }');">Previous</a>
	                    	</li>
                    	</c:otherwise>
                    </c:choose>
                    
                    <c:forEach var="p" begin="${ requestScope.pi.startPage }" 
                    					 end="${ requestScope.pi.endPage }"
                    					step="1">
                    	<li class="page-item">
                    		<a class="page-link" onclick="onSearch('${p}');">${ p }</a>
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
		                    	<a class="page-link" onclick="onSearch('${ requestScope.pi.currentPage + 1 }');">Next</a>
		                    </li>
		                </c:otherwise>
                	</c:choose>
                
                </ul>
            </div>

            <br clear="both"><br>
			<div class="tagss"><jsp:include page="../../common/tagAll.jsp" /></div>
            <form id="searchForm" action="" method="get" align="center">
                <div class="select">
                    <select class="custom-select" name="condition" id="condition">
                    	<option value="title">제목</option>
                        <option value="writer">작성자</option>
                        <option value="content">내용</option>
                    </select>
                </div>
                <div class="text">
                    <input type="search" class="form-control" name="keyword" id="keyword">
                </div>
                <button type="button" class style="color:white; background:#5271FF; padding:6px; width:100px; border-radius:5px; border:none;" onclick="onSearch(1);">검색</button>
            </form>
            <br><br>
        </div>
        <br><br>

    </div>

	<script>
	    $(function(){
	      $(".card").css("display", "inline-block");
	      $(".container").css("width","0%");
	    });
	    
	    $(document).ready(function() {
	        $("#keyword").val(getParameter("search"));
	        $("#condition").val(getParameter("sort"));
	        tagifyAll.addTags(getParameter("tag"));
	    });
	   
	    function onSearch(cp) {
			let cpage = cp;
			let search = $("#keyword").val();
			let sort = $("#condition").val();
			let tag = $("#tagAllName").val();
			tag = replaceAll(replaceAll(replaceAll(replaceAll(replaceAll(replaceAll(tag, "[", ""), "]", ""), "{", ""), "}", ""), "\"value\":", ""), "\"", "");
			location.href='search.co?cpage='+cpage+'&search='+search+'&sort='+sort+'&tag='+tag;
		};
	    
	   /* 
	   function onSearch() {
	        let cpage = 1;
	        let search = $("#cboardSearch").val();
	        let sort = $("#cboardSort").val();
	        let tag = $("#tagAllName").val();
	        tag = replaceAll(replaceAll(replaceAll(replaceAll(replaceAll(replaceAll(tag, "[", ""), "]", ""), "{", ""), "}", ""), "\"value\":", ""), "\"", "");
	        location.href='list.co?cpage='+cpage+'&search='+search+'&sort='+sort+'&tag='+tag;
	   }
	    */
	    function getParameter(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }
	   
	   function replaceAll(str, searchStr, replaceStr) { return str.split(searchStr).join(replaceStr); }
	   
	</script>

	<jsp:include page="../../common/footer.jsp" />

</body>
</html>