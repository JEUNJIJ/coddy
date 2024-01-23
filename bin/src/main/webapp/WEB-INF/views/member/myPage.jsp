<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>

        .innerOuter {
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }
        
        // 은지한테 받은 코드
        	.menu {
	  list-style-type: none;
	  margin-right: 10px;
	  margin-left: 0px;
	  left-padding: 0px;
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

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>마이페이지</h2>
            <br>

   <hr>
            <br>
            <div style="display: flex;">
					
                    <ul class="menu" style="padding-left:0px;">
                    	<br>
                        <li><a href="myPage.me">마이페이지</a>
                        <ul style="width : 210px;">
                        	<li><a href="pwdChange.me">- 비밀번호 변경</a></li>
                        	<li><a href="delete.me">- 회원 탈퇴</a></li>
                        </ul></li>
                        <hr>
                        <li><a href="#">나의 평가</a></li>
                        <hr>
                        <li><a href="#">참여한 프로젝트</a></li>
                        <li><a href="#">찜한 프로젝트</a></li>
                        <li><a href="#">찜한 채용공고</a></li>
                        <hr>
                        <li><a href="written.me">작성한 게시글</a></li>
                        <li><a href="#">작성한 댓글</a></li>
                    </ul>
                    
                    
                    
                    
            <form action="" method="post"  enctype="multipart/form-data">
                <div class="form-group" style="display:flex">
                	<div class="content1" style="width:60%; padding-left : 60px;">
                	   <img src="https://avatars.githubusercontent.com/u/109032883?v=4" alt="" width="150px"height="150px" id="preview"
                	   > <br> <br>
                    
                    
                     <input type="file" name="" class="btn btn-secondary btn-sm" value="업로드" onchange="" style="width : 230px;">
                     <input type="hidden" name="memberImg" value="">
                     
                     <br><br>
                     
                    					
					<label for="memberId">* ID : </label>
                    <input type="text" class="form-control" id="userId" value="user01" name="" readonly> <br>

					<label for="memberEmail"> * Email : </label>
                    <input type="text" class="form-control" id="email" value="user01@kh.or.kr" name="" readonly> <br>
                    
                    </div>

                    <div class="content2" style="width:40%; padding-left : 50px;">
                    
                    <label for="memberName">Name : </label>
                    <input type="text" class="form-control" id="userName" value="홍길동" name=""> <br>
					
                    <label for="memberInfo"> &nbsp; 자기소개 : </label>
                    <input type="text" class="form-control" id="address" value="" name="" style="height : 280px;"> <br>
                    

                     </div>
                     
                </div> 
                <br><br><br><br>	
                <div class="btns" align="center" style="padding-right : 150px;">
                    <button type="submit" class="btn btn-primary">수정하기</button>
                 
                </div>
            </form>
        </div>
        <br><br>
        </div>
    </div>

	


</body>
</html>