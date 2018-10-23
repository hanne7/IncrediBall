<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
	a,a:link{text-decoration:none; color: black;}
</style>
<header>
<div class="container mt-3 d-flex justify-content-between">
	<div class="row mt-2">
		<div class="col-sm"><a href="/"><h3>IncrediBall</h3></a></div>
		<div class="col-sm">
			<button id="voConBtn" class="btn btnvo btn-danger mt-1 font-italic" style="font-size: 11px; height: 28px;">Voice Control</button>
			<div class="outputvo my-2 text-center" style="font-size: 11px;"></div>
		</div>
	</div>
	<script src="/resources/speech/script.js"></script>
	<ul class="nav justify-content-end mt-3">
		<c:if test="${empty login }">
			<li class="nav-item ml-5"><a href="/user/join">회원가입</a></li>
			<li class="nav-item ml-5"><a href="#" data-toggle="modal" data-target="#loginModal">로그인</a></li>
		</c:if>
		<c:if test="${!empty login }">
			<p>${login.nickname }(${login.userid })님 환영합니다!</p>
			<li class="nav-item ml-5"><a href="/user/logout">로그아웃</a></li>
		</c:if>
		<li class="nav-item ml-5"><a href="/user/myPage">마이페이지</a></li>
		<li class="nav-item ml-5"><a href="/shop/cart">장바구니</a></li>		
	</ul>
</div>
<nav class="nav nav-pills nav-fill dropdown bg-dark mt-2">
	<a class="nav-item nav-link border text-white" href="/">HOME</a>
	<a class="nav-item nav-link border text-white" href="/news/">NEWS</a>
	<a class="nav-item nav-link border text-white" href="/board/list?cate=0">BOARD</a>
	<a class="nav-item nav-link border text-white" href="/shop/shopMain">SHOP</a>
</nav>

<!-- Modal -->
<div class="modal fade position-fixed" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">로그인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="/user/login" method="post">
        	<div class="form-group">
				<label for="userid">ID</label> 
				<input type="text" class="form-control form-control-sm" name="userid"
					placeholder="ID를 입력하세요">
			</div>
			<div class="form-group">
				<label for="password">Password</label> 
				<input type="password" class="form-control form-control-sm" name="password"
					placeholder="Password를 입력하세요">
			</div>
			<div class="checkbox icheck float-right mr-3">
	      		<input type="checkbox" name="useCookie"> Remember Me
	      	</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Login</button>
      </div>
      </form>
    </div>
  </div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$(".btnvo").on("click",function(event){
		console.log("voice control...");
		setTimeout("if($('.outputvo').text()!=''){voiceControl();}" , 5500);
	});
});

function voiceControl() {

		if(($('.outputvo').text().indexOf('메인')!=-1||$('.outputvo').text().indexOf('홈')!=-1) && ($('.outputvo').text().indexOf('가자')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1||$('.outputvo').text().indexOf('보여')!=-1)){
			self.location = '/';
		}
		if($('.outputvo').text().indexOf('게시판')!=-1 && ($('.outputvo').text().indexOf('가자')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1||$('.outputvo').text().indexOf('보여')!=-1)){
			self.location = '/board/list?cate=0';
		}
		if($('.outputvo').text().indexOf('자유게시판')!=-1 && ($('.outputvo').text().indexOf('가자')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1||$('.outputvo').text().indexOf('보여')!=-1)){
			self.location = '/board/list?cate=3';
		}
		if($('.outputvo').text().indexOf('축구 게시판')!=-1 && ($('.outputvo').text().indexOf('가자')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1||$('.outputvo').text().indexOf('보여')!=-1)){
			self.location = '/board/list?cate=2';
		}		
		if($('.outputvo').text().indexOf('프로토')!=-1 && ($('.outputvo').text().indexOf('가자')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1||$('.outputvo').text().indexOf('보여')!=-1)){
			self.location = '/board/list?cate=4';
		}
		if($('.outputvo').text().indexOf('공지')!=-1 && ($('.outputvo').text().indexOf('가자')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1||$('.outputvo').text().indexOf('보여')!=-1)){
			self.location = '/board/list?cate=1';
		}
		if($('.outputvo').text().indexOf('뉴스')!=-1 && ($('.outputvo').text().indexOf('가자')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1||$('.outputvo').text().indexOf('보여')!=-1)){
			self.location = '/news/';
		}
		if($('.outputvo').text().indexOf('쇼핑몰')!=-1 && ($('.outputvo').text().indexOf('가자')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1||$('.outputvo').text().indexOf('보여')!=-1)){
			self.location = '/shop/shopMain';
		}
		if($('.outputvo').text().indexOf('축구화')!=-1 && ($('.outputvo').text().indexOf('보여')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1)){
			self.location = '/shop/shopMain?cate=1';
		}
		if($('.outputvo').text().indexOf('유니폼')!=-1 && ($('.outputvo').text().indexOf('보여')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1)){
			self.location = '/shop/shopMain?cate=2';
		}
		if($('.outputvo').text().indexOf('축구공')!=-1 && ($('.outputvo').text().indexOf('보여')!=-1||$('.outputvo').text().indexOf('열어')!=-1||$('.outputvo').text().indexOf('가줘')!=-1||$('.outputvo').text().indexOf('가 줘')!=-1)){
			self.location = '/shop/shopMain?cate=3';
		}		
}
</script>
</header>