<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>관리자 회사 추가</title>
	<style>
		
	</style>
	</head>
	<body class="sb-nav-fixed">
		<jsp:include page="../common/adminMenuBar.jsp" />
		<div id="readArea" style="display: none;">
			<div id="layoutSidenav_content">
				<main>
					<div class="container-fluid px-4">
						<h1 class="mt-4">Company</h1>
						<ol class="breadcrumb mb-4">
							<li class="breadcrumb-item active">Component</li>
							<li class="breadcrumb-item active">Company</li>
							<li class="breadcrumb-item active">Create</li>
						</ol>
						<div class="card mb-4">
							<div class="card-body">
								해당 페이지에서는 기업 회원을 추가 가능합니다. 특별한 경우 외에는 사용을 금지합니다.
								<a target="_blank" href="adminList.cp">계정 관리의 경우 여기를 클릭하세요.</a>
							</div>
						</div>
						<div class="card mb-4">
							<div class="card-header">
								<i class="fas fa-table me-1"></i>
                                Company Regist
							</div>
							<div class="card-body">
								<fieldset align="center">
									<legend>관리자 회사 추가 페이지</legend>
									아이디 : <input type="text" name="companyId" id="companyId"><br>
									비밀번호 : <input type="password" name="companyPwd" id="companyPwd"><br>
									이메일 : <input type="email" name="companyEmail" id="companyEmail"><br>
									사업명 : <input type="text" name="companyName" id="companyName"><br>
									대표자명 : <input type="text" name="companyOwner" id="companyOwner"><br>
									사업자등록번호 : <input type="number" name="companyBno" id="companyBno"><br>
									사원수 : <input type="number" name="companyWorker" id="companyWorker"><br>
									평균급여 : <input type="number" name="companySalary" id="companySalary"><br>
									설명 : <textarea name="companyInfo" id="companyInfo" cols="30" rows="10"></textarea>
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
					url : "adminRegist.cp",
					data : {companyId: $("#companyId").val(), companyPwd: $("#companyPwd").val(), companyEmail: $("#companyEmail").val(), companyName: $("#companyName").val(), companyOwner: $("#companyOwner").val(), companyBno: $("#companyBno").val(), companyWorker: $("#companyWorker").val(), companySalary: $("#companySalary").val(), companyInfo: $("#companyInfo").val()},
					success : function(result) { alert(result); },
					error : function(xhr, status, error) { alert(error); }
				});
			};
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
	</body>
</html>