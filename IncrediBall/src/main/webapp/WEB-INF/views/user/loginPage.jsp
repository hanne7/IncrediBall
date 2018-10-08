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
	  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
      </div>
      <div class="modal-body">
        <form action="/user/login" method="post">
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
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary">Login</button>
      </div>
      </form>
    </div>
</div>
<%@include file="../include/footer.jsp" %>

</body>
</html>
