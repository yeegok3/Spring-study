<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Bootstrap Example</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" />
</head>
<body>

	<div class="container">
	<jsp:include page="../common/header.jsp"/>
		<h1>Spring Study</h1>
		<div class="panel panel-warning">
			<div class="panel-heading">로그인 화면</div>
			<div class="panel-body">
			
			<form action="${contextPath}/memLogin.do" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
				<table class="table table-bordered">
					<tr>
						<th>아이디</td>
						<td><input id="memID" name="memID" type="text" class="form-control" maxlength="20" placeholder="아이디를 입력하세요."/></td>
					</tr>
					<tr>
						<th>비밀번호</td>
						<td colspan="2"><input id="memPassword" name="memPassword" type="password" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요."/></td>
					</tr>
					
					<tr>
						<td colspan="3">
							</span><input type="submit" class="btn btn-primary btn-sm pull-right" value="로그인"/>
						</td>
					</tr>
				</table>			
			
			</form>
			</div>
			
			<!-- 실패 메세지 뿌리기 -->
			<!-- Modal -->
			<div id="myMessage" class="modal fade" role="dialog">
			  <div class="modal-dialog modal-sm">
			
			    <!-- Modal content-->
			    <div id="messageType" class="modal-content panel-info">
			      <div class="modal-header panel-heading">
			        <button type="button" class="close" data-dismiss="modal">&times;</button>
			        <h4 class="modal-title">${msgType}</h4>
			      </div>
			      <div class="modal-body">
			        <p>${msg}</p>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			      </div>
			    </div>
			
			  </div>
			</div>
			
			<div class="panel-footer">
				<small>&copy; 2024 Yeegok3. All Rights Reserved.</small>
			</div>
		</div>
	</div>

	<script>
	$(document).ready(function() {
		if(${!empty msgType}) {
			if(${msgType eq "실패 메세지"}){
				$("#messageType").attr("class", "modal-content panel-warning");
			}else {
				$("#messageType").attr("class", "modal-content panel-success");
			}
			$("#myMessage").modal("show");
		}
	});
	</script>

</body>
</html>


















