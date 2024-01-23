<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>기업 회원가입</title>
	<!-- 구글 recaptcha2 -->
    <script src='https://www.google.com/recaptcha/api.js'></script>
	<!-- bnoKey -->
	<script src="${ pageContext.request.contextPath }/resources/js/bnoKey.js"></script>
	<style>
		.signupOuter { width: 100%; height: 60%; }
		.signupInner { border-radius: 10px; border: 2px solid wheat; opacity: 0.7; margin-left: 5%; margin-top: 5%; margin-bottom: 5%; margin-right: 5%; width: 90%; text-align: center; text-decoration-color: coral; padding: 3%; }
		.signupOther { align: center }
		.signupInputs { width: 100%; }
		.signupOneLine { display: flex; }
		.signupOneLine a { width: 25%; }
		.fieldSets { width: 100%; border: 3px solid turquoise; padding: 3%; border-radius: 10px; }

		/* 네온 사인 관련 스타일 */
		@import url('https://fonts.googleapis.com/css2?family=Raleway:wght@400;700&display=swap');
		* { margin: 0; padding: 0; box-sizing: border-box; }
		a { text-decoration: none; }
		/*
		body {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh;
			background: #050801;
			font-family: 'Raleway', sans-serif;
			font-weight: bold;
		}
		*/
		.signupOneLine>a {
			position: relative;
			display: inline-block;
			color: #03e9f4;
			text-decoration: none;
			text-transform: uppercase;
			transition: 0.5s;
			letter-spacing: 4px;
			overflow: hidden;
		}
		.signupOneLine>a:hover {
			background: #03e9f4;
			color: #050801;
			box-shadow: 0 0 5px #03e9f4, 0 0 25px #03e9f4, 0 0 50px #03e9f4, 0 0 200px #03e9f4;
			-webkit-box-reflect:below 1px linear-gradient(transparent, #0005);
		}
		.signupOneLine>a:nth-child(1) { filter: hue-rotate(270deg); }
		.signupOneLine>a:nth-child(2) { filter: hue-rotate(110deg); }
		.signupOneLine>a>span { position: absolute; display: block; }
		.signupOneLine>a>span:nth-child(1) {
			top: 0;
			left: 0;
			width: 100%;
			height: 2px;
			background: linear-gradient(90deg,transparent,#03e9f4);
			animation: animate1 1s linear infinite;
		}
		@keyframes animate1 { 0% { left: -100%; } 50%, 100% { left: 100%; } }
		.signupOneLine>a>span:nth-child(2) {
			top: -100%;
			right: 0;
			width: 2px;
			height: 100%;
			background: linear-gradient(180deg,transparent,#03e9f4);
			animation: animate2 1s linear infinite;
			animation-delay: 0.25s;
		}
		@keyframes animate2 { 0% { top: -100%; } 50%, 100% { top: 100%; } }
		.signupOneLine>a>span:nth-child(3) {
			bottom: 0;
			right: 0;
			width: 100%;
			height: 2px;
			background: linear-gradient(270deg,transparent,#03e9f4);
			animation: animate3 1s linear infinite;
			animation-delay: 0.50s;
		}
		@keyframes animate3 { 0% { right: -100%; } 50%, 100% { right: 100%; } }
		.signupOneLine>a>span:nth-child(4) {
			bottom: -100%;
			left: 0;
			width: 2px;
			height: 100%;
			background: linear-gradient(360deg,transparent,#03e9f4);
			animation: animate4 1s linear infinite;
			animation-delay: 0.75s;
		}
		@keyframes animate4 { 0% { bottom: -100%; } 50%, 100% { bottom: 100%; } }
	</style>
	<!-- .signupOther { background-image: url("${ pageContext.request.contextPath }/resources/image/company/signup-bg.jpg"); background-repeat: no-repeat; background-size : contain; }  -->
	</head>
	<body>
		<jsp:include page="../common/header.jsp" />
		<div class="content">
			<div class="signupOuter">
				<div class="signupInner">
					<h1>기업 회원가입 양식</h1>
					<form action="signup.cp" method="post" onsubmit="return onSubmit();">
						<fieldset class="fieldSets">
							<legend style="width: 30%; text-decoration-color: lemonchiffon; font-size: 30px;">계정 정보 입력</legend>
							<div>
								<label for="companyId">ID</label>
								<div class="signupOneLine">
									<input type="text" name="companyId" id="companyId" class="signupInputs form-control" placeholder="ID 입력" required>
									<a onclick="onId();" id="onId"><span></span><span></span><span></span><span></span>ID 중복 체크</a>
								</div>
							</div>
							<div>
								<label for="companyPwd">Password</label>
								<input type="password" name="companyPwd" id="companyPwd" class="signupInputs form-control" placeholder="PWD 입력" onkeyup="onPassword();" required>
							</div>
							<div>
								<label for="companyPwd2">Password 재입력</label>
								<input type="password" name="companyPwd2" id="companyPwd2" class="signupInputs form-control" placeholder="PWD 확인" onkeyup="onPassword();" required>
							</div>
						</fieldset><br>
						<fieldset class="fieldSets">
							<legend style="width: 30%; text-decoration-color: lemonchiffon; font-size: 30px;">회사 정보 입력</legend>
							<div>
								<label for="companyName">회사명</label>
								<input type="text" name="companyName" id="companyName" class="signupInputs form-control" placeholder="회사명 입력" required>
							</div>
							<div>
								<label for="companyOwner">사업주명</label>
								<input type="text" name="companyOwner" id="companyOwner" class="signupInputs form-control" placeholder="사업주명 입력" required>
							</div>
							<div>
								<label for="companyWorker">직원수</label>
								<input type="number" name="companyWorker" id="companyWorker" class="signupInputs form-control" placeholder="직원수 입력" value="1" required>
							</div>
							<div>
								<label for="companySalary">평균연봉 정보</label>
								<input type="number" name="companySalary" id="companySalary" class="signupInputs form-control" placeholder="평균연봉 입력" value="14000000" required>
							</div>
							<div>
								<label for="companyInfo">회사소개</label>
								<textarea name="companyInfo" id="companyInfo" class="signupInputs form-control" placeholder="간단 회사 소개"></textarea>
							</div>
							<div>
								<label for="companyEmail">Email</label>
								<div class="signupOneLine">
									<input type="email" name="companyEmail" id="companyEmail" class="signupInputs form-control" placeholder="Email 입력 @포함" required>
									<a onclick="onEmail();" id="onEmail"><span></span><span></span><span></span><span></span>이메일 인증하기</a>
								</div>
							</div>
							<div>
								<label for="companyBno">사업자 등록번호</label>
								<div class="signupOneLine">
									<input type="number" name="companyBno" id="companyBno" class="signupInputs form-control" placeholder="사업자 등록번호 입력 -없이 입력" max="9999999999" min="0000000000" required>
									<a onclick="onBno();" id="onBno"><span></span><span></span><span></span><span></span>사업자 번호 확인</a>
								</div>
							</div>
						</fieldset><br>
						<div class="signupOther">
							<div align="center"><div class="g-recaptcha" data-sitekey="${ sessionScope.gKey }"></div></div>
						</div>
						<br>
						<div class="signupButtonArea">
							<button type="submit" class="btn btn-primary"><span class="spinner-grow spinner-grow-sm"></span>&nbsp;가입하기</button>
							<button type="button" class="btn btn-primary" onclick="backToLogin();">로그인 페이지로 돌아가기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<jsp:include page="../common/footer.jsp" />
		<script>
			$(function() {
				$("html").animate({scrollTop : $(".signupOuter").offset().top}, 800);
				$('#companyInfo').summernote({
					minHeight: 300,
					maxHeight: null,
					focus: false,
					lang: "ko-KR",
					toolbar: [
						// [groupName, [list of button]]
						['fontname', ['fontname']],
						['fontsize', ['fontsize']],
						['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
						['color', ['forecolor','color']],
						['table', ['table']],
						['para', ['ul', 'ol', 'paragraph']],
						['height', ['height']],
						['insert',['picture','link','video']],
						['view', ['fullscreen', 'help']]
					],
					fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
					fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72','76','102	'],
					callbacks: {
						onImageUpload : function(files) {
							uploadSummernoteImageFile(files[0],this);
						},
						onPaste: function (e) {
							var clipboardData = e.originalEvent.clipboardData;
							if (clipboardData && clipboardData.items && clipboardData.items.length) {
								var item = clipboardData.items[0];
								if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
									e.preventDefault();
								}
							}
						}
					}
				});
				$("div.note-editable").on('drop',function(e){
					for(i=0; i< e.originalEvent.dataTransfer.files.length; i++){ uploadSummernoteImageFile(e.originalEvent.dataTransfer.files[i],$("#summernote")[0]); }
					e.preventDefault();
				});
			});
			let checkId = false;
			let checkGoogle = false;
			let checkEmail = false;
			let checkPwd = false;
			let checkBno = false;
			let bnoStatus = "-1";
			function onSubmit() {
				checkGoogle = onGoogle();
				if(checkEmail != true) { alert("Email 인증 필요"); $("#companyEmail").focus(); return false; }
				else if(checkBno != true) { alert("사업자 인증 필요"); $("#companyBno").focus(); return false; }
				else if(checkGoogle != true) { alert("recaptchav2 인증 필요"); $(".g-recaptcha").focus(); return false; }
				else if(checkPwd != true) { alert("비밀번호가 서로 다름"); $("#companyPwd").focus(); return false; }
				else if(checkId != true) { alert("아이디 중복 체크 필요"); $("#companyId").focus(); return false; }
				else if($("#comapnyWorker").val() <= 0) { alert("직원수는 1명 이상입니다."); $("#companyWorker").focus(); return false; }
				else if($("#comapnySalary").val() <= 0) { alert("평균연봉 정보는 음수일 수 없습니다."); $("#companySalary").focus(); return false; }
				else { return true; }
			};
			function onPassword() { 
				if($("#companyPwd").val() == $("#companyPwd2").val()) { checkPwd = true }
				else { checkPwd = false }
			};
			function onGoogle() {
    			if (grecaptcha.getResponse().length == 0) { return false; }
				else { return true; }
            };
			function onId() {
				if($("#companyId").val().length < 6) { alert("ID는 최소 6글자 이상으로 맞춰주세요."); }
				else {
					$.ajax({
						url: "companyCheck.cp",
	    				type: "get",
	    				data: {id: $("#companyId").val()},
	    				success: function(result) { 
							if(result=="NNNNN") { alert("사용 불가능한 아이디입니다."); } 
							else { if(confirm("사용 가능한 아이디입니다. 사용하시겠습니까?") != true) {  } else { $("#companyId").attr("readonly", true); $("#onId").removeAttr("onclick"); checkId = true;  } } },
	    				error: function() { console.log("아이디 중복 체크 실패"); }
					});
				}
			};
			function onBno() {
				if($("#companyBno").val().length != 10) { alert("사업자 등록번호는 10자리 숫자입니다."); }
				else {
					$.ajax({
						url: "companyBnoCheck.cp",
	    				type: "post",
						data: {companyBno: $("#companyBno").val()},
						success: function(result) { if(result == "not a number") { alert("사업자 등록번호가 숫자가 아닙니다."); } else if(result == "not a valid") { alert("유효하지않은 사업자 등록번호입니다."); } else { apiBno($("#companyBno").val()); } },
						error: function() { console.log("사업자 유효성 체크 실패"); }
					});
				}
			};
			function onEmail() {
				$.ajax({
						url: "companyEmailCheck.cp",
	    				type: "post",
						data: {companyEmail: $("#companyEmail").val()},
						success: function(result) { if(result == "failed") { alert("인증번호 생성 실패. 관리자에게 문의해주세요!"); checkEmail = false; } else { if(prompt("인증번호 입력") != result) { alert("인증 실패"); checkEmail = false; } else { alert("인증성공"); checkEmail = true; $("#companyEmail").attr("readonly", true); $("#onEmail").removeAttr("onclick"); } } },
						error: function() { console.log("이메일 인증 실패"); }
					});
			}
			function backToLogin() { if(confirm("정말로 로그인 페이지로 돌아갑니까?") == true) { location.href = "/coddy/loginPage.cp"; } }
			function apiBno(number) { 
				let apiKey = BNO_KEY;
				var data = { b_no: [number] };

				$.ajax({
					url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=" + apiKey,
					type: "POST",
					data: JSON.stringify(data),
					dataType: "JSON",
					contentType: "application/json",
					accept: "application/json",
					success: function (result) {
						console.log(result.data[0]);
						bnoStatus = result.data[0].b_stt_cd;
						if(bnoStatus == "") { alert("미등록 사업자입니다."); checkBno = false; }
						else if(bnoStatus == "02") { alert("휴업자입니다."); checkBno = false; }
						else if(bnoStatus == "03") { alert("폐업자입니다."); checkBno = false; }
						else if(bnoStatus == "01") { alert("확인이 완료되었습니다."); $("#companyBno").attr("readonly", true); $("#onBno").removeAttr("onclick"); checkBno = true; }
						else { alert("알수없는 사업자 번호."); checkBno = false; }
					},
					error: function (error) { console.log("에러: ", error); },
				});
			};
			function uploadSummernoteImageFile(file, editor) {
				data = new FormData();
				data.append("file", file);
				$.ajax({
					data : data,
					type : "post",
					url : "uploadSummernoteImageFile.cp",
					contentType : false,
					processData : false,
					success : function(data) {
						$(editor).summernote('insertImage', data);
					}
				});
			}
		</script>
	</body>
</html>