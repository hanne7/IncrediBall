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
<div class="container">
	<h4 class="my-3">> NEWS</h4>
	<div class="d-flex justify-content-start">
		<div class="flex-fill border mt-3">
			<ul class="list-group">
			  <li class="list-group-item bg-secondary text-white"><h3 class="text-center">국내축구</h3></li>
			  <li class="list-group-item">Dapibus ac facilisis in</li>
			  <li class="list-group-item">Morbi leo risus</li>
			  <li class="list-group-item">Porta ac consectetur ac</li>
			  <li class="list-group-item">Vestibulum at eros</li>
			</ul>
		</div>
		<div class="flex-fill border mt-3">
			<ul class="list-group">
			  <li class="list-group-item bg-secondary text-white"><h3 class="text-center">유럽축구</h3></li>
			  <li class="list-group-item">Dapibus ac facilisis in</li>
			  <li class="list-group-item">Morbi leo risus</li>
			  <li class="list-group-item">Porta ac consectetur ac</li>
			  <li class="list-group-item">Vestibulum at eros</li>
			</ul>
		</div>
	</div>
</div>
<c:import url="/footer"/>
<script type="text/javascript">
	var result = '${msg}';
	if(result == 'SUCCESS'){
		alert("처리가 완료되었습니다.");
	}
	
	
	$(document).ready(function(){
		
		$.ajax({
			type:"get",
			url:"/news/getNews/",
			headers:{
				"Content-Type":"application/json"
			},
			data:JSON,
			dataType:'text',
			success:function(data){ 
				
			}
		});
	});
	
	
</script>




</body>
</html>
