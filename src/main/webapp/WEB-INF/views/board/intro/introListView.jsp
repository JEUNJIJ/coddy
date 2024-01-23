<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트소개</title>
<style>

   #pagingArea{
   width:fit-content; 
   margin:auto;
  }

  .content_1{
    width: 1200px;
    height: 250px;
  }
  .popular-project{
    width: 100%;
    height: 100%;  
    float: left;
  }

  .popular-project-list{
    height: 220px;
    padding: 13px 24px;
    border: 1px lightgray solid;
    border-radius: 8px;
    box-sizing: border-box;
  }

  .popular-project-list h2{
    font-size: 14px;
    width: 100%;
    font-weight: 500;
  }


  .content_1 h1{
    font-size: 22px;
    color: #333;
  }

  .popular-project-list{
    height: 220px;
    padding: 13px 24px;
    border: 1px lightgray solid;
    border-radius: 8px;
    box-sizing: border-box;
    margin-right: 20px;
  }

  /* swiper 이미지 영역 사이즈 조절 */
  .swiper {
      width: 80%;
      height: 250px;
  }   

  /* 이미지 사이즈 조절 */
  .swiper-slide>img {
    width : 100%;
    height : 200px;
  }

  /* 화살표 버튼색 변경 (기본색은 파란색) */
  div[class^=swiper-button] {
    color : white;
    /* display : none;  */
  }

  /* 카드 css */
  .card {
    width: 350px;
    height: 250px;
    background: white;
    padding: .4em;
    border-radius: 6px;
    margin: 20px;
    margin-bottom: 20px;
    display : flex;
  }

  .card-image {
  	padding-top : 10px;
    width: 120px;
    height: 120px;
    border-radius: 6px 6px 0 0;
  }

  .card-image:hover {
    transform: scale(0.98);
  }

  .category:hover {
    cursor: pointer;
  }

  .heading {
    font-weight: 600;
    color: rgb(88, 87, 87);
    padding: 7px;
    display: flex;
  }

  .heading:hover {
    cursor: pointer;
  }

  .author {
    color: gray;
    font-weight: 400;
    font-size: 11px;
    padding-top: 20px;
    width: 80%;
    display: inline-block;
  }

  .name {
    font-weight: 600;
  }

  .card:hover {
    cursor: pointer;
  }
    

  .card-list{
    width: 100%;
    margin-top: 50px;
    border-top: 1px solid lightgray;
          
  }

  /* 검색바 */

  .search-bar{
    margin-top: 40px;
  }
  .search-input {
    border: 2px solid transparent;
    width: 15em;
    height: 2.5em;
    padding-left: 0.8em;
    outline: none;
    overflow: hidden;
    background-color: #F3F3F3;
    border-radius: 10px;
    transition: all 0.5s;
    margin-left: 5px;
  }

  .search-input:hover,
  .search-input:focus {
    border: 2px solid #5271FF;
    box-shadow: 0px 0px 0px 7px rgb(74, 157, 236, 20%);
    background-color: white;
  }

  @keyframes checkAnim {
    0% {
      height: 0;
    }

    100% {
      height: 10px;
    }
  }

  .custom-checkbox:checked ~ .search-checkmark:after {
    animation: checkAnim 0.2s forwards;
  }

  /* 페이징바 */
  .paging-area button:disabled{

    background-color : #5271FF;
    color : white;
  }
  .paging-area button{
    background-color : white;
    border-radius: 4px;
    border-width: 1px;
    margin: 2px;
    border-color: rgba(0,0,0,.125);
  }

  /* 좋아요 */
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
    font-size: 12px;
    user-select: none;
    transition: 100ms;
    padding-bottom: 10px;
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

  .write_button {
    font-family: monospace;
    background-color: #5271FF;
    color: #f3f7fe;
    border: none;
    border-radius: 8px;
    width: 80px;
    height: 35px;
    transition: .3s;
    float: right;
    margin-right: 35px;
    font-size: 12px;
  }

  /* 제목 */
  .title {
    padding-left : 20px;
    width : 90%;

  }
  
  .modal-content1 {
	  background-color: #fff;
	  padding: 20px;
	  border-radius: 10px; /* 둥근 테두리로 변경 */
	  max-width: 400px;
	  width: 100%;
	  margin: 10% auto; /* 화면 중앙에 표시 */
	  box-sizing: border-box;
	  position: relative; /* 상대 위치 설정 */
	  border: 1px solid #888;
	}
  
  	 .close-btn2 {
	  cursor: pointer;
	  position: absolute;
	  top: 10px;
	  right: 10px;
	  font-size: 24px; /* 조금 더 큰 크기로 변경 */
	  color: #333; /* 닫기 버튼 색상 변경 */
	}
  
  	    .comment-container {
      max-width: 600px;
      margin: 20px auto;
      font-family: Arial, sans-serif;
    }

    .comment {
      border: 1px solid #ddd;
      border-radius: 5px;
      padding: 10px;
      margin-bottom: 10px;
    }

    .comment-author {
      font-weight: bold;
      color: #333;
    }

    .comment-text {
      margin-top: 5px;
      color: #555;
    }

    .comment-date {
      font-size: 0.8em;
      color: #888;
    }
  
