<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<c:import url="/header"/>
<div class="container">
	<table class="table table-sm mt-2 mb-0 text-center border">
		<div class="mt-3 ml-3"> 
			<c:if test="${boardVO.category==1 }"><h3>> 공지사항</h3></c:if>
			<c:if test="${boardVO.category==2 }"><h3>> 축구게시판</h3></c:if>
			<c:if test="${boardVO.category==3 }"><h3>> 자유게시판</h3></c:if>
			<c:if test="${boardVO.category==4 }"><h3>> 프로토분석</h3></c:if>
			<c:if test="${boardVO.category==5 }"><h3>> QnA</h3></c:if>
		</div>
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
			<td><fmt:formatDate value="${boardVO.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
			<td class="bg-dark text-white w-25">마지막수정시간</td>
			<td><fmt:formatDate value="${boardVO.moddate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25" colspan="4">글 내용</td>
		</tr>
	</table>
	<% pageContext.setAttribute("newLineChar", "\r\n"); %>
	<div class="container-fluid pt-4 border" style="min-height:300px; max-height:500px; overflow: scroll">
		${fn:replace(boardVO.content, newLineChar, "<br/>")}		
	</div>
	<div class="btn-group d-flex justify-content-end" role="group" aria-label="boardbtn">
	  <button id="go-list" type="button" class="btn btn-secondary">목록</button>
	  <button id="create-post" type="button" class="btn btn-secondary">글쓰기</button>
	  <c:if test="${boardVO.userid == login.userid }">
		<button id="modify-post" type="button" class="btn btn-secondary">글수정</button>
	  	<button id="delete-post" type="button" class="btn btn-secondary">글삭제</button>
	  </c:if>
	</div>
</div>
<c:import url="/footer"/>
<form role="form" method="post">
	<input type="hidden" name="bno" value="${boardVO.bno }">
	<input type="hidden" name="cate" value="${cri.cate }">
	<input type="hidden" name="page" value="${cri.page }">
	<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
	<input type="hidden" name="searchType" value="${cri.searchType}">
	<input type="hidden" name="keyword" value="${cri.keyword}">
</form>
<script type="text/javascript">
	var result = '${msg}';
	if(result == 'SUCCESS'){
		alert("처리가 완료되었습니다.");
	}
	
	$(document).ready(function(){
		
		var formObj = $("form[role='form']");
		console.log(formObj);
		
		$("#delete-post").on("click", function(){
			var del = confirm('삭제하시겠습니까?');
			if(del == true){
				formObj.attr("action", "/board/delete");
				formObj.submit();
			}
		});
		
		$("#go-list").on("click", function(){
			formObj.attr("method", "get");
			formObj.attr("action", "/board/list");
			formObj.submit();
		});
		
		$("#modify-post").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/board/modify")
			formObj.submit();
		});
		
		$("#create-post").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/board/create")
			formObj.submit();
		});
	});
</script>
</body>
</html>
