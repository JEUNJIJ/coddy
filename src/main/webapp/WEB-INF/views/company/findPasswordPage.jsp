<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>기업 계정 찾기</title>
	<style>
		/* tabview */
		/*
		* { margin:0; padding:0; }
		body { font-family: '맑은 고딕' 돋움; font-size:0.75em; color:#333; }
		ul li{ list-style-type: none; }
		.tab-box{ margin: 50px auto 0 auto;  width:520px; }
		.tab-box ul{ height:30px; }
		.tab-box li{ float:left; width:100px; height:30px; line-height:30px; margin-right: 2px; text-align: center; background-color: #ccc; border-radius:3px 3px 0 0; cursor: pointer; }
		.tab-box li.selected{ background-color: orange; }
		.tab-view{ width:506px; border: 1px solid gray; text-align:center; margin-top:-1px; } */
		/* loginForm */
		@import url(https://fonts.googleapis.com/css?family=Audiowide);
		::-moz-selection { background: #cc0000; text-shadow: none; }
		::selection { background: #cc0000; text-shadow: none; }
		html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,embed,figure,figcaption,footer,header,hgroup,menu,nav,output,ruby,section,summary,time,mark,audio,video {
			border: 0;
			font: inherit;
			font-size: 100%;
			margin: 0;
			padding: 0;
			vertical-align: baseline;
			text-rendering: optimizeLegibility;
		}
		article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section { display: block; }
		html,body { height: 100%; margin: 0; padding: 0; }
		body {
			background: #1b1b1b;
			color: #FFF;
			font-family: "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
			font-size: 12px;
			line-height: 1;
		}
		.background-wrap {
			width: 100%;
			height: 100%;
			position: absolute;
			top: 0;
			left: 0;
			z-index: -1;
			overflow: hidden;
		}
		.background {
			background: url('https://myrror.co/etc/419062774_1385132057.jpg');
			background-position: center;
			background-size: cover;
			filter: blur(10px);
			height: 105%;
			position: relative;
			width: 105%;
			right: -2.5%;
			left: -2.5%;
			top: -2.5%;
			bottom: -2.5%;
		}
		* { box-sizing: border-box; cursor: default; outline: none; }
		
		form {
			background: #111;
			border: 1px solid #191919;
			border-radius: .4em;
			bottom: 0;
			box-shadow: 0 5px 10px 5px rgba(0,0,0,0.2);
			height: 320px;
			left: 0;
			margin: auto;
			overflow: hidden;
			position: absolute;
			right: 0;
			top: 0;
			width: 420px;
		}
		form:after {
			background: linear-gradient(to right, #111111, #444444, #b6b6b8, #444444, #2F2F2F, #272727);
			content: "";
			display: block;
			height: 1px;
			left: 50px;
			position: absolute;
			top: 0;
			width: 150px;
		}
		form:before {
			border-radius: 50%;
			box-shadow: 0 0 6px 4px #fff;
			content: "";
			display: block;
			height: 5px;
			left: 34%;
			position: absolute;
			top: -7px;
			width: 8px;
		}
		.inset { border-top: 1px solid #19191a; padding: 20px; }
		form h1 {
			font-family: 'Audiowide';
			border-bottom: 1px solid #000;
			font-size: 18px;
			padding: 15px 0;
			position: relative;
			text-align: center;
			text-shadow: 0 1px 0 #000;
		}
		form h1 { color: #FFbb00; font-family: Audiowide; font-weight: normal; }
		form h1.poweron { color: #ffffff; transition: all 0.5s; animation: flicker 1s ease-in-out 1 alternate, neon 1.5s ease-in-out infinite alternate; animation-delay: 0s, 1s; }
		form h1:after {
			position: absolute;
			width: 250px;
			height: 180px;
			content: "";
			display: block;
			pointer-events: none;
			top: 0;
			margin-left: 138px;
			transform-style: flat;
			transform: skew(20deg);
			background: -moz-linear-gradient(top, hsla(0,0%,100%,0.1) 0%, hsla(0,0%,100%,0) 100%);
			background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,hsla(0,0%,100%,0.2)), color-stop(100%,hsla(0,0%,100%,0)));
			background: -webkit-linear-gradient(top, hsla(0,0%,100%,0.1) 0%,hsla(0,0%,100%,0) 100%);
			background: -o-linear-gradient(top, hsla(0,0%,100%,0.1) 0%,hsla(0,0%,100%,0) 100%);
			background: -ms-linear-gradient(top, hsla(0,0%,100%,0.1) 0%,hsla(0,0%,100%,0) 100%);
			filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#42ffffff', endColorstr='#00ffffff',GradientType=0 );
			background: linear-gradient(to bottom, hsla(0,0%,100%,0.1) 0%,hsla(0,0%,100%,0) 100%);
		}
		input[type=text], input[type=password], input[type=number], input[type=email] {
			background: linear-gradient(#1f2124,#27292c);
			border: 1px solid #222;
			border-radius: .3em;
			box-shadow: 0 1px 0 rgba(255,255,255,0.1);
			color: #FFF;
			font-size: 13px;
			margin-bottom: 20px;
			padding: 8px 5px;
			width: 100%;
		}
		input[type=text]:disabled, input[type=password]:disabled, input[type=number]:disabled, input[type=email]:disabled { color: #999; }
		label[for=remember] {
			color: #bbb;
			display: inline-block;
			height: 20px;
			line-height: 20px;
			vertical-align: top;
			padding: 0 0 0 5px;
		}
		.p-container { padding: 0 20px 20px; }
		.p-container:after { clear: both; content: ""; display: table; }
		.p-container span { color: #0d93ff; display: block; float: left; padding-top: 8px; }
		input[type=submit], input[type=button] {
			background: #fb0;
			border: 1px solid rgba(0,0,0,0.4);
			border-radius: .3em;
			box-shadow: inset 0 1px 0 rgba(255,255,255,0.3), inset 0 10px 10px rgba(255,255,255,0.1);
			color: #873C00;
			cursor: pointer;
			font-size: 13px;
			font-weight: bold;
			height: 40px;
			padding: 5px 20px;
			width: 100%;
		}
		.denied { color: white !important; text-shadow: 0 0 1px black; background: #EE0000 !important; }
		input[type=submit]:hover, input[type=submit]:focus, input[type=button]:hover, input[type=button]:focus { box-shadow: inset 0 1px 0 rgba(255,255,255,0.3), inset 0 -10px 10px rgba(255,255,255,0.1); }
		input[type=text]:hover:not([disabled]), 
		input[type=text]:focus, 
		input[type=password]:hover:not([disabled]), 
		input[type=password]:focus, 
		input[type=number]:hover:not([disabled]), 
		input[type=number]:focus, 
		input[type=email]:hover:not([disabled]), 
		input[type=email]:focus, 
		label:hover ~ input[type=text], 
		label:hover ~ input[type=password],
		label:hover ~ input[type=number],
		label:hover ~ input[type=email] { background: #27292c; }
		input[type="checkbox"] {
			opacity: 0;
			background: red;
			position: absolute;
			cursor: pointer;
			z-index: 1;
			height: 100%;
			width: 100%;
			left: 0;
			top: 0;
		}
		.checkboxouter {
			height: 20px;
			width: 20px;
			border-radius: 3px;
			background-color: #000;
			position: relative;
			display: inline-block;
			border: 2px solid #555;
		}
		.checkbox {
			position: absolute;
			border-bottom: 2px solid #333;
			border-right: 2px solid #333;
			background-color: transparent;
			height: 10px;
			width: 5px;
			margin: auto;
			left: 50%;
			transform: rotate(45deg);
			transform-origin: -35% 30%;
			transition: all 0.2s;
		}
		input[type="checkbox"]:checked ~ .checkbox { transition: all 0.3s; border-bottom: 2px solid #ffcc00; border-right: 2px solid #ffcc00; }
		@keyframes neon {
		  	from {
				text-shadow: 
				0 0 2.5px #fff,
				0 0 5px #fff,
				0 0 7.5px #fff,
				0 0 10px #B6FF00,
				0 0 17.5px #B6FF00,
				0 0 20px #B6FF00,
				0 0 25px #B6FF00,
				0 0 37.5px #B6FF00;
			}
			to {
				text-shadow: 
				0 0 3px #fff,
				0 0 7px  #fff,
				0 0 13px  #fff,
				0 0 17px  #B6FF00,
				0 0 33px  #B6FF00,
				0 0 38px  #B6FF00,
				0 0 48px #B6FF00,
				0 0 63px #B6FF00;
			}
		}
		@keyframes flicker {
			0% {
				text-shadow: 
				0 0 2.5px #fff,
				0 0 5px #fff,
				0 0 7.5px #fff,
				0 0 10px #B6FF00,
				0 0 17.5px #B6FF00,
				0 0 20px #B6FF00,
				0 0 25px #B6FF00,
				0 0 37.5px #B6FF00;
		  	}
		  	2% { text-shadow: none; }
			8% {
				text-shadow: 
				0 0 2.5px #fff,
				0 0 5px #fff,
				0 0 7.5px #fff,
				0 0 10px #B6FF00,
				0 0 17.5px #B6FF00,
				0 0 20px #B6FF00,
				0 0 25px #B6FF00,
				0 0 37.5px #B6FF00;
			}
		  	10% { text-shadow: none; }
			20% {
				text-shadow: 
				0 0 2.5px #fff,
				0 0 5px #fff,
				0 0 7.5px #fff,
				0 0 10px #B6FF00,
				0 0 17.5px #B6FF00,
				0 0 20px #B6FF00,
				0 0 25px #B6FF00,
				0 0 37.5px #B6FF00;
			}
		  	22% { text-shadow: none; }
			24% {
				text-shadow: 
				0 0 2.5px #fff,
				0 0 5px #fff,
				0 0 7.5px #fff,
				0 0 10px #B6FF00,
				0 0 17.5px #B6FF00,
				0 0 20px #B6FF00,
				0 0 25px #B6FF00,
				0 0 37.5px #B6FF00;
			}
		  	28% { text-shadow: none; }
			32% {
				text-shadow: 
				0 0 2.5px #fff,
				0 0 5px #fff,
				0 0 7.5px #fff,
				0 0 10px #B6FF00,
				0 0 17.5px #B6FF00,
				0 0 20px #B6FF00,
				0 0 25px #B6FF00,
				0 0 37.5px #B6FF00;
			}
			34% { text-shadow: none; }
			36% { text-shadow: none; }
			42% { text-shadow: none; }
			100% {
				text-shadow: 
				0 0 2.5px #fff,
				0 0 5px #fff,
				0 0 7.5px #fff,
				0 0 10px #B6FF00,
				0 0 17.5px #B6FF00,
				0 0 20px #B6FF00,
				0 0 25px #B6FF00,
				0 0 37.5px #B6FF00;
			}
		}
	</style>
	</head>
	<body>
		<div class="content">
			<div class="tab-box">
				<!-- <ul class="selected"><li>메뉴 1</li><li>메뉴 2</li></ul> -->
				<div class="tab-view">
					<div class="background-wrap"><div class="background"></div></div>
					<form id="accesspanel" action="findIdAccess.cp" method="post">
						<h1 id="litheader">기업 비밀번호 찾기</h1>
						<div class="inset">
					    	<p><input type="email" name="companyEmail" id="companyEmail" placeholder="Email 입력" required></p>
					    	<p><input type="number" name="companyBno" id="companyBno" placeholder="사업자 등록번호 입력" required></p>
					    	<div style="text-align: center;">
					      		<div class="checkboxouter">
							        <input type="checkbox" name="plusId" id="remember" value="true">
							        <label class="checkbox"></label>
					      		</div>
					      		<label for="remember">아이디와 비밀번호 모두 찾기</label>
					    	</div>
					   		<input class="loginLoginValue" type="hidden" name="service" value="login" />
					  	</div>
					  	<p class="p-container"><input type="submit" name="Login" id="go" value="비밀번호 요청"></p>
						<p class="p-container"><input type="button" onclick="location.href='loginPage.cp'" value="돌아가기"></p>
					</form>
				</div>
			</div>
		</div>
		<script>
			$(document).ready(function() {
			    var state = false;
			    $('#accesspanel').on('submit', function(e) {
			        e.preventDefault();
			        state = !state;
			        if (state) {
			            document.getElementById("litheader").className = "poweron";
			            document.getElementById("go").className = "";
			            document.getElementById("go").value = "Initializing...";
			        }else{
			            document.getElementById("litheader").className = "";
			            document.getElementById("go").className = "denied";
			            document.getElementById("go").value = "Access Denied";
			        }
			    });
			});
		</script>
	</body>
</html>