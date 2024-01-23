<%@page import="org.springframework.core.io.ClassPathResource"%>
<%@page import="org.springframework.core.io.Resource"%>
<%@page import="com.kh.coddy.common.Keys"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Resource resource = new ClassPathResource("keys/kakaoLogin.json");
	String kakaoLoginKey = Keys.read(resource.getURL().getPath(), "key.kakaoLogin");  

    /* 캐시 이미지 저장하지 않음 */
    response.setHeader("Cache-Control","no-store");  
    response.setHeader("Pragma","no-cache");  
    response.setDateHeader("Expires",0);  
    if (request.getProtocol().equals("HTTP/1.1"))        
        response.setHeader("Cache-Control", "no-cache"); 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <!-- 데이트피커쪽 관련-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- TWAK 키값 -->
    <script src="${ pageContext.request.contextPath }/resources/js/twak.js"></script>
    <!-- icons -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <!-- 구글 폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
    <!-- Tagify -->
    <script src="https://unpkg.com/@yaireo/tagify"></script>
    <!-- Tagify (구버젼 브라우저 지원) -->
    <script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
    <link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
    <!-- 도로명 주소 카카오 api -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!-- prettify.js -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/ink/3.1.10/js/prettify.js"></script>
    <!-- include summernote css/js -->
    <script src="${ pageContext.request.contextPath }/resources/js/summernote/summernote-lite.js"></script>
    <script src="${ pageContext.request.contextPath }/resources/js/summernote/lang/summernote-ko-KR.js"></script>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/summernote/summernote-lite.css">
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
        #header_1_center>ul>li a {text-decoration:none; color:black; font-size:18px; font-weight:900; margin-left: 20px;}
        #header a {text-decoration:none; color:black;}

        /* 세부페이지마다 공통적으로 유지할 style */
        .content {
            width:1200px;
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
            width:200px;
            height:80px;
            float: left;
            position:absolute;
            
            object-fit : cover; 
        }
        
        /* 기업전용 로그인 버튼 공간 스타일링 */
        /* 12.03 기준 예전 로그인 스타일이라 나중에 뺴도됨 */
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
        .loginByCompany .loginByCompany__text { transform: translateX(30px); color: #fff; font-weight: 600; }
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

        /* 로그인 모달 */
        .login-box {
            position: absolute;
            top: 50%;
            left: 0%;
            width: 400px;
            padding: 40px;
            transform: translate(0%, 0%);
            background: rgba(0,0,0,.5);
            box-sizing: border-box;
            box-shadow: 0 15px 25px rgba(0,0,0,.6);
            border-radius: 10px;
        }
        .login-box h2 { margin: 0 0 30px; padding: 0; color: #fff; text-align: center; }
        .login-box .user-box { position: relative; }
        .login-box .user-box input {
            width: 100%;
            padding: 10px 0;
            font-size: 16px;
            color: #fff;
            margin-bottom: 30px;
            border: none;
            border-bottom: 1px solid #fff;
            outline: none;
            background: transparent;
        }
        .login-box .user-box label {
            position: absolute;
            top:0;
            left: 0;
            padding: 10px 0;
            font-size: 16px;
            color: #fff;
            pointer-events: none;
            transition: .5s;
        }
        .login-box .user-box input:focus ~ label,
        .login-box .user-box input:valid ~ label { top: -20px; left: 0; color: #03e9f4; font-size: 12px; }
        .login-box form a {
            position: relative;
            display: inline-block;
            padding: 10px 20px;
            color: #03e9f4;
            font-size: 16px;
            text-decoration: none;
            text-transform: uppercase;
            overflow: hidden;
            transition: .5s;
            margin-top: 40px;
            letter-spacing: 4px;
        }
        .login-box a:hover {
            background: #03e9f4;
            color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 5px #03e9f4,
                        0 0 25px #03e9f4,
                        0 0 50px #03e9f4,
                        0 0 100px #03e9f4;
        }
        .login-box a span { position: absolute; display: block; }
        .login-box a span:nth-child(1) {
            top: 0;
            left: -100%;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, transparent, #03e9f4);
            animation: btn-anim1 1s linear infinite;
        }
        @keyframes btn-anim1 { 0% { left: -100%; } 50%, 100% { left: 100%; } }
        .login-box a span:nth-child(2) {
            top: -100%;
            right: 0;
            width: 2px;
            height: 100%;
            background: linear-gradient(180deg, transparent, #03e9f4);
            animation: btn-anim2 1s linear infinite;
            animation-delay: .25s;
        }
        @keyframes btn-anim2 { 0% { top: -100%; } 50%, 100% { top: 100%; } }
        .login-box a span:nth-child(3) {
            bottom: 0;
            right: -100%;
            width: 100%;
            height: 2px;
            background: linear-gradient(270deg, transparent, #03e9f4);
            animation: btn-anim3 1s linear infinite;
            animation-delay: .5s;
        }
        @keyframes btn-anim3 { 0% { right: -100%; } 50%, 100% { right: 100%; } }
        .login-box a span:nth-child(4) {
            bottom: -100%;
            left: 0;
            width: 2px;
            height: 100%;
            background: linear-gradient(360deg, transparent, #03e9f4);
            animation: btn-anim4 1s linear infinite;
            animation-delay: .75s;
        }
        @keyframes btn-anim4 { 0% { bottom: -100%; } 50%, 100% { bottom: 100%; } }
        .logBody { margin:0; padding:0; font-family: sans-serif; background: linear-gradient(#141e30, #243b55); }
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
                    <li><a href="search.co?cpage=1&search=&sort=title&tag=">코드리뷰</a></li>
                    <li><a href="list.no">공지</a></li>
                    <li><a href="list.fr">자유</a></li>
                    <li><a href="introlist.bo">소개</a></li>
                    <li><a href="listView.hb?cpage=1&search=&sort=new&career=none&education=none&tag=&where=all&viewOn=f">채용공고</a></li>
                </ul>
            </div>
            <div id="header_1_right">
                <c:choose>
                    <c:when test="${empty sessionScope.loginMember}">
                        <c:choose>
                            <c:when test="${empty sessionScope.loginCompany}">
                                <a href="signup.me">회원가입</a>
                                <a id="loginA" data-toggle="modal" data-target="#loginModal">로그인</a> <!-- 모달의 원리 : 이 버튼 클릭시 data-target에 제시되어있는 해당 아이디의 div요소를 띄워줌 -->
                            </c:when>
                            <c:otherwise>
                                <label><b style="color: #5271FF; font-size: 13px;">${sessionScope.loginCompany.companyName}</b> 기업 로그인중</label> &nbsp;&nbsp;
                                <a href="myPage.cp">마이페이지</a>
                                <a href="logout.cp">로그아웃</a>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
               	    <c:otherwise>
                        <label><b style="color: #5271FF; font-size: 16px;">${sessionScope.loginMember.memberName}</b>님 환영합니다</label> &nbsp;&nbsp;
                        <a href="myPage.se">마이페이지</a>
                        <c:choose>
                            <c:when test="${empty sessionScope.isKakao}">
                                <a href="logout.me">로그아웃</a>
                            </c:when>
                            <c:otherwise>
                                <a href="https://kauth.kakao.com/oauth/logout?client_id=<%= kakaoLoginKey %>&logout_redirect_uri=http://127.0.0.1:8082/coddy/kakaoLogout.me">로그아웃</a>
                            </c:otherwise>
                        </c:choose>
                        <br>
                        <c:choose>
	                        <c:when test="${sessionScope.loginMember.memberId eq 'admin'}">
	                        	<a href="adminMain.main">관리 페이지</a>
	                        </c:when>
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
                <!-- 
                <div class="modal-header">
                    <h4 class="modal-title">Login</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form action="login.me" method="post">
                -->
                    <!-- Modal body -->
                <!-- 
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
                -->
                    <!-- Modal footer -->
                <!-- 
                    <div class="modal-footer">
                        <div align="center" style="margin:auto;">                          
                            <a href="https://kauth.kakao.com/oauth/authorize?client_id=<%= kakaoLoginKey %>&redirect_uri=http://localhost:8082/coddy/kakaoLogin.me&response_type=code">
                               <img src="resources/image/login/kakao_login.png" style="width: 100%; height: 100%;">
                            </a>
                        </div>
                    </div>
                </form>
                -->
                <div class="logBody">
                    <div class="login-box">
                        <h2>로그인 페이지</h2>
                        <form action="login.me" method="post" id="loginForm">
                            <div class="user-box">
                                <input type="text" id="userId" name="memberId" required>
                                <label for="userId">ID</label>
                            </div>
                            <div class="user-box">
                                <input type="password" id="userPwd" name="memberPwd" required>
                                <label for="userPwd">Password</label>
                            </div>
                            <div align="center">
                                <a href="#" onclick="$('#loginForm').submit();"><span></span><span></span><span></span><span></span>로그인</a>
                                &nbsp;&nbsp;&nbsp;
                                <a href="findIdForm.me"><span></span><span></span><span></span><span></span>계정 찾기</a>
                                <a href="https://kauth.kakao.com/oauth/authorize?client_id=<%= kakaoLoginKey %>&redirect_uri=http://127.0.0.1:8082/coddy/kakaoLogin.me&response_type=code">
                                    <img src="resources/image/login/kakao_login.png" style="width: 100%; height: 100%;">
                                </a>
                                <a href='loginPage.cp'>기업전용 로그인<span></span><span></span><span></span><span></span></a>
                            </div>
                        </form>
                    </div>
                </div>
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