</style>
</head>
<div>
  <jsp:include page="../../common/header.jsp" />	
  <div class="content">
    <div class="content_title">
      <h2>프로젝트 소개</h2>
    </div>
    <div class="content_1">
      <div class="popular-project">
        <h1>인기 프로젝트</h1>
        <div class="popular-project-list">
          <div class="swiper">
            <!-- Additional required wrapper -->
            <div class="swiper-wrapper">
              <!-- Slides -->
              <div class="swiper-slide" id="slide0"></div>
              <div class="swiper-slide" id="slide1"></div>
              <div class="swiper-slide" id="slide2"></div>
            </div>
            
            <!-- If we need pagination -->
            <div class="swiper-pagination"></div>
        
            <!-- If we need navigation buttons -->
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
          </div>
        </div>

      </div>
    </div>

      <div style="width: 90%; margin: auto;">
      </div>
      <br><br>
 		
       <div id="search-area" style="float: right; display: flex; margin-top: 2%; margin-bottom: 2%;">
       <!--  
    <form action="search.bo" method="get" style="display: flex;">
        <select name="condition" id="condition" style="height : 45px;">
            <option value="MEMBER_ID" selected>작성자</option>
            <option value="IBOARD_TITLE">제목</option>
            <option value="IBOARD_CONTENT">내용</option>
        </select>
        &nbsp;
        <input type="search" style="height" value="${requestScope.keyword}" class="form-control form-control-lg" id="keyword" name="keyword">
        &nbsp;&nbsp;
        <button type="submit" style="width : 80px;">검색</button>
    </form>
      -->
	<br><br>
    		
    		
    		
    		
    </div>
    <br><br><br><br>

    
    <div class="">
    <c:if test="${not empty sessionScope.loginMember}">
      <button class="write_button" onclick="openModal()">게시글 작성</button>
    </c:if>
    </div>
    
    <div class="content_2">
      <div class="card-list">
        <c:forEach var="i" items="${requestScope.list}" varStatus="status">
        <div class="card">
        <div class="cardTop">
        <div class="heading" onclick="location.href='introDetail.bo?ino=${i.iboardNo}'">

              <div class="card-image">
              <img src="${requestScope.listi[status.index].getIAttachmentPath()}/${requestScope.listi[status.index].getIAttachmentChange()}" width="100%" height="100%"onerror="this.src='resources/image/white.jpg'">
              </div>
              <div>
              	<div class="title" ><h5 style="width : 200px;"><b>[프로젝트]</b><br>${i.iboardTitle}</h5></div>
              	<br>
              	<c:forEach var="tag" items="${requestScope.tags}" varStatus="status">
              	<div class="title"><p style="font-size: 12px;">${tag.tagsNo}</p></div>
              	</c:forEach>
              </div>
              </div>
            
                             
           
            <div class="notHeading">

              <div class="author"> By <span class="name"><b>${i.iboardWriter}</b></span>
              <br> ♥ : ${requestScope.like} 
              <br><i class="fas fa-eye" style="line-height: 18px; margin-left: 3px;"></i>&nbsp; ${i.iboardViews}<br>	 작성일 :  ${i.iboardInsert}
              
              </div>
			           
            <c:if test="${not empty sessionScope.loginMember}">
	         	<c:choose>
	            	<c:when test="${requestScope.ws_list[status.index]}">
		              <label class="container">
		                <input type="checkbox" checked="checked" name="favorite" onclick="onWish('${i.iboardNo}');">
		                <div class="checkmark">
		                  <svg viewBox="0 0 256 256">
		                  <rect fill="none" height="512" width="512"></rect>
		                  <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
		                </div>
		              </label>
		            </c:when>
		           <c:otherwise>
		             <label class="container">
		               <input type="checkbox" name="favorite" onclick="onWish('${i.iboardNo}');">
		                <div class="checkmark">
		                  <svg viewBox="0 0 256 256">
		                  <rect fill="none" height="512" width="512"></rect>
		                  <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
		                </div>
		             </label>
		           </c:otherwise>
	          </c:choose>
         </c:if>  
                
          </div>
           
        </div>
      </div>
           </c:forEach>

      </div>

      <br><br><br><br><br>

            
       <div id="pagingArea">
            <ul class="pagination" style="margin: auto;">
            
              <c:choose>
                <c:when test="${ requestScope.pi.currentPage eq 1 }">
                    <li class="page-item disabled">
                      <a class="page-link" href="#">Previous</a>
                    </li>
                  </c:when>
                  <c:otherwise>
                    <li class="page-item">
                      <a class="page-link" href="introlist.bo?cpage=${ requestScope.pi.currentPage - 1 }">Previous</a>
                    </li>
                  </c:otherwise>
                </c:choose>
                
                <c:forEach var="p" begin="${ requestScope.pi.startPage }" 
                          end="${ requestScope.pi.endPage }"
                          step="1">
                  <li class="page-item">
                    <a class="page-link" href="introlist.bo?cpage=${ p }">${ p }</a>
                  </li>
                </c:forEach>
                
                <c:choose>
                  <c:when test="${ requestScope.pi.currentPage eq requestScope.pi.maxPage }">
                    <li class="page-item disabled">
                      <a class="page-link" href="#">Next</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                      <a class="page-link" href="introlist.bo?cpage=${ requestScope.pi.currentPage + 1 }">Next</a>
                    </li>
                </c:otherwise>
              </c:choose>
            
            </ul>
          </div>
  </div>
  <script>
    $(function(){
      $(".card").css("display", "inline-block");
      $(".container").css("width","0%");
    });
    
    $(document).ready(function() {
        $("#introSearch").val(getParameter("search"));
        $("#introSort").val(getParameter("sort"));
        tagifyAll.addTags(getParameter("tag"));
    })
    
   function onWish(e) {
            $.ajax({
		url: "introWish.hb",
 				type: "get",
		data: {iboardNo: e},
		success: function(result) { console.log(result); },
		error: function() { console.log("좋아요 실패"); }
		});
            
   }
    
   function onSearch() {
        let cpage = 1;
        let search = $("#introSearch").val();
        let sort = $("#introSort").val();
        let tag = $("#tagAllName").val();
        tag = replaceAll(replaceAll(replaceAll(replaceAll(replaceAll(replaceAll(tag, "[", ""), "]", ""), "{", ""), "}", ""), "\"value\":", ""), "\"", "");
        location.href='introlist.bo?cpage='+cpage+'&search='+search+'&sort='+sort+'&tag='+tag;
   }
   function getParameter(name) {
       name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
       var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search);
       return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
   }
   
   function replaceAll(str, searchStr, replaceStr) { return str.split(searchStr).join(replaceStr); }
   
   function openModal() {
	    document.getElementById('listModal').style.display = 'flex';
   }
   
	function closeModal() {
	    document.getElementById('listModal').style.display = 'none';
	}
	
	$(function() {
		$("#search-area option[value=${requestScope.condition}]")
									.attr("selected", true);
	});
	
	
	
	
