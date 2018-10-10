<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
	a,a:link{text-decoration:none; color: black;}
</style>
<header>
<div class="container mt-3 d-flex justify-content-between">
	<div>
		<h2><a href="/">IncrediBall</a></h2>
	</div>
	<ul class="nav justify-content-end mt-3">
		<c:if test="${empty login }">
		<li class="nav-item ml-5"><a href="/user/join">회원가입</a></li>
		<li class="nav-item ml-5"><a href="#" data-toggle="modal" data-target="#loginModal">로그인</a></li>
		</c:if>
		<c:if test="${!empty login }">
		<li class="nav-item ml-5"><a href="/user/logout">로그아웃</a></li>
		</c:if>
		<li class="nav-item ml-5"><a href="/user/myPage">마이페이지</a></li>
		<li class="nav-item ml-5"><a href="#">장바구니</a></li>		
	</ul>
</div>
<nav class="nav nav-pills nav-fill dropdown bg-dark mt-2">
	<a class="nav-item nav-link border text-white" href="/">HOME</a>
	<a class="nav-item nav-link border text-white" href="#">NEWS</a>
	<a class="nav-item nav-link border text-white" href="/board/list">BOARD</a>
	<a class="nav-item nav-link border text-white" href="#">SHOP</a>
</nav>

<!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Login</button>
      </div>
      </form>
    </div>
  </div>
</div>
</header>