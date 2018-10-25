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
			<span id="useridSpan"></span>
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
	showValidSpan($('#phoneSpan'), $('#phone'));
	showValidSpan($('#addressSpan'), $('#address'));
});

function showValidSpan(spanId, inputId){
	spanId.hide();
	var msg = ''
	
	if((spanId.get(0)==$('#useridSpan').get(0)) || (spanId.get(0)==$('#usernameSpan').get(0)) || (spanId.get(0)==$('#nicknameSpan').get(0))){
		msg = '2자 이상 20자 이하로 입력해주세요.'
		inputId.keyup(function(){
			if((inputId.val().length>20) || (inputId.val().length<2)){
				spanId.addClass('text-danger h5');
				spanId.text(msg);
				spanId.show();
			}
			if((inputId.val().length<=20) && (inputId.val().length>=2)){
				spanId.hide();
			}			
		});
	}
	if(spanId.get(0) == $('#passwordSpan').get(0)){
		msg = 'password는 8자 이상 20자 이하로 입력해주세요.'
		inputId.keyup(function(){
			if((inputId.val().length>20) || (inputId.val().length<8)){
				spanId.addClass('text-danger h5');
				spanId.text(msg);
				spanId.show();
			}
			if((inputId.val().length<=20) && (inputId.val().length>=8)){
				spanId.hide();
			}
		});
	}
	if((spanId.get(0)==$('#phoneSpan').get(0)) || (spanId.get(0)==$('#addressSpan').get(0))){
		msg = '45자 이내로 작성해주세요!';
		inputId.keyup(function(){
			if(inputId.val().length>45){
				spanId.addClass('text-danger h5');
				spanId.text(msg);
				spanId.show();
			}
			if(inputId.val().length<=45){
				spanId.hide();
			}
		});
	}
	inputId.keyup(function(){
		if(inputId.val().indexOf(' ')!=-1){
			alert('공백은 입력할 수 없습니다.');
		} 
	});
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
	if($.trim($('#userid').val())==''){
		alert("ID를 입력해주세요.");
		$('#userid').focus();
		return false;
	}
	if($('#userid').val().indexOf(' ')!=-1){
		alert("ID에 공백이 들어가면 안됩니다.")
		$('#userid').focus();
		return false;
	}
	if($.trim($('#password').val())==''){
		alert("패스워드를 입력해주세요.");
		$('#password').focus();
		return false;
	}
	if($('#password').val().indexOf(' ')!=-1){
		alert('password에 공백(spacebar)이 들어가면 안됩니다.')
		$('#password').focus();
		return false;
	}
	if($.trim($('#username').val())==''){
		alert("이름을 입력해주세요.");
		$('#username').focus();
		return false;
	}
	if($('#username').val().indexOf(' ')!=-1){
		alert("이름에 공백이 들어가면 안됩니다.")
		$('#username').focus();
		return false;
	}
	if($.trim($('#email').val())==''){
		alert("이메일을 입력해주세요.");
		$('#email').focus();
		return false;
	}
	if($.trim($('#nickname').val())==''){
		alert("필명을 입력해주세요.");
		$('#nickname').focus();
		return false;
	}
	if($.trim($('#phone').val())==''){
		alert("연락처를 입력해주세요.");
		$('#phone').focus();
		return false;
	}
	if($.trim($('#address').val())==''){
		alert("주소를 입력해주세요.");
		$('#address').focus();
		return false;
	}
	return true;
}

</script>
</body>
</html>
