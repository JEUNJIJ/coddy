<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>게시판 수정중</title>
	<style>
		.formDiv { width: 100%; margin: 20px; padding-top: 10px; border: 1px solid gray; }
		.inputTable { text-align: center; }
		.inputTable tr { width: 20%; }
		.inputTable td { width: 80%; }
		.inputTable input { width: 100%; }
		.inputTable textarea { width: 100%; }
		.inputTable select { width: 100%; }

		/* 태그 개인 설정 */
		tags { width: 100%; color: darkgoldenrod; }
		.tags-look .tagify__dropdown__item {
			display: inline-block; border-radius: 3px; padding: .3em .5em; border: 1px solid #CCC;
			background: #F3F3F3; margin: .2em; font-size: .85em; color: black; transition: 0s;
		}
		.tags-look .tagify__dropdown__item--active { color: black; }
		.tags-look .tagify__dropdown__item:hover { background: lightyellow; border-color: gold; }
		.tagify__tag { background-color: inherit; }
		.pageForm { width: 100%; height: 15%; }
	</style>
	</head>
	<body>
		<jsp:include page="../../common/header.jsp" />
		<div class="content">
			<div class="formDiv">
				<form action="update.hb" method="post" enctype="multipart/form-data" onsubmit="return onSubmit();">
					<table class="inputTable" style="width: 100%;">
						<h3 align="center">게시글 수정</h3>
						<thead>
						</thead>
						<tbody>
							<tr>
								<th>상호명</th>
								<td><input type="text" placeholder="" name="companyName" id="companyName" value="${sessionScope.loginCompany.companyName}" readonly>
								<input type="hidden" placeholder="" name="companyNo" id="companyNo" value="${sessionScope.loginCompany.companyNo}" required readonly></td>
							</tr>
							<tr>
								<th>제목 입력</th>
								<td><input type="text" placeholder="제목을 입력해주세요." name="hboardTitle" id="hboardTitle" value="${sessionScope.hb.hboardTitle}" required>
								<input type="hidden" placeholder="" name="hboardNo" id="hboardNo" value="${sessionScope.hb.hboardNo}"></td>
							</tr>
							<tr>
								<th>모집 날짜</th>
								<td>
									<input type="text" class="hboardCalendar" id="hboardCalendar" name="hboardCalendar" disabled required>
									<input type="hidden" id="hboardStart" name="hboardStart" value="${sessionScope.hb.hboardStart}" required readonly>
									<input type="hidden" id="hboardEnd" name="hboardEnd" value="${sessionScope.hb.hboardEnd}" required readonly>
								</td>
							</tr>
							<tr>
								<th>내용 입력</th>
								<td><textarea name="hboardContent" id="hboardContent" cols="30" rows="10" required>${sessionScope.hb.hboardContent}</textarea></td>
							</tr>
							<tr>
								<th>연봉정보입력</th>
								<td><input type="number" placeholder="연봉 정보를 입력해주세요." name="hboardSalary" id="hboardSalary" value="${sessionScope.hb.hboardSalary}" required></td>
							</tr>
							<tr>
								<th>경력선택</th>
								<td>
									<select name="hboardCareer" id="hboardCareer" size="">
										<c:choose>
											<c:when test="${sessionScope.hb.hboardCareer eq 'none'}">
												<option value="none" selected>경력무관</option>
											</c:when>
											<c:otherwise>
												<option value="none">경력무관</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardCareer eq 'intern'}">
												<option value="intern" selected>인턴</option>
											</c:when>
											<c:otherwise>
												<option value="intern">인턴</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardCareer eq 'newcomer'}">
												<option value="newcomer" selected>신입</option>
											</c:when>
											<c:otherwise>
												<option value="newcomer">신입</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardCareer eq 'junior'}">
												<option value="junior" selected>주니어</option>
											</c:when>
											<c:otherwise>
												<option value="junior">주니어</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardCareer eq 'middle'}">
												<option value="middle" selected>미들</option>
											</c:when>
											<c:otherwise>
												<option value="middle">미들</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardCareer eq 'senior'}">
												<option value="senior" selected>시니어</option>
											</c:when>
											<c:otherwise>
												<option value="senior">시니어</option>
											</c:otherwise>
										</c:choose>
									</select>
								</td>
							</tr>
							<tr>
								<th>필요학력입력</th>
								<td>
									<select name="hboardEducation" id="hboardEducation" size="">
										<c:choose>
											<c:when test="${sessionScope.hb.hboardEducation eq 'none'}">
												<option value="none" selected>학력무관</option>
											</c:when>
											<c:otherwise>
												<option value="none">학력무관</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardEducation eq 'highSchool'}">
												<option value="highSchool" selected>고등학교 졸업</option>
											</c:when>
											<c:otherwise>
												<option value="highSchool">고등학교 졸업</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardEducation eq 'juniorCollege'}">
												<option value="juniorCollege" selected>전문대학 졸업</option>
											</c:when>
											<c:otherwise>
												<option value="juniorCollege">전문대학 졸업</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardEducation eq 'university'}">
												<option value="university" selected>대학 졸업</option>
											</c:when>
											<c:otherwise>
												<option value="university">대학 졸업</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardEducation eq 'master'}">
												<option value="master" selected>석사 이상</option>
											</c:when>
											<c:otherwise>
												<option value="master">석사 이상</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardEducation eq 'doctor'}">
												<option value="doctor" selected>박사 이상</option>
											</c:when>
											<c:otherwise>
												<option value="doctor">박사 이상</option>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${sessionScope.hb.hboardEducation eq 'professor'}">
												<option value="professor" selected>교수 및 연구원</option>
											</c:when>
											<c:otherwise>
												<option value="professor">교수 및 연구원</option>
											</c:otherwise>
										</c:choose>
									</select>
								</td>
							</tr>
							<tr>
								<th>위치정보입력</th>
								<td>
									<input type="text" id="postcode" name="hboardLocation" placeholder="우편번호" value="${sessionScope.hb.hboardLocation}" readonly required>
									<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
									<script>
										let exitFlag = true;
										function execDaumPostcode() {
											new daum.Postcode({
												oncomplete: function(data) {									
													// 우편번호와 주소 정보를 해당 필드에 넣는다.
													document.getElementById('postcode').value = data.zonecode;
												}
											}).open();
										}
										function onSubmit() {
											if(!exitFlag) { alert("도로명 찾기를 해주세요."); return false; }
											if(tagifyAll.getTagElms()[0] == null) { alert("태그는 1개 이상 존재해야됩니다."); return false; }
											return exitFlag; 
										}
									</script>
								</td>
							</tr>
							<tr>
								<th>태그정보입력</th>
								<td style="text-align: left;">
									<jsp:include page="../../common/tagAll.jsp" />
								</td>
							</tr>
							<tr>
								<th>대표이미지 입력</th>
								<td>
									<label for="thumb" style="width: 100%; height: 100%;">
										<img src="${sessionScope.ha.hattachmentPath}/${sessionScope.ha.hattachmentChange}" onerror="this.src='resources/image/white.jpg'" id="uploadThumb" width="120px" height="60px">
										<input type="file" id="thumb" name="thumb" accept="image/*" onchange="loadThumb(this);" style="visibility: hidden;">
									</label>
									<script>
										function loadThumb(input) {
											var files = input.files;
											$("#uploadThumb").attr("src", URL.createObjectURL(files[0]));
										};
									</script>
								</td>
							</tr>
							<tr> 
								<th colspan="2"><button type="submit" style="margin:auto; display:block;">작성완료</button></th>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
		<jsp:include page="../../common/footer.jsp" />
		<script>
			$(function() {
				$(".hboardCalendar").daterangepicker({
					locale: {
						"separator": " - ",
						"format": 'YYYY-MM-DD',
						showMonthAfterYear:true,
						showOn:"both",
						numberOfMonths:[1,2],
						"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
						"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
						"applyLabel": "확인",
						"cancelLabel": "취소",
					},
					showDropdowns: true,
					cancelButtonClasses: "btn btn-outline-secondary",
					applyButtonClasses:"btn btn-outline-success",
					startDate: "${sessionScope.hb.hboardStart}",
					endDate: "${sessionScope.hb.hboardEnd}"
				});
				$("#hboardStart").val($(".hboardCalendar").val().split(" - ")[0]);
				$("#hboardEnd").val($(".hboardCalendar").val().split(" - ")[1]);
				$(".hboardCalendar").change(function() {
					$("#hboardStart").val($(this).val().split(" - ")[0]);
					$("#hboardEnd").val($(this).val().split(" - ")[1]);
				})
				tagifyAll.addTags("${sessionScope.tagList}");
				$('#hboardContent').summernote({
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
				function uploadSummernoteImageFile(file, editor) {
					data = new FormData();
					data.append("file", file);
					$.ajax({
						data : data,
						type : "post",
						url : "uploadSummernoteImageFile.hb",
						contentType : false,
						processData : false,
						success : function(data) {
							$(editor).summernote('insertImage', data);
						}
					});
				}
			});
		</script>
	</body>
</html>