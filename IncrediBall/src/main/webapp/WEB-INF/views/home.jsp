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
<div class="d-flex justify-content-around">
			<div id="carouselExampleIndicators" class="carousel slide"
				data-ride="carousel" data-interval="2500">
				<ol class="carousel-indicators">
					<li data-target="#carouselExampleIndicators" data-slide-to="0"
						class="active"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img class="d-block w-100"
							src="http://placehold.it/1000x350?auto=yes&bg=777&fg=555&text=First slide"
							alt="First slide">
						<div class="carousel-caption d-none d-md-block">
							<h3>1st</h3>
							<p>1st slide</p>
						</div>
					</div>
					<div class="carousel-item">
						<img class="d-block w-100"
							src="http://placehold.it/1000x350?auto=yes&bg=666&fg=444&text=Second slide"
							alt="Second slide">
						<div class="carousel-caption d-none d-md-block">
							<h3>2nd</h3>
							<p>2nd slide</p>
						</div>
					</div>
					<div class="carousel-item">
						<img class="d-block w-100"
							src="http://placehold.it/1000x350?auto=yes&bg=555&fg=333&text=Third slide"
							alt="Third slide">
						<div class="carousel-caption d-none d-md-block">
							<h3>3rd</h3>
							<p>3rd slide</p>
						</div>
					</div>
				</div>
				<a class="carousel-control-prev" href="#carouselExampleIndicators"
					role="button" data-slide="prev"> <span
					class="carousel-control-prev-icon" aria-hidden="true"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
					role="button" data-slide="next"> <span
					class="carousel-control-next-icon" aria-hidden="true"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>
			<div class="border flex-fill">
			<div class="list-group">
				<a href="#" class="list-group-item list-group-item-action bg-secondary text-white">공지사항</a>
				<a href="#"	class="list-group-item list-group-item-action">Dapibus acfacilisis in</a> 
				<a href="#"	class="list-group-item list-group-item-action">Morbi leo risus</a>
				<a href="#" class="list-group-item list-group-item-action">Portaac consectetur ac</a> 
				<a href="#"	class="list-group-item list-group-item-action disabled">Vestibulum at eros</a>
			</div>
		</div>
	</div>
<div class="d-flex justify-content-between mt-2">
	<div class="border">
		<div class="card" style="width: 18rem;">
  			<img class="card-img-top" src="http://placehold.it/200px150/?text=Image cap" alt="Card image cap">
  			<div class="card-body">
    			<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
  			</div>
  			<a href="#" class="btn btn-primary">Go Shop</a>
		</div>
	</div>
	<div class="border flex-fill">
		<div class="list-group">
			<a href="#" class="list-group-item list-group-item-action bg-secondary text-white">뉴스리스트</a>
			<a href="#"	class="list-group-item list-group-item-action">Dapibus acfacilisis in</a> 
			<a href="#"	class="list-group-item list-group-item-action">Morbi leo risus</a>
			<a href="#" class="list-group-item list-group-item-action">Portaac consectetur ac</a> 
			<a href="#"	class="list-group-item list-group-item-action disabled">Vestibulum at eros</a>
		</div>
	</div>
	<div class="border flex-fill">
		<div class="list-group">
			<a href="#" class="list-group-item list-group-item-action bg-secondary text-white">인기글</a>
			<a href="#"	class="list-group-item list-group-item-action">Dapibus acfacilisis in</a> 
			<a href="#"	class="list-group-item list-group-item-action">Morbi leo risus</a>
			<a href="#" class="list-group-item list-group-item-action">Portaac consectetur ac</a> 
			<a href="#"	class="list-group-item list-group-item-action disabled">Vestibulum at eros</a>
		</div>	
	</div>
</div>
</div>
<c:import url="/footer"/>
<script type="text/javascript">
	var result = '${msg}';
	if(result == 'SUCCESS'){
		alert("처리가 완료되었습니다.");
	}
</script>
</body>
</html>
