<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>관리자 회원 추가</title>
	</head>
	<body class="sb-nav-fixed">
		<jsp:include page="../common/adminMenuBar.jsp" />
		<div id="readArea" style="display: none;">
			<div id="layoutSidenav_content">
				<main>
					<div class="container-fluid px-4">
						<h1 class="mt-4">Member</h1>
						<ol class="breadcrumb mb-4">
							<li class="breadcrumb-item active">Component</li>
							<li class="breadcrumb-item active">Member</li>
							<li class="breadcrumb-item active">Create</li>
						</ol>
						<div class="card mb-4">
							<div class="card-body">
								해당 페이지에서는 일반 회원을 추가 가능합니다. 특별한 경우 외에는 사용을 금지합니다.
								<a target="_blank" href="adminList.me">계정 관리의 경우 여기를 클릭하세요.</a>
							</div>
						</div>
						<div class="card mb-4">
							<div class="card-header">
								<i class="fas fa-table me-1"></i>
                                Member Regist
							</div>
							<div class="card-body">
								<fieldset align="center">
									<legend>임시 회원가입 페이지</legend>
									아이디 : <input type="text" name="memberId" id="memberId"><br>
									비밀번호 : <input type="password" name="memberPwd" id="memberPwd"><br>
									이메일 : <input type="email" name="memberEmail" id="memberEmail"><br>
									이름 : <input type="text" name="memberName" id="memberName"><br>
									설명 : <textarea name="memberInfo" id="memberInfo" cols="30" rows="10"></textarea>
								</fieldset>
							</div>
							<div align="center">
								<button type="button" onclick="onSign();">가입시키기</button>
								<button type="button" onclick="location.href='/coddy'">집으로</button>
							</div>
						</div>
					</div>
				</main>
			</div>
		</div>
		<script>
			function onSign() {
				$.ajax({
					type : "POST",
					url : "insertForce.me",
					data : {memberId: $("#memberId").val(), memberPwd: $("#memberPwd").val(), memberEmail: $("#memberEmail").val(), memberName: $("#memberName").val(), memberInfo: $("#memberInfo").val()},
					success : function(result) { alert(result); },
					error : function(xhr, status, error) { alert(error); }
				});
			};
		</script>
	</body>
</html>