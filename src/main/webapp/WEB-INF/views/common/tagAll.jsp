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
		<input type="text" name="tagAllName" id="tagAllName" value="">
		<script>
			var inputAll = document.querySelector('input[name=tagAllName]');
			/*
			let tagAllArr = ['C언어', 'C++', 'C#', 'GO', 'Java', 'JavaScript', 
				'Spring', 'React', 'Node.js', 'Vue', 'Swift', 'Kotlin', 
				'Python', 'Django', 'Php', 'Flutter', 'MySql', 'MarianDB',
				'MongoDB', 'OracleDB', 'Unity', 'AWS', 'Docker', 'Kubernetes',
				'Git', 'Figma', 'Window', 'Linux', 
				'PM', '기획', '프론트엔드', '백엔드', 'CDN', '디자인', '네트워크/서버', 'IOS 앱 개발', 'AOS 앱 개발', 'AI학습', '게임개발'];
			*/
			var tagAllArr = [];
			<c:forEach var="tag" items="${requestScope.tagAll}" varStatus="status">
				tagAllArr.push("${tag}");
			</c:forEach>

			var tagifyAll = new Tagify(inputAll, {
				enforceWhitelist: true,
				whitelist : tagAllArr,
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