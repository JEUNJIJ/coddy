<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>태그 리스트 보기 페이지</title>
	<style>
		.card-body>table { border-top: 1px solid #5271FF; border-collapse: collapse; text-align: center; }
		.card-body>table>thead>tr>th { border-top: 1px solid #5271FF; border-bottom: 1px solid #5271FF; }
		.card-body>table>thead>tr>td { border-bottom: 1px solid #5271FF; }
	</style>
	</head>
	<body class="sb-nav-fixed">
		<jsp:include page="../common/adminMenuBar.jsp" />
		<div id="readArea" style="display: none;">
			<div id="layoutSidenav_content">
				<main>
					<div class="container-fluid px-4">
						<h1 class="mt-4">Tag</h1>
						<ol class="breadcrumb mb-4">
							<li class="breadcrumb-item active">Component</li>
							<li class="breadcrumb-item active">Tag</li>
						</ol>
						<div class="card mb-4">
							<div class="card-body">
								해당 페이지에서는 태그 조회, 추가, 비활성화 작업을 할 수 있습니다.<br>
								<a href="javascript: void(0);" onclick="onAddTag();"><i class="fa fa-plus"></i>&nbsp;태그를 추가하기.</a>
							</div>
						</div>
						<div class="card mb-4">
							<div class="card-header">
								<i class="fas fa-table me-1"></i>
                                Tag List
							</div>
							<div class="card-body">
								<table class="card-table" align="center">
									<colgroup>
										<col width="5%"/>
										<col width="15%"/>
										<col width="30%"/>
										<col width="50%"/>
									</colgroup>
									<thead>
										<tr>
											<th>번호</th>
											<th>태그이름</th>
											<th>태그타입</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody id="tb">
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</main>
			</div>
		</div>
		<script>
			$(document).ready(function() { onLoad(); });
			function onLoad() {
				$.ajax({
					type : "get",
					url : "adminListLoad.tg",
					success : function(col) {
						if (col=="none") { $("#tb").html($("#tb").html() + "<tr><td colspan='4' style='border-top: 1px solid #5271FF; border-bottom: 1px solid #5271FF;'>태그가 없습니다.</td></tr>"); }
						else { $("#tb").html(col); for(var i of $("#tb>tr>.tgType")) { if($(i).text() == 1) $(i).text('직군태그'); if($(i).text() == 0) $(i).text('기술태그'); } for(var i of $("#tb>tr>.tgActive")) { if($(i).text() == 1) $(i).html("<button type='button' class='btn btn-danger' onclick='onDelete(this);'>정지하기</button>"); if($(i).text() == 0) $(i).html("<button type='button' class='btn btn-info' onclick='onRestore(this);'>복원하기</button>"); } $("#tb").html($("#tb").html() + "<tr><td colspan='4' style='border-top: 1px solid #5271FF; border-bottom: 1px solid #5271FF;'>더 이상 태그가 없습니다.</td></tr>"); }
					},
					error: function() { alert("로딩에 실패함"); }
				});
			};
			function onAddTag() {
				let tagsName = prompt("태그 이름을 입력해주세요");
				let tagsType = prompt("태그 유형 선택(0: 기술태그 / 1:직군태그)");
				$.ajax({
					data: { "tagsName": tagsName, "tagsType": tagsType },
					type : "get",
					url : "adminAdd.tg",
					success : function(result) { alert(result); if(result=="추가에 성공함") onLoad(); },
					error: function() { alert("추가에 실패함"); }
				});
			};
			function onDelete(col) {
				$.ajax({
					data: { "tagsNo": $(col).parent().parent().children().eq(0).text() },
					type : "post",
					url : "adminDelete.tg",
					success : function(result) { alert(result); if(result=="삭제에 성공함") onLoad(); },
					error: function() { alert("삭제에 실패함"); }
				});
			};
			function onRestore(col) {
				$.ajax({
					data: { "tagsNo": $(col).parent().parent().children().eq(0).text() },
					type : "post",
					url : "adminRestore.tg",
					success : function(result) { alert(result); if(result=="복원에 성공함") onLoad(); },
					error: function() { alert("복원에 실패함"); }
				});
			};
		</script>
	</body>
</html>