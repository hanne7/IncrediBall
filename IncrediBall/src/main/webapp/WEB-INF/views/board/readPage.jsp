<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${boardVO.title }</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</head>
<body class="bg-light">
<%@include file="../include/header.jsp" %>
<div class="container">
	<table class="table table-sm mt-5 mb-0 text-center">
		<tr>
			<td class="bg-dark text-white w-25">제목</td>
			<td colspan="3"><b>${boardVO.title }</b></td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25">작성자</td>
			<td colspan="3">${boardVO.nickname }(${boardVO.userid })</td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25">작성시간</td>
			<td>${boardVO.regdate }</td>
			<td class="bg-dark text-white w-25">마지막수정시간</td>
			<td>${boardVO.moddate }</td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25" colspan="4">글 내용</td>
		</tr>
	</table>
	<% pageContext.setAttribute("newLineChar", "\r\n"); %>
	<div class="container-fluid" style="height:500px; overflow: scroll">
		${fn:replace(boardVO.content, newLineChar, "<br/>")}		
	</div>
	<div class="btn-group d-flex justify-content-end" role="group" aria-label="boardbtn">
	  <button type="button" class="btn btn-secondary" onclick="location.href='/board/'">목록</button>
	  <button type="button" class="btn btn-secondary" onclick="location.href='/board/create'">글쓰기</button>
	  <c:if test="${boardVO.userid == login.userid }">
		<button type="button" class="btn btn-secondary" onclick="location.href='/board/modify?bno=${boardVO.bno}'">글수정</button>
	  	<button type="button" class="btn btn-secondary" onclick="location.href='/board/delete?bno=${boardVO.bno}'">글삭제</button>
	  </c:if>
	</div>
</div>
<%@include file="../include/footer.jsp" %>

</body>
</html>
