<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</head>
<body class="bg-light">
<%@include file="../include/header.jsp" %>
<div class="container">
	<p><h4>회원가입</h4></p>
	<form method="post" onsubmit="return confirm('가입하시겠습니까?')">
		<div class="form-group">
			<label for="userid">ID</label> 
			<input type="text" class="form-control form-control-sm" name="userid"
				placeholder="ID를 입력하세요">
		</div>
		<div class="form-group">
			<label for="password">Password</label> 
			<input type="password" class="form-control form-control-sm" name="password"
				placeholder="Password를 입력하세요">
		</div>
		<div class="form-group">
			<label for="username">이름</label> 
			<input type="text" class="form-control form-control-sm" name="username"
				placeholder="이름을 입력하세요">
		</div>
		<div class="form-group">
			<label for="email">Email address</label>
			<input type="email" class="form-control form-control-sm" name="email"	
				aria-describedby="emailHelp" placeholder="Email을 입력하세요"> <small
				id="emailHelp" class="form-text text-muted">We'll never
				share your email with anyone else.</small>
		</div>
		<div class="form-group">
			<label for="nickname">필명</label> 
			<input type="text" class="form-control form-control-sm" name="nickname"
				placeholder="사용하실 필명을 입력하세요">
		</div>
		<div class="form-group">
			<label for="phone">연락처</label> 
			<input type="text" class="form-control form-control-sm" name="phone"
				placeholder="연락가능한 번호를 입력하세요">
		</div>
		<div class="form-group">
			<label for="address">주소</label> 
			<input type="text" class="form-control form-control-sm" name="address"
				placeholder="주소를 입력하세요">
		</div>
		<button type="submit" class="btn btn-primary">가입하기</button>
	</form>
</div>
<%@include file="../include/footer.jsp" %>

</body>
</html>
