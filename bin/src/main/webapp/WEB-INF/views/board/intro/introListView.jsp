<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
		/* 공통영역 */
        .content {

            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }
        
        /* content_1 영역 */
        .content_1 {
        	width : 1200px;
        	height : 250px;
        }
        
          .popular-project{
    width: 50%;
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
        
        
        
        /* 인엽이가 준거 */
		.card {
		      padding: 20px;
		      width: 280px;
		      min-height: 300px;
		      border-radius: 20px;
		      background: #e8e8e8;
		      box-shadow: 5px 5px 6px #dadada,
		                  -5px -5px 6px #f6f6f6;
		      transition: 0.4s; 
		      display: inline-block;
		      margin: 30px;
		   
		    }
		
		    .card:hover {
		      translate: 0 -10px;
		    }
		
		    .card-title {
		      font-size: 18px;
		      font-weight: 600;
		      color: #2e54a7;
		      margin: 15px 0 0 10px;
		    }
		
		    .card-image {
		      min-height: 170px;
		      background-color: #c9c9c9;
		      border-radius: 15px;
		      box-shadow: inset 8px 8px 10px #c3c3c3,
		                inset -8px -8px 10px #cfcfcf;
		    }
		
		    .card-body {
		      margin: 13px 0 0 10px;
		      color: rgb(31, 31, 31);
		      font-size: 15px;
		    }
		
		    .footer {
		      float: right;
		      margin: 28px 0 0 18px;
		      font-size: 13px;
		      color: #636363;
		    }
		
		    .by-name {
		      font-weight: 700;
		    }
</style>

<title>Insert title here</title>
</head>
<body>
<jsp:include page="../../common/header.jsp" />



<div class="content">
	<div class="content_title">
		<h2>프로젝트 소개</h2>
	</div>
		<div class="content_1">
			<div class="popular-project">
				<h5>인기 프로젝트 리스트</h5>
				
				<div class="popular-project-list">
					<ol>
						<li>
							<div>
								<p>이상해씨</p>
							</div>
						</li>
						<li>
							<div>
								<p>피카츄</p>
							</div>
						</li>
						<li>
							<div>
								<p>토게피</p>
							</div>
						</li>
						<li>
							<div>
								<p>꼬부기</p>
							</div>
						</li>
						<li>
							<div>
								<p>파이리</p>
							</div>
						</li>
					</ol>
				</div>
			</div>
		</div>
			<div class="card">
				<div class="card-image"></div>
				<p class="card-title">Card title</p>
				<p class="card-body">
				  Nullam ac tristique nulla, at convallis quam. Integer consectetur mi nec magna tristique, non lobortis.
				</p>
				<p class="footer">Written by <span class="by-name">John Doe</span> on <span class="date">25/05/23</span></p>
				</div>
</div>
</div>

</body>
</html>