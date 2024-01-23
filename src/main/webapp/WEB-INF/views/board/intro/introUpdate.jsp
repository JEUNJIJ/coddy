<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<style>

.content_title{
    text-align: center;
    height: 200px;
}
.content_1{
    height: 350px;
    border-top: 1px solid #e8e8e8;
    padding-top: 30px;
}
.content_left{
    width: 65%;
    float: left;
    padding-left: 20px;
}

.content_right{
    float: right;
    width: 35%;
}
/* 프로젝트 상태(모집) */
.project_status{
    box-sizing: border-box;
    width: 55px;
    margin-left: 10px;
    display: inline-block;
    font-size: 12px;
    border: 1px solid #e8e8e8;
    border-radius: 100px;
}
/* 프로젝트 좋아요 */

.project_like{
    margin-top: 10px;
}
.project_like span{
    margin-left: 30px;
    font-size: 15px;
    color: gray;
}
.container input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
  height: 0;
  width: 0;
}

.container {
  display: inline-block;
  position: relative;
  cursor: pointer;
  font-size: 20px;
  user-select: none;
  transition: 100ms;
  width: 10px;
}

.checkmark {
  top: 0;
  left: 0;
  height: 2em;
  width: 2em;
  transition: 100ms;
  animation: dislike_effect 400ms ease;
}

.container input:checked ~ .checkmark path {
  fill: #FF5353;
  stroke-width: 0;
}

.container input:checked ~ .checkmark {
  animation: like_effect 400ms ease;
}

.container:hover {
  transform: scale(1.1);
}

@keyframes like_effect {
  0% {
    transform: scale(0);
  }

  50% {
    transform: scale(1.2);
  }

  100% {
    transform: scale(1);
  }
}

@keyframes dislike_effect {
  0% {
    transform: scale(0);
  }

  50% {
    transform: scale(1.2);
  }

  100% {
    transform: scale(1);
  }
}



/* 프로젝트 사진 스크롤 */
.photo-scroll {
  margin-top: 80px;
  overflow-x: scroll;
  white-space: nowrap;
}

.photo-scroll-image {
  width: 300px;
  height: 200px;
  border-radius: 10px;
  margin: 0 12px;
  border: 1px solid lightgray;
}

/* 포지션 현황 */
.position_status td{
    text-align: left;
}
.position_status{
    margin-left: 30px;
    margin-top: 30px;
}

.position_button {
    font-family: monospace;
    background-color: #f3f7fe;
    color: #3b82f6;
    border: none;
    border-radius: 8px;
    width: 80px;
    height: 32px;
    transition: .3s;
  }
  
  .position_button:hover {
    background-color: #3b82f6;
    box-shadow: 0 0 0 5px #3b83f65f;
    color: #fff;
  }

  /* 기술태그 */
  .tag_card {
    width: 80%;
    height: 250px;
    margin: 30px;
    background: #EEF5FF;
    padding: 10px;
    display: flex;
    flex-wrap: wrap;
    color: #5271FF;
    border-radius: 15px;
    box-shadow: -20px 20px 0px -5px #5271FF;
  }
  .card__tags {
    overflow: auto;
    height: 80%;
  }
  .title {
    font-weight: 900;
    font-size: 1.7em;
  }

  .tag__name {
    display: inline-block;
    color: #fff;
    font-size: 1.1em;
    background-color: #5271FF;
    padding: 6px 23px 9px;
    border-radius: 70em;
    margin: 8px 6px 8px 0;
    margin-left: 0px;
    position: relative;
    text-transform: lowercase;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
  }

  .tag__name::before,
  .tag__name::after {
    content: "";
    display: inline-block;
    position: absolute;
    top: 40%;
    width: 7px;
    height: 7px;
    border-radius: 50%;
    background: #fff;
  }

  .tag__name::before {
    left: 7px;
  }

  .tag__name::after {
    right: 7px;
  }

  .tag__name:hover {
    transform: scale(1.1);
    background-color: #51572c;
  }

  .content_4{
    margin-top: 80px;
  }

  #project_info{
    margin-top: 50px;
  }
  
  .img_file{
    border: 1px solid #cacaca;
    border-radius: 2px;
    display: inline-block;
    text-align: center;
    margin: auto;
}
.img_name{
    display: inline-block;
}
	.img{
    border: 2px dashed #cacaca;
}

.question textarea {
  border-radius: 8px;
  height: 500px;
  width: 100%;
  resize: none;
  outline: 0;
  padding: 8px 14px;
  border: 1px solid rgb(219, 213, 213);
}
	  
