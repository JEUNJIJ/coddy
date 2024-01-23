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
		<input type="text" name="tagTechName" id="tagTechName">
		<script>
			var inputTech = document.querySelector('input[name=tagTechName]');
			/*
			let tagTechArr = ['C언어', 'C++', 'C#', 'GO', 'Java', 'JavaScript', 
				'Spring', 'React', 'Node.js', 'Vue', 'Swift', 'Kotlin', 
				'Python', 'Django', 'Php', 'Flutter', 'MySql', 'MarianDB',
				'MongoDB', 'OracleDB', 'Unity', 'AWS', 'Docker', 'Kubernetes',
				'Git', 'Figma', 'Window', 'Linux'];
			*/
			var tagTechArr = [];
			<c:forEach var="tag" items="${requestScope.tagTech}" varStatus="status">
				tagTechArr.push("${tag}");
			</c:forEach>

			var tagifyTech = new Tagify(inputTech, {
				enforceWhitelist: true,
				whitelist : tagTechArr,
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