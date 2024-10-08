<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Bootstrap Example</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="${contextPath}/resources/style.css" />
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	

	
	
</head>
<body>

	<div class="container">
	<jsp:include page="../common/header.jsp"/>
		<h1>Spring Study</h1>
		<div class="panel panel-warning">
			<div class="panel-heading">회원가입</div>
			<div class="panel-body">
			<form name="frm" action="${contextPath}/memRegister.do" method="post">
				<table class="table table-bordered">
					<tr>
						<td>아이디</td>
						<td><input id="memID" name="memID" type="text" class="form-control" maxlength="20" placeholder="아이디를 입력하세요."/></td>
						<td><button type="button" class="btn btn-primary" onclick="registerCheck()">중복확인</button></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td colspan="2"><input id="memPassword" name="memPassword" type="password" onkeyup="passwordCheck()" class="form-control" maxlength="20" placeholder="비밀번호를 입력하세요."/></td>
					</tr>
					<tr>
						<td>비밀번호확인</td>
						<td colspan="2"><input id="memPassword2" name="memPassword2" onkeyup="passwordCheck()" type="password" class="form-control" maxlength="20" placeholder="비밀번호를 확인하세요."/></td>
					</tr>
					<tr>
						<td>사용자 이름</td>
						<td colspan="2"><input id="memName" name="memName" type="text" class="form-control" maxlength="20" placeholder="이름을 입력하세요." /></td>
					</tr>
					<tr>
						<td>나이</td>
						<td colspan="2"><input id="memAge" name="memAge" type="number" class="form-control" maxlength="20" placeholder="10 ~ 100 사이의 나이만 입력가능합니다." /></td>
					</tr>
					<tr>
						<td>성별</td>
						<td colspan="2">
							<div class="form-group">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-primary active">
									<input type="radio" autocomplete="off" id="memGender" name="memGender" value="남자" checked /> 
									남자</label>
									<label class="btn btn-primary">
									<input type="radio" autocomplete="off" id="memGender" name="memGender" value="여자" />	
									여자</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>이메일</td>
						<td colspan="2"><input id="memEmail" name="memEmail" type="text" class="form-control" placeholder="이메일을 입력해 주세요."/></td>
					</tr>
					<tr>
						<td colspan="3">
							<span id="passMessage"></span><input type="button" class="btn btn-primary btn-sm pull-right" value="등록" onclick="goRegister()" />
						</td>
					</tr>
				</table>			
			
			</form>
			</div>
			<!-- 모달창 코딩 -->
			<!-- Trigger the modal with a button -->
			
			
			<!-- Modal -->
			<div id="myModal" class="modal fade" role="dialog">
			  <div class="modal-dialog modal-sm">
			
			    <!-- Modal content-->
			    <div id="checkType" class="modal-content panel-info">
			      <div class="modal-header panel-heading">
			        <button type="button" class="close" data-dismiss="modal">&times;</button>
			        <h4 class="modal-title">중복확인 메세지</h4>
			      </div>
			      <div class="modal-body">
			        <p id="checkMessage"></p>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			      </div>
			    </div>
			
			  </div>
			</div>
			
			
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
			
			<!-- footer -->
			<div class="panel-footer">
				<small>&copy; 2024 Yeegok3. All Rights Reserved.</small>
			</div>
		</div>
	</div>


	<script>
		
		function registerCheck() {
			let memID = $("#memID").val();
			$.ajax({
				url : "${contextPath}/memRegisterCheck.do",
				type : "get",
				data : {
					"memID" : memID
				},
				success : function(result) {
					if(result == 1){
						$("#checkMessage").html("사용할수 있는 아이디입니다.");
						$("#checkType").attr("class", "modal-content panel-success");
					}else{
						$("#checkMessage").html("사용할수 없는 아이디입니다.");
						$("#checkType").attr("class", "modal-content panel-warning");
					}
					$("#myModal").modal("show");
				},
				error : function() {
					alert("memRegisterCheck error!")
				}
			});
		}
		
		function passwordCheck() {
			let memPassword1 = $("#memPassword").val();
			let memPassword2 = $("#memPassword2").val();
			if(memPassword1 != memPassword2){
				$("#passMessage").html("비밀번호가 일치하지 않습니다.");
			}else {
				$("#passMessage").html("");
				$("#memPassword").val(memPassword1);
			}
		}
		
		function goRegister() {
			let memAge = $("#memAge").val();
			if(memAge == null || memAge == ""){
				alert("나이를 입력핫에요.");
				return false;
			}
			document.frm.submit();
		}
		
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






































