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
	<c:forEach items="${carts }" var="productVO">
		<div class="d-flex justify-content mt-3 mr-3">
			<div class="ml-3">
				<img src="/displayProduct?fileName=${productVO.fullname }" width="200" height="100">
			</div>
			<div class="m-auto">
				<h5>${productVO.productName }</h5>
			</div>
			<div class="m-auto">
				<h5><fmt:formatNumber value="${productVO.cost }" pattern="#,###"/>원</h5>
			</div>
			<div class="m-auto">
				<h5>${productVO.quantity }</h5>
			</div>
			<div class="m-auto">
				<a href="/shop/order"><h5>주문하기</h5></a>
			</div>
		</div>
	</c:forEach>
</div>
<c:import url="/footer"/>
</body>
</html>
