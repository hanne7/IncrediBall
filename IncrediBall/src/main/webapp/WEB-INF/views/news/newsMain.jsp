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
<div class="container">
	<h4 class="my-3">> NEWS</h4>
	<div class="d-flex justify-content-start">
		<div class="w-50 border mt-1">
			<div class="bg-secondary text-white p-1"><h3 class="text-center">국내축구</h3></div>
			<ul class="list-group" id="koreaFootball">
			</ul>
		</div>
		<div class="w-50 border mt-1">
			<div class="bg-secondary text-white p-1"><h3 class="text-center">유럽축구</h3></div>
			<ul class="list-group" id="euroFootball">
			</ul>
		</div>
	</div>
</div>

<c:import url="/footer"/>
<script type="text/javascript" charset="UTF-8">
	var result = '${msg}';
	if(result == 'SUCCESS'){
		alert("처리가 완료되었습니다.");
	}
	
	
	$(document).ready(function(){
		
		$.ajax({
			type:"get",
			url:"/news/getEuroNews",
			dataType:'json',
			success:function(data){
				
				var euroNews = data.items;
				console.log(euroNews)
				var str="";
				$(euroNews).each(function(i, e){
					str += "<li class='list-group-item mt-0'><a href='" + euroNews[i].link + "' target='_blank'>" + euroNews[i].title + "</a></li>";	
				});
				 						
				$("#euroFootball").html(str);
			}			
		});
		
		$.ajax({
			type:"get",
			url:"/news/getKorNews",
			dataType:'json',
			success:function(data){
				
				var korNews = data.items;
				console.log(korNews)
				var str="";
				$(korNews).each(function(i, e){
					str += "<li class='list-group-item mt-0'><a href='" + korNews[i].link + "' target='_blank'>" + korNews[i].title + "</a></li>";	
				});
				
				$("#koreaFootball").html(str);
			}			
		});
	});
	
	
</script>




</body>
</html>
