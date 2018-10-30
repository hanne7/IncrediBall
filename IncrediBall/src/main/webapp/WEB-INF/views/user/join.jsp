<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>

</head>
<body class="bg-light">
<c:import url="/header"/>
<div class="container">
	<p><h4>회원가입</h4></p>
	<form method="post" id="joinForm">
		<div class="form-group">
			<label for="userid">ID</label> 
			<input type="text" class="form-control form-control-sm" name="userid" id="userid"
				placeholder="ID를 입력하세요">
			<span id="useridSpan"></span><span id="validId"></span>
		</div>
		<div class="form-group">
			<label for="password">Password</label> 
			<input type="password" class="form-control form-control-sm" name="password" id="password"
				placeholder="Password를 입력하세요">
			<span id="passwordSpan"></span>
		</div>
		<div class="form-group">
			<label for="username">이름</label> 
			<input type="text" class="form-control form-control-sm" name="username" id="username"
				placeholder="이름을 입력하세요">
			<span id="usernameSpan"></span>
		</div>
		<div class="form-group">
			<label for="email">Email address</label>
			<input type="email" class="form-control form-control-sm" name="email" id="email"	
				aria-describedby="emailHelp" placeholder="Email을 입력하세요"> <small
				id="emailHelp" class="form-text text-muted">We'll never
				share your email with anyone else.</small>
			<span id="emailSpan"></span>
		</div>
		<div class="form-group">
			<label for="nickname">필명</label> 
			<input type="text" class="form-control form-control-sm" name="nickname" id="nickname"
				placeholder="사용하실 필명을 입력하세요">
			<span id="nicknameSpan"></span>
		</div>
		<div class="form-group">
			<label for="phone">연락처</label> 
			<input type="text" class="form-control form-control-sm" name="phone" id="phone"
				placeholder="연락가능한 번호를 입력하세요">
			<span id="phoneSpan"></span>
		</div>
		<div class="form-group">
			<label for="address">주소</label> 
			<input type="text" class="form-control form-control-sm" name="address" id="address"
				placeholder="주소를 입력하세요">
			<span id="addressSpan"></span>
		</div>
		<button type="submit" class="btn btn-primary" onclick="javascript:joinSubmit();">가입하기</button>
	</form>
</div>
<c:import url="/footer"/>

<script type="text/javascript">

$(document).ready(function(){
	showValidSpan($('#useridSpan'), $('#userid'));
	showValidSpan($('#passwordSpan'), $('#password'));
	showValidSpan($('#usernameSpan'), $('#username'));
	showValidSpan($('#nicknameSpan'), $('#nickname'));
	showValidSpan($('#emailSpan'), $('#email'));
	showValidSpan($('#phoneSpan'), $('#phone'));
	showValidSpan($('#addressSpan'), $('#address'));
});

