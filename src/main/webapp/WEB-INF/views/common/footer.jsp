<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
      /* div{border:1px solid red;} */
        #footer {
            width:80%;
            height:200px;
            margin:auto;
            margin-top:50px;
            display : flex;
        }
        #footer-1 {
            width:65%;
            height:60%;
            border-top:1px solid lightgray;

        }
        #footer-2 {
        width:35%; 
        height:60%;
        border-top:1px solid lightgray;

        }
        #footer-1, #footer-2 {padding-left:50px;}
        #footer-1>a {
            text-decoration:none;
            font-weight:600;
            margin:10px;
            line-height:40px;
            color:black;
        }
        #footer-2>p {
            margin:0;
            padding:10px;
            font-size:13px;
        }
        #p2 {text-align:center;}
      
        
        .td1 {
        	padding-right : 15px;
        	font-family: 'Noto Sans KR', sans-serif;
          font-family: 'Noto Serif KR', serif;
        	font-size: 12px;
        }
        .td2 {
            font-family: 'Noto Sans KR', sans-serif;
            font-family: 'Noto Serif KR', serif;
        }
        
        #p1 {
        font-family: 'Noto Sans KR', sans-serif;
		font-family: 'Noto Serif KR', serif;
        }
        
        
     
        
    </style>
</head>
<body>

    <div id="footer">
        <div id="footer-1">
			<table>
				<tr>
					<td id="td1" style="padding-right : 30px; padding-top : 30px;"><b>Creators</b></td>
					<td class="td1" style="padding-top : 30px; text-align : center">|</td>
					<td class="td1" style="padding-top : 30px; text-align : center" onclick="location.href='https://github.com/Afdddd'">김인엽</td>
					<td class="td1" style="padding-top : 30px; text-align : center">| </td>
					<td class="td1" style="padding-top : 30px; text-align : center" onclick="location.href='https://github.com/ttp6418'">봉영훈</td>
					<td class="td1" style="padding-top : 30px; text-align : center">|</td>
					<td class="td1" style="padding-top : 30px; text-align : center" onclick="location.href='https://github.com/backdfb'">김효중</td>
					<td class="td1" style="padding-top : 30px; text-align : center">|</td>
					<td class="td1" style="padding-top : 30px; text-align : center" onclick="location.href='https://github.com/JEUNJIJ'">정은지</td>
					<td class="td1" style="padding-top : 30px; text-align : center">|</td>
					<td class="td1" style="padding-top : 30px; text-align : center" onclick="location.href='https://github.com/HanYoungUk'">한영욱</td>
				</tr>
				<tr>
					<td style="padding-right : 30px; padding-top : 30px; text-align : center"><b>Reference</b></td>
					<td style="padding-right : 15px; padding-top : 30px; text-align : center"> |</td>
					<td class="td2" style="padding-top : 30px; text-align : center"><a href="https://letspl.me/">LET'SPL</a></td>
					<td style="padding-top : 30px; text-align : center">|</td>
					<td class="td2" style="padding-top : 30px; text-align : center"><a href="https://holaworld.io/">HOLA</a></td>
					<td style="padding-top : 30px; text-align : center">|</td>
					<td class="td2" style="padding-top : 30px; text-align : center"><a href="https://www.inflearn.com/">Inflearn</a></td>
				</tr>
				<tr>
					<td style="padding-right : 30px; padding-top : 30px; text-align : center"><b>Compete</b></td>
					<td style="padding-right : 15px; padding-top : 30px; text-align : center"> |</td>
					<td colspan="2" style="padding-top : 30px; text-align : center"><a href="#"><img src="resources/image/meetgo_logo.png" style="height : 50px; width : 50px;"></a></td>
					<td colspan="2" style="padding-top : 30px; text-align : center"><a href="#"><img src="resources/image/mbtingLoggo2.png" style="height : 50px; width : 50px;"></a></td>
					<td colspan="2" style="padding-top : 30px; text-align : center"><a href="#"><img src="resources/image/logo2.png" style="height : 50px; width : 50px;"></a></td>
				</tr>
			</table>
        </div>

        <div id="footer-2">
            <br>
            <div style="text-align : center;">
                <img src="resources/image/logo.png" style="height : 50px; width:100px;"><br><br>
                <div style="text-align : left;">
                    <p style="font-size : 12px;" id="p1">
                        사업자 : 김인엽 <br>
                        Contact : 010-1516-5162 <br>
                        Address : 서울특별시 영등포구 선유동2로 57 이레빌딩 <br>
                    </p>
                </div>
                <br>
            </div>
        </div>
    </div>
</body>
</html>