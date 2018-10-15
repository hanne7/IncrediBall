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
<c:if test="${count == 0}">
	<script type="text/javascript">alert('존재하지 않는 id거나 잘못된 password 입니다.') </script>
	<% session.removeAttribute("count"); %>
</c:if>
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
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-success" onclick="location.href='/user/join'">Join Us</button>
        <button type="submit" class="btn btn-primary">Login</button>
      </div>
      </form>
    </div>
    </div>
</div>
<c:import url="/footer"/>
</body>
</html>
