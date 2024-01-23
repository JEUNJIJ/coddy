<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글작성</title>
</head>
<style>
    #freeEnrollForm>table {width:100%;}
    #freeEnrollForm>table * {margin:5px;}
    .innerOuter {
        border:1px solid lightgray;
        width:80%;
        margin:auto;
        padding:5% 10%;
        background-color:white;
    }
</style>
<body>

    <jsp:include page="../../common/header.jsp" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2 style="color:#5271FF;">자유롭게 작성하기</h2>
            <p class="subtitle">무엇이든 작성해 보아요.</p>
            <br>

            <form id="freeEnrollForm" method="post" action="insert.fr" enctype="multipart/form-data">
                <table align="center">
                    <tr>
                        <th><label for="title">제목</label></th>
                        <td><input type="text" id="fboardTitle" class="form-control" name="fboardTitle" required></td>
                    </tr>
                    <tr>
                        <th><label for="writer">작성자</label></th>
                        <td><input type="text" id="fboardWriter" class="form-control" value="${ sessionScope.loginMember.memberId }" name="fboardWriter" readonly></td>
                    </tr>
                    <tr>
                        <th><label for="upfile">첨부파일</label></th>
                        <td><input type="file" id="upfile" class="form-control-file border" name="upfile"></td>
                    </tr>
                    
              <script>					    
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

					    $(document).ready(function() {
					        $("a[name='file-delete']").on("click", function(e) {
					            e.preventDefault();
					            deleteFile($(this));
					        });
					    });
		    </script>
                    
                    <tr>
                        <th><label for="content">내용</label></th>
                        <td><textarea id="fboardContent" class="form-control" rows="10" style="resize:none;" name="fboardContent" required></textarea></td>
                    </tr>
                </table>
                <br>

                <div align="center">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-danger">취소하기</button>
                </div>
            </form>
        </div>
        <br><br>

    </div>  
    
    <jsp:include page="../../common/footer.jsp" />  

</body>
</html>