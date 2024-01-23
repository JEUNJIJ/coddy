<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<style>

.form_outer{
    width: 1200px;
    box-shadow: 0 3px 28px 0 rgba(0,0,0,.04);
    padding: 10px;
}

.form_area{
    width: 1080px;
    margin: auto;
    
}

.question{
    margin-top: 80px;
}

.project_name{
    margin-top: 50px;
}

.input-wrapper input {
    width: 100%;
    border: 1px solid rgb(219, 213, 213);
    padding: 8px;
    font-size: 1rem;
    border-radius: 8px;
    color: black;
}

.question input:focus {
    outline-color: #5271FF;
}

/* 이미지 업로드 */
.img{
    border: 2px dashed #cacaca;
}

.question textarea {
  border-radius: 8px;
  height: 500px;
  width: 100%;
  resize: none;
  outline: 0;
  padding: 8px 14px;
  border: 1px solid rgb(219, 213, 213);
}

.question textarea:focus {
    outline-color: #5271FF;
}

.img_file{
    border: 1px solid #cacaca;
    border-radius: 2px;
    display: inline-block;
    text-align: center;
    margin: auto;
}
.img_name{
    display: inline-block;
}


/* 모집인원 */
#skills{
    width: 50%;
    border: 1px solid rgb(219, 213, 213);
    padding: 8px;
    font-size: 1rem;
    border-radius: 8px;
    color: black;
}
#skills:focus {
    outline-color: #5271FF;
}

.personnel{
    margin-left: 10px;
    display: inline-block;
}
.minus, .plus{
    cursor: pointer;
}

.personnel div{
    display: inline-block;
    margin: 15px;
    font-size: 20px;
}
.personnel_btns{
    float: right;
}

.date>input{
    width: 35%;
    border: 1px solid rgb(219, 213, 213);
    padding: 8px;
    font-size: 1rem;
    border-radius: 8px;
    color: black;
}

/* 모집인원 */
#location{
    width: 50%;
    border: 1px solid rgb(219, 213, 213);
    padding: 8px;
    font-size: 1rem;
    border-radius: 8px;
    color: black;
}
#location:focus {
    outline-color: #5271FF;
}

.write_btn{
    margin: 80px;
    text-align: center;
}

</style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />	  
    <div class="content">
        <div class="content_title">
            <h2>팀원 모집 생성</h2> 
        </div>
        <div class="form_outer">
            <form class="form_area" action="insert.rec" method="post" enctype="multipart/form-data">
                <input type="hidden" name="recruitmentWriter" value="${sessionScope.loginMember.memberNo}">
                <div class="project_name">
                    <h3>프로젝트명</h3>
                    <div class="input-wrapper">
                        <input type="text" name="recruitmentTitle" class="input" required id="title" maxlength="20">
                    </div>
                </div>
                <script>
                    $("#title").val().length
                    </script>

                <div class="question">
                    <h3>간단소개</h3>
                    <div class="input-wrapper">
                        <input type="text" name="recruitmentIntro" class="input" required>
                    </div>
                </div>
                
                <div class="question">
                    <h3>대표이미지</h3>
                    <img style="cursor: pointer; border: 3px dotted lightgray;" id="titleImg" width="250" height="170" src="resources/image/white.jpg">
                    <img style="cursor: pointer; border: 3px dotted lightgray;" id="contentImg1" width="150" height="120" src="resources/image/white.jpg">
                    <img style="cursor: pointer; border: 3px dotted lightgray;" id="contentImg2" width="150" height="120" src="resources/image/white.jpg">
                    <img style="cursor: pointer; border: 3px dotted lightgray;" id="contentImg3" width="150" height="120" src="resources/image/white.jpg">
                    <div id="img_list">
                        <input type="file" id="file1" name="titleImg" accept="image/*" onchange="loadImg(this,1);" required> 
                        <input type="file" id="file2" name="img" accept="image/*" onchange="loadImg(this,2);">
                        <input type="file" id="file3" name="img" accept="image/*" onchange="loadImg(this,3);">
                        <input type="file" id="file4" name="img" accept="image/*" onchange="loadImg(this,4);">
                    </div>
                    <br>
                    <span>대표사진은 필수 입니다.</span><br>
                </div>
               
                <div class="question">
                    <h3>설명</h3>
                    <textarea id="content" name="recruitmentContent" required></textarea>
                </div>
                <div class="question">
                    <h3>기술/언어</h3>
                    <jsp:include page="../../common/tagTech.jsp" />
                </div>

                <div class="question">                  
                    <h3>모집인원</h3>
                        <select id="skills" name="position">
                            <option>Project Manager</option>                                            
                            <option>Project Planner</option>                             
                            <option>FE</option>                             
                            <option>BE</option>                             
                            <option>DB Manager</option>                             
                            <option>CDN</option>                             
                            <option>Design</option>                             
                            <option>3D Model</option>                             
                            <option>UI/UX Planner</option>                             
                            <option>UI/UX Designer</option>  
                            <option>Web Publisher</option>   
                            <option>Web Server Developer</option>   
                            <option>Network and Server</option>   
                            <option>IOS Developer</option>   
                            <option>AOS Developer</option>   
                            <option>Data Scientist</option>   
                            <option>ML/AI</option>   
                            <option>Game Designer</option>   
                            <option>Game Developer</option>   
                            <option>System Manager</option>   
                            <option>Translation</option>   
                            <option>Embeded/IOT</option>
                            <option>Secure Coding</option>
                            <option>Block Chain</option>
                            <option>QA</option>
                            <option>R/D</option>
                            <option>Marketing/Sale</option>
                            <option>DX Design</option>
                            <option>Algorithm Developer</option>
                        </select>
                    <input id="project_member" type='number' name="personnelMax" required>
                        <div class="member_list">
                            <div class="project_member">                               
                            </div>
                        </div>
                    <div class="personnel_btns">
                        <button type="button" id="personnel_add">추가</button>
                        <button type="button" id="personnel_remove">삭제</button>       
                    </div>
                </div>

                <div class="question date">
                    <h3>프로젝트 기간</h3>
                    <input type="date" id="start_date" name="recruitmentStart" required> ~ <input type="date" id="end_date" name="recruitmentEnd" required>
                </div>

                <div class="question">
                    <h3>지역</h3>
                    <select  id="location" name="recruitmentLocation">
                        <option>미지정</option>
                        <option>서울특별시</option>
                        <option>경기도</option>
                        <option>부산광역시</option>
                        <option>인천광역시</option>
                        <option>경상남도</option>
                        <option>경상북도</option>
                        <option>대전광역시</option>
                        <option>충청남도</option>
                        <option>충청북도</option>
                        <option>전라남도</option>
                        <option>전라북도</option>
                        <option>광주광역시</option>
                        <option>강원도</option>
                        <option>울산광역시</option>
                        <option>제주특별자치도</option>
                    </select>
                </div>
                
                <div class="write_btn">
                    <button type="submit">작성완료</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="../../common/footer.jsp" />	  
