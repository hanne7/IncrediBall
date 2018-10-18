<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${boardVO.title }</title>
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/plugins/jQuery/jquery-3.3.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.js"></script>
<script type="text/javascript" src="/resources/js/upload.js"></script>

<style type="text/css">
	.popup {position: absolute;}
	.back {background-color: gray; opacity: 0.5; width: 100%; height: 300%; overflow: hidden; z-index: 1101;}
	.front {z-index: 1110; opacity: 1; border: 1px; margin: auto;}
	.show {
		position: relative;
		max-width: 1200px;
		max-height: 800px;
		overflow: auto;
	}
</style>

</head>
<body class="bg-light">
<c:import url="/header"/>
<div class="container">
	<table class="table table-sm mt-2 mb-0 text-center border">
		<div class="mt-3 ml-3"> 
			<c:if test="${boardVO.category==1 }"><h3>> 공지사항</h3></c:if>
			<c:if test="${boardVO.category==2 }"><h3>> 축구게시판</h3></c:if>
			<c:if test="${boardVO.category==3 }"><h3>> 자유게시판</h3></c:if>
			<c:if test="${boardVO.category==4 }"><h3>> 프로토분석</h3></c:if>
			<c:if test="${boardVO.category==5 }"><h3>> QnA</h3></c:if>
		</div>
		<tr>
			<td class="bg-dark text-white w-25">제목</td>
			<td colspan="3"><b>${boardVO.title }</b></td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25">작성자</td>
			<td colspan="3">${boardVO.nickname }(${boardVO.userid })</td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25">작성시간</td>
			<td><fmt:formatDate value="${boardVO.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
			<td class="bg-dark text-white w-25">마지막수정시간</td>
			<td><fmt:formatDate value="${boardVO.moddate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		</tr>
		<tr>
			<td class="bg-dark text-white w-25" colspan="4">글 내용</td>
		</tr>
	</table>
	<% pageContext.setAttribute("newLineChar", "\r\n"); %>
	<div class="container-fluid pt-4 border" style="min-height:300px; max-height:500px; overflow: scroll">
		${fn:replace(boardVO.content, newLineChar, "<br/>")}
		<div class="popup back" style="display:none;"></div>
		<div id="popup_front" class="popup front" style="display:none;"><img id="popup-img"></div>
		<div class="uploadedList clearfix d-flex justify-content-start">
		</div>		
	</div>
	<div class="btn-group d-flex justify-content-end" role="group" aria-label="boardbtn">
	  <button id="go-list" type="button" class="btn btn-secondary">목록</button>
	  <button id="create-post" type="button" class="btn btn-secondary">글쓰기</button>
	  <c:if test="${boardVO.userid == login.userid }">
		<button id="modify-post" type="button" class="btn btn-secondary">글수정</button>
	  	<button id="delete-post" type="button" class="btn btn-secondary">글삭제</button>
	  </c:if>
	</div>
	
	<!-- reply  -->
	<c:if test="${!empty login }">
	<div class="row">
		<div class="col-md-12">
			<div class="box box-success">
				<div class="box-header">
					<h5 class="box-title">ADD NEW REPLY</h5>
				</div>
				<div class="box-body">
					<label for="writer">Writer</label>
					<input class="form-control" type="text" id="writer" value="${login.nickname }(${login.userid})" readonly />
					<label for="replyText">ReplyText</label>
					<input class="form-control" type="text" placeholder="댓글을 남겨주세요" id="replyText" />
					<input type="hidden" id="writerIdx" value="${login.idx }" />
				</div>
				<div class="box-footer">
					<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
				</div>
			</div>
		</div>
	</div>
	</c:if>
	
	<c:if test="${empty login }">
		<h5>댓글을 남기시려면 로그인 하셔야 합니다.</h5>
		<a href="/user/loginPage">로그인 하러가기</a>
	</c:if>
	
	<!-- 댓글 수정 Modal -->
	<div id="modifyModal" class="modal modal-primary fade position-fixed" role="dialog" tabindex="-2" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body" data-rno>
					<p><input type="text" id="modReplyText" class="form-control"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
					<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- replyList-->
	<div class="mt-3 timeline">
		<span class="badge badge-success">Replies List<small id="replycntsmall">[${boardVO.replycnt }]</small></span>
		<div id="reply-box">
			<div id="repliesDiv">
			</div>
			<div class="text-center">
				<ul id="reply-pagination" class="pagination pagination-sm">
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 댓글 수정 Modal -->
	<div id="modifyModal" class="modal modal-primary fade position-relative" role="dialog" tabindex="-2" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body" data-rno>
					<p><input type="text" id="modReplyText" class="form-control"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
					<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
