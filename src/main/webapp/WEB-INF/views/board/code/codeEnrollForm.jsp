<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/ckeditor5-classic-plus@36.0.1/build/ckeditor.min.js"></script>
<!-- 				   
<script src="https://cdn.jsdelivr.net/npm/ckeditor5-upload-adapter@1.0.3/src/uploadadapter.min.js"></script>
 -->
<script src="resources/js/UploadAdapter.js"></script>
<title>코드리뷰</title>
<style>

	button[type="submit"] {
      border: 0px;
      color: white;
      padding: 6px;
      border-radius: 8px;
      background-color: #5271FF;
      }
      
    button[type="reset"] {
      border: 0px;
      color: black;
      padding: 6px;
      border-radius: 8px;
      background-color: lightgray;
      }
      
    .Outer {
	  height:1600px;
	  width:1200px;
	 
	  border-radius: 15px;
	  margin-top:20px;
	  padding:45px;
	  padding-top: 10px;      	
      
      }
      
	.ck.ck-editor {
    	max-width: 1100px;
    	margin: 0 auto;
	}
	.ck-editor__editable {
		height: 1200px;
	    max-height: 1200px;
	    overflow-y: auto;
	}	
	
</style>
</head>
<body>

<jsp:include page="../../common/header.jsp" />


    <div class="content">
    	<hr>
    	<br><br>
        
        <h4 style="color : #5271FF;"><b style="padding-left: 50px;">코드리뷰 글쓰기</b></h4>
        <div class="Outer">
        <div class="innerOuter">
        	<form id="enrollForm" method="post" action="insert.co" enctype="multipart/form-data">
                
                <input type="hidden" id="cboardContent" name="cboardContent" value="">
                <table align="center">
                    <tr>
                        <th><label for="title"></label></th>
                        <td><input type="text" id="title" class="form-control" name="cboardTitle" placeholder="제목을 입력하세요." style="width:1100px;" required></td>
                    </tr>
                    <tr>
                        <th><label for="writer"></label></th>
                        <td><input type="text" id="writer" class="form-control" value="${ sessionScope.loginMember.memberName }" name="cboardWriter" readonly></td>
                    </tr>
                    <tr>
                        <th><label for="tag"></label></th>
                        <td><jsp:include page="../../common/tagTech.jsp" /></td>
                    </tr>
                    <tr>
                        <th><label for="upfile"></label></th>
                        <td><input type="file" id="upfile" class="form-control-file border" name="upfile"></td>
                    </tr>
                    <tr>
                    	<th><label for="content"></label></th>
                    	<td>
                    	    <div id="editor">
					        	<p id="">내용을 입력하세요.</p>
					    	</div>


						<script>
						    function MyCustomUploadAdapterPlugin(editor) {
						        editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
						            return new UploadAdapter(loader);
						        };
						        
						        console.log(editor.plugins.get('FileRepository'));
						    }
						    
					    
					        ClassicEditor
					            .create( document.querySelector( '#editor' ), {
					            	language:'ko',
					            	extraPlugins: [MyCustomUploadAdapterPlugin],
					            	
					            })
					            .then(editor => {
					                window.editor = editor;
					            })
					            .catch( error => {
					                console.error( error );
					            } );
					    </script>
					    </td>
                    </tr>
                    </table>
                   
                <br>

                <div align="center">
                	<button type="reset" class="">취소하기</button>
                    <button type="submit" class="" onclick="setContent();">등록하기</button>
                </div>
            </form>
            
            <script>
            	function setContent() {
            		
            		
            		let value = editor.getData();
            	
            	    editor.setData(value);
            		
            		
            		$("#cboardContent").val(value);
            		
            		console.log($("#cboardContent").val());
            	}
            </script>
        </div>
        </div>
        <br><br>

    </div>
    
    <jsp:include page="../../common/footer.jsp" />


</body>
</html>