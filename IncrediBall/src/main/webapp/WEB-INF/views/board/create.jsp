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

</head>
<body class="bg-light">
<%@include file="../include/header.jsp" %>
<div class="container">
	<p><h4>글쓰기</h4></p>
	<form method="post" onsubmit="return confirm('작성하시겠습니까?')">
		<div class="form-group">
			<label for="nickname">필명</label> 
			<input type="text" class="form-control form-control-sm" name="nickname"
				value="${userVO.nickname }" readonly="readonly">
		</div>
		<div class="form-group">
			<label for="title">제목</label> 
			<input type="text" class="form-control form-control-sm" name="title"
				placeholder="글 제목을 입력하세요">
		</div>
		<div class="form-group">
			<label for="content">내용</label> 
			<textarea class="form-control" name="content" rows=14
				placeholder="내용을 입력하세요."></textarea>
		</div>
		<input type="hidden" name="useridx" value="${userVO.idx }">
		<button type="submit" class="btn btn-primary">글쓰기</button>
	</form>
</div>
<%@include file="../include/footer.jsp" %>

</body>
</html>