</script>
	</div>
  <jsp:include page="../../common/footer.jsp" />	
  
  		<div id="listModal" class="modal">
		  <div class="modal-content1">
		    <span class="close-btn2" onclick="closeModal()">&times;</span>
		    
				<div class="comment-container">
				<c:forEach var="b" items="${projectlist}">
					  <div class="comment" onclick="location.href='introForm.bo?projectno=${b.projectNo}'">
					    <div class="comment-author">${b.projectName}</div>
					    <div class="comment-text">${b.projectOwner}</div>
					    <div class="comment-date">${b.projectStart} ~ ${b.projectEnd}</div>
					  </div>
				</c:forEach>
        <c:if test="${empty projectlist}">
          <div class="comment">
            제출 가능한 프로젝트가 없습니다.
          </div>
        </c:if>
		    <div id="delete">
		    </div>
		  </div>
		</div>
	</div>
	
	<script>
	   $.ajax({
      url:"recent.iec",
      type:"get",
      data:{},
      success:function(result){

        let resultStr = "";
        for(let i = 0; i < result.length; i++) {
          let path = result[i].iAttachmentPath+ "/"+ result[i].iAttachmentChange;
          let el = "#slide"+i;
          resultStr="<img src='"+path+"'>";
          $(".swiper-wrapper>"+el).html(resultStr);
        } 
       
      }
    });
    // 슬라이더 동작 정의
    const swiper = new Swiper('.swiper', {
                  autoplay : {
                      delay : 3000 // 3초마다 이미지 변경
                  },
                  loop : true, //반복 재생 여부
                  slidesPerView : 1, // 이전, 이후 사진 미리보기 갯수
                  pagination: { // 페이징 버튼 클릭 시 이미지 이동 가능
                      el: '.swiper-pagination',
                      clickable: true
                  },
                  navigation: { // 화살표 버튼 클릭 시 이미지 이동 가능
                      prevEl: '.swiper-button-prev',
                      nextEl: '.swiper-button-next'
                  }
              });
              
      
    </script>
</body>
</html>