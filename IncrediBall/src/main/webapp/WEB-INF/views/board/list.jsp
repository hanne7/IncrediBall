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
<title>게시판</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</head>
<body class="bg-light">
<%@include file="../include/header.jsp" %>
<div class="container">
	<nav class="nav nav-pills nav-justified bg-light border">
		<a class="nav-item nav-link" href="#">공지사항</a>
		<a class="nav-item nav-link text-light bg-secondary" href="#">전체보기</a>
		<a class="nav-item nav-link" href="#">축구게시판</a>
		<a class="nav-item nav-link" href="#">자유게시판</a>
		<a class="nav-item nav-link" href="#">프로토분석</a>
		<a class="nav-item nav-link" href="#">QnA</a>
	</nav>
	<table class="table table-hover">
	  <thead class="thead-light">
	    <tr>
	      <th class="text-center" scope="col">no.</th>
	      <th class="text-center" scope="col">제 목</th>
	      <th class="text-center" scope="col">글쓴이</th>
	      <th class="text-center" scope="col">작성시간</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:forEach items="${list }" var="boardVO">
	    	<tr>
	      		<th scope="row" class="text-center">${boardVO.bno }</th>
	      		<td class="w-50 text-center"><a href="/board/readPage${pm.makeQuery(pm.cri.page)}&bno=${boardVO.bno}">${boardVO.title }</a></td>
	      		<td class="text-center">${boardVO.nickname }</td>
	      		<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate }"/></td>
	    	</tr>
	    </c:forEach>
	  </tbody>
	</table>
	<div class="d-flex text-center justify-content-end mt-3">
	  <ul class="pagination mr-auto ml-auto">
	  	<c:if test="${pm.prev }">
	  		<li class="page-item"><a class="page-link" href="list${pm.makeQuery(pm.startPage-1) }">&laquo;</a></li>
	  	</c:if>
	    <c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="idx">
  		   	<%-- <li <c:out value="${pm.cri.page == idx?'class= page-item active':'class= page-item'}"/>>
  		   		<a class="page-link" href="list${pm.makeQuery(idx) }">${idx }</a>
  		   	</li> --%>
  		   	<c:if test="${pm.cri.page == idx }">
  		   		<li class="page-item active"><a class="page-link" href="list${pm.makeQuery(idx) }">${idx }</a>
  		   	</c:if>
  		   	<c:if test="${pm.cri.page != idx }">
  		   		<li class="page-item"><a class="page-link" href="list${pm.makeQuery(idx) }">${idx }</a>
  		   	</c:if>
	    </c:forEach>
	    <c:if test="${pm.next && pm.endPage>0 }">
	    	<li class="page-item"><a class="page-link" href="list${pm.makeQuery(pm.endPage+1) }">&raquo;</a></li>
	    </c:if>	    
	  </ul>
	  <button type="button" class="ml-5 btn btn-secondary h-75 mr-3" onclick="location.href='/board/create'">글쓰기</button>
	</div>
</div>
<%@include file="../include/footer.jsp" %>
<script type="text/javascript">
	var result = '${msg}';
	if(result == 'SUCCESS'){
		alert("처리가 완료되었습니다.");
	}
</script>
</body>
</html>
