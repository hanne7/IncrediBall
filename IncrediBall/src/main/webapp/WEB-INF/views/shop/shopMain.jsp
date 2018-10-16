<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>

<head>
<meta charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Shop</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/uploadProduct.js"></script>

</head>
<body class="bg-light">
<c:import url="/header"/>
<div class="container mt-3">
	<nav class="navbar navbar-expand-lg navbar-dark bg-secondary">
	  <a class="navbar-brand ml-5" href="#">Category</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mx-auto">
	      <li class="nav-item active">
	        <a class="nav-link mx-3" href="#">축구화 <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link mx-3" href="#">유니폼</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link mx-3" href="#">축구공</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link mx-3" href="#">GK장비</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link mx-3" href="#">기타용품</a>
	      </li>	     
	    </ul>
	    <form class="form-inline my-2 my-lg-0">
	      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	      <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
	    </form>
	  </div>
	</nav>
</div>
<div class="container mt-4 d-flex">
	<div class="mx-auto" style="width: 70%; min-width: 65%;">
		<ul class="nav nav-tabs nav-pills ml-2">
		  <li class="nav-item">
		    <a class="nav-link text-light bg-secondary" href="#">신상품순</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">낮은가격순</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">높은가격순</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" href="#">인기상품순</a>
		  </li>
		</ul>
		<div class="d-flex flex-wrap m-2">
			<c:forEach items="${productList}" var="productVO">
				<div class="mr-auto">
					<a href="/shop/readProduct${pm.makeSearch(pm.cri.page)}&idx=${productVO.idx}" class="text-center"><img src="http://placehold.it/200x150">
								<p>${productVO.productName }<br><b>${productVO.cost }원</b></p>
					</a>
				</div>
			</c:forEach>
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
		<%-- <c:if test="${login.userid == 'admin' }"> --%>
			<div class="d-flex justify-content-end">
				<button id="product-create" type="button" class="btn btn-secondary h-75 mr-5">상품등록</button>
			</div>
		<%-- </c:if> --%>
	</div>
	<div class="mr-3" style="width: 25%; min-width: 20%">
		<div class="position-fixed">
			<div class="text-center mt-2">
				<h4>추천 상품</h4>
			</div>
			<div class="card d-flex m-2">
	  			<img class="card-img-top" src="http://placehold.it/250px200/?text=Image cap" alt="Card image cap">
	  			<div class="card-body">
	    			<p class="card-text"> Manchester United </p>
	  			</div>
	  			<a href="#" class="btn btn-primary">상세보기</a>
			</div>
		</div>
	</div>
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
		$("#product-create").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/shop/create")
			formObj.submit();
		});
	});
</script>


</body>
</html>