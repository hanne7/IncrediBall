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

// 오류 및 인식 할 수없는 연설 처리
recognition.onnomatch = function (event) {
    output.textContent = 'I didnt recognise that text.';
}
