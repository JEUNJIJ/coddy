<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
	</style>
	</head>
	<body>
		<input type="text" name="tagCareerName" id="tagCareerName">
		<script>
			var inputCareer = document.querySelector('input[name=tagCareerName]');
			// let tagCareerArr = ['PM', '기획', '프론트엔드', '백엔드', 'CDN', '디자인', '네트워크/서버', 'IOS 앱 개발', 'AOS 앱 개발', 'AI학습', '게임개발'];
			var tagCareerArr = [];
			<c:forEach var="tag" items="${requestScope.tagCareer}" varStatus="status">
				tagCareerArr.push("${tag}");
			</c:forEach>

			var tagifyCareer = new Tagify(inputCareer, {
				enforceWhitelist: true,
				whitelist : tagCareerArr,
				blacklist : ["fuck", "shit"],
				dropdown: {
					enabled : 0,
					maxItems: 200,
					classname: "tags-look",
					enabled: 0,
					closeOnSelect: false
				}
			})

			// toggle Tagify on/off
			/*
			document.querySelector('input[type=checkbox]').addEventListener('change', function(){
				document.body.classList[this.checked ? 'add' : 'remove']('disabled');
			})
			*/
		</script>
	</body>
</html>