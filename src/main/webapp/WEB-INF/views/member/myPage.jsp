<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My페이지</title>
      <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700,900&display=swap" rel="stylesheet">
    <style>
        .innerOuter {
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }
        
        /* 은지한테 받은 코드 */
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
        
        ul {
            list-style:none;
        }
 
    </style>
</head>
<body>
	<jsp:include page="../common/header.jsp" />	

        <div class="innerOuter">
            <h2>마이페이지</h2>
            <br>
            <hr>
            <br>
            <div style="display: flex;">
					
                <ul class="menu" style="padding-left:0px; width : 230px;">
                    <br>
                    <li><a href="myPage.se">마이페이지</a>
                        <ul style="width : 210px;">
                        	<li><a href="pwdChange.me">- 비밀번호 변경</a></li>
                        	<li><a href="delete.me">- 회원 탈퇴</a></li>
                        </ul>
                    </li>
                   <hr>
		            <li><a href="written.io">참여한 프로젝트</a></li>
		            <li><a href="#">찜한 프로젝트</a></li>
		            <li><a href="likedJob.me">찜한 채용공고</a></li>
		            <hr>
		            <li><a href="written.ro">작성한 게시글</a></li>
		          </ul>
                    
                <form action="update.me" method="post" enctype="multipart/form-data">
                	<input type="hidden" name="memberNo" value="${sessionScope.loginMember.memberNo}">
	                    <div class="form-group" style="display:flex">
	                        <div class="content1" style="width:60%; padding-left : 80px;">
	                       
	                         <br> <br>
	                        
	                                       
	                         <label for="memberId">* ID : </label>
	                         <input type="text" class="form-control" id="memberId" value="${sessionScope.loginMember.memberId}" style="width : 300px;" name="memberId" readonly> <br>
	
	                         <label for="memberEmail"> * Email : </label>
	                         <input type="text" class="form-control" id="memberEmail" value="${sessionScope.loginMember.memberEmail}" style="width : 300px;" name="memberEmail" readonly> <br>
	                        
	                        <label for="memberName">Name : </label>
	                            <input type="text" class="form-control" id="memberName" value="${sessionScope.loginMember.memberName}" name="memberName" style="width : 300px;"> <br>
	                        </div>
	
	                        <div class="content2" style="width:40%; padding-left : 50px;">
	                        
	                        <br><br>
	                            
	                            <label for="memberInfo"> &nbsp; 자기소개 : </label>
	                            <!-- <input type="text" class="form-control" id="memberInfo" value="${sessionScope.loginMember.memberInfo}" name="memberInfo" style="height : 280px;"> -->
	                            <textarea name="memberInfo" id="memberInfo" style="width : 300px; height : 250px; resize:none;">${sessionScope.loginMember.memberInfo}</textarea><br>
	                        </div>
	                     
	                    </div> 
	                    <br><br><br><br>	
	                    <div class="btns" align="center" style="padding-right : 100px;">
	                        <button type="submit" id="uploadBtn" class="btn btn-primary">수정하기</button>
	                    </div>
                  
                </form>
            </div>
            <br><br>
        </div>
        
    </div>
    <jsp:include page="../common/footer.jsp"></jsp:include>
    
</body>
</html>