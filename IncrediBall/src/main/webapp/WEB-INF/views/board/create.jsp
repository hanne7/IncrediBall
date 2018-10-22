<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>글쓰기</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

<style type="text/css">
	.fileDrop{
		width: 100%;
		height: 100%;
		border: 1px dotted gray;
		background-color: lightslategrey;
		margin: auto;
	}
</style>

</head>
<body class="bg-light">
<c:import url="/header"/>
<div class="container">
	<p><h4>글쓰기</h4></p>
	<form id="createForm" method="post">
		<div class="form-group">
			<label for="nickname">필명</label> 
			<input type="text" class="form-control form-control-sm" name="nickname"
				value="${userVO.nickname }" readonly="readonly">
		</div>
		
		<div class="form-group w-25">
			<select class="form-control form-control-sm" name="category">
				<option value="1" <c:if test="${cate==1}">selected</c:if>>공지사항</option>
				<option value="2" <c:if test="${cate==2}">selected</c:if>>축구게시판</option>
				<option value="3" <c:if test="${cate==3 || cate==0}">selected</c:if>>자유게시판</option>
				<option value="4" <c:if test="${cate==4}">selected</c:if>>프로토분석</option>
				<option value="5" <c:if test="${cate==5}">selected</c:if>>QnA</option>
			</select>	
		</div>
		
		<div class="d-flex justify-content-start">
			<div class="form-group" style="width: 60%;">
				<label for="title">제목</label> 
				<input type="text" class="form-control form-control-sm" name="title" id="title"
					placeholder="글 제목을 입력하세요">
			</div>
			<div class="form-group mx-auto">
				<label for="attach">첨부파일을 이곳에 drop 해주세요.</label>
				<div class="fileDrop"></div>
			</div>
		</div>
		<ul class="d-flex justify-content-start clearfix border uploadedList">
		</ul>
		<div class="form-group">
			<label for="content">내용</label> 
			<textarea class="form-control" name="content" rows=13 id="content"
				placeholder="내용을 입력하세요."></textarea>
		</div>
		<input type="hidden" name="useridx" value="${userVO.idx }">
		<button type="submit" class="btn btn-primary">글쓰기</button>
	</form>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript" src="/resources/js/upload.js"></script>

<script id="template" type="text/x-handlebars-template">
<li class="border ml-3" style="list-style-type: none;">
	<span><img src="{{imgsrc}}" alt="Attachment"></span>
	<br>
	<a href="{{getLink}}">{{fileName}}</a>
	<button type="button" class="btn close" href="{{fullName}}"><span aria-hidden="true">&times;</span></button>
</li>
</script>

<script type="text/javascript">
var template = Handlebars.compile($("#template").html());

$(".fileDrop").on("dragenter dragover", function(event){
	event.preventDefault();
});

$(".fileDrop").on("drop", function(event){
	event.preventDefault();
	
	var files = event.originalEvent.dataTransfer.files;
	
	var file = files[0];
	
	var formData = new FormData();
	
	formData.append("file", file);
	
	$.ajax({
		url:'/uploadAjax',
		data:formData,
		dataType:'text',
		processData:false,
		contentType:false,
		type:'POST',
		success:function(data){
			var fileInfo = getFileInfo(data);
			var html = template(fileInfo);
			$(".uploadedList").append(html);
		}
	});
});

$("#createForm").submit(function(event){
	event.preventDefault();
	
	if(validate()==false){
		return false; 
	}	
	var that = $(this);
	var str = "";
	
	$(".uploadedList .btn").each(function(index){
		str += "<input type='hidden' name='files[" + index + "]' value='" + $(this).attr("href") + "'>";
	});
	
	that.append(str);
	var cf = confirm('작성하시겠습니까?');
	if(cf==true){
		that.get(0).submit();	
	}else{
		false;	
	}	
});

$(".uploadedList").on("click","button", function(event){
	var that = $(this);
	
	$.ajax({
		url:"/deleteFile",
		type:"post",
		data:{fileName:$(this).attr("href")},
		dataType:"text",
		success:function(result){
			if(result == 'deleted'){
				alert("deleted");
				that.parent("li").remove();
			}
		}
	});
});

function validate(){
	if($.trim($('#title').val())==''){
		alert("제목을 입력해주세요.");
		$('#title').focus();
		return false;
	}
	if($.trim($('#content').val())==''){
		alert("내용을 입력해주세요.");
		$('#content').focus();
		return false;
	}
	return true;
}

</script>


<c:import url="/footer"/>
</body>
</html>
