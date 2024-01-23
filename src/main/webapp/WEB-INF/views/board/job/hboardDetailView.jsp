<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>${sessionScope.hb.hboardTitle}</title>
	<!-- KakaoMap -->
	<script type="text/javascript" id="tMapSc" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${sessionScope.tmapKey}&libraries=services&autoload=false" autoload="false"></script>
	<style>
		.mainContent { width: 100%; height: 95%; border: 2px solid rgb(138, 125, 114); border-radius: 20px; }
		/*
		.mainContent div { border-bottom:1px solid; border-color: coral; }
		*/
		.subContent { width: 100%; height: 5%; padding: 5px; }
		.boardTitleBar { width: 100%; height: 5%; padding: 5px; border-bottom: 2px; border-bottom-style: solid; border-bottom-color: rgb(138, 125, 114); }
		.boardTitleBarImg { border-radius: 7px; overflow: hidden; }
		.boardTitleBarImg img { object-fit: cover; }
		.boardContentBar { width: 100%; height: 95%; display: flex; }
		.boardContentArea { width: 75%; height: 100%; }
		.boardMiniArea { width: 25%; height: 600px; top: 20%; position: sticky; overflow: auto; }
		.boardMiniCard { width: 100%; height: 550px; border: 2px solid #929fd8; border-radius: 20px; padding: 10px; background-color: whitesmoke; margin:0 auto; overflow: auto; }
		.boardMiniAttach { width: 100%; border: 2px solid #929fd8; border-radius: 20px; padding: 10px; background-color: whitesmoke; }
		.boardContentThumb { width: 100%; height: 420px; padding: 4%; }
		.boardContentTag { width: 100%; height: 120px; }
		.boardContentContent { width: 100%; height: 630px; padding: 10px; }
		.boardContentMap { width: 100%; height: 360px; padding: 10px; overflow: auto; }

		.tagList { border: 1px solid grey; border-radius: 8px; margin: 3px; padding: 3px; display: inline-flex; }
        .tagList:before { content: '#'; }
        .tagList:hover { cursor: pointer; transform: scale(1.24); background-color: black; color: white; }
        .tagListNo { border: 1px solid grey; border-radius: 8px; margin: 3px; padding: 3px; display: inline-flex; }
        .tagListNo:before { content: '#'; }

		.boardMiniCardTable { width: 100%; text-align: center; margin: 0px; padding: 0px; }
		.boardMiniCardTable th, .boardMiniCardTable td { border: 1px solid rgb(114, 184, 250); }
		.boardMiniCardTable th { border-left: 0px; }
		.boardMiniCardTable td { border-right: 0px; }

		.hattachmentList { text-decoration: none; color: olive; }
		.hattachmentList:hover { cursor: default; color: olive; text-decoration: none; }

		.pmArea { float: right; }
	</style>
	</head>
	<body>
		<jsp:include page="../../common/header.jsp" />
		<div class="content">
			<div class="mainContent">
				<div class="boardTitleBar">
					<div style="width: 100%; display: flex">
						<div class="boardTitleBarImg"><img src="resources/file_upload/company/<fmt:formatNumber value='${sessionScope.hb.companyNo}' pattern='00000000' />.jpg" onerror="this.src='resources/image/white.jpg'" width="30px" height="30px"></div>
						&nbsp;&nbsp;<h4 onclick="location.href='listView.hb?cpage=1&search=${sessionScope.co.companyName}&sort=new&career=none&education=none&tag=&where=all&viewOn=f'">${sessionScope.co.companyName}</h4>
					</div>
					<h3>${sessionScope.hb.hboardTitle}</h3><br>
				</div>
				<div class="boardContentBar">
					<div class="boardContentArea">
						<div class="boardContentThumb">
							<img src="${sessionScope.ht.hattachmentPath}/${sessionScope.ht.hattachmentChange}" onerror="this.src='resources/image/white.jpg'" width="100%" height="100%">
						</div>
						<div class="boardContentTag">
							<c:if test="${ empty sessionScope.hr}">
                                <span class="tagListNo">태그없음</span>
                            </c:if>
                            <c:forEach var="tag" items="${sessionScope.hr}">
                                <span class="tagList" onclick="location.href='listView.hb?cpage=1&search=&sort=new&career=none&education=none&tag=${tag.tagsNo}&where=all&viewOn=f'">${tag.tagsNo}</span>
                            </c:forEach>
						</div>
						<div class="boardContentContent">
							<pre style="overflow: auto; width: 100%; height: 100%;">${sessionScope.hb.hboardContent}</pre>
						</div>
						<div class="boardContentMap">
							<h4 style="border: 2px solid khaki; border-radius: 20px; width: 480px; text-align: center; padding: 2px;" onclick="location.href='listView.hb?cpage=1&search=&sort=new&career=none&education=none&tag=&where=${sessionScope.where}&viewOn=f'">${sessionScope.geo.addr}</h4>
							<h6>우편번호 : ${sessionScope.hb.hboardLocation}</h6>
							<p style="margin-top:-12px"><em class="link"><a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">지도가 표시되지 않는 경우</a></em></p>
							<div class="tMap" id="tMap" style="width:100%;height:330px;"></div>
						</div>
					</div>
					<div class="boardMiniArea">
						<div class="boardMiniCard">
							<h6>${sessionScope.hb.hboardTitle}</h6>
							<p style="float: right;">${sessionScope.co.companyName}</p><br>
							<div style="box-sizing: border-box; padding: 0px; margin: 0px;">
								<table class="boardMiniCardTable">
									<thead></thead>
									<tbody>
										<tr>
											<th width="20" style="border-top: 0px;">기간</th>
											<td width="80" style="border-top: 0px;">${sessionScope.hb.hboardStart}<br>${sessionScope.hb.hboardEnd}</td>
										</tr>
										<tr>
											<th>경력</th>
											<td>
												<c:if test="${sessionScope.hb.hboardCareer eq 'none'}">경력무관</c:if>
												<c:if test="${sessionScope.hb.hboardCareer eq 'intern'}">인턴</c:if>
												<c:if test="${sessionScope.hb.hboardCareer eq 'newcomer'}">신입</c:if>
												<c:if test="${sessionScope.hb.hboardCareer eq 'junior'}">주니어</c:if>
												<c:if test="${sessionScope.hb.hboardCareer eq 'middle'}">미들</c:if>
												<c:if test="${sessionScope.hb.hboardCareer eq 'senior'}">시니어</c:if>
											</td>
										</tr>
										<tr>
											<th>학력</th>
											<td>
												<c:if test="${sessionScope.hb.hboardEducation eq 'none'}">학력무관</c:if>
												<c:if test="${sessionScope.hb.hboardEducation eq 'highSchool'}">고등학교 졸업</c:if>
												<c:if test="${sessionScope.hb.hboardEducation eq 'juniorCollege'}">전문대학 졸업</c:if>
												<c:if test="${sessionScope.hb.hboardEducation eq 'university'}">대학 졸업</c:if>
												<c:if test="${sessionScope.hb.hboardEducation eq 'master'}">석사 이상</c:if>
												<c:if test="${sessionScope.hb.hboardEducation eq 'doctor'}">박사 이상</c:if>
												<c:if test="${sessionScope.hb.hboardEducation eq 'professor'}">교수 및 연구원</c:if>
											</td>
										</tr>
										<tr>
											<th>연봉</th>
											<td>${sessionScope.hb.hboardSalary}</td>
										</tr>
										<tr>
											<th>대표</th>
											<td>${sessionScope.co.companyOwner}</td>
										</tr>
										<tr>
											<th>EMAIL</th>
											<td>${sessionScope.co.companyEmail}</td>
										</tr>
										<tr>
											<th>직원수</th>
											<td>${sessionScope.co.companyWorker}</td>
										</tr>
										<tr>
											<th>조회수</th>
											<td>${sessionScope.hb.hboardViews}</td>
										</tr>
										<tr>
											<th>찜수</th>
											<td>${sessionScope.wish}명</td>
										</tr>
										<tr>
											<th style="border-bottom: 0px;">개요</th>
											<td style="border-bottom: 0px;">${sessionScope.co.companyInfo}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="boardMiniAttach">
							<h4 style="color: plum;">첨부파일</h4>
							<c:if test="${sessionScope.hb.companyNo eq sessionScope.loginCompany.companyNo}">
								<div class="pmArea"><i class="fa fa-plus" aria-hidden="true" onclick="$('#addFile').click();;"></i></div>
								<input type="file" style="visibility: hidden;" id="addFile" name="addFile" onchange="addAttachment(this);">
							</c:if>
							<br><br>
							<c:if test="${ empty sessionScope.ha}"><h5 style="color: black;">표기할 첨부파일이 없습니다.</h5></c:if>
							<c:forEach var="att" items="${sessionScope.ha}">
                                <a href='${att.hattachmentPath}/${att.hattachmentChange}' class="hattachmentList" download>${att.hattachmentOrigin}</a>&nbsp;&nbsp;
								<c:if test="${sessionScope.hb.companyNo eq sessionScope.loginCompany.companyNo}">
									<div class="pmArea"><i class="fa fa-minus" aria-hidden="true" onclick="minusAttachment('${att.hattachmentNo}');"></i></div>
								</c:if>
								<br>
                            </c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="subContent">
				<c:if test="${sessionScope.hb.companyNo eq sessionScope.loginCompany.companyNo}">
					<div style="float: right;">
						<form action="updateForm.hb" method="post">
							<input type="hidden" name="hboardNo" value="${sessionScope.hb.hboardNo}">
							<input type="hidden" name="companyNo" value="${sessionScope.co.companyNo}">
							<button type="submit" class="btn btn-warning">수정하기</button>
						</form>
						&nbsp;&nbsp;
						<form action="deleteForm.hb" method="post">
							<input type="hidden" name="hboardNo" value="${sessionScope.hb.hboardNo}">
							<input type="hidden" name="companyNo" value="${sessionScope.co.companyNo}">
							<button type="submit" class="btn btn-danger">삭제하기</button>
						</form>
					</div>
				</c:if>
			</div>
		</div>
		<script type="text/javascript">
			var mapContainer = document.getElementById('tMap')
			kakao.maps.load(function() {
				const  map = new kakao.maps.Map(mapContainer, { center: new kakao.maps.LatLng('${sessionScope.geo.lat}', '${sessionScope.geo.lng}'), level: 3 });
				var geocoder = new kakao.maps.services.Geocoder();

				geocoder.addressSearch('${sessionScope.geo.addr}', function(result, status) {
					if (status === kakao.maps.services.Status.OK) {
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						var marker = new kakao.maps.Marker({map: map, position: coords});
						var infowindow = new kakao.maps.InfoWindow({content: '<div style="width:150px;text-align:center;padding:6px 0;"><b style="color: #5271FF">${sessionScope.co.companyName}</b></div>'});
						infowindow.open(map, marker);
						map.setCenter(coords);
					} 
				});  
			});
			function getParameter(name) {
                name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
                var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
                return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
            }
			function addAttachment(input) {
				var formData = new FormData();
				formData.append("uploadFiles", input.files[0]);
				$.ajax({
					type : "POST",
					url : "addFile.hb",
					processData: false,
					contentType: false,
					data : formData,
					success : function(result) { alert(result); location.href="/coddy/boardDetail.hb?hno=${sessionScope.hb.hboardNo}"; },
					error : function(xhr, status, error) { alert(error); }
				})
			}
			function minusAttachment(e) {
				$.ajax({
					type : "POST",
					url : "minusFile.hb",
					data : { ano : e },
					success : function(result) { alert(result); location.href="/coddy/boardDetail.hb?hno=${sessionScope.hb.hboardNo}"; },
					error : function(xhr, status, error) { alert(error); }
				})
			}
		</script>
		<jsp:include page="../../common/footer.jsp" />
	</body>
</html>