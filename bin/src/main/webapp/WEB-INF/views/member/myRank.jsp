<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	.menu {
	  list-style-type: none;
	  margin-right: 10px;
	  margin-left: 0px;
	  padding-left: 0px;
	  width: 15%;
	  height: 100%;
	  overflow: auto;
	}
	
	.menu li a {
	  display: block;
	  color: #000;
	  padding: 8px 16px;
	  text-decoration: none;
	}
	
	.menu li a.active {
	  background-color: #5271FF;
	  color: white;
	}
	
	.menu li a:hover:not(.active) {
	  background-color: #5271FF;
	  color: white;
	}
</style>
</head>
<body>

    <jsp:include page="../common/header.jsp" />
 	<div class="container">
           
            <hr>
            <br>
            <div style="display: flex;">
					
                    <ul class="menu" style="padding-left:0px;">
                    	<br>
                        <li><a href="#">마이페이지</a></li>
                        <hr>
                        <li><a href="#">나의 평가</a></li>
                        <hr>
                        <li><a href="#">참여한 프로젝트</a></li>
                        <li><a href="#">찜한 프로젝트</a></li>
                        <li><a href="#">찜한 채용공고</a></li>
                        <hr>
                        <li><a href="#">작성한 게시글</a></li>
                        <li><a href="#">작성한 댓글</a></li>
                    </ul>

                <div style="height:800px;
                            width:1000px;
                            padding:15px;">
                	<h4><b>김개발</b>님의 점수는 <b>85</b>점 입니다.</h4>
                	<div style="height:600px;
                		 width:900px;
                		 border: 1px solid lightgray;
                		 border-radius: 15px;
                		 margin-top:20px;
                		 padding:15px;">
                	</div>
                </div>
            </div>
     </div>
</body>
</html>