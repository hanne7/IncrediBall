// 크롬만 현재 지원 가능 / 사용할수있도록 변수 지정
var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition
var SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList
var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent
// 문법
var grammar = '#JSGF V1.0';
// 문법을 음성 인식에 연결
var recognition = new SpeechRecognition();
var speechRecognitionList = new SpeechGrammarList();
speechRecognitionList.addFromString(grammar, 1);
recognition.grammars = speechRecognitionList;
recognition.continuous = true;
// 언어 지정
// recognition.lang = 'en-US';
recognition.lang = 'ko-KR';
recognition.interimResults = false;
recognition.maxAlternatives = 1;

// 음성 인식 시작하기
var output = document.querySelector('.outputvo');
var btn = document.querySelector('.btnvo');
// 음성 인식시작전 버튼 클릭
btn.onclick = function () {
    recognition.start();
    console.log('Ready to receive a text command.');
    console.log('명령하십시오.');
}

// 결과 받기 및 처리
recognition.onresult = function (event) {
    var last = event.results.length - 1;
    var text = event.results[last][0].transcript;
    // 결과를 원하는 태그에 저장
    output.textContent = text;
    console.log('Confidence: ' + event.results[0][0].confidence);
    if(text.indexOf('아')!=-1){
    	recognition.stop();
    }else if(text!=''){
    	setTimeout(voiceControl(text) , 4000);
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

// 음성 인식 종료
recognition.onspeechend = function () {
//    recognition.stop();
}

// 오류 및 인식 할 수없는 연설 처리
recognition.onnomatch = function (event) {
    output.textContent = 'I didnt recognise that text.';
}
recognition.onerror = function (event) {
    output.textContent = 'Error occurred in recognition: ' + event.error;
}