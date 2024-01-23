<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>${sessionScope.loginCompany.companyName} 기업정보</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  	<link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700,900&display=swap" rel="stylesheet">
	<style>
		body { font-family: 'Roboto', sans-serif; background: #fbfbfb; }
		.profile-widget {
			width: 400px;
			margin: 0 auto;
			background-color: #fff;
			border: 1px solid #00BCD4;
			border-radius: 14px;
			text-align: center;
			color: #00BCD4;
		}
		.cover-img { max-height: 200px; overflow: hidden; width: 100%; }
		.user-details{ padding: 0px 20px 30px; }
		.profile-widget h3 { color: #00BCD4; margin: 20px 0px 10px; }
		.profile-widget img { width: 100%; max-width: 100%; height: auto; display: block; }
		.user-img {
			width: 100px;
			height: 100px;
			border-radius: 100%;
			overflow: hidden;
			box-shadow: 0px 0px 4px 0px #808080;
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
		.followers h3:last-child{ float: right; }
		.followers h3 span { font-weight: normal; font-size: 16px; }
		button.follow-btn {
			font-size: 19px;
			background: #00BCD4;
			border: none;
			color: #fff;
			padding: 10px 15px;
			margin: 20px 0px 0px;
			width: 100%;
			cursor: pointer;
		}
		button.follow-btn:hover{ opacity: 0.8; }
		h2.widget-heading { font-size: 25px; font-weight: normal; margin: 20px 0px 10px; padding: 0px 0px 10px; }
		@media (max-width: 767px){ .profile-widget { width: 90%; }
	}
	</style>
	</head>
	<body>
		<jsp:include page="../common/header.jsp" />
		<div class="content">
			<div style="display: flex;">
				<jsp:include page="./companyMenuBar.jsp" />
				<jsp:include page="./companyProfileCard.jsp" />
			</div>
		</div>
		<jsp:include page="../common/footer.jsp" />
	</body>
</html>