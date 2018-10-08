<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<%@include file="../include/header.jsp" %>
<div class="container mt-5">
	<ul class="nav nav-tabs nav-pills">
	  <li class="nav-item">
	    <a class="nav-link active" href="/user/myPage">내 정보</a>
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
		<div class="card flex-fill">
		  <img class="card-img-top" src="http://placehold.it/500x420" alt="Card image cap">
		  <div class="card-body">
		    <p class="card-text">
		    	<button type="button" class="btn btn-primary">이미지 등록</button>
		    	<br>
		    	<button type="button" class="btn btn-link">회원탈퇴</button>
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
				<td>${userVO.regdate }</td>
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
<%@include file="../include/footer.jsp" %>

</body>
</html>
