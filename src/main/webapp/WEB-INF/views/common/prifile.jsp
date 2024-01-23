<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
				<!-- 프로필을 클릭 했을 시 보여질 Modal -->
				<div class="profile-widget" id="profilemodal">
				    <h2 class="widget-heading">프로필</h2>
				    <div class="cover-img">        
				        <img src="https://i.namu.wiki/i/w11dbZZeomJI4bD3_KItw3vq7tgglcM1YQA_xHULxMsixPpY1S7KcB8WrEFhJNuSuejiiQkicGKMH12JvpUqBQ.webp" alt="User profile cover photo">
				    </div>
				    <div class="user-details">
				        <div class="user-img">
				            <c:choose>
                        	<c:when test="${sessionScope..memberPhotoExtend eq 'jpg' || sessionScope..memberPhotoExtend eq 'png'}">
                            	<img src="resources/image/profile/<fmt:formatNumber value='${sessionScope..memberNo}' pattern='00000000' />.${sessionScope..memberPhotoExtend}" width="300px"height="300px" id="preview"  alt="User photo">
                         	</c:when>
                         	<c:otherwise>
                         		<img src="https://vlee.kr/wp-content/uploads/2020/03/windows10.jpg" width="300px"height="300px" id="preview"  alt="User photo">
                         	</c:otherwise>
                         </c:choose>
				        </div>
				        <h3>${sessionScope.loginMember.memberName}</h3>
				        <p>자신이 보유하고 있는 기술 태그들 쓰기</p>
				        <div class="followers">
				            <h3>자신의 평점<br><span>546</span></h3>
				            <h3>프로젝트 개수<br><span>3</span></h3>
				        </div>
				        <button class="follow-btn"><a href="#" style="color : white">참여중인 프로젝트</a></button>
				    </div>
				</div>
			</div>
		</div>

</body>
</html>