</div>

<c:import url="/footer"/>
<form role="form" method="post">
	<input type="hidden" name="bno" value="${boardVO.bno }">
	<input type="hidden" name="cate" value="${cri.cate }">
	<input type="hidden" name="page" value="${cri.page }">
	<input type="hidden" name="perPageNum" value="${cri.perPageNum }">
	<input type="hidden" name="searchType" value="${cri.searchType}">
	<input type="hidden" name="keyword" value="${cri.keyword}">
</form>
<script type="text/javascript">
	var result = '${msg}';
	if(result == 'SUCCESS'){
		alert("처리가 완료되었습니다.");
	}
	
	$(document).ready(function(){
		
		var formObj = $("form[role='form']");
		console.log(formObj);
		
		$("#delete-post").on("click", function(){
			
			var del = confirm('삭제하시겠습니까?');
			if(del == true){
				var arr = [];
				$(".uploadedList .mt-5").each(function(index){
					arr.push($(this).attr("data-src"));
				});
				
				if(arr.length > 0){
					$.post("/deleteAllFiles", {files:arr}, function(){
						
					});
				}
				formObj.attr("action", "/board/delete");
				formObj.submit();
			}
		});
		
		$("#go-list").on("click", function(){
			formObj.attr("method", "get");
			formObj.attr("action", "/board/list");
			formObj.submit();
		});
		
		$("#modify-post").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/board/modify")
			formObj.submit();
		});
		
		$("#create-post").on("click", function() {
			formObj.attr("method", "get");
			formObj.attr("action", "/board/create")
			formObj.submit();
		});
	});
</script>

