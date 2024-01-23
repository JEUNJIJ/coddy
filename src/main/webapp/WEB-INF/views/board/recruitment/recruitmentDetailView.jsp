<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모집 상세</title>
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
.like_count{
  margin-left: 30px;
  margin-right: 30px;
  font-size: 15px;
  color: gray;
}
.view_count{
  margin-left: 12px;
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

  .fas{
    margin-left: 30px;
  }


/* 멤버 프로필 */
.content_5{
  margin-top: 80px;
}
.swiper{
      width: 100%;
    }
.swiper-wrapper{
  float: left;
}

</style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />	
    <div class="content" >
        <div class="content_title">
            <h2 style="margin-bottom: 10px;">${requestScope.r.recruitmentTitle}<span class="project_status"></span></h2>
            <span>${requestScope.r.recruitmentWriter}</span><br>
            <div class="project_like">
              <c:if test="${not empty sessionScope.loginMember}">
                <c:choose>
                  <c:when test="${requestScope.wish>0}">
                    <label class="container">
                        <input checked="checked" type="checkbox" onclick="onWish('${r.recruitmentNo}');">
                        <div class="checkmark">
                        <svg viewBox="0 0 256 256">
                        <rect fill="none" height="256" width="256"></rect>
                        <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                        </div>
                    </label>
                    <span class="like_count">${requestScope.likeCount}</span>
                    <i class="fas fa-eye" style="line-height: 30px; margin-left: 3px;"></i>
                    <span class="view_count">${r.recruitmentView}</span>
                  </c:when>
                  <c:otherwise>
                    <label class="container">
                      <input  type="checkbox" onclick="onWish('${r.recruitmentNo}');">
                      <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="256" width="256"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                      </div>
                  </label>
                    <span class="like_count">${requestScope.likeCount}</span>
                    <i class="fas fa-eye" style="line-height: 30px; margin-left: 3px;"></i>
                    <span class="view_count">${r.recruitmentView}</span>
                  </c:otherwise>  
               </c:choose>
              </c:if>
            </div>
        </div>
        <div class="content_1">
        <div class="content_left">
            <h2>모집 현황</h2>   
            <table class="position_status">
                <tbody>
                  <c:forEach var="state" items="${requestScope.state}" varStatus="status">
                    <tr>
                        <td colspan="2" style="width: 200px;">${state.position}</td>
                        <td style="width: 200px;"><span  id="applyState_${status.index}"></span> / ${state.maxPersonnel}</td>
                        <td colspan="2"><button class="position_button" id="position_button_${status.index}" data-toggle="modal" data-target="#apply_${status.index}">지원하기</button></td>
                    </tr>
                    <script>
                        $(function(){

                          if(${requestScope.p.projectReady} == 0){ // 프로젝트가 모집중이라면 실시간 채팅방 인원 조회
                            getApply('${p.projectNo}','${state.position}','${status.index}','${state.maxPersonnel}');
                            setInterval(function(){getApply('${p.projectNo}','${state.position}','${status.index}','${state.maxPersonnel}')},500);
                          }else{ // 프로젝트가 진행중이거나 완료되었다면 해당 프로젝트에 참여한 인원만 조회
                            getFixApply('${p.projectNo}','${state.position}','${status.index}','${state.maxPersonnel}');
                          } 
                      });
                      </script>
                    <div class="modal" id="apply_${status.index}">
                      <div class="modal-dialog">
                        <div class="modal-content">

                          <!-- Modal Header -->
                          <div class="modal-header">
                            <c:if test="${requestScope.p.projectReady}==0">
                            <h4 class="modal-title">지원하기</h4>
                          </c:if>
                          <h4 class="modal-title">입장하기</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                          </div>

                          <!-- Modal body -->
                          <div class="modal-body">
                            <c:if test="${requestScope.p.projectReady}==0">
                            <b>${state.position}</b> 에 지원하시겠습니까?
                            </c:if>
                            <b>${state.position}</b> 에 입장하시겠습니까?
                          </div>

                          <!-- Modal footer -->
                          <div class="modal-footer">
                            <c:if test="${requestScope.p.projectReady}==0">
                            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="insertApply('${p.projectNo}','${sessionScope.loginMember.memberNo}','${state.position}','${state.maxPersonnel}');">지원하기</button>
                            </c:if>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="insertApply('${p.projectNo}','${sessionScope.loginMember.memberNo}','${state.position}','${state.maxPersonnel}');">입장하기</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                          </div>

                        </div>
                      </div>
                    </div>

                  </c:forEach>
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
        <h2>소개</h2>
        <hr>
        <div id="project_info">
          ${requestScope.r.recruitmentContent}
        </div>
      </div>

      <c:choose>
        <c:when test="${requestScope.p.projectReady ne 0}">
        <div class="content_5">  
          <h2>멤버</h2>
          <hr>
          
          <div class="swiper">
                <div class="swiper-wrapper">     
                  <c:forEach var="f" items="${requestScope.fList}" varStatus="tagStatus">           
                    <div class="card swiper-slide">
                      <div class="card-border-top">
                      </div>
                      <div class="img">
                      </div>
                      <span style="margin: auto;">${f.memberName}</span>
                      <p class="job" style="margin: auto;">${f.role}</p>
                      <button style="margin: auto;" class="position_button" onclick='location.href="profile.me?mno=" + ${f.memberNo}'>프로필</button>
                    </div>  
                  </c:forEach>    
                </div>
              <div class="swiper-button-prev"></div>
              <div class="swiper-button-next"></div>
            </div>
          </div>
       </c:when>
      </c:choose>
          <script>
            const swiper = new Swiper('.swiper', {
                //기본 셋팅
                //방향 셋팅 vertical 수직, horizontal 수평 설정이 없으면 수평
                direction: 'horizontal',
                //한번에 보여지는 페이지 숫자
                slidesPerView: 7,
                //페이지와 페이지 사이의 간격
                spaceBetween: 10,
                //드레그 기능 true 사용가능 false 사용불가
                debugger: true,
                //마우스 휠기능 true 사용가능 false 사용불가
                mousewheel: true,                
                // 마지막 여백
                slidesOffsetAfter: 120,
                //방향표
                navigation: {
                  //다음페이지 설정
                  nextEl: '.swiper-button-next',
                  //이전페이지 설정
                  prevEl: '.swiper-button-prev',
                },
            });
          </script>

      
    
    </div>
    <jsp:include page="../../common/footer.jsp" />	
    
    <script>

      function state(){
        let state = "";
        if(${requestScope.p.projectReady}>0){
          state = "진행중";
          $(".project_status").css("backgroundColor","#FF5353");
          $(".project_status").css("color","white");
        }else{
          state = "모집중";
        }

        $(".project_status").text(state);
      }

      function onWish(e) {
        $.ajax({
          url: "boardWish.rec",
          type: "get",
          data: {recruitmentNo: e},
          success: function(result) {  }
        });
      }

      $(function(){
          state();
          $(".container").css("width","10px");          
      });

      function getApply(projectNo, position, i, maxPersonnel){
          $.ajax({
            url:"getApply.rec",
            type:"get",
            data:{
              projectNo : projectNo,
              position : position
            },
            success : function(result){
              if(result >= maxPersonnel){
                let btn = "#position_button_" + i ;
                $(btn).prop("disabled", true);
                $(btn).css("backgroundColor","lightgray");
                $(btn).text("완료");
                $("#applyState_"+i).text(result);
              }else{
                let applyStateEl = "#applyState_"+ i;
                let btn = "#position_button_" + i ;
                $(btn).prop("disabled", false);
                $(applyStateEl).text(result);
                $("#applyState_"+i).text(result);
              }
            },
            error : function(){
              console.log("지원 현황 불러오기 실패");
            }
          });
        }

        function getFixApply(projectNo, position, i, maxPersonnel){
          $.ajax({
            url:"getFixApply.rec",
            type:"get",
            data:{
              projectNo : projectNo,
              position : position
            },
            success : function(result){
              console.log(result);
              
              let btn = "#position_button_" + i ;
              
              for(let j=0; j<result.length; j++){

                if( result.length != 0){
                  if(result[j] == '${sessionScope.loginMember.memberNo}'){
                    $(btn).text("입장하기");
                    $(btn).prop("disabled", false);
                    $("#applyState_"+i).text(result.length);
                    break;
                  }else {
                    $(btn).prop("disabled", true);
                    $(btn).css("backgroundColor","lightgray");
                    $(btn).text("완료");
                    $("#applyState_"+i).text(result.length);
                  }
                }
                
              }
              if(result.length == 0){
                $(btn).prop("disabled", true);
                    $(btn).css("backgroundColor","lightgray");
                    $(btn).text("완료");
                    $("#applyState_"+i).text(result.length);
              }
              

            },
            error : function(){
              console.log("지원 현황 불러오기 실패");
            }
          });
        }
      

      function insertApply(projectNo, memberNo, position,maxPersonnel){
          $.ajax({
            url:"insertApply.rec",
            type:"get",
            data: {
              projectNo : projectNo,
              memberNo : memberNo,
              position : position,
              maxPersonnel : maxPersonnel
            },
            success:function(){
              location.href='room.rec?pno='+projectNo;
            }
          });
      }

     
          

      


  </script>
</body>

