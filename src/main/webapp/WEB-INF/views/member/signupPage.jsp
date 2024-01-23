<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<!-- 구글 recaptcha2 -->
    <script src='https://www.google.com/recaptcha/api.js'></script>
	<style>
		@import url(https://fonts.googleapis.com/css?family=Raleway:200,300,400,500,600);
		@font-face {
			font-weight: normal;
			font-style: normal;
			font-family: 'codropsicons';
			src: url("../fonts/codropsicons/codropsicons.eot");
			src: url("../fonts/codropsicons/codropsicons.eot?#iefix") format("embedded-opentype"), url("../fonts/codropsicons/codropsicons.woff") format("woff"), url("../fonts/codropsicons/codropsicons.ttf") format("truetype"), url("../fonts/codropsicons/codropsicons.svg#codropsicons") format("svg");
		}
		/* button 스타일 */
		.button {
			float: left;
			min-width: 150px;
			max-width: 250px;
			display: block;
			margin: 1em;
			padding: 1em 2em;
			border: none;
			background: none;
			color: inherit;
			vertical-align: middle;
			position: relative;
			z-index: 1;
			-webkit-backface-visibility: hidden;
			-moz-osx-font-smoothing: grayscale;
		}
		.button:focus { outline: none; }
		.button > span { vertical-align: middle; }
		.button--border-thin { border: 1px solid; }
		.button--border-medium { border: 2px solid; }
		.button--border-thick { border: 3px solid; }
		.button--round-s { border-radius: 5px; }

		/* nina 스타일 */
		.button--nina {
			padding: 0 2em;
			background: #5271FF;
			color: #fff;
			overflow: hidden;
			-webkit-transition: background-color 0.3s;
			transition: background-color 0.3s;
		}
		.button--nina.button--inverted { background: #fff; color: #5271FF; }
		.button--nina > span {
			display: inline-block;
			padding: 1em 0;
			opacity: 0;
			color: #fff;
			-webkit-transform: translate3d(0, -10px, 0);
			transform: translate3d(0, -10px, 0);
			-webkit-transition: -webkit-transform 0.3s, opacity 0.3s;
			transition: transform 0.3s, opacity 0.3s;
			-webkit-transition-timing-function: cubic-bezier(0.75, 0, 0.125, 1);
			transition-timing-function: cubic-bezier(0.75, 0, 0.125, 1);
		}
		.button--nina::before {
			content: attr(data-text);
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			padding: 1em 0;
			-webkit-transition: -webkit-transform 0.3s, opacity 0.3s;
			transition: transform 0.3s, opacity 0.3s;
			-webkit-transition-timing-function: cubic-bezier(0.75, 0, 0.125, 1);
			transition-timing-function: cubic-bezier(0.75, 0, 0.125, 1);
		}
		.button--nina:hover { background-color: #3f51b5; }
		.button--nina:hover::before {
			opacity: 0;
			-webkit-transform: translate3d(0, 100%, 0);
			transform: translate3d(0, 100%, 0);
		}
		.button--nina:hover > span {
			opacity: 1;
			-webkit-transform: translate3d(0, 0, 0);
			transform: translate3d(0, 0, 0);
		}
		.button--nina:hover > span:nth-child(1) { -webkit-transition-delay: 0.045s; transition-delay: 0.045s; }
		.button--nina:hover > span:nth-child(2) { -webkit-transition-delay: 0.09s; transition-delay: 0.09s; }
		.button--nina:hover > span:nth-child(3) { -webkit-transition-delay: 0.135s; transition-delay: 0.135s; }
		.button--nina:hover > span:nth-child(4) { -webkit-transition-delay: 0.18s; transition-delay: 0.18s; }
		.button--nina:hover > span:nth-child(5) { -webkit-transition-delay: 0.225s; transition-delay: 0.225s; }
		.button--nina:hover > span:nth-child(6) { -webkit-transition-delay: 0.27s; transition-delay: 0.27s; }
		.button--nina:hover > span:nth-child(7) { -webkit-transition-delay: 0.315s; transition-delay: 0.315s; }
		.button--nina:hover > span:nth-child(8) { -webkit-transition-delay: 0.36s; transition-delay: 0.36s; }
		.button--nina:hover > span:nth-child(9) { -webkit-transition-delay: 0.405s; transition-delay: 0.405s; }
		.button--nina:hover > span:nth-child(10) { -webkit-transition-delay: 0.45s; transition-delay: 0.45s; }

		/* 회원가입 스타일 */
		.innerOuter { border-radius: 30px; border: 1px solid #e5ddff; padding: 3%; }
	</style>
	</head>
	<body>
		<jsp:include page="../common/header.jsp" />
	    <div class="content"><br><br>
	        <div class="innerOuter" id="innerOuter">
	            <h2>회원가입</h2><br>
	            <form action="insert.me" method="post" id="enrollForm" onsubmit="return onGoogle();">
	                <div class="form-group">
	                    <label for="memberId">* ID : </label>
	                    <input type="text" class="form-control" id="memberId" placeholder="Please Enter ID" name="memberId" required>
	                    <div id="checkResult" style="font-size: 0.8em; display: none;"></div> <br>
	                    <label for="memberPwd">* Password : </label>
	                    <input type="password" class="form-control" id="memberPwd" placeholder="Please Enter Password" name="memberPwd" required> <br>
	                    <label for="checkPwd">* Password Check : </label>
	                    <input type="password" class="form-control" id="checkPwd" placeholder="Please Enter Password" required> <br>
	                    <label for="memberName">* Name : </label>
	                    <input type="text" class="form-control" id="memberName" placeholder="Please Enter Name" name="memberName" required> <br>
						<div style="display:flex;">
							<div style="width:70%;">
								<label for="memberEmail">* Email : </label>
								<div style="display: flex; margin-right:40px;">
									<input type="email" class="form-control" id="memberEmail" placeholder="Please Enter Email" name="memberEmail" required> <br>
									<img src="resources/image/white.jpg" width="5px;" height="38px;">
									<span id="signupEmailAuthSpan" style="display:none"></span>
									<input type="button" value="인증번호 요청" onclick="authMake();" class="btn btn-outline-warning" id="signupEmailAuthButton">
								</div>
							</div>
							<div style="width:30%;">
								<label for="memberAuth">* 인증번호 : </label>
								<div style="display: flex;">
									<input type="number" class="form-control" id="memberAuth" placeholder="인증번호 6자리" name="memberAuth"> <br>
									<img src="resources/image/white.jpg" width="5px;" height="38px;">
									<input type="button" value="인증번호 확인" onclick="authCheck();" class="btn btn-outline-success" id="signupAuthCheckButton" disabled>
								</div>
							</div>
						</div>
						<br>
						<label for="memberName"> &nbsp Infomation : </label>
	                    <textarea class="form-control" id="memberInfo" placeholder="간단 자기소개" name="memberInfo"></textarea> <br>
						<br>
						<div align="center" style="display:flex;">
							<label class="form-check-label"><input type="checkbox" id="check1" class="form-check-input" name="" value="">동의합니다</label>
							<button type="button" class="button button--nina button--border-thin button--round-s" data-text="이용약관" onclick="" style="margin:auto; display:block;"><span>이</span><span>용</span><span>약</span><span>관</span></button>
							<label class="form-check-label"><input type="checkbox" id="check2" class="form-check-input" name="" value="">동의합니다</label>
							<button type="button" class="button button--nina button--border-thin button--round-s" data-text="제3자 정보제공 동의약관" onclick="" style="margin:auto; display:block;"><span>제</span><span>3</span><span>자</span><span> </span><span>정</span><span>보</span><span>제</span><span>공</span><span>약</span><span>관</span></button>
						</div><br>
						<div align="center"><div class="g-recaptcha" data-sitekey="${ sessionScope.googleKey }"></div></div>
	                </div><br>
	                <div align="center" class="btns">
	                    <button type="submit" class="btn btn-primary" disabled>회원가입</button>
	                    <button type="reset" class="btn btn-danger">초기화</button>
	                </div>
	            </form>
	        </div><br><br><hr>
	    </div>
		<jsp:include page="../common/footer.jsp" />
	    <script>
			let checkId = false;
			let checkAuth = false;
			let numberAuth;
			let emailAuth;
	    	$(function() {
				$("html").animate({scrollTop : $(".innerOuter").offset().top}, 800);
	    		let $idInput = $("#enrollForm input[name=memberId]");
	    		$idInput.keyup(function() {
	    			if($(this).val().length >= 5) {
	    				$.ajax({
	    					url: "memberCheck.me",
	    					type: "get",
	    					data: {checkIds: $idInput.val()},
	    					success: function(result) { 
								if(result=="NNNNN") { $("#checkResult").show(); $("#checkResult").css("color", "red").text("사용불가능한 아이디입니다."); checkId = false; } 
								else { $("#checkResult").show(); $("#checkResult").css("color", "green").text("사용가능한 아이디입니다."); checkId = true; } check(); },
	    					error: function() { console.log("아이디 중복 체크 실패"); }
	    				});
	    			}
	    			else { $("#enrollForm button[type=submit]").attr("disabled", true); checkId = false }
	    		});
	    	})
			function onGoogle() {
    			if (grecaptcha.getResponse().length == 0) { alert('reCAPTCHA를 확인해 주세요.'); return false; }
				if ($("#memberPwd").val() != $("#checkPwd").val()) { alert('비밀번호가 서로 달라요.'); return false; }
				if ((!($("#check1").is(':checked'))) || (!($("#check2").is(':checked')))) { alert('필수 약관에 동의해주세요.'); return false; }
                return true;
            }
			function authMake() {
				$.ajax({
					url: "authMake.me",
					type: "post",
					data: {email: $("#memberEmail").val()},
					success: function(numberA) { 
						numberAuth = numberA;
						emailAuth = $("#memberEmail").val();
						$("#signupAuthCheckButton").attr("disabled", false);
						$("#signupEmailAuthSpan").css("display: contents;");
						$("#memberEmail").attr("readonly", true);
						window.alert("인증번호 발급됨");
					},
					error: function() { console.log("이메일 인증 요청 실패"); }
				});
			}
			function authCheck() {
				$.ajax({
					url: "authCheck.me",
					type: "post",
					data: {email: emailAuth, number: $("#memberAuth").val()},
					success: function(result) {
						if (result == 'Y') { window.alert("인증성공."); checkAuth = true; $("#signupAuthCheckButton").attr("disabled", true); }
						else { window.alert("인증번호가 틀렸습니다."); }
						check();
					},
					error: function() { console.log("이메일 인증 검증 실패"); }
				});
			}
			function check() {
				if(!checkAuth || !checkId) { $("#enrollForm button[type=submit]").attr("disabled", true); }
				else { $("#enrollForm button[type=submit]").attr("disabled", false); }
			}
	    </script>
	</body>
</html>