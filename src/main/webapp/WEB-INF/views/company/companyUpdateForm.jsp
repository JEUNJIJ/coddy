<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>${sessionScope.loginCompany.companyName} 계정 정보 변경</title>
		<style>
			input[type=text], input[type=password], input[type=email], input[type=number], input[type=date], input[type=datetime-local] { border: none; text-align: center; color: #00BCD4; width: 160px; }
			textarea { border: none; text-align: center; color: #00BCD4; width: 400px; }
			input[type=submit] { border: none; border-radius: 20px; background-color: inherit; color: #00BCD4; width: 40%; height: 50px; }
			input[type=submit]:hover { border: none; background-color: #00BCD4; color: white }
		</style>
	</head>
	<body>
		<jsp:include page="../common/header.jsp" />
		<div class="content">
			<div style="display: flex;">
				<jsp:include page="./companyMenuBar.jsp" />
				<div style="display: flex; float: left; padding-left: 40px;">
					<jsp:include page="./companyProfileCard.jsp" />
					&nbsp;
                    <div class="profile-widget" style="width: 500px;">
						<form action="update.cp" method="post">
							<input type="hidden" name="companyNo" value="${sessionScope.loginCompany.companyNo}">
							<h1 align="center">Profile</h1>
							<table align="center" style="width: 100%;">
								<thead>

								</thead>
								<tbody>
									<tr>
										<th>Name</th>
										<td><input type="text" name="companyName" value="${sessionScope.loginCompany.companyName}" required></td>
										<th>Owner</th>
										<td><input type="text" name="companyOwner" value="${sessionScope.loginCompany.companyOwner}" required></td>
									</tr>
									<tr>
										<th>ID</th>
										<td><input type="text" name="companyId" value="${sessionScope.loginCompany.companyId}" required readonly></td>
										<th>Email</th>
										<td><input type="email" name="companyEmail" value="${sessionScope.loginCompany.companyEmail}" required readonly></td>
									</tr>
									<tr>
										<th>BNO</th>
										<td><input type="number" name="companyBno" value="${sessionScope.loginCompany.companyBno}" required readonly></td>
										<th>JOIN</th>
										<td><input type="datetime-local" name="companyInsert" value="${sessionScope.loginCompany.companyInsert}" required readonly></td>
									</tr>
									<tr>
										<th>Worker</th>
										<td><input type="number" name="companyWorker" value="${sessionScope.loginCompany.companyWorker}" required></td>
										<th>Salary</th>
										<td><input type="number" name="companySalary" value="${sessionScope.loginCompany.companySalary}" required></td>
									</tr>
									<tr>
										<th rowspan="10">Info</th>
										<td colspan="3" rowspan="10"><textarea name="companyInfo" id="companyInfo" cols="2" rows="10" maxlength="800">${sessionScope.loginCompany.companyInfo}</textarea></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th></th>
										<td></td>
										<th></th>
										<td></td>
									</tr>
									<tr>
										<th>New PWD</th>
										<td><input type="password" name="companyNewPwd" value=""></td>
										<th>Check PWD</th>
										<td><input type="password" name="companyPwd" value="" required></td>
									</tr>
								</tbody>
							</table>
							<input type="submit" value="변경확인">
						</form>
					</div>
				</div>
			</div>
		</div>
		<script>
			$(document).ready(function() {
				$('#companyInfo').summernote({
					minHeight: 300,
					maxHeight: null,
					focus: false,
					lang: "ko-KR",
					prettifyHtml:true,
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
			})
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
		<jsp:include page="../common/footer.jsp" />
	</body>
</html>