<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
	a,a:link{text-decoration:none; color: black;}
	.toolong{
		display: inline; overflow: hidden; text-overflow: ellipsis;
	}
</style>
<script src="/resources/speech/reco.js"></script>
<header>
<div class="container mt-3 d-flex justify-content-between">
	<div class="row mt-2">
		<div class="col-sm"><a href="/"><h3>IncrediBall</h3></a></div>
		<div class="col-sm">
			<button id="voConBtn" class="btn btnvo btn-danger mt-1 font-italic" style="font-size: 11px; height: 28px;">Voice Control</button>
			<div class="outputvo my-2 text-center" style="font-size: 11px;"></div>
		</div>
	</div>
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

	var power = "${power}";
	var mode = "${mode}";
	console.log('power : '+ power);
	console.log('mode : ' + mode);
		
	// 음성 인식 시작하기
	var output = document.querySelector('.outputvo');
	var btn = document.querySelector('.btnvo');
	// 음성 인식시작전 버튼 클릭
	btn.onclick = function () {
	    recognition.start();
	    console.log('Ready to receive a text command.');
	    $.ajax({
			type:'post',
			url:'/voiceControl',
			dataType:'text',
			data:power,
			contentType:'text/plain',
			success:function(result){
				console.log('power : ' + result);
				console.log('mode : ' + mode);
				power=result;
			}
		});
		output.textContent = '대기 모드';
	}	
	
	$(document).ready(function(){
		if(power == 1){
			recognition.start();
			console.log('Ready to receive a text command.');
			if(mode == 1){
				output.textContent = '명령하십시오...';
			} else{
				output.textContent = '대기 모드';
			}
		}
	});
	
	
	// 결과 받기 및 처리
	recognition.onresult = function (event) {
	    var last = event.results.length - 1;
	    var text = event.results[last][0].transcript;
	    // 결과를 원하는 태그에 저장
	    output.textContent = text;
	    console.log('Confidence: ' + event.results[0][0].confidence);
	    if(text.indexOf('종료')!=-1){
	    	$.ajax({
				type:'post',
				url:'/voiceControl',
				dataType:'text',
				data:power,
				contentType:'text/plain',
				success:function(result){
					console.log('power : ' + result);
					power = result;
					if(mode==1){
						mode="0";
					}
				}
			});
	    	output.textContent = '음성모드 종료합니다.';
	    	recognition.stop();
	    } else if(text.indexOf('토리')!=-1){    	
	    	if(mode==0){
	    		$.ajax({
		    		type:'post',
		    		url:'/modeControl',
		    		dataType:'text',
		    		data:mode,
		    		contentType:'text/plain',
		    		success:function(result){
		    			console.log('mode : ' + result);
		    			mode = result;
		    		}
		    	});
	    		output.textContent = '명령하십시오...';	
	    	}	    	
	    } else if(text.indexOf('대기')!=-1){
	    	if(mode==1){
	    		$.ajax({
		    		type:'post',
		    		url:'/modeControl',
		    		dataType:'text',
		    		data:mode,
		    		contentType:'text/plain',
		    		success:function(result){
		    			console.log('mode : ' + result);
		    			mode = result;
		    		}
		    	});
	    		output.textContent = '대기모드';
	    	}
	    } else if(text!=''){
	    	setTimeout(modeCheck(text), 2000);
	    }
	}
	
	// 음성 인식 종료
	recognition.onspeechend = function () {
		if(power==1){
    		setTimeout(restart(), 2000);
    	}
		recognition.stop();
	}

	recognition.onerror = function (event) {
	    
	    if(power==1){
	    	output.textContent = 'Error occurred in recognition: ' + event.error;
    		setTimeout(restart(), 2000);
    	}
	}
	
	function restart(){
		var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition
		var SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList
		var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent
		var grammar = '#JSGF V1.0';
		var recognition = new SpeechRecognition();
		var speechRecognitionList = new SpeechGrammarList();
		speechRecognitionList.addFromString(grammar, 1);
		recognition.grammars = speechRecognitionList;
		recognition.continuous = true;

		recognition.lang = 'ko-KR';
		recognition.interimResults = false;
		recognition.maxAlternatives = 1;
		
		recognition.start();
		console.log('restart');
		console.log('Ready to receive a text command.');
		
		console.log('power : '+ power);
		console.log('mode : ' + mode);
		
		recognition.onresult = function (event) {
		    var last = event.results.length - 1;
		    var text = event.results[last][0].transcript;
		    // 결과를 원하는 태그에 저장
		    output.textContent = text;
		    console.log('Confidence: ' + event.results[0][0].confidence);
		    if(text.indexOf('종료')!=-1){
		    	$.ajax({
					type:'post',
					url:'/voiceControl',
					dataType:'text',
					data:power,
					contentType:'text/plain',
					success:function(result){
						console.log('power : ' + result);
						power = result;
						if(mode==1){
							mode="0";
						}
					}
				});
		    	output.textContent = '음성모드 종료합니다.';
		    	recognition.stop();
		    } else if(text.indexOf('토리')!=-1){
		    	
		    	if(mode==0){
		    		$.ajax({
			    		type:'post',
			    		url:'/modeControl',
			    		dataType:'text',
			    		data:mode,
			    		contentType:'text/plain',
			    		success:function(result){
			    			console.log('mode : ' + result);
			    			mode = result;
			    		}
			    	});
		    		output.textContent = '명령하십시오...';	
		    	}	    	
		    } else if(text.indexOf('대기')!=-1){
		    	if(mode==1){
		    		$.ajax({
			    		type:'post',
			    		url:'/modeControl',
			    		dataType:'text',
			    		data:mode,
			    		contentType:'text/plain',
			    		success:function(result){
			    			console.log('mode : ' + result);
			    			mode = result;
			    		}
			    	});
		    		output.textContent = '대기모드';
		    	}
		    } else if(text!=''){
		    	setTimeout(modeCheck(text), 2000);
		    }
		}
		// 음성 인식 종료
		recognition.onspeechend = function () {
			if(power==1){
	    		setTimeout(restart(), 2000);
	    	}
			recognition.stop();
		}

		recognition.onerror = function (event) {
		    
		    if(power==1){
		    	output.textContent = 'Error occurred in recognition: ' + event.error;
	    		setTimeout(restart(), 2000);
	    	}
		}
	}
	
	function modeCheck(text){
		if(mode==1){
			setTimeout(voiceControl(text) , 4000);
		} else {
			setTimeout("output.textContent = '명령모드가 아닙니다.'", 2000);
		}
	}

	function voiceControl(text) {
		if((text.indexOf('메인')!=-1||text.indexOf('홈')!=-1) && (text.indexOf('가자')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1||text.indexOf('보여')!=-1)){
			self.location = '/';
		}
		if(text.indexOf('게시판')!=-1 && (text.indexOf('가자')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1||text.indexOf('보여')!=-1)){
			self.location = '/board/list?cate=0';
		}
		if(text.indexOf('자유게시판')!=-1 && (text.indexOf('가자')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1||text.indexOf('보여')!=-1)){
			self.location = '/board/list?cate=3';
		}
		if(text.indexOf('축구 게시판')!=-1 && (text.indexOf('가자')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1||text.indexOf('보여')!=-1)){
			self.location = '/board/list?cate=2';
		}		
		if(text.indexOf('프로토')!=-1 && (text.indexOf('가자')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1||text.indexOf('보여')!=-1)){
			self.location = '/board/list?cate=4';
		}
		if(text.indexOf('공지')!=-1 && (text.indexOf('가자')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1||text.indexOf('보여')!=-1)){
			self.location = '/board/list?cate=1';
		}
		if(text.indexOf('뉴스')!=-1 && (text.indexOf('가자')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1||text.indexOf('보여')!=-1)){
			self.location = '/news/';
		}
		if(text.indexOf('쇼핑몰')!=-1 && (text.indexOf('가자')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1||text.indexOf('보여')!=-1)){
			self.location = '/shop/shopMain';
		}
		if(text.indexOf('축구화')!=-1 && (text.indexOf('보여')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1)){
			self.location = '/shop/shopMain?cate=1';
		}
		if(text.indexOf('유니폼')!=-1 && (text.indexOf('보여')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1)){
			self.location = '/shop/shopMain?cate=2';
		}
		if(text.indexOf('축구공')!=-1 && (text.indexOf('보여')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1)){
			self.location = '/shop/shopMain?cate=3';
		}
		if(text.indexOf('장바구니')!=-1 && (text.indexOf('보여')!=-1||text.indexOf('열어')!=-1||text.indexOf('가줘')!=-1||text.indexOf('가 줘')!=-1)){
			self.location = '/shop/cart';
		}
	}
</script>
</header>