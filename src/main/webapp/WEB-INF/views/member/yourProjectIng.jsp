<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head> 
    <meta charset="UTF-8">
    <title>상대방이 참여하고 있는 프로젝트</title>
    <style>
      .innerOuter { 
        width:70%; 
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
	   width : 800px;
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
              
          <div class="modal-body">

				    
		

		 <h3>참여하고 있는 프로젝트</h3><br>
		<span> ▷ 총 ${requestScope.listCount}개의 게시물이 있습니다. </span>

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
		      <c:forEach var="r" items="${ requestScope.list }">
		    <tr>
		        <td class="center, rno" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${r.recruitmentNo}</td>
		        <td class="left" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${r.recruitmentTitle}</td>
		        <td class="center" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${r.recruitmentWriter}</td>
		        <td class="center" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${r.recruitmentInsert}</td>
		        <td class="center" style="border-bottom: 1px solid #d3d3d3; padding: 10px;">${r.recruitmentView}</td>   
		    </tr>
			  </c:forEach>
			</tbody>
		</table>
		</br>
		
		<script>
			
			$(function(){
				
				$("#table>tbody>tr").click(function(){
					
					let rno = $(this).children(".rno").text();
					
					location.href = "detail.rec?rno=" + rno;
				
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
                      <a class="page-link" href="yourProjectIng.bo?cpage=${ requestScope.pi.currentPage - 1 }">Previous</a>
                    </li>
                  </c:otherwise>
              </c:choose>
                
              <c:forEach var="p" begin="${ requestScope.pi.startPage }" 
                          end="${ requestScope.pi.endPage }"
                          step="1">
                  <li class="page-item">
                    <a class="page-link" href="yourProjectIng.bo?cpage=${ p }">${ p }</a>
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
                      <a class="page-link" href="yourProjectIng.bo?cpage=${ requestScope.pi.currentPage + 1 }">Next</a>
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