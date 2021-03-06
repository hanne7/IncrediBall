<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</head>
<body class="bg-light">
<c:import url="/header"/>
<div class="container mt-5">
	<ul class="nav nav-tabs nav-pills">
	  <li class="nav-item">
	    <a class="nav-link text-light bg-secondary" href="/user/myPage">내 정보</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="/user/modifyPage">회원정보수정</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="#">작성글 보기</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="#">작성댓글 보기</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" href="#">쪽지함</a>
	  </li>
	</ul>
	<div class="d-flex justify-content-around border">
		<div class="card">
		<c:if test="${userVO.imgName == null }">
			<img class="card-img-top" src="http://placehold.it/500x360" alt="Card image cap">
		</c:if>
		<c:if test="${userVO.imgName != null }">
			<img width="500" class="card-img-top" src="/user/displayImg?imgName=${userVO.imgName }" alt="Card image cap">
		</c:if>  
		  <div class="card-body">
		    <p class="card-text">
		    	<form action="/user/addImg" method="post" enctype="multipart/form-data">
		    		<input type="file" name="imgFile" accept="image/*">
		    		<input type="hidden" name="idx" value="${userVO.idx }">
		    		<button id="imgBtn" type="submit" class="btn btn-success">이미지 등록</button>
		    	</form>
		    	<br>
		    	<button id="deleteBtn" type="button" class="btn btn-danger mt-2">회원탈퇴</button>
		    </p>
		  </div>
		</div>
		<table class="table table-bordered flex-fill text-center ml-3">
			<tr>
				<td class="bg-dark text-white w-25">ID</td>
				<td>${userVO.userid }</td>
			</tr>
			<tr>
				<td class="bg-dark text-white w-25">필명</td>
				<td>${userVO.nickname }</td>
			</tr>
			<tr>
				<td class="bg-dark text-white w-25">이름</td>
				<td>${userVO.username }</td>
			</tr>
			<tr>
				<td class="bg-dark text-white w-25">회원가입일</td>
				<td><fmt:formatDate value="${userVO.regdate }" pattern="yyyy년  MM월  dd일"/> </td>
			</tr>
			<tr>
				<td class="bg-dark text-white w-25">포인트</td>
				<td>${userVO.userpoint }</td>
			</tr>
			<tr>
				<td class="bg-dark text-white w-25">레벨</td>
				<td>${userVO.usergrade }</td>
			</tr>
		</table>	
	</div>
</div>
<form role="form1" method="post">
	<input type="hidden" name="idx" value="${userVO.idx }">
</form>
<c:import url="/footer"/>
<script type="text/javascript">
	var result = '${msg}';
	if(result == 'SUCCESS'){
		alert("처리가 완료되었습니다.");
	}
	
	var formObj = $("form[role='form1']");
	
	$('#deleteBtn').on("click", function(){
		var del = confirm('탈퇴하시겠습니까?');
		if(del == true){
			formObj.attr("action", "/user/delete");
			formObj.submit();
		}
	});
	
</script>

</body>
</html>
