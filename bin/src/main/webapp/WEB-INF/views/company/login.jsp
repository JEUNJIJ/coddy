<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>기업 로그인</title>
	<style>
		@import url('https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400');

		body, html { font-family: 'Source Sans Pro', sans-serif; background-color: #1d243d; padding: 0; margin: 0; }

		#particles-js { position: absolute; width: 100%; height: 100%; }

		.container{
			margin: 0;
			top: 50px;
			left: 50%;
			position: absolute;
			text-align: center;
			transform: translateX(-50%);
			background-color: rgb( 33, 41, 66 );
			border-radius: 9px;
			border-top: 10px solid #79a6fe;
			border-bottom: 10px solid #8BD17C;
			width: 400px;
			height: 500px;
			box-shadow: 1px 1px 108.8px 19.2px rgb(25,31,53);
		}

		.box h4 { font-family: 'Source Sans Pro', sans-serif; color: #5c6bc0; font-size: 18px; margin-top:94px; }
		.box h4 span { color: #dfdeee; font-weight: lighter; }
		.box h5 { font-family: 'Source Sans Pro', sans-serif; font-size: 13px; color: #a1a4ad; letter-spacing: 1.5px; margin-top: -15px; margin-bottom: 70px; }
		.box input[type = "text"],.box input[type = "password"] {
			display: block;
			margin: 20px auto;
			background: #262e49;
			border: 0;
			border-radius: 5px;
			padding: 14px 10px;
			width: 320px;
			outline: none;
			color: #d6d6d6;
			-webkit-transition: all .2s ease-out;
			-moz-transition: all .2s ease-out;
			-ms-transition: all .2s ease-out;
			-o-transition: all .2s ease-out;
			transition: all .2s ease-out;
		}
		
		::-webkit-input-placeholder { color: #565f79; }

		.box input[type = "text"]:focus,.box input[type = "password"]:focus { border: 1px solid #79A6FE; }

		a{ color: #5c7fda; text-decoration: none; }
		a:hover { text-decoration: underline; }

		label input[type = "checkbox"] { display: none; }

		/* style the artificial checkbox */
		label span {
			height: 13px;
			width: 13px;
			border: 2px solid #464d64;
			border-radius: 2px;
			display: inline-block;
			position: relative;
			cursor: pointer;
			float: left;
			left: 7.5%;
		}

		.btn1 {
			border:0;
			background: #7f5feb;
			color: #dfdeee;
			border-radius: 100px;
			width: 340px;
			height: 49px;
			font-size: 16px;
			position: absolute;
			top: 79%;
			left: 8%;
			transition: 0.3s;
			cursor: pointer;
		}
		.btn1:hover { background: #5d33e6; }

		.rmb { position: absolute; margin-left: -24%; margin-top: 0px; color: #dfdeee; font-size: 13px; }

		.forgetpass { position: relative; float: right; right: 28px; }

		.dnthave{ position: absolute; top: 92%; left: 24%; }

		[type=checkbox]:checked + span:before {
			font-family: FontAwesome;
			font-size: 16px;
			content: "\f00c";
			position: absolute;
			top: -4px;
			color: #896cec;
			left: -1px;
			width: 13px;
		}
		.typcn {
			position: absolute;
			left: 339px;
			top: 282px;
			color: #3b476b;
			font-size: 22px;
			cursor: pointer;
		}      
		.typcn.active { color: #7f60eb; }

		.error {
			background: #ff3333;
			text-align: center;
			width: 337px;
			height: 20px;
			padding: 2px;
			border: 0;
			border-radius: 5px;
			margin: 10px auto 10px;
			position: absolute;
			top: 31%;
			left: 7.2%;
			color: white;
			display: none;
		}

		.reference {
			position: relative;
			left: 0;
			bottom: 0;
			top: 605px;
			width: 100%;
			color: #78797d;
			font-size: 14px;
			text-align: center;
		}
		.reference .fa { color: #7f5feb; }
		.animated a { text-decoration: none; }
	</style>
	</head>
	<body>
			<div id="articles-js">
				<div class="animated bounceInDown">
					<div class="container">
						<span class="error animated tada" id="msg"></span>
						<form action="login.co" method="post" name="form1" class="box" onsubmit="return checkStuff()">
							<h4>기업용<span>로그인 페이지</span></h4>
							<h5>아이디와 비밀번호를 입력해주세요.</h5>
							<input type="text" name="companyId" placeholder="ID" autocomplete="off" required>
							<i class="typcn typcn-eye" id="eye"></i>
							<input type="password" name="companyPwd" placeholder="Passsword" id="companyPwd" autocomplete="off" required>
							<!--
							<label>
								<input type="checkbox">
								<span></span>
								<small class="rmb">로그인 정보 기억</small>
							</label>
							-->
							<a href="/coddy/">홈으로</a>
							<a href="#" class="forgetpass">비밀번호 찾으러 가기</a>
							<input type="submit" value="Sign in" class="btn1">
						</form>
						<a href="signupPage.co" class="dnthave">기업전용 회원 가입하러 가기</a>
					</div> 
					<div class="reference">
						<span>문의하기 <i class="fa fa-heart pulse"></i><a href=""><a href="">1:1 상담</a><br></span>
					</div>
				</div>
			</div>
		<script>
			var pwd = document.getElementById('companyPwd');
			var eye = document.getElementById('eye');

			eye.addEventListener('click',togglePass);

			function togglePass(){
				eye.classList.toggle('active');
				(pwd.type == 'password') ? pwd.type = 'text' : pwd.type = 'password';
			}

			// Form Validation
			function checkStuff() {
				var id = document.form1.companyId;
				var password = document.form1.companyPwd;
				var msg = document.getElementById('msg');
			
				if (id.value == "") {
					msg.style.display = 'block';
					msg.innerHTML = "아이디를 입력해주세요";
					id.focus();
					return false;
				} else {
					msg.innerHTML = "";
				}
				
				if (password.value == "") {
					msg.innerHTML = "비밀번호를 입력해주세요";
					password.focus();
					return false;
				} else {
					msg.innerHTML = "";
				}
			}

			// ParticlesJS
			// ParticlesJS Config.
			particlesJS("particles-js", {
				"particles": {
					"number": {
						"value": 60,
						"density": {
							"enable": true,
							"value_area": 800
						}
					},
					"color": {
						"value": "#ffffff"
					},
					"shape": {
						"type": "circle",
						"stroke": {
							"width": 0,
							"color": "#000000"
						},
						"polygon": {
							"nb_sides": 5
						},
						"image": {
							"src": "img/github.svg",
							"width": 100,
							"height": 100
						}
					},
					"opacity": {
						"value": 0.1,
						"random": false,
						"anim": {
							"enable": false,
							"speed": 1,
							"opacity_min": 0.1,
							"sync": false
						}
					},
					"size": {
						"value": 6,
						"random": false,
						"anim": {
							"enable": false,
							"speed": 40,
							"size_min": 0.1,
							"sync": false
						}
					},
					"line_linked": {
						"enable": true,
						"distance": 150,
						"color": "#ffffff",
						"opacity": 0.1,
						"width": 2
					},
					"move": {
						"enable": true,
						"speed": 1.5,
						"direction": "top",
						"random": false,
						"straight": false,
						"out_mode": "out",
						"bounce": false,
						"attract": {
							"enable": false,
							"rotateX": 600,
							"rotateY": 1200
						}
					}
				},
				"interactivity": {
					"detect_on": "canvas",
					"events": {
						"onhover": {
							"enable": false,
							"mode": "repulse"
						},
						"onclick": {
							"enable": false,
							"mode": "push"
						},
						"resize": true
					},
					"modes": {
						"grab": {
							"distance": 400,
							"line_linked": {
								"opacity": 1
							}
						},
						"bubble": {
							"distance": 400,
							"size": 40,
							"duration": 2,
							"opacity": 8,
							"speed": 3
						},
						"repulse": {
							"distance": 200,
							"duration": 0.4
						},
						"push": {
							"particles_nb": 4
						},
						"remove": {
							"particles_nb": 2
						}
					}
				},
				"retina_detect": true
			});
		</script>
	</body>
</html>