function showValidSpan(spanId, inputId){
	spanId.hide();
	spanId.addClass('h5 font-italic');
	if(spanId.get(0)==$('#useridSpan').get(0)){
		inputId.keyup(function(){
			var reg = /^[a-zA-Z0-9]{4,20}$/g;
			var regResult = inputId.val().match(reg);
			console.log(regResult);
			if(regResult==null){
				spanId.removeClass('text-success font-weight-bold');
				spanId.addClass('text-danger');
				spanId.text('4자 이상 20자 이하의 영문과 숫자로만 입력해주세요.');
				spanId.show();
			} else{
				spanId.text('v');
				spanId.removeClass('text-danger');
				spanId.addClass('text-success font-weight-bold');
				spanId.show();				
			}
		});
	}	
	if(spanId.get(0)==$('#usernameSpan').get(0)){
		inputId.keyup(function(){
			var reg = /^[가-힣]{2,20}$/g;
			var regResult = inputId.val().match(reg);
			console.log(regResult);
			if(regResult==null){
				spanId.removeClass('text-success font-weight-bold');
				spanId.addClass('text-danger');
				spanId.text('2자 이상 20자 이하의 한글로 입력해주세요.(공백/특수문자 입력불가)');
				spanId.show();
			} else {
				spanId.text('v');
				spanId.removeClass('text-danger');
				spanId.addClass('text-success font-weight-bold');
				spanId.show();
			}			
		});
	}
	if(spanId.get(0)==$('#nicknameSpan').get(0)){
		inputId.keyup(function(){
			var reg = /^[\S]{2,20}$/g;
			var regResult = inputId.val().match(reg);
			console.log(regResult);
			if(regResult==null){
				spanId.removeClass('text-success font-weight-bold');
				spanId.addClass('text-danger');
				spanId.text('2자 이상 20자 이하로 입력해주세요.(공백 입력불가)');
				spanId.show();
			} else {
				spanId.text('v');
				spanId.removeClass('text-danger');
				spanId.addClass('text-success font-weight-bold');
				spanId.show();
			}			
		});
	}
	if(spanId.get(0) == $('#passwordSpan').get(0)){
		inputId.keyup(function(){
			var reg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*?_-]).{8,20}$/g;
			var regResult = inputId.val().match(reg);
			console.log(regResult);
			if(regResult==null){
				spanId.removeClass('text-success font-weight-bold');
				spanId.addClass('text-danger');
				spanId.text('8~20자의 영문+숫자+특수문자 조합으로 입력해주세요.(특수문자는!@#$%^&*?_-만 사용가능)');
				spanId.show();
			} else {
				spanId.text('v');
				spanId.removeClass('text-danger');
				spanId.addClass('text-success font-weight-bold');
				spanId.show();
			}
		});
	}
	if(spanId.get(0)==$('#emailSpan').get(0)){
		inputId.keyup(function(){
			var reg = /^[\w.-]+@[a-zA-Z.]+\.[a-zA-Z]{2,3}$/gi;
			var regResult = inputId.val().match(reg);
			console.log(regResult);
			if(regResult==null){
				spanId.removeClass('text-success font-weight-bold');
				spanId.addClass('text-danger');
				spanId.text('email형식에 맞게 작성해주세요! (예시> xxx@xxx.xxx )');
				spanId.show();
			} else {
				spanId.text('v');
				spanId.removeClass('text-danger');
				spanId.addClass('text-success font-weight-bold');
				spanId.show();
			}
		});
	}
	if(spanId.get(0)==$('#phoneSpan').get(0)){
		inputId.keyup(function(){
			var reg = /^[0-9]{10,12}$/g;
			var regResult = inputId.val().match(reg);
			console.log(regResult);
			if(regResult==null){
				spanId.removeClass('text-success font-weight-bold');
				spanId.addClass('text-danger');
				spanId.text('10~12자 사이의 숫자로만 작성해주세요!');
				spanId.show();
			} else {
				spanId.text('v');
				spanId.removeClass('text-danger');
				spanId.addClass('text-success font-italic font-weight-bold');
				spanId.show();
			}
		});
	}
	if(spanId.get(0)==$('#addressSpan').get(0)){
		inputId.keyup(function(){
			var reg = /^[\S].{1,44}$/g;
			var regResult = inputId.val().match(reg);
			console.log(regResult);
			if(regResult==null){
				spanId.removeClass('text-success font-weight-bold');
				spanId.addClass('text-danger');
				spanId.text('공백 포함 2자 이상 45자 이내로 작성해주세요!');
				spanId.show();
			} else {
				spanId.text('v');
				spanId.removeClass('text-danger');
				spanId.addClass('text-success font-weight-bold');
				spanId.show();
			}
		});
	}
}


function joinSubmit(){
	event.preventDefault();
	
	if(validate()==false){
		return false;
	}
	
	 var cf = confirm('가입하시겠습니까?');
	 if(cf==false){
		 return false;
	 } else{
		 $("#joinForm").get(0).submit();
	 }	
}

function validate(){
	var reg = /^[a-zA-Z0-9]{4,20}$/g;
	var regResult = $('#userid').val().match(reg);
	if(regResult==null){
		alert("올바른 ID를 입력해주세요");
		$('#userid').focus();
		return false;
	}
	
	reg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*?_-]).{8,20}$/g;
	regResult = $('#password').val().match(reg);
	if(regResult==null){
		alert("올바른 패스워드를 입력해주세요");
		$('#password').focus();
		return false;
	}
	
	reg = /^[가-힣]{2,20}$/g;
	regResult = $('#username').val().match(reg);
	if(regResult==null){
		alert("올바른 이름을 입력해주세요");
		$('#username').focus();
		return false;
	}
	
	reg = /^[\S]{2,20}$/g;
	regResult = $('#nickname').val().match(reg);
	if(regResult==null){
		alert("올바른 필명을 입력해주세요");
		$('#nickname').focus();
		return false;
	}	
	
	reg = /^[\w.-]+@[a-zA-Z.]+\.[a-zA-Z]{2,3}$/gi;
	regResult = $('#email').val().match(reg);
	if(regResult==null){
		alert("올바른 email을 입력해주세요");
		$('#email').focus();
		return false;
	}
	
	reg = /^[0-9]{10,12}$/g;
	regResult = $('#phone').val().match(reg);
	if(regResult==null){
		alert("올바른 연락처를 입력해주세요");
		$('#phone').focus();
		return false;
	}
	
	reg = /^[\S].{1,44}$/g;
	regResult = $('#address').val().match(reg);
	if(regResult==null){
		alert("올바른 주소를 입력해주세요");
		$('#address').focus();
		return false;
	}
	
	return true;
}

</script>
</body>
</html>
