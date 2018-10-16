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
<title>${productVO.productName }</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<script type="text/javascript" src="/resources/js/uploadProduct.js"></script>

<style type="text/css">
	.popup {position: absolute;}
	.back {background-color: gray; opacity: 0.5; width: 100%; height: 300%; overflow: hidden; z-index: 1101;}
	.front {z-index: 1110; opacity: 1; border: 1px; margin: auto;}
	.show {
		position: relative;
		max-width: 1200px;
		max-height: 800px;
		overflow: auto;
	}
</style>

</head>
<body class="bg-light">
<c:import url="/header"/>
<div class="container">
	<table class="table table-sm mt-2 mb-0 text-center border">
		<div class="mt-3 ml-3"> 
			<c:if test="${productVO.productCategory==1 }"><h3>> 축구화</h3></c:if>
			<c:if test="${productVO.productCategory==2 }"><h3>> 유니폼</h3></c:if>
			<c:if test="${productVO.productCategory==3 }"><h3>> 축구공</h3></c:if>
			<c:if test="${productVO.productCategory==4 }"><h3>> GK장비</h3></c:if>
			<c:if test="${productVO.productCategory==5 }"><h3>> 기타용품</h3></c:if>
		</div>
		<tr>
			<td class="bg-dark text-white w-25">상품명</td>
			<td colspan="3"><h5><b>${productVO.productName }</b></h5></td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25">가격</td>
			<td colspan="3"><b><fmt:formatNumber value="${productVO.cost }" pattern="#,###"/>원</b></td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25">등록시간</td>
			<td><fmt:formatDate value="${productVO.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25" colspan="4">상품 설명</td>
		</tr>
	</table>
	<% pageContext.setAttribute("newLineChar", "\r\n"); %>
	<div class="container-fluid pt-4 border" style="min-height:300px; max-height:500px; overflow: scroll">
		<div class="popup back" style="display:none;"></div>
		<div id="popup_front" class="popup front" style="display:none;"><img id="popup-img"></div>
		<div class="uploadedList clearfix d-flex justify-content-start">
		</div>		
		${fn:replace(productVO.status, newLineChar, "<br/>")}
	</div>
	<div class="btn-group d-flex justify-content-end" role="group" aria-label="boardbtn">
	  <button id="go-list" type="button" class="btn btn-secondary">목록</button>
	  <%-- <c:if test="${login.userid == 'admin' }"> --%>	
	  	<button id="create-post" type="button" class="btn btn-secondary">상품등록</button>
		<button id="modify-post" type="button" class="btn btn-secondary">상품수정</button>
	  	<button id="delete-post" type="button" class="btn btn-secondary">상품삭제</button>
	  <%-- </c:if> --%>
	</div>
</div>

<div class="popup back" style="display:none;"></div>
<div id="popup_front" class="popup front" style="display:none;"><img id="popup-img"></div>

<c:import url="/footer"/>
<form role="form" method="post">
	<input type="hidden" name="idx" value="${productVO.idx }">
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
				var arr = [];
				$(".uploadedList .mt-5").each(function(index){
					arr.push($(this).attr("data-src"));
				});
				
				if(arr.length > 0){
					$.post("/deleteAllProducts", {files:arr}, function(){
						
					});
				}
				formObj.attr("action", "/shop/delete");
				formObj.submit();
			}
		});
		
		$("#go-list").on("click", function(){
			formObj.attr("method", "get");
			formObj.attr("action", "/shop/shopMain");
			formObj.submit();
		});
		
		$("#modify-post").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/shop/modify")
			formObj.submit();
		});
		
		$("#create-post").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/shop/create")
			formObj.submit();
		});
	});
</script>

<%--...이미 업로드된 첨부파일을 보여주기 위한 handlebars의 템플릿. --%>
<script id="templateAttach" type="text/x-handlebars-template">
<div data-src='{{fullName}}' class="mt-5">
	<div class="w-50">
		<span><img src="{{imgsrc}}" alt="Attachment" width=100%;></span>
		<p class="imglink text-center"><a href="{{getLink}}" class="">{{fileName}}</a></p>
	</div>
</div>
</script>

<script type="text/javascript">
var bno = ${productVO.idx};
var template = Handlebars.compile($("#templateAttach").html());

$.getJSON("/shop/getAttach/" + bno, function(list){
	$(list).each(function(){
		var fileInfo = getFileInfo(this);
		var html = template(fileInfo);
		$(".uploadedList").append(html);
	});
});

$(".uploadedList").on("click", ".imglink a", function(event){
	var fileLink = $(this).attr("href");
	
	if(checkImageType(fileLink)){
		event.preventDefault();
		
		var imgTag = $("#popup-img");
		imgTag.attr("src", fileLink);
		
		console.log(imgTag.attr("src"));
		
		$(".popup").show('slow');
		imgTag.addClass("show");
	}
});

$("#popup-img").on("click", function(){
	$(".popup").hide('slow');
});
</script>


</body>
</html>