<%-- 댓글목록 처리 위한 handlebars 탬플릿 --%>
<script id="template" type="text/x-handlebars-template">
{{#each .}}
<div class="replyLi my-4" data-rno={{rno}}>
	<div class="">
		<div class="d-flex justify-content-start">
			<h5 class="">작성자 - {{nickname}}({{userid}})</h5>
			<span class="ml-5">{{prettifyDate regdate}}</span>
		</div>
		<textarea class="form-control" rows="3" readonly>{{replyText}}</textarea>
		<div class="">
			{{#eqReplyer replyerIdx}}
			<a class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modifyModal">Modify</a>
			{{/eqReplyer}}
		</div>
	</div>
</div>
{{/each}}
</script>

<script type="text/javascript">
Handlebars.registerHelper("prettifyDate", function(timeValue){
	var dateObj = new Date(timeValue);
	var year = dateObj.getFullYear();
	var month = dateObj.getMonth() + 1;
	var date = dateObj.getDate();
	var hour = dateObj.getHours();
	var min = dateObj.getMinutes();
	var sec = dateObj.getSeconds();
	
	return year + "/" + month + "/" + date + " " + hour + ":" + min + ":" + sec;
});

var printData = function(replyArr, target, templateObject){
	var template = Handlebars.compile(templateObject.html());
	
	var html = template(replyArr);
	$(".replyLi").remove();
	target.after(html);
}

var bno = ${boardVO.bno};
var replyPage = 1;

function getPage(pageInfo){
	$.getJSON(pageInfo, function(data){
		printData(data.list, $("#repliesDiv"), $("#template"));
		printPaging(data.pm, $(".pagination"));
		
		$("#modifyModal").modal('hide');
		$("#replycntsmall").html("[ " + data.pm.totalCount + " ]");
	});
}

var printPaging = function(pm, target){
	var str = "";
	
	if(pm.prev){
		str +="<li class='page-item'><a class='page-link' href='" + (pm.startPage-1) + "'> << </a></li>";
	}
	
	for(var i=pm.startPage, len=pm.endPage; i<=len; i++){
		var strClass = "class='page-item'";
		if(pm.cri.page == i){
			strClass = "class='page-item active'";
		} 
		str += "<li " + strClass + "><a class='page-link' href='" + i + "'>" + i + "</a></li>";
	}
	
	if(pm.next){
		str += "<li class='page=item'><a class='page-link' href='" + (pm.endPage+1)+"'> >> </a></li>";
	}
	
	target.html(str);
}

$(".badge-success").on("click", function(){
	if($(".timeline .replyLi").length < 1){
		getPage("/replies/" + bno + "/1");
		$("#reply-box").toggle();
	}	
	
	$("#reply-box").toggle();	
});

$(".pagination").on("click", "li a", function(event){
	event.preventDefault();
	replyPage = $(this).attr("href");
	getPage("/replies/" + bno + "/" + replyPage);
});

$("#replyAddBtn").on("click", function(){
	var replyerObj = $("#writerIdx");
	var replytextObj = $("#replyText");
	var replyerIdx = replyerObj.val();
	var replyText = replytextObj.val();
	
	$.ajax({
		type:'post',
		url:'/replies/',
		headers:{
			"Content-Type":"application/json",
			"X-HTTP-Method-Override":"POST"
		},
		dataType:'text',
		data:JSON.stringify({bno:bno, replyerIdx:replyerIdx, replyText:replyText}),
		success:function(result){
			console.log("result: " + result);
			if(result == 'SUCCESS'){
				alert("등록되었습니다");
				replyPage = 1;
				getPage("/replies/" + bno + "/" + replyPage);
				//replyerObj.val("");
				replytextObj.val("");
			}
		}
	});
});

$("#replyText").on("keypress", function(event){
	if(event.keyCode == 13){
		$("#replyAddBtn").click();
	}
});

$("#replyModBtn").on("click",function(){
	var rno = $(".modal-title").html();
	var replyText = $("#modReplyText").val();
	
	$.ajax({
		type:'put',
		url:"/replies/" + rno,
		headers:{
			"Content-Type":"application/json",
			"X-HTTP-Method-Override":"PUT"
		},
		data:JSON.stringify({replyText:replyText}),
		dataType:'text',
		success:function(result){
			console.log("result: " + result);
			if(result == "SUCCESS"){
				alert("수정 되었습니다.");
				getPage("/replies/" + bno + "/" + replyPage);
			}
		}
	});
});

$("#replyDelBtn").on("click", function(){
	var rno = $(".modal-title").html();
	var replyText = $("#modReplyText").val();
	
	$.ajax({
		type:'delete',
		url:'/replies/' + rno,
		headers:{
			"Content-Type":"application/json",
			"X-HTTP-Method-Override":"DELETE"
		},
		dataType:'text',
		success:function(result){
			console.log("result: " + result);
			if(result == 'SUCCESS'){
				alert("삭제 되었습니다.");
				getPage("/replies/" + bno + "/" + replyPage);
			}
		}
	});
});

$(".timeline").on("click", ".replyLi", function(event){
	
	var reply = $(this);
	
	$("#modReplyText").val(reply.find('textarea').text());
	$(".modal-title").html(reply.attr("data-rno"));
});

Handlebars.registerHelper("eqReplyer", function(replyer, block){
	var accum = '';
	if (replyer == '${login.idx}'){
		accum += block.fn();
	}
	return accum;
});
</script>

<%--...이미 업로드된 첨부파일을 보여주기 위한 handlebars의 템플릿. --%>
<script id="templateAttach" type="text/x-handlebars-template">
<div data-src='{{fullName}}' class="mt-5">
	<div class="w-50">
		<span><img src="{{imgsrc}}" alt="Attachment" width=100%;></span>
		<p class="imglink text-center"><a href="{{getLink}}" class="">{{fileName}}</a></p>
	</div>
</div>
</script>

<script type="text/javascript">
var bno = ${boardVO.bno};
var template = Handlebars.compile($("#templateAttach").html());

$.getJSON("/board/getAttach/" + bno, function(list){
	$(list).each(function(){
		var fileInfo = getFileInfo(this);
		var html = template(fileInfo);
		$(".uploadedList").append(html);
	});
});

$(".uploadedList").on("click", ".imglink a", function(event){
	var fileLink = $(this).attr("href");
	
	if(checkImageType(fileLink)){
		event.preventDefault();
		
		var imgTag = $("#popup-img");
		imgTag.attr("src", fileLink);
		
		console.log(imgTag.attr("src"));
		
		$(".popup").show('slow');
		imgTag.addClass("show");
	}
});

$("#popup-img").on("click", function(){
	$(".popup").hide('slow');
});
</script>


</body>
</html>
