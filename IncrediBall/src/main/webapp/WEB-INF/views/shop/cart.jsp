<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
<meta charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>IncrediBall</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</head>
<body class="bg-light">
<c:import url="/header"/>
<div class="container mt-4">
	<div class="ml-3">
		<h4>>장바구니</h4>
	</div>
	<div class="d-flex justify-content mt-3 mr-3">
		<div class="ml-3">
			<img src="http://placehold.it/200x150">
		</div>
		<div class="m-auto">
			<h5>축구화1</h5>
		</div>
		<div class="m-auto">
			<h5>10000원</h5>
		</div>
		<div class="m-auto">
			<h5>1개</h5>
		</div>
		<div class="m-auto">
			<a href="/shop/order"><h5>주문하기</h5></a>
		</div>
	</div>
</div>
<c:import url="/footer"/>
</body>
</html>
