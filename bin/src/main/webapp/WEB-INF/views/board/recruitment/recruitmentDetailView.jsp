<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모집 상세</title>
<style>

.content_title{
    text-align: center;
    height: 150px;
}
.content_1{
    height: 350px;
    border-top: 1px solid #e8e8e8;
    padding-top: 30px;
}
.content_left{
   
    width: 60%;
    float: left;
    height: 200px;
}

.content_right{
    float: right;
    width: 40%;
    height: 200px;
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
  margin-top: 30px;
  overflow-x: scroll;
  white-space: nowrap;
}

.content_3>h2{
    margin-left: 10px;
    margin-top: 50px;
    text-align: left;
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



</style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />	
    <div class="content">
        <div class="content_title">
            <h2 style="margin-bottom: 10px;">CodeBuddy<span class="project_status">모집중</span></h2>
            <span>김인엽</span><br>
            <div class="project_like">
                <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                    <svg viewBox="0 0 256 256">
                    <rect fill="none" height="256" width="256"></rect>
                    <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                </label>
                <span class="like_count">223</span>
            </div>
        </div>
        <script>
            $(function(){
                    $(".container").css("width","10px");
            });
        </script>

        <div class="content_1">
        <div class="content_left">
            <h2>모집 현황</h2>        
            <table class="position_status">
                <tbody>
                    <tr>
                        <td style="width: 100px;">PM</td>
                        <td style="width: 200px;">1/1</td>
                        <td><button class="position_button">지원하기</button></td>
                    </tr>
                    <tr>
                        <td style="width: 100px;">Front-End</td>
                        <td style="width: 200px;">1/3</td>
                        <td><button class="position_button">지원하기</button></td>
                    </tr>
                    <tr>
                        <td style="width: 100px;">Back-End</td>
                        <td style="width: 200px;">1/3</td>
                        <td><button class="position_button">지원하기</button></td>
                    </tr>
                    <tr>
                        <td style="width: 100px;">디자이너</td>
                        <td style="width: 200px;">1/3</td>
                        <td><button class="position_button">지원하기</button></td>
                    </tr>
                </tbody>
            </table> 
        </div>

        <div class="content_right">
            <h2>기술/언어</h2>

            <div class="tag_card">
              <span class="title">All tags</span>
              <div class="card__tags">
                <ul class="tag">
                  <li class="tag__name">JS</li>
                  <li class="tag__name">wordpress</li>
                  <li class="tag__name">uiverse</li>
                  <li class="tag__name">Css</li>
                  <li class="tag__name">html</li>
                  <li class="tag__name">go</li>
                  <li class="tag__name">java</li>
                  <li class="tag__name">ux/ui</li>
                  <li class="tag__name">figma</li>
                  <li class="tag__name">wordpress</li>
                  <li class="tag__name">uiverse</li>
                  <li class="tag__name">Css</li>
                  <li class="tag__name">html</li>
                  <li class="tag__name">go</li>
                  <li class="tag__name">java</li>
                  <li class="tag__name">ux/ui</li>
                  <li class="tag__name">figma</li>
                  <li class="tag__name">wordpress</li>
                  <li class="tag__name">uiverse</li>
                  <li class="tag__name">Css</li>
                  <li class="tag__name">html</li>
                  <li class="tag__name">go</li>
                  <li class="tag__name">java</li>
                  <li class="tag__name">ux/ui</li>
                  <li class="tag__name">figma</li>
                  <li class="tag__name">wordpress</li>
                  <li class="tag__name">uiverse</li>
                  <li class="tag__name">Css</li>
                  <li class="tag__name">html</li>
                  <li class="tag__name">go</li>
                  <li class="tag__name">java</li>
                  <li class="tag__name">ux/ui</li>
                  <li class="tag__name">figma</li>
                  <li class="tag__name">wordpress</li>
                  <li class="tag__name">uiverse</li>
                  <li class="tag__name">Css</li>
                  <li class="tag__name">html</li>
                  <li class="tag__name">go</li>
                  <li class="tag__name">java</li>
                  <li class="tag__name">ux/ui</li>
                  <li class="tag__name">figma</li>
                </ul>
              </div>
            </div>
            
         </div>
     </div>

      <div clas="content_3">
          <h2>이미지</h2>
          <div class="photo-scroll">
              <image class="photo-scroll-image" src="resources/image/001.png"/>
              <image class="photo-scroll-image" src="resources/image/002.png"/>
              <image class="photo-scroll-image" src="resources/image/003.png"/>
              <image class="photo-scroll-image" src="resources/image/001.png"/>
          </div>
          <br>
      </div>
      <div class="content_4">
        <h2>소개</h2>
        

      </div>
    
    </div>
</body>

