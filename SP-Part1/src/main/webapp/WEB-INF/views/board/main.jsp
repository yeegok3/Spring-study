<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities }"/>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${contextPath}/resources/style.css" />
</head>

<body>
	<div class="container">
	<jsp:include page="../common/header.jsp"/>
		<h1>Spring Study</h1>
		<div class="panel panel-warning">
			<div class="panel-heading">회원게시판</div>
			<div class="panel-body" id="view">게시판 리스트</div>
			<div class="panel-body" id="wform" style="display: none">
				<form id="frm">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				
					<input type="hidden" id="memID" name="memID" value="${mvo.member.memID }" />
					<table class="table table-bordered">
						<tr>
							<td>제목</td>
							<td><input type="text" id="title" name="title"
								class="form-control" required /></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea class="form-control" id="content"
									name="content" cols="30" rows="10" style="resize:none"></textarea></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td><input class="form-control" type="text" id="writer"
								name="writer" value="${mvo.member.memName }" readonly /></td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" class="btn btn-primary btn-sm" onclick="goInsert()">등록</button>
								<button type="reset" class="btn btn-warning btn-sm" id="fclear">취소</button>
								<button type="button" class="btn btn-info btn-sm"
									onclick="goList()">목록</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="panel-footer">
				<small>&copy; 2024 Yeegok3. All Right Reserved.</small>
			</div>
		</div>
	</div>


	<script type="text/javascript">
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfToken = "${_csrf.token}";

	loadList();

	function loadList() {
				
		$.ajax({
			url: "board/all",
			type: "get",
			dataType: "json",
			success: makeView,
			error: function(){alert("list error");}
		});
	}
	
	function makeView(data) {
		let listHtml = "<table class='table table-bordered'>";
		listHtml += "<tr>";
		listHtml += "<td>번호</td>";
		listHtml += "<td>제목</td>";
		listHtml += "<td>작성자</td>";
		listHtml += "<td>작성일</td>";
		listHtml += "<td>조회수</td>";
		listHtml += "</tr>";
		
		$.each(data, (index, obj) => {
			listHtml += "<tr>";
			listHtml += "<td>"+obj.idx+"</td>";
			listHtml += "<td id='tt"+obj.idx+"'><a href='javascript:goContent("+obj.idx+")'>"+obj.title+"</a></td>";
			listHtml += "<td>"+obj.writer+"</td>";
			listHtml += "<td>"+obj.indate.split(' ')[0]+"</td>";
			listHtml += "<td id='cnt"+obj.idx+"'>"+obj.count+"</td>";
			listHtml += "</tr>";
			
			listHtml += "<tr id='c"+obj.idx+"' style='display:none'>";
			listHtml += "<td>내용</td>";
			listHtml += "<td colspan='4'>";
			listHtml += "<textarea id='txt"+obj.idx+"' rows='7' class='form-control' style='resize:none' readonly></textarea>";
			
			if("${mvo.member.memID}" == obj.memID){
				listHtml += "<br>";
				listHtml += "<span id='up"+obj.idx+"'><button class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp;";
				listHtml += "<button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>&nbsp;";
				listHtml += "<br>"
			}else {
				listHtml += "<br>";
				listHtml += "<span id='up"+obj.idx+"'><button class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")' disabled >수정화면</button></span>&nbsp;";
				listHtml += "<button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")' disabled>삭제</button>&nbsp;";
				listHtml += "<br>"
			}
			listHtml += "</td>";
			listHtml += "</tr>";
			
		});
		if(${!empty mvo.member}){
		listHtml += "<tr><td colspan='5'>";
		listHtml += "<button class='btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>";
		listHtml += "</td></tr>";
		}
		listHtml += "</table>";
		$("#view").html(listHtml);
		
		$("#fclear").trigger("click");
		$("#view").css("display", "block");
		$("#wform").css("display", "none");
	}
	
	function goForm(){
		$("#view").css("display", "none");
		$("#wform").css("display", "block");
	}
	
	function goList() {
		$(".form-control").val("");
		$("#view").css("display", "block");
		$("#wform").css("display", "none");
		loadList();
	}

	function goInsert() {
		let memID = $("#memID").val();
 		let title = $("#title").val();
 		let content = $("#content").val();
 		let writer = $("#writer").val();
 		if(title === ""){
 			alert("제목을 입력해야 합니다.");
 		}else {
 	
 			let fData = {
 					memID: memID,
 					title: title,
 					content: content,
 					writer: writer
 			};
 			
			$.ajax({
				url: "board/new",
				type: "post",
				data: fData,
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfToken);
				},
				success: loadList,
				error: () => {alert("insert error");}
			});
 		}
	}
	
	function goContent(idx) {
		$("tr[id^='c']").not("#c"+idx).css("display", "none");
		let content = $("#c"+idx);
		
		if(content.css("display") === "none"){
			$.ajax({
				url: "board/count/"+idx,
				type: "put",
				dataType: "json",
				beforeSend: xhr => xhr.setRequestHeader(csrfHeaderName, csrfToken),
				success: data => {
					$("#cnt"+idx).text(data.count);
				},
				error: () => alert("count error!!")
			});
			
			$.ajax({
				url: "board/"+idx,
				type: "get",
				dataType: "json",
				success: function(data) {
					$("#txt"+idx).val(data.content);
				},
				error: function() {alert("content error!!")}
			});
			content.css("display", "table-row");
			$("#txt"+idx).attr("readonly", true);
		}else {
			content.css("display", "none");
			
			goList();
		}
	}
	
	function goDelete(idx) {
		$.ajax({
			url: "board/"+idx,
			type: "delete",
			beforeSend: xhr => xhr.setRequestHeader(csrfHeaderName, csrfToken),
			success: loadList,
			error: () => alert("delete error!!")
		});
	}
	
	function goUpdateForm(idx) {
		
	    $("td>a").css({
	        "cursor": "not-allowed",   // 마우스 커서 사용 불가 모양으로 변경
	        "pointer-events": "none" // 클릭 막기
	    });
		
		$("#txt"+idx).attr("readonly", false);
		let title = $("#tt"+idx).text();
		let newInput = "<input type='text' id='ntt"+idx+"' class='form-control' value='"+title+"' />";
		$("#tt"+idx).html(newInput);
	
		let newButton = "<button class='btn btn-info btn-sm' onclick='goUpdate("+idx+")'>수정</button>";
		$("#up"+idx).html(newButton);
	}

	function goUpdate(idx) {
		let title = $("#ntt"+idx).val();
		let content = $("#txt"+idx).val();
		$.ajax({
			url: "board/update",
			type: "put",
			contentType: "application/json;charset=utf-8",
			data: JSON.stringify({"idx":idx, "title": title, "content": content}),
			beforeSend: xhr => xhr.setRequestHeader(csrfHeaderName, csrfToken),
			success: loadList,
			error: () => alert("update error!!")
		});
	}
</script>
</body>
</html>




































































