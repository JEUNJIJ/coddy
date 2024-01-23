<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head> 
    <meta charset="UTF-8">
    <title>마이페이지-자유게시판</title>
    <style>
      .innerOuter { 
        width:80%; 
        margin:auto; 
        padding:5% 10%; 
        background-color:white; 
      }
          
      .menu { 
        list-style-type: none;
        margin-right: 10px;
        margin-left: 0px;
        padding-left: 0px;
        width: 15%;
        height: 100%;
        overflow: auto;
      }
      
      .menu li a {
        display: block;
        color: #000;
        padding: 8px 16px;
        text-decoration: none;
      }
      
      .menu li a.active {
        background-color: #5271FF;
        color: white;
      }
      
      .menu li a:hover:not(.active) {
        background-color: #5271FF;
        color: white;
      }
      
      ul {
        list-style:none;
      }
     
	  h2 { 
			font-weight: border; 
	  }
	  
	  .hr1 { 
		border: 0;
		height: 2px;
		background:  #d3d3d3;
	   }
	   
	  .grey { 
	     color: #727272;
	   }
	   
	   #strong { 
	     font-weight: 900;
	   }

       #table {
       padding-left : 100px;
       width: 100%;
       border-top: 1px solid #d3d3d3;
       border-collapse: collapse;
       }
       
       th { 
       background-color: #d3d3d3 ; 
       border-top: 3px solid #727272;
       }
     
	  .greylist {
	  width: 50px;
	  height: 30px;
	  font-weight: 900;
	  color: white;
	  text-align: center;
	  background: grey;
	  border: solid 2px white;
	  border-radius: 5px;
	  }
	  
	  .gradient {
	  width: 80px;
	  height: 30px;
	  font-weight: 900;
	  color: white;
	  text-align: center;
	  background: linear-gradient( to bottom, grey, black );
	  border: solid 2px white;
	  border-radius: 5px;
	  }
	
      .left {
      text-align: left;
      }
      .right { 
       float: right;
       }
      .center {
       text-align: left;
       }
	
	   a {
	   color:black;
	   text-decoration-line : none;
	   }
	   
	   .modal-body {
	   width : 400px;
	   }
	   
	   #menubar {
	   	width : 100%;
	   	border: 1px solid red;
	   	height : 50px;
	 	display: table;
	   }
	   
	   .menubar {
	   	float : left;
	   	display : flex;
	   }
	   
	  .wrap {
	  width : 100%;
      min-width: 500px;
    }
    
    .menu2 {
      display: table;
      table-layout: fixed;
      width: 100%;  /* 부모 요소의 너비 상속받음 */
      height : 50px;
      padding-top : 15px;
      text-align: center;
    }

    .menu_item {
      display: table-cell;
      width: 25%;
      height: 100%;
    }
    
    .menu_item a { 
    display:block; 
    width:100%;
    height : 100%;
    }
     
   #pagingArea{
   width:fit-content; 
   margin:auto;
  }
  
    #color {
  	background-color: skyblue;
  	padding : 15px;
  }
  #color1 {
  	background-color: #f3f7fe;
  }
  #color2 {
  	background-color: #f3f7fe;
  }
    </style>
  </head>
  <body>
    <jsp:include page="../common/header.jsp" />	


      <div class="innerOuter">
        <h2>작성한 게시글</h2>
        <br><hr><br>
        <div style="display: flex;">
          <ul class="menu" style="padding-left:0px; width : 230px;"><br>
            <li><a href="myPage.se">마이페이지</a>
              <ul style="width : 210px;">
                <li><a href="pwdChange.me">- 비밀번호 변경</a></li>
                <li><a href="delete.me">- 회원 탈퇴</a></li>
              </ul>
            </li>
            <hr>
            <li><a href="written.io">참여한 프로젝트</a></li>
            <li><a href="#">찜한 프로젝트</a></li>
            <li><a href="likedJob.me">찜한 채용공고</a></li>
            <hr>
            <li><a href="written.ro">작성한 게시글</a></li>
          </ul>
              
          <div class="modal-body">


				<div class="wrap">
				      <div class="menu2">
				        <div class="menu_item" id="color1"><a href="written.ro">모집게시판</a></div>
				        <div class="menu_item" id="color2"><a href="written.co">코드리뷰게시판</a></div>
				        <div class="menu_item" id="color"><a href="written.fo">자유게시판</a></div>
				      </div>
				    </div>
				    <br><br>
		
		<h3>자유게시판</h3><br>
		<span> ▷ 총 ${requestScope.listCount}개의 게시물이 있습니다. </span>
		<!-- 
		<span class="right";> 
		            <span class="grey"; id="strong";>SELECT</span>
		    <select>
		    <option value="제목"; name="제목"; >제목</option>
		    <option value="글쓴이";name="글쓴이";>글쓴이</option>
		    </select>
		<input type="text";> <input type="button" name="검색" class="gradient" value="검색" >
		</span>
		 -->
		
		


	
		<br>
		<table id="table">
			<thead>
			    <tr>
			        <th style="border-bottom: 1px solid #d3d3d3; padding: 10px;">번호</th>
			        <th style="border-bottom: 1px solid #d3d3d3; padding: 10px;">제목</th>
			        <th style="border-bottom: 1px solid #d3d3d3; padding: 10px;">글쓴이</th>
			        <th style="border-bottom: 1px solid #d3d3d3; padding: 10px;">일시</th>
			        <th style="border-bottom: 1px solid #d3d3d3; padding: 10px;">조회수</th>
			    </tr>
			</thead>
			<tbody>
		      <c:forEach var="i" items="${ requestScope.list }">
		    <tr>
		        <td class="center, fno" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${i.fboardNo}</td>
		        <td class="left" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${i.fboardTitle}</td>
		        <td class="center" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${i.fboardWriter}</td>
		        <td class="center" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${i.fboardInsert}</td>
		        <td class="center" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${i.fboardViews}</td>   
		    </tr>
			  </c:forEach>
			</tbody>
		</table>
		</br>
		
		<script>
			
			$(function(){
				
				$("#table>tbody>tr").click(function(){
					
					let fno = $(this).children(".fno").text();
					
					location.href = "detail.fr?fno=" + fno;
				
				});
				
				
			});
			
		</script>
		
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
                      <a class="page-link" href="written.fo?cpage=${ requestScope.pi.currentPage - 1 }">Previous</a>
                    </li>
                  </c:otherwise>
              </c:choose>
                
              <c:forEach var="p" begin="${ requestScope.pi.startPage }" 
                          end="${ requestScope.pi.endPage }"
                          step="1">
                  <li class="page-item">
                    <a class="page-link" href="written.fo?cpage=${ p }">${ p }</a>
                  </li>
              </c:forEach>
                
                <c:choose>
                  <c:when test="${ requestScope.pi.currentPage eq requestScope.pi.maxPage }">
                    <li class="page-item disabled">
                      <a class="page-link">Next</a>
                    </li>
                  </c:when>
                  <c:otherwise>
                    <li class="page-item">
                      <a class="page-link" href="written.fo?cpage=${ requestScope.pi.currentPage + 1 }">Next</a>
                    </li>
                  </c:otherwise>
                </c:choose>
            
            </ul>
          </div>
		</div>

           
          </div>
        </div>
      
    <jsp:include page="../common/footer.jsp" />	
  </body>
</html>