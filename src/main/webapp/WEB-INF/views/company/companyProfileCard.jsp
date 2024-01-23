<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>${sessionScope.loginCompany.companyName} 기업정보</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  	<link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700,900&display=swap" rel="stylesheet">
	<style>
		body { font-family: 'Roboto', sans-serif; background: #fbfbfb; }
		.profile-widget {
			width: 400px;
			margin: 0 auto;
			background-color: #fff;
			border: 1px solid #00BCD4;
			border-radius: 14px;
			text-align: center;
			color: #00BCD4;
		}
		.cover-img { max-height: 200px; overflow: hidden; width: 100%; }
		.user-details{ padding: 0px 20px 30px; }
		.profile-widget h3 { color: #00BCD4; margin: 20px 0px 10px; }
		.profile-widget img { width: 100%; max-width: 100%; height: auto; display: block; }
		.user-img {
			width: 100px;
			height: 100px;
			border-radius: 100%;
			overflow: hidden;
			box-shadow: 0px 0px 4px 0px #808080;
			border: 4px solid #fff;
			margin: 0 auto;
			margin-top: -60px;
			position: relative;
			z-index: 999;
		}
		.followers h3 {
			width: 49%;
			float: left;
			padding: 6px 0px;
			border: 1px dashed #838383;
			border-radius: 144px;
			font-size: 18px;
		}
		.followers h3:last-child{ float: right; }
		.followers h3 span { font-weight: normal; font-size: 16px; }
		button.follow-btn {
			font-size: 19px;
			background: #00BCD4;
			border: none;
			color: #fff;
			padding: 10px 15px;
			margin: 20px 0px 0px;
			width: 100%;
			cursor: pointer;
		}
		button.follow-btn:hover{ opacity: 0.8; }
		h2.widget-heading { font-size: 25px; font-weight: normal; margin: 20px 0px 10px; padding: 0px 0px 10px; }
		@media (max-width: 767px){ .profile-widget { width: 90%; }
	}
	</style>
	</head>
	<body>
        <div class="profile-widget">
            <h2 class="widget-heading">About Business...</h2>
            <div class="cover-img"><label for="chooseFileBg"><img src="resources/file_upload/company_bg/<fmt:formatNumber value='${sessionScope.loginCompany.companyNo}' pattern='00000000' />.jpg" onerror="this.src='resources/image/white.jpg'" onclick="" id="uploadFilesBg"></label></div>
            <div class="user-details">
                <div class="user-img">
                    <form method="post" enctype="multipart/form-data">
                        <label for="chooseFile">
                            <div id="canvas">
                                <c:choose>
                                    <c:when test="${sessionScope.loginCompany.companyPhotoExtend eq 'jpg'}">
										<img src="resources/file_upload/company/<fmt:formatNumber value='${sessionScope.loginCompany.companyNo}' pattern ='00000000' />.jpg" onerror="this.src='resources/image/company/uploadFile.jpg'" id="uploadFiles">
                                    </c:when>
                                    <c:otherwise>
										<img src="resources/image/company/uploadFile.jpg" id="uploadFiles">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </label>
                        <input type="file" id="chooseFile" name="chooseFile" accept="image/*" onchange="loadFile(this);" style="visibility: hidden;">
						<input type="file" id="chooseFileBg" name="chooseFileBg" accept="image/*" onchange="loadFileBg(this);" style="visibility: hidden;">
                    </form>
                </div>
                <div id="fileName"></div>
                <h3>대표자 : ${sessionScope.loginCompany.companyOwner}</h3>
                <p>${sessionScope.loginCompany.companyInfo}</p>
                <div class="followers">
                    <h3>${sessionScope.loginCompany.companyWorker}<br><span>직원수</span></h3>
                    <h3>${sessionScope.howManyWritten}<br><span>작성글수</span></h3>
                </div>
                <button class="follow-btn" onclick="location.href='updateForm.cp'">내 정보 수정</button>
            </div>
            Image by <a href="https://www.freepik.com/free-photo/empty-room-with-chairs-desks_15501155.htm#query=office&position=4&from_view=search&track=sph&uuid=bc5b64e6-870d-4c59-a1d8-d8ba1d700a20">Freepik</a>
            <c:choose>
                <c:when test="${sessionScope.loginCompany.companyPhotoExtend}">
                    <a href="https://www.freepik.com/free-vector/illustration-uploading-icon_2609994.htm#page=3&query=upload%20file&position=34&from_view=search&track=ais&uuid=9266a4ed-f875-4e8e-a066-016287752433">Image by rawpixel.com</a> on Freepik
                </c:when>	
            </c:choose>
        </div>
        <script>
			function loadFile(input) {
				var files = input.files;
				$("#uploadFiles").attr("src", URL.createObjectURL(files[0]));

				var formData = new FormData();
				formData.append("uploadFiles", files[0])

				$.ajax({
					type : "POST",
					url : "uploadFile.cp",
					processData: false,
					contentType: false,
					data : formData,
					success : function(result) { alert(result); },
					error : function(xhr, status, error) { alert(error); }
				});
			};
			function loadFileBg(input) {
				var files = input.files;
				$("#uploadFilesBg").attr("src", URL.createObjectURL(files[0]));

				var formData = new FormData();
				formData.append("uploadFiles", files[0])

				$.ajax({
					type : "POST",
					url : "uploadFileBg.cp",
					processData: false,
					contentType: false,
					data : formData,
					success : function(result) { alert(result); },
					error : function(xhr, status, error) { alert(error); }
				});
			};
		</script>
    </body>
</html>