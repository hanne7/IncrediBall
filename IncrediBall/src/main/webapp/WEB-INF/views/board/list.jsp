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
<c:import url="/header"/>
<div class="container mt-2"><h4 class="ml-3">>BOARD</h4></div>
<div class="container mt-2">
	<nav class="nav nav-pills nav-justified bg-light border">
		<a class="nav-item nav-link <c:if test="${pm.cri.getCate()==1 }">text-light bg-secondary</c:if>" href="/board/list?cate=1">공지사항</a>
		<a class="nav-item nav-link <c:if test="${pm.cri.getCate()==0 }">text-light bg-secondary</c:if>" href="/board/list?cate=0">전체보기</a>
		<a class="nav-item nav-link <c:if test="${pm.cri.getCate()==2 }">text-light bg-secondary</c:if>" href="/board/list?cate=2">축구게시판</a>
		<a class="nav-item nav-link <c:if test="${pm.cri.getCate()==3 }">text-light bg-secondary</c:if>" href="/board/list?cate=3">자유게시판</a>
		<a class="nav-item nav-link <c:if test="${pm.cri.getCate()==4 }">text-light bg-secondary</c:if>" href="/board/list?cate=4">프로토분석</a>
		<a class="nav-item nav-link <c:if test="${pm.cri.getCate()==5 }">text-light bg-secondary</c:if>" href="/board/list?cate=5">QnA</a>
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
	      		<td class="w-50 text-center"><a href="/board/readPage${pm.makeSearch(pm.cri.page)}&bno=${boardVO.bno}">${boardVO.title }</a></td>
	      		<td class="text-center">${boardVO.nickname }</td>
	      		<td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate }"/></td>
	    	</tr>
	    </c:forEach>
	  </tbody>
	</table>
	<ul class="nav text-center justify-content-around mt-3">
	  <div class="d-flex justify-content-around h-75 ml-2 mr-5">
	  	<select name="searchType">
	  		<option value="stitle" <c:if test="${pm.cri.searchType == 'stitle'}">selected</c:if>>제목</option>
	  		<option value="scontent" <c:if test="${pm.cri.searchType == 'scontent'}">selected</c:if>>내용</option>
	  		<option value="snickname" <c:if test="${pm.cri.searchType == 'snickname'}">selected</c:if>>필명</option>
	  		<option value="suserid" <c:if test="${pm.cri.searchType == 'suserid'}">selected</c:if>>ID</option>
	  		<option value="tc" <c:if test="${pm.cri.searchType == 'tc'}">selected</c:if>>제목+내용</option>
	  	</select>
	  	<input style="max-width: auto;" type="text" name="keyword" id="keywordInput" value="${pm.cri.keyword }">
	  	<button id="search-btn" class="btn btn-outline-dark btn-sm">검색</button>
	  </div>
	  <ul class="pagination ml-5 mr-auto">
	  	<c:if test="${pm.prev }">
	  		<li class="page-item"><a class="page-link" href="list${pm.makeSearch(pm.startPage-1) }">&laquo;</a></li>
	  	</c:if>
	    <c:forEach begin="${pm.startPage }" end="${pm.endPage }" var="idx">
  		   	<%-- <li <c:out value="${pm.cri.page == idx?'class= page-item active':'class= page-item'}"/>>
  		   		<a class="page-link" href="list${pm.makeQuery(idx) }">${idx }</a>
  		   	</li> --%>
  		   	<c:if test="${pm.cri.page == idx }">
  		   		<li class="page-item active"><a class="page-link" href="list${pm.makeSearch(idx) }">${idx }</a>
  		   	</c:if>
  		   	<c:if test="${pm.cri.page != idx }">
  		   		<li class="page-item"><a class="page-link" href="list${pm.makeSearch(idx) }">${idx }</a>
  		   	</c:if>
	    </c:forEach>
	    <c:if test="${pm.next && pm.endPage>0 }">
	    	<li class="page-item"><a class="page-link" href="list${pm.makeSearch(pm.endPage+1) }">&raquo;</a></li>
	    </c:if>	    
	  </ul>
	  <button id="create-post" type="button" class="btn btn-secondary h-75 mr-4">글쓰기</button>
	</ul>
</div>
<c:import url="/footer"/>
<form role="form" method="post">
	<input type="hidden" name="cate" value="${pm.cri.getCate()}">
</form>
<script type="text/javascript">
	var result = '${msg}';
	if(result == 'SUCCESS'){
		alert("처리가 완료되었습니다.");
	}
	
	$(document).ready(function(){
		var formObj = $("form[role='form']");
		console.log(formObj);
		
		$("#create-post").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/board/create")
			formObj.submit();
		});
		
		$("#search-btn").on("click",function(event){
			self.location = "list"
				+ "${pm.makeQuery(1)}"
				+ "&searchType="
				+ $("select option:selected").val()
				+ "&keyword=" + encodeURIComponent($('#keywordInput').val());
				
		});
	});
</script>
</body>
</html>
