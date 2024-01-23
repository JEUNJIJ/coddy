<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>정말로 삭제합니까?</title>
	<style>
		.pw {
			width: 500px;
			height: 32px;
			font-size: 15px;
			border: 0;
			border-radius: 15px;
			outline: none;
			padding-left: 10px;
			background-color: rgb(233, 233, 233);
		}
	</style>
	</head>
	<body>
		<jsp:include page="../../common/header.jsp" />
		<div class="content">
			<form action="delete.hb" method="post">
				<div align="center" style="text-align: center; border: 1px solid rosybrown; border-radius: 10px; height: 300px; padding: 100px;">
					<input type="hidden" name="hboardNo" value="${sessionScope.hb.hboardNo}">
					<input type="hidden" name="companyNo" value="${sessionScope.hb.companyNo}">
					<span>비밀번호를 입력해주세요 : </span>
					<input type="password" class="pw" name="password">
					<br><br><br><br><br>
					<button type="submit" class="btn btn-primary btn-danger">
						<span class="spinner-grow spinner-grow-sm"></span>&nbsp;&nbsp;입력완료
					</button>
				</div>
			</form>
		</div>
		<jsp:include page="../../common/footer.jsp" />
	</body>
</html>