</body>
<script>  
$(function(){
	
	$("tagTechName").prop("required",true);
    $("#titleImg").click(function(){
        $("#file1").click();
    });
    $("#contentImg1").click(function(){
        $("#file2").click();
    });
    $("#contentImg2").click(function(){
        $("#file3").click();
    });
    $("#contentImg3").click(function(){
        $("#file4").click();
    });
    $("#img_list").hide();
});
function loadImg(inputFile, num){
    if(inputFile.files.length == 1){
        let reader = new FileReader();
        reader.readAsDataURL(inputFile.files[0]);
        reader.onload = function(e) {
            switch(num){
                case 1: $("#titleImg").attr("src",e.target.result);
                        break;
                case 2: $("#contentImg1").attr("src",e.target.result);
                        break;
                case 3: $("#contentImg2").attr("src",e.target.result);
                        break;
                case 4: $("#contentImg3").attr("src",e.target.result);
                        break;
            }
        };
    }else{
        switch(num){
            case 1: $("#titleImg").attr("src",null); 
                    break;
            case 2: $("#contentImg1").attr("src",null); 
                    break;
            case 3: $("#contentImg2").attr("src",null); 
                    break;
            case 4: $("#contentImg3").attr("src",null); 
                    break;
            }
        }
    }
    // 파일 추가
    function addFile() {
            var str = "<div class='file-group'><input type='file' name='files' accept='image/*'><a href='#this' name='file-delete'>삭제</a></div>";
            $(".img_list").append(str);

            $("a[name='file-delete']").on("click", function(e) {
                e.preventDefault();
                deleteFile($(this));
            }); 
        }
    // 파일 삭제
    function deleteFile(obj) {
        obj.parent().remove();
    }
    
    $(document).on("change", "#project_member", function() {
    // Get the value and convert it to a number
    let memberIndex = parseInt($("#project_member").val(), 10);

        if (memberIndex < 1) {
            $("#project_member").val(1); 
        }
        if(memberIndex > 5){
            $("#project_member").val(5); 
        }
    
    });

    $(document).ready(function() {
        
        $("a[name='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
   
        // 모집인원 추가
        $("#personnel_add").on("click",function(){
            let $list = $(  
                            "<div class='project_member'>"+
                            "<select id='skills' name='position'"+
                            "<option>PM</option>"+                                           
                            "<option>Project Planner</option>"+                             
                            "<option>FE</option>"+                             
                            "<option>BE</option>"+                             
                            "<option>DB Manager</option>"+                             
                            "<option>CDN</option>"+                             
                            "<option>Design</option>"+                             
                            "<option>3D Model</option>"+                             
                            "<option>UI/UX Planner</option>"+                             
                            "<option>UI/UX Designer</option>"+  
                            "<option>Web Publisher</option>"+   
                            "<option>Web Server Developer</option>"+   
                            "<option>Network and Server</option>"+   
                            "<option>IOS Developer</option>"+   
                            "<option>AOS Developer</option>"+   
                            "<option>Data Scientist</option>"+   
                            "<option>ML/AI</option>"+   
                            "<option>Game Designer</option>"+   
                            "<option>Game Developer</option>"+   
                            "<option>System Manager</option> "+  
                            "<option>Translation</option>"+   
                            "<option>Embeded/IOT</option>"+
                            "<option>Secure Coding</option>"+
                            "<option>Block Chain</option>"+
                            "<option>QA</option>"+
                            "<option>R/D</option>"+
                            "<option>Marketing/Sale</option>"+
                            "<option>DX Design</option>"+
                            "<option>Algorithm Developer</option>"+
                                "</select>"+
                                "<input type='number' id='project_member' name='personnelMax'required>"+
                            "</div>");           
            $(".member_list").append($list);
        });
        // 모집인원 삭제
        $("#personnel_remove").on("click",function(){
            $(".project_member").eq($(".member_list").children().length-1).remove();
        });


        // 모집인원수 감소
        $(document).on("click", ".minus", function() {
            let i = parseInt($(this).siblings(".countNumber").text());
            
            if(i>0){
                i = i-1;
                $(this).siblings(".countNumber").text(i);
            }
            console.log(i);
        });
        // 모집인원수 증가
        $(document).on("click", ".plus", function() {           
            let i = parseInt($(this).siblings(".countNumber").text());
            i = i+1;
           $(this).siblings(".countNumber").text(i);
           
           
           console.log(i);
        });
	
       
      

    });
</script>
