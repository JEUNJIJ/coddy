<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>ID찾기</title>
	<style>
		#idFinder { border: 1px solid #e5ddff; width: 100%; height: 50%; padding: 20%; border-radius: 30px; }
		.oneLine { display: inline; width: 100%; margin: auto; padding: 2%; }
		.oneLine>div>input { border-left-width: 0px; border-right-width: 0px; border-top-width:2px; border-bottom-width: 2px; border-color: #5271FF; }
		.buttonLine {  }
		.btn-donate {
			--clr-font-main: hsla(0 0% 20% / 100);
			--btn-bg-1: hsla(194 100% 69% / 1);
			--btn-bg-2: hsla(217 100% 56% / 1);
			--btn-bg-color: hsla(360 100% 100% / 1);
			--radii: 0.5em;
			cursor: pointer;
			padding: 0.9em 1.4em;
			min-width: 120px;
			min-height: 44px;
			font-size: var(--size, 1rem);
			font-family: "Segoe UI", system-ui, sans-serif;
			font-weight: 500;
			transition: 0.8s;
			background-size: 280% auto;
			background-image: linear-gradient(325deg, var(--btn-bg-2) 0%, var(--btn-bg-1) 55%, var(--btn-bg-2) 90%);
			border: none;
			border-radius: var(--radii);
			color: var(--btn-bg-color);
			box-shadow: 0px 0px 20px rgba(71, 184, 255, 0.5), 0px 5px 5px -1px rgba(58, 125, 233, 0.25), inset 4px 4px 8px rgba(175, 230, 255, 0.5), inset -4px -4px 8px rgba(19, 95, 216, 0.35);
		}
		.btn-donate:hover { background-position: right top; }
		.btn-donate:is(:focus, :focus-visible, :active) { outline: none; box-shadow: 0 0 0 3px var(--btn-bg-color), 0 0 0 6px var(--btn-bg-2); }
		@media (prefers-reduced-motion: reduce) { .btn-donate { transition: linear; } }
		.oneLine>div>input:focus, .oneLine>div>input:hover {
			outline: none;
			border-color: rgba(0,249,42,1);
			background-color: #fff;
			box-shadow: 0 0 0 4px rgb(0,249,42 / 10%);
		}
	</style>
	</head>
	<body>
		<jsp:include page="../common/header.jsp" />
		<div class="content"><br><br>
			<div id="idFinder">
				<div class="inputLine" style="text-align: center;">
					<h2>ID 찾기</h2><br><br>
					<div class="oneLine">
						<br><br>
						<div style="width: 100%;">
							<span>이름</span>
							<input type="text" name="memberName" id="memberName" placeholder="name" class="form-control">
						</div>
						<br> <br> <br> <br>
						<div style="width: 100%;">
							<span>이메일</span>
							<input type="email" name="memberEmail" id="memberEmail" placeholder="email" class="form-control">
						</div>
						<br> <br>
					</div>
				</div>
				<br><br><br><br>
				<div align="center" class="buttonLine">
					<button type="button" class="btn-donate" onclick="findId();">확인하기</button>&nbsp;&nbsp;
					<button type="button" class="btn-donate" onclick="findPwd();">비밀번호 찾기</button>
				</div>
			</div>
		</div>
		<jsp:include page="../common/footer.jsp" />
		<script>
			$(function() {
				$("html").animate({scrollTop : $("#idFinder").offset().top}, 800);
			})
			function findId() {
				if(($("#memberName").val() != "") && ($("#memberEmail").val() != "")) {
					$.ajax({
						url: "findId.me",
						type: "post",
						data: {memberName: $("#memberName").val(), memberEmail: $("#memberEmail").val()},
						success: function(id) { if(id != "") { window.alert("고객님의 아이디는 " + id + "입니다."); } else { window.alert("해당하는 아이디가 없습니다."); } },
						error: function() { console.log("아이디 찾기 실패"); }
					})
				} else { window.alert("필수 입력사항입니다."); }
			}
			function findPwd() {
				if(($("#memberName").val() != "") && ($("#memberEmail").val() != "")) {
					$.ajax({
						url: "findPwd.me",
						type: "post",
						data: {memberName: $("#memberName").val(), memberEmail: $("#memberEmail").val()},
						success: function(result) { if(result == "N") { window.alert("해당하는 계정이 없거나 잘못된 요청입니다."); } else { window.alert("새 비밀번호가 이메일로 전송되었습니다."); location.href="/coddy/" } },
						error: function() { console.log("비밀번호 찾기 실패"); }
					})
				} else { window.alert("필수 입력사항입니다."); }
			}
		</script>
	</body>
</html>