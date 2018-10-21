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
<c:import url="/header"/>
<div class="container mt-5">
	<ul class="nav nav-tabs nav-pills">
	  <li class="nav-item">
	    <a class="nav-link" href="/user/myPage">내 정보</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link text-light bg-secondary" href="/user/modifyPage">회원정보수정</a>
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
	<div>
		<form method="post" action="/user/modify" onsubmit="return confirm('수정하시겠습니까?')">
			<div class="form-group">
				<label for="userid">ID</label> 
				<input type="text" class="form-control form-control-sm" name="userid"
					value="${userVO.userid }">
			</div>
			<div class="form-group">
				<label for="password">Password</label> 
				<input type="password" class="form-control form-control-sm" name="password"
					value="${userVO.password }">
			</div>
			<div class="form-group">
				<label for="username">이름</label> 
				<input type="text" class="form-control form-control-sm" name="username"
					value="${userVO.username }">
			</div>
			<div class="form-group">
				<label for="email">Email address</label>
				<input type="email" class="form-control form-control-sm" name="email"	
					aria-describedby="emailHelp" value="${userVO.email }"> <small
					id="emailHelp" class="form-text text-muted">We'll never
					share your email with anyone else.</small>
			</div>
			<div class="form-group">
				<label for="nickname">필명</label> 
				<input type="text" class="form-control form-control-sm" name="nickname"
					value="${userVO.nickname }">
			</div>
			<div class="form-group">
				<label for="phone">연락처</label> 
				<input type="text" class="form-control form-control-sm" name="phone"
					value="${userVO.phone }">
			</div>
			<div class="form-group">
				<label for="address">주소</label> 
				<input type="text" class="form-control form-control-sm" name="address"
					value="${userVO.address }">
			</div>
			<input type="hidden" name="idx" value="${userVO.idx }">
			<button type="submit" class="btn btn-secondary">수정하기</button>
		</form>	
	</div>
</div>
<c:import url="/footer"/>

</body>
</html>
