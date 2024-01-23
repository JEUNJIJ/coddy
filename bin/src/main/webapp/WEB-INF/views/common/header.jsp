<%@page import="org.springframework.core.io.ClassPathResource"%>
<%@page import="org.springframework.core.io.Resource"%>
<%@page import="com.kh.coddy.common.Keys"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Resource resource = new ClassPathResource("keys/kakaoLogin.json");
	String kakaoLoginKey = Keys.read(resource.getURL().getPath(), "key.kakaoLogin"); 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <!-- jQuery 라이브러리 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- 부트스트랩에서 제공하고 있는 스타일 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- 부트스트랩에서 제공하고 있는 스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- swiper.js 라이브러리추가 (cdn) -->
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    <!-- JavaScript(Alertify) -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
	<!-- CSS(Alertify) -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
	<!-- Default theme(Alertify) -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme(Alertify) -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css"/>
    <!-- chat.js -->
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <!-- datepicker range -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <!-- 데이터피커쪽 관련-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- TWAK 키값 -->
    <script src="${ pageContext.request.contextPath }/resources/js/twak.js"></script>
    <style>
        div {box-sizing:border-box;}
        #header {
            width:1200px;
            height:100px;
            padding-top:20px;
            margin:auto;
        }
        #header>div {width:100%; margin-bottom:10px;}
        #header_1 {height:40%;}
        #header_2 {height:60%;}
        #header_1>div{
            height:100%;
            float:left;
        }
        #header_1_left {width:15%; }
        #header_1_center {width:55%;}
        #header_1_right {width:30%;}
        #header_1_right {text-align:center; line-height:35px; font-size:12px; text-indent:35px; text-align: right;}
        #header_1_right>a {margin:5px;}
        #header_1_right>a:hover {cursor:pointer;}
        #header_1_center>ul {width:100%; height:100%; list-style-type:none; margin:auto; padding:0;}
        #header_1_center>ul>li {float:left; width:15%; height:100%; line-height:55px; text-align:center;}
        #header_1_center>ul>li a {text-decoration:none; color:black; font-size:18px; font-weight:900;}
        #header a {text-decoration:none; color:black;}


        /* 세부페이지마다 공통적으로 유지할 style */
        .content {
            width:1200px;
            height: 1800px;
            margin:auto;
        }
        .content_title h2{
            color: #42495B;
            font-size: 1.75rem;
            line-height: 1.5;
            font-weight: 500;	
            margin-bottom: 40px;
            margin-top: 20px;
        }
        
        #header_1_left>img{
            width:150px;
            height:100px;
            float: left;
            position:absolute;
            top: 0px;
        }
        
        /* 기업전용 로그인 버튼 공간 스타일링 */
        .loginByCompany {
            position: relative;
            width: 200px;
            height: 40px;
            cursor: pointer;
            display: flex;
            align-items: center;
            border: 1px solid #34974d;
            background-color: #3aa856;
        }
        .loginByCompany, .loginByCompany__icon, .loginByCompany__text { transition: all 0.3s; }
        .loginByCompany .loginByCompany__text {
            transform: translateX(30px);
            color: #fff;
            font-weight: 600;
        }
        .loginByCompany .loginByCompany__icon {
            position: absolute;
            transform: translateX(159px);
            height: 100%;
            width: 39px;
            background-color: #34974d;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .loginByCompany .loginByCompanySvg { width: 30px; stroke: #fff; }
        .loginByCompany:hover { background: #34974d; }
        .loginByCompany:hover .loginByCompany__text { color: transparent; }
        .loginByCompany:hover .loginByCompany__icon { width: 148px; transform: translateX(0); }
        .loginByCompany:active .loginByCompany__icon { background-color: #2e8644; }
        .loginByCompany:active { border: 1px solid #2e8644; }
    </style>
</head>
<body>
	<c:if test="${ not empty sessionScope.alertMsg }">
		<script>alertify.alert("Alert", "${ sessionScope.alertMsg }", function() { alertify.success("okay"); });</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>
    <div id="header">
        <div id="header_1">
            <div id="header_1_left">
                <img src="resources/image/logo.png" onclick="location.href='/coddy/'">
            </div>
            <div id="header_1_center">
                <ul>
                    <li><a href="list.rec">모집</a></li>
                    <li><a href="">코드리뷰</a></li>
                    <li><a href="">자유</a></li>
                    <li><a href="introlist.bo">소개</a></li>
                    <li><a href="">채용공고</a></li>
                </ul>
            </div>
            <div id="header_1_right">
                <c:choose>
                <c:when test="${empty sessionScope.loginMember and empty sessionScope.nickname}">
                    <a href="signup.me">회원가입</a>
                    <a data-toggle="modal" data-target="#loginModal">로그인</a> <!-- 모달의 원리 : 이 버튼 클릭시 data-target에 제시되어있는 해당 아이디의 div요소를 띄워줌 -->
                </c:when>
               	<c:otherwise>
                    <c:choose>
                        <c:when test="${not empty sessionScope.loginMember}">
                            <label>${sessionScope.loginMember.memberName}님 환영합니다</label> &nbsp;&nbsp;
                            <a href="myPage.me">마이페이지</a>
                            <a href="logout.me">로그아웃</a>
                        </c:when>
                        <c:otherwise>
                            <label>${sessionScope.nickname}님 환영합니다</label> &nbsp;&nbsp;
                            <a href="">마이페이지</a>
                            <a href="https://kauth.kakao.com/oauth/logout?client_id=<%= kakaoLoginKey %>&logout_redirect_uri=http://localhost:8082/coddy/kakaoLogout.me">로그아웃</a>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
               </c:choose>
            </div>
        </div>       
    </div>
    <!-- 로그인 클릭 시 뜨는 모달 (기존에는 안보이다가 위의 a 클릭 시 보임) -->
    <div class="modal fade" id="loginModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Login</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form action="login.me" method="post">
                    <!-- Modal body -->
                    <div class="modal-body">
                        <label for="userId" class="mr-sm-2">ID : </label>
                        <input type="text" class="form-control mb-2 mr-sm-2" placeholder="Enter ID" id="userId" name="memberId"> <br>
                        <label for="userPwd" class="mr-sm-2">Password : </label>
                        <input type="password" class="form-control mb-2 mr-sm-2" placeholder="Enter Password" id="userPwd" name="memberPwd">
                        <div align="center">
                            <button type="submit" class="btn btn-primary">로그인</button>
                            <button type="button" class="btn btn-danger" onclick=location.href='findIdForm.me'>로그인이 안돼요</button>
                        </div>
                        <br>
                      	<div align="center">
                      		<button type="button" class="loginByCompany" onclick="location.href='loginPage.co'">
								<span class="loginByCompany__text">기업전용 로그인</span>
								<span class="loginByCompany__icon"><svg xmlns="http://www.w3.org/2000/svg" width="24" viewBox="0 0 24 24" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" stroke="currentColor" height="24" fill="none" class="loginByCompanySvg"><line y2="19" y1="5" x2="12" x1="12"></line><line y2="12" y1="12" x2="19" x1="5"></line></svg></span>
							</button>
                      	</div>
                    </div>
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div align="center" style="margin:auto;">                          
                            <a href="https://kauth.kakao.com/oauth/authorize?client_id=<%= kakaoLoginKey %>&redirect_uri=http://localhost:8082/coddy/kakaoLogin.me&response_type=code">
                               <img src="resources/image/login/kakao_login.png" style="width: 100%; height: 100%;">
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <br clear="both">
    <!--Start of Tawk.to Script-->
    <script type="text/javascript">
        /* import { TWAK_KEY } from '${ pageContext.request.contextPath }/resources/js/twak.js'; */
        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
        (function(){
            var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
            s1.async=true;
            s1.src='https://embed.tawk.to/' + TWAK_KEY;
            s1.charset='UTF-8';
            s1.setAttribute('crossorigin','*');
            s0.parentNode.insertBefore(s1,s0);
        })();
    </script>
    <!--End of Tawk.to Script-->
</body>
</html>