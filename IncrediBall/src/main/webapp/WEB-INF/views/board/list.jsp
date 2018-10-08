<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</head>
<body class="bg-light">
<%@include file="../include/header.jsp" %>
<div class="container">
	<table class="table table-hover">
	  <thead class="thead-light">
	    <tr>
	      <th class="text-center" scope="col">no.</th>
	      <th class="text-center" scope="col">title</th>
	      <th class="text-center" scope="col">writer</th>
	      <th class="text-center" scope="col">regdate</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:forEach items="${list }" var="boardVO">
	    	<tr>
	      		<th scope="row" class="text-center">${boardVO.bno }</th>
	      		<td class="w-50 text-center">${boardVO.title }</td>
	      		<td class="text-center">${boardVO.nickname }</td>
	      		<td class="text-center">${boardVO.regdate }</td>
	    	</tr>
	    </c:forEach>
	  </tbody>
	</table>
</div>
<%@include file="../include/footer.jsp" %>

</body>
</html>
