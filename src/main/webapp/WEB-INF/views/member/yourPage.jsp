<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700,900&display=swap" rel="stylesheet">
<title>상대방 페이지</title>
<style>

  .innerOuter {
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }
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
        
body {
    font-family: 'Roboto', sans-serif;
    background: #fbfbfb;
}
.profile-widget {
    width: 400px;
    margin: 0 auto;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-align: center;
    color: #848484;
}
.cover-img {
    max-height: 200px;
    overflow: hidden;
    width: 100%;
}
.user-details{
    padding: 0px 20px 30px;
}
.profile-widget h3 {
    color: #6E9DDC;
    margin: 20px 0px 10px;
}
.profile-widget img {
    width: 100%;
    max-width: 100%;
    height: auto;
    display: block;
}
.user-img {
    width: 100px;
    height: 100px;
    border-radius: 100%;
    overflow: hidden;
    box-shadow: 0px 0px 4px 0px #6E9DDC;
    border: 4px solid #fff;
    margin: 0 auto;
    margin-top: -60px;
    position: relative;
    z-index: 999;
}
.followers h3 {
    width: 49%;
    float: left;
    padding: 6px 0px;
    border: 1px dashed #838383;
    border-radius: 144px;
    font-size: 18px;
}
.followers h3:last-child{
    float: right;
}
.followers h3 span {
    font-weight: normal;
    font-size: 16px;
}
button.follow-btn {
    font-size: 19px;
    background: #6E9DDC;
    border: none;
    color: #fff;
    padding: 10px 15px;
    margin: 20px 0px 0px;
    width: 100%;
    cursor: pointer;
}
button.follow-btn:hover{
    opacity: 0.8;
}
h2.widget-heading {
    font-size: 25px;
    font-weight: normal;
    margin: 20px 0px 10px;
    padding: 0px 0px 10px;
}
@media (max-width: 767px){
.profile-widget {
    width: 90%;
}
</style>
</head>
<body>

<jsp:include page="../common/header.jsp" />	

        <div class="innerOuter">
                   
				<div class="profile-widget">
				    <h2 class="widget-heading">프로필</h2>
				    <div class="cover-img">				  
				       <label for="chooseFileBg"><img src="resources/image/background/<fmt:formatNumber value='${list[0].memberNo}' pattern='00000000' />.jpg" onerror="this.src='resources/image/company/signup-bg.jpg'">
				       </label>
				    </div>     
				    <div class="user-details">
				        <div class="user-img">
				        	<form method="post" enctype="multipart/form-data">
		                        <label for="chooseFile">
		                            <div id="canvas">
		                                <c:choose>
		                                    <c:when test="${list[0].memberPhotoExtend eq jpg}">
		                                        <img src="resources/image/company/signup-bg.jpg" id="uploadFiles">
		                                    </c:when>
		                                    <c:otherwise>
		                                        <img src="resources/image/profile/<fmt:formatNumber value='${list[0].memberNo}' pattern ='00000000' />.${list[0].memberPhotoExtend}" alt="User photo2" id="uploadFiles">
		                                    </c:otherwise>
		                                </c:choose>
		                            </div>
		                        </label>
                    		</form>
				        </div>
				         <div id="fileName"></div>
				        <h3>${list[0].memberName}</h3>
				        <p>자신이 보유하고 있는 기술 태그들 쓰기</p>
				        <div class="followers">
				            <h3>아이디<br><span>${list[0].memberId}</span></h3>
				            <h3>프로젝트 개수<br><span>${requestScope.countSum}</span></h3>
				        </div>
				        <button class="follow-btn" onclick="location.href='yourProjectIng.bo?mno=${list[0].memberNo}'">참여중인 프로젝트</button>
				    </div>
						Image by <a href="https://www.freepik.com/free-photo/empty-room-with-chairs-desks_15501155.htm#query=office&position=4&from_view=search&track=sph&uuid=bc5b64e6-870d-4c59-a1d8-d8ba1d700a20">Freepik</a>
		            <c:choose>
		                <c:when test="${list[0].memberPhotoExtend}">
		                    <a href="https://www.freepik.com/free-vector/illustration-uploading-icon_2609994.htm#page=3&query=upload%20file&position=34&from_view=search&track=ais&uuid=9266a4ed-f875-4e8e-a066-016287752433">Image by rawpixel.com</a> on Freepik
		                </c:when>	
		            </c:choose>
		        </div>
			</div>
		</div>
	
	<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>