</style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />	
    <div class="content" style="height: 2000px;">
    <form id="enrollForm" method="post" action="introinsert.bo" enctype="multipart/form-data">
       <br><br><br><br><br>
        <div class="content_1">
        <div class="content_left">
            <h2>글 작성</h2>   
            <table class="position_status">
            	  
                <tbody>
                 	<tr>
	                        <th><label for="title"></label></th>
	                        <td style="width : 500px; padding-bottom : 30px;"><input type="text" id="iboardTitle" value="${i.iboardTitle}" class="form-control" name="iboardTitle" placeholder="제목을 입력하세요" required></td>
	                    </tr>
	             
	                    <tr>
	                        <th><label for="content"></label></th>
	                        <td><textarea id="iboardContent" class="form-control" rows="10" value="${i.iboardContent}" style="resize:none;" name="iboardContent" placeholder="내용을 입력하세요" required></textarea></td>
	                    </tr>
	                    	<input type="hidden" name="projectNo" value="${projectNo}" id="projectNo">
                </tbody>
            </table> 
        </div>

        <div class="content_right">
            <h2>기술/언어</h2>

            <div class="tag_card">
              <span class="title">All tags</span>
              <div class="card__tags">
                <ul class="tag">
                  <c:forEach var="tag" items="${requestScope.tags}" varStatus="status">
                    <li class="tag__name">${tag.tagsNo}</li>
                  </c:forEach>
                </ul>
              </div>
            </div>
            
         </div>
     </div>
		<br><br><br><br><br><br><br>
		<h3>프로젝트 기간 : ${requestScope.p.projectStart} ~ ${requestScope.p.projectEnd }</h3>
		<br><br>
      <div clas="content_3">
          <div class="photo-scroll">
              <image class="photo-scroll-image" src="${requestScope.thumOne.getRAttachmentPath()}/${requestScope.thumOne.getRAttachmentChange()}"/>
              
              <c:forEach var="img" items="${requestScope.thumList}" varStatus="status">
                <image class="photo-scroll-image" src="${img.getRAttachmentPath()}/${img.getRAttachmentChange()}"/>
              </c:forEach>
          </div>
          <br>
      </div>
      <div class="content_4">
          <h3>스크린샷</h3>
	                <br>

	                <hr>
	              <div class="question">
                    <h3>대표이미지</h3>
                    <img style="cursor: pointer; border: 3px dotted lightgray;" id="titleImg" width="250" height="170" src="resources/image/white.jpg">
                    <img style="cursor: pointer; border: 3px dotted lightgray;" id="contentImg1" width="150" height="120" src="resources/image/white.jpg">
                    <img style="cursor: pointer; border: 3px dotted lightgray;" id="contentImg2" width="150" height="120" src="resources/image/white.jpg">
                    <img style="cursor: pointer; border: 3px dotted lightgray;" id="contentImg3" width="150" height="120" src="resources/image/white.jpg">
					<img style="cursor: pointer; border: 3px dotted lightgray;" id="contentImg4" width="150" height="120" src="resources/image/white.jpg">
					<img style="cursor: pointer; border: 3px dotted lightgray;" id="contentImg5" width="150" height="120" src="resources/image/white.jpg">
                  <div id="img_list">
                        <input type="file" id="file1" name="titleImg" accept="image/*" onchange="loadImg(this,1);"> 
                        <input type="file" id="file2" name="img" accept="image/*" onchange="loadImg(this,2);">
                        <input type="file" id="file3" name="img" accept="image/*" onchange="loadImg(this,3);">
                        <input type="file" id="file4" name="img" accept="image/*" onchange="loadImg(this,4);">
                        <input type="file" id="file5" name="img" accept="image/*" onchange="loadImg(this,5);">
                        <input type="file" id="file6" name="img" accept="image/*" onchange="loadImg(this,6);">
                 </div>
                    <br>
                    <span><b>사진을 넣어주세요. 총 6장 가능합니다.</b></span><br>
                  
                </div>         
	                  <br><br>
	<script>
				 $(function(){
					    $("#titleImg").click(function(){
					        $("#file1").click();
					    });
					    $("#contentImg1").click(function(){
					        $("#file2").click();
					    });
					    $("#contentImg2").click(function(){
					        $("#file3").click();
					    });
					    $("#contentImg3").click(function(){
					        $("#file4").click();
					    });
					    $("#contentImg4").click(function(){
					        $("#file5").click();
					    });
					    $("#contentImg5").click(function(){
					        $("#file6").click();
					    });
					    $("#img_list").hide();
					});
					function loadImg(inputFile, num){
					    if(inputFile.files.length == 1){
					        let reader = new FileReader();
					        reader.readAsDataURL(inputFile.files[0]);
					        reader.onload = function(e) {
					            switch(num){
					                case 1: $("#titleImg").attr("src",e.target.result);
					                        break;
					                case 2: $("#contentImg1").attr("src",e.target.result);
					                        break;
					                case 3: $("#contentImg2").attr("src",e.target.result);
					                        break;
					                case 4: $("#contentImg3").attr("src",e.target.result);
					                        break;
					                case 5: $("#contentImg4").attr("src",e.target.result);
			                        		break;
					                case 6: $("#contentImg5").attr("src",e.target.result);
			                        		break;
					            }
					        };
					    }else{
					        switch(num){
					            case 1: $("#titleImg").attr("src",null); 
					                    break;
					            case 2: $("#contentImg1").attr("src",null); 
					                    break;
					            case 3: $("#contentImg2").attr("src",null); 
					                    break;
					            case 4: $("#contentImg3").attr("src",null); 
					                    break;
					            case 5: $("#contentImg4").attr("src",null); 
			                    		break;
					            case 6: $("#contentImg5").attr("src",null); 
			                    		break;
					            }
					        }
					    }
					    // 파일 추가
					    function addFile() {
					            var str = "<div class='file-group'><input type='file' name='files' accept='image/*'><a href='#this' name='file-delete'>삭제</a></div>";
					            $(".img_list").append(str);

					            $("a[name='file-delete']").on("click", function(e) {
					                e.preventDefault();
					                deleteFile($(this));
					            }); 
					        }
					    // 파일 삭제
					    function deleteFile(obj) {
					        obj.parent().remove();
					    }
					    

					    $(document).ready(function() {
					        $("a[name='file-delete']").on("click", function(e) {
					            e.preventDefault();
					            deleteFile($(this));
					        });
					    });
				    </script>
        <br><br>
      </div>
      <div align="center">
	      <button type="submit" class="btn btn-warning">등록하기</button>
	    </div>
    </form>
  </div>
  <jsp:include page="../../common/footer.jsp" />	
</body>