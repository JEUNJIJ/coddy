<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모집</title>
<style>
  
  .content_1{
    width: 1200px;
    height: 250px;
   
  }
  .new-project{
    width: 50%;
    height: 100%;  
    float: left;
  }
  .popular-project{
    width: 50%;
    height: 100%;
    float: right;
  }
  .popular-project-list{
    height: 220px;
    padding: 13px 24px;
    border: 1px lightgray solid;
    border-radius: 8px;
    box-sizing: border-box;
  }


  .popular-project-list ul{
    display: flex;
    flex-direction: column;
    margin-bottom: 0;
  }

  .popular-project-list li{
    border-bottom: 1px solid #f6f6f6;
    padding: 8px 0;
    cursor: pointer;
    list-style: none;
    height: 65px;
  }

  .popular-project-list h2{
    font-size: 14px;
    width: 100%;
    font-weight: 500;
  }

  .popular-project-list h3{
    font-size: 13px;
    color: #ccc;
    margin-top: 5px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-weight: 400;
  }

  .popular-project-list div{
    display: flex;
    flex-direction: row;
  }

  .content_1 h1{
    font-size: 22px;
    color: #333;
  }

  .new-project-list{
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
      height: 200px;
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
      width: 250px;
      height: 300px;
      background: white;
      padding: .4em;
      border-radius: 6px;
      margin: 20px;
      margin-bottom: 20px;
    }

    .card-image {
      background-color: rgb(236, 236, 236);
      width: 100%;
      height: 130px;
      border-radius: 6px 6px 0 0;
    }

    .card-image:hover {
      transform: scale(0.98);
    }

    .category {
      text-transform: uppercase;
      font-size: 0.7em;
      font-weight: 600;
      color: #5271FF;
      padding: 10px 7px 0;
    }

    .category:hover {
      cursor: pointer;
    }

    .heading {
      font-weight: 600;
      color: rgb(88, 87, 87);
      padding: 7px;
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

    /* 모집 체크박스 */
    .checkbox-container {
      display: inline-block;
      position: relative;
      padding-left: 35px;
      margin-bottom: 12px;
      cursor: pointer;
      font-size: 16px;
      user-select: none;
    }

    .custom-checkbox {
      position: absolute;
      opacity: 0;
      cursor: pointer;
      height: 0;
      width: 0;
    }
  
    .search-checkmark {
      position: absolute;
      top: 0;
      left: 0;
      height: 25px;
      width: 25px;
      background-color: #eee;
      border-radius: 4px;
      transition: background-color 0.3s;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);  
    }

    .search-checkmark:after {
      content: "";
      position: absolute;
      display: none;
      left: 9px;
      top: 5px;
      width: 5px;
      height: 10px;
      border: solid white;
      border-width: 0 3px 3px 0;
      transform: rotate(45deg);
    }

    .custom-checkbox:checked ~ .search-checkmark {
      background-color: #5271FF;
      box-shadow: 0 3px 7px rgba(33, 150, 243, 0.3);
    }

    .custom-checkbox:checked ~ .search-checkmark:after {
      display: block;
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


</style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />	
    <div class="content">
        <div class="content_title">
            <h2>프로젝트 팀원 모집</h2>
        </div>
        <div class="content_1">
            <div class="new-project">
                <h1>신규 프로젝트</h1>

                <div class="new-project-list">
                    <div class="swiper">
                        <!-- Additional required wrapper -->
                        <div class="swiper-wrapper">
                            <!-- Slides -->
                            <div class="swiper-slide"><img src="resources/image/001.png"></div>
                            <div class="swiper-slide"><img src="resources/image/002.png"></div>
                            <div class="swiper-slide"><img src="resources/image/003.png"></div>
                        </div>
                    
                        <!-- If we need pagination -->
                        <div class="swiper-pagination"></div>
                    
                        <!-- If we need navigation buttons -->
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-button-next"></div>
                    
                       
                    </div>
                </div>
                <script>
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
            </div>
            
            

            <div class="popular-project">
                <h1>인기 프로젝트</h1>
                
                <div class="popular-project-list">
                    <ul>
                        <li>
                            <div>
                                <h2>Lemon</h2>
                                <span>23.11.22</span>
                            </div>
                            <h3>레시피몬스터, 레시피 커뮤니티</h3>
                        </li>
                        <li>
                            <div>
                                <h2>OurNeighborhood</h2>
                                <span>23.11.22</span>
                            </div>
                            <h3>아파트 입주민들을 위한 소통 커뮤니티</h3>
                        </li>
                        
                        <li>
                            <div>
                                <h2>Pet and Met</h2>
                                <span>23.11.22</span>
                            </div>
                            <h3>애완 동물 커뮤니티</h3>
                        </li>
                    </ul>
                </div>
            </div>

        </div>

        <div class="search-bar">

            
            <input class="search-input" placeholder="기술스택">
            <input class="search-input" placeholder="포지션">
            <input class="search-input" placeholder="프로젝트 이름">    

            <label class="checkbox-container" style="text-align: center;">
              <span style="vertical-align: auto;">모집중</span>
               <input class="custom-checkbox" checked="" type="checkbox">
              <span class="search-checkmark"></span>
            </label>            
        </div>
        <div class="">
          <button class="write_button" onclick="location.href='detail.rec'">게시글 작성</button>
        </div>
        <div class="content_2">
          <div class="card-list">

            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>
            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>

            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>

            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>
            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>
            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>

            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>

            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>
            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>
            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>

            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>

            <div class="card">
              <div class="card-image"></div>
              <div class="category">커뮤니티</div>
              <div class="heading"> 
                <h5>OurNeighborhood</h5>
                <div class="explain">아파트 입주민들을 위한 소통 커뮤니티</div>
                  <div class="author"> By <span class="name">김인엽</span> 4일전</div>
                  <label class="container">
                    <input checked="checked" type="checkbox">
                    <div class="checkmark">
                      <svg viewBox="0 0 256 256">
                      <rect fill="none" height="512" width="512"></rect>
                      <path d="M224.6,51.9a59.5,59.5,0,0,0-43-19.9,60.5,60.5,0,0,0-44,17.6L128,59.1l-7.5-7.4C97.2,28.3,59.2,26.3,35.9,47.4a59.9,59.9,0,0,0-2.3,87l83.1,83.1a15.9,15.9,0,0,0,22.6,0l81-81C243.7,113.2,245.6,75.2,224.6,51.9Z" stroke-width="20px" stroke="#d0d0d0" fill="none"></path></svg>
                    </div>
                  </label> 
                </div>                          
            </div>


            

          </div>         
          <script>
            
            $(function(){
              $(".card").css("display", "inline-block");
              $(".container").css("width","0%");
            });

          </script>
        </div>
        <br><br>
        <div class="paging-area" align="center">
            <!-- <button onclick="location.href=''">&lt;</button> -->
            <button onclick="location.href=''" disabled>1</button>
            <button onclick="location.href=''">2</button>
            <button onclick="location.href=''">3</button>
            <button onclick="location.href=''">4</button>   
            <button onclick="location.href=''" >&gt;</button>
             
            </div>
    </div>

</body>
</html>