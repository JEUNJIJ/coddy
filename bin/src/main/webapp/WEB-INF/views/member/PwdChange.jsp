<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	  left-padding: 0px;
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
	table {
	  border-spacing: 10px;
	  border-collapse: separate;
	}
	table td {
	  width: 300px;

	}
</style>
</head>
<body>

	   <jsp:include page="../common/header.jsp" />	

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>비밀번호 변경</h2>
            <br>

   <hr>
            <br>
            <div style="display: flex;">
					
                    <ul class="menu" style="padding-left:0px; width : 300px;">
                    	<br>
                        <li><a href="myPage.me">마이페이지</a>
                        <ul style="width : 210px;">
                        	<li><a href="pwdChange.me">- 비밀번호 변경</a></li>
                        	<li><a href="delete.me">- 회원 탈퇴</a></li>
                        </ul></li>
                        <hr>
                        <li><a href="#">나의 평가</a></li>
                        <hr>
                        <li><a href="#">참여한 프로젝트</a></li>
                        <li><a href="#">찜한 프로젝트</a></li>
                        <li><a href="#">찜한 채용공고</a></li>
                        <hr>
                        <li><a href="written.me">작성한 게시글</a></li>
                        <li><a href="#">작성한 댓글</a></li>
                    </ul>
             
            
                  <div class="modal-body">
                    <form action="pwd.me" method="post" id="pwUpdateForm" name="pwUpdateForm">
                        
                        <!-- 
                            비밀번호 변경 시 : 현재 비밀번호, 변경할 비밀번호, 변경할 비밀번호 확인
                                                 , 변경할 아이디
                         -->
                         <!--  
                             비밀번호 변경 요청 시 변경하고자 하는 회원의 아이디값도 같이 form 으로 넘기고자 함
                             input type="text" 로 아이디를 굳이 입력받지 않고도 넘기고 싶음
                             => input type="hidden" 로 아이디값을 넘길 것
                         -->
                         <input type="hidden" name="memberId" value="${login.memberId}" id="memberId">
                         <br><br><br><br><br><br>	
                        <table>
                            <tr>
                                <td>현재 비밀번호</td>
                                <td>
                                    <input type="password" name="memberPwd" id="memberPwd" placeholder="현재 비밀번호" required>
                                </td>
                            </tr>
                          
                            <tr style="height : 150px;">
                                <td>변경할 비밀번호</td>
                                <td>
                                    <input type="password" name="updatePwd" id="updatePwd" value="updatePwd" placeholder="새 비밀번호" required>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>변경할 비밀번호 재입력</td>
                                <td>
                                    <input type="password" name="checkPwd" id="checkPwd" value="checkPwd" placeholder="새 비밀번호 확인" required>
                                </td>
                            </tr>
                        </table>
                        <br><br><br>
                        <div style="width : 400px; text-align : center">
                        <button type="submit" class="btn btn-secondary btn-sm">비밀번호 변경</button>
                    	</div>
                    </form>
                    
                    <!-- 
                      <script>
               			$(document).ready(function(){
               				if($("#memberPwd").val==""){
               					alert("현재 비밀번호를 입력해주세요");
               					$("#memberPwd").focus();
               					return false
               				}
               				if($("#updatePwd").val=""){
               					alert("변경 비밀번호를 입력해주세요");
               					$("#updatePwd").focus();
               					return false
               				}
               				if($("#checkPwd").val=""){
               					alert("변경 비밀번호를 입력해주세요");
               					$("#checkPwd").focus();
               					return false
               				}
               				if($("#updatePwd").val() != $("#checkPwd").val()){
               					alert("변경 비밀번호가 일치하지 않습니다.");
               					$("#checkPwd").focus();
               					
               				$.ajax({
               					url : "",
               					type : "POST",
               					dataType : "json",
               					data : $("#pwUpdateForm").serializeArray(),
               					success : function(data){
               						
               						if(data==0){
               							alert("패스워드가 틀렸습니다.");
               							return;
               						} else {
               							if(confirm("변경하시겠습니까?")){
               								$("#pwUpdateForm").submit();
               							}
               							
               						}
               					}
               					
               					
               				})
               				
               			});
               			
               		})	
                    </script>
                     -->
                  </div>
                </div>
              </div>
            </div>

</body>
</html>