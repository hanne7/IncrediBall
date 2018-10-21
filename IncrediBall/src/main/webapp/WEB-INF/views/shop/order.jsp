<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
		<h4>>주문하기</h4>
	</div>
	<div class="d-flex justify-content mt-3 mr-3">
		<div id="product-info">
				<h4>${productOrderViewVO.productName}</h4>
				<label>가격 : </label>
				<p><b><fmt:formatNumber value="${productOrderViewVO.productPrice}" pattern="#,###" />원</b></p>
				<label>설명 : </label>
				<p>${productOrderViewVO.productDescription}</p>
				<label>수량선택 : </label>
				<p>
				<form action="payProduct.do" method="post" onsubmit="return confirm('결재 하시겠습니까?')">
				<input type="number" name="qty" value="${productOrderViewVO.qty}">
				</p>
				<label>결제방식선택 : </label>
				<select name="paymentType">
					<option value="CASH" <c:if test="${productOrderViewVO.paymentType eq 'CASH'}">selected</c:if> >현금</option>
					<option value="CARD" <c:if test="${productOrderViewVO.paymentType eq 'CARD'}">selected</c:if> >신용카드</option>
					<option value="VA" <c:if test="${productOrderViewVO.paymentType eq 'VA'}">selected</c:if> >가상계좌</option>
					<option value="MOBILE" <c:if test="${productOrderViewVO.paymentType eq 'MOBILE'}">selected</c:if> >휴대폰결제</option>
					<option value="PAY" <c:if test="${productOrderViewVO.paymentType eq 'PAY'}">selected</c:if> >카카오페이</option>
				</select>				
				<input type="hidden" name="idx" value="${productOrderViewVO.idx}">
				<p>					
					<input type="submit" value="결제" class="w3-button w3-black">
				</p>
				</form>
			</div>>
	</div>
</div>
<c:import url="/footer"/>
</body>
</html>
