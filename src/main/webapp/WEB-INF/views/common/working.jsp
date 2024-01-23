<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>작업중 페이지</title>
	<link href="resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	</head>
	<body>
		<%@ include file="header.jsp" %>
        <div class="container" style="height: 600px;">
            <div style="width: 100%; height: 10%; padding: 40px"><h2 style="color: darkslateblue">작업중인 페이지입니다.</h2></div>
			<div style="display: flex; width: 100%; height: 90%; padding: 40px">
                <div style="width: 65%; height: 100%; border-radius: 10%; overflow: hidden;"><img src="resources/image/working.jpg" alt="" width="100%" height="100%" style="object-fit: cover;"></div>
                <div style="width: 35%; height: 100%; padding: 40px">
                    <h6 style="color: gray;">현재 페이지에 대해 개선작업을 통해 추후 제공해드리도록 하겠습니다.</h6><br><br><br><h3 style="color: #5271FF;"><b>감사합니다.</b></h3>
                    <br><br>
                    <div style="text-align: center;"><button type="button" class="btn btn-info" onclick="location.href='/coddy'">홈으로</button></div>                 
                </div>
            </div>
		</div>
        <%@ include file="footer.jsp" %>
	</body>
</html>