<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>채용 공고 리스트 보기 페이지</title>
	<style>
		.card-body>table { border-top: 1px solid #5271FF; border-collapse: collapse; text-align: center; }
		.card-body>table>thead>tr>th { border-top: 1px solid #5271FF; }
		.card-body>table>thead>tr>td { border-top: 1px solid #5271FF; }

		.tagList { border: 1px solid grey; border-radius: 8px; margin: 3px; padding: 3px; display: inline-flex; }
        .tagList:before { content: '#'; }
        .tagList:hover { cursor: pointer; transform: scale(1.24); background-color: black; color: white; }
	</style>
	</head>
	<body class="sb-nav-fixed">
		<jsp:include page="../../common/adminMenuBar.jsp" />
		<div id="readArea" style="display: none;">
			<div id="layoutSidenav_content">
				<main>
					<div class="container-fluid px-4">
						<h1 class="mt-4">Hboard</h1>
						<ol class="breadcrumb mb-4">
							<li class="breadcrumb-item active">Board</li>
							<li class="breadcrumb-item active">Hire</li>
							<li class="breadcrumb-item active">Read</li>
						</ol>
						<div class="card mb-4">
							<div class="card-body">
								해당 페이지에서는 채용공고 게시판 리스트를 출력합니다. 필요한 경우 삭제를 해주세요.
							</div>
						</div>
						<div class="card mb-4">
							<div class="card-header">
								<i class="fas fa-table me-1"></i>
                                Hboard List
							</div>
							<div class="card-body">
								<table class="card-table" align="center">
									<colgroup>
										<col width="5%"/>
										<col width="13%"/>
										<col width="22%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="10%"/>
										<col width="7%"/>
										<col width="13%"/>
									</colgroup>
									<thead>
										<tr>
											<th colspan="8">기본정보</th>
											<th colspan="1" rowspan="2">태그정보</th>
										</tr>
										<tr>
											<th>번호</th>
											<th>제목</th>
											<th>내용</th>
											<th>작성자</th>
											<th>등록일</th>
											<th>삭제여부</th>
											<th>위치</th>
											<th>조회수</th>
											<th></th>
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
					url : "adminListLoad.hb",
					success : function(col) {
						if (col=="none") { $("#moreLoad").attr("disabled", true); $("#tb").html($("#tb").html() + "<tr><td colspan='9' style='border-top: 1px solid #5271FF; border-bottom: 1px solid #5271FF;'>더 이상 표기할 정보가 없습니다.</td></tr>"); }
						else { $("#tb").html($("#tb").html() + col); }
					},
					error: function() { alert("로딩에 실패함"); }
				});
			};
			function onDelete(e, hboardNo) {
				$.ajax({
					data : { "hboardNo": hboardNo },
					type : "post",
					url : "adminDelete.hb",
					success : function(result) { $(e).parent().html("<button type='button' class='btn btn-info' onclick='onRestore(this, " + hboardNo + ");'>복원시키기</button>"); },
					error: function() { alert("삭제에 실패함"); }
				});
			};
			function onRestore(e, hboardNo) {
				$.ajax({
					data : { "hboardNo": hboardNo },
					type : "post",
					url : "adminRestore.hb",
					success : function(result) { $(e).parent().html("<button type='button' class='btn btn-danger' onclick='onDelete(this, " + hboardNo + ");'>탈퇴시키기</button>"); },
					error: function() { alert("복원에 실패함"); }
				});
			};
		</script>
	</body>
</html>