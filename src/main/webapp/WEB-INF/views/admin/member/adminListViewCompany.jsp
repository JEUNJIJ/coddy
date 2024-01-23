<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>기업 정보 리스트 보기 페이지</title>
	<style>
		.card-body>table { border-top: 1px solid #5271FF; border-collapse: collapse; text-align: center; }
		.card-body>table>thead>tr>th { border-top: 1px solid #5271FF; }
		.card-body>table>thead>tr>td { border-top: 1px solid #5271FF; }
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
							<li class="breadcrumb-item active">Read</li>
						</ol>
						<div class="card mb-4">
							<div class="card-body">
								해당 페이지에서는 기업 회원을 조회 및 삭제 처리 가능합니다.
								<a target="_blank" href="adminRegistForm.cp">계정 추가의 경우 여기를 클릭하세요.</a>
							</div>
						</div>
						<div class="card mb-4">
							<div class="card-header">
								<i class="fas fa-table me-1"></i>
                                Company Administrate
							</div>
							<div class="card-body">
								<table class="card-table" align="center">
									<colgroup>
										<col width="3%"/>
										<col width="10%"/>
										<col width="4%"/>
										<col width="10%"/>
										<col width="41%"/>
										<col width="10%"/>
										<col width="5%"/>
										<col width="7%"/>
										<col width="10%"/>
									</colgroup>
									<thead>
										<tr>
											<th colspan="5" style="border-left: 1px solid #5271FF; border-right: 1px solid #5271FF;">회사정보</th>
											<th colspan="4" style="border-right: 1px solid #5271FF;">계정정보</th>
										</tr>
										<tr>
											<th style="border-left: 1px solid #5271FF;">번호</th>
											<th>상호명</th>
											<th>대표</th>
											<th>사업자 등록번호</th>
											<th style="border-right: 1px solid #5271FF;">설명</th>
											<th>회사 ID</th>
											<th>email</th>
											<th>가입일</th>
											<th style="border-right: 1px solid #5271FF;">탈퇴일</th>
										</tr>
									</thead>
									<tbody id="tb">
										
									</tbody>
								</table>
								<br>
								<div style="text-align: center;"><button type="button" class="btn btn-primary" id="moreLoad" onclick="onLoad(page++);" style="background-color: #5271FF; color: moccasin; width: 20%;"><span class="spinner-border spinner-border-sm"></span>&nbsp;더 불러오기</button></div>
							</div>
						</div>
					</div>
				</main>
			</div>
		</div>
		<script>
			let page = 1;
			$(document).ready(function() { onLoad(page++); });
			function onLoad(page) {
				$.ajax({
					data : { "page": page },
					type : "get",
					url : "adminListLoad.cp",
					success : function(col) {
						if (col=="none") { $("#moreLoad").attr("disabled", true); $("#tb").html($("#tb").html() + "<tr><td colspan='9' style='border-top: 1px solid #5271FF; border-bottom: 1px solid #5271FF;'>더 이상 표기할 정보가 없습니다.</td></tr>"); }
						else { $("#tb").html($("#tb").html() + col); }
					},
					error: function() { alert("로딩에 실패함"); }
				});
			};
			function onDelete(e, companyNo) {
				$.ajax({
					data : { "companyNo": companyNo },
					type : "post",
					url : "adminDelete.cp",
					success : function(result) { $(e).parent().html("<button type='button' class='btn btn-info' onclick='onRestore(this, " + companyNo + ");'>복원시키기</button>"); },
					error: function() { alert("삭제에 실패함"); }
				});
			};
			function onRestore(e, companyNo) {
				$.ajax({
					data : {"companyNo": companyNo},
					type : "post",
					url : "adminRestore.cp",
					success : function(result) { $(e).parent().html("<button type='button' class='btn btn-danger' onclick='onDelete(this, " + companyNo + ");'>탈퇴시키기</button>"); },
					error: function() { alert("복원에 실패함"); }
				});
			};
		</script>
	</body>
</html>