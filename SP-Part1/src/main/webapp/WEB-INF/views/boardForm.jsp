<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Bootstrap Example</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" />
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>

<body>

	<div class="container">
		<h2>Spring Study</h2>
		<div class="panel panel-default">
			<div class="panel-heading">BOARD</div>
			<div class="panel-body">
			<form action="${pageContext.request.contextPath}/boardInsert.do" method="post">
				<table class="table">
					<tr>
						<td>제목</td>
						<td><input type="text" name="title" class="form-control" required /></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea name="content" id="" cols="30" rows="10" class="form-control"></textarea></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input type="text" name="writer" class="form-control"/></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<button type="submit" class="btn btn-success btn-sm">등록</button>
							<button type="reset" class="btn btn-warning btn-sm">취소</button>
							<button type="button" class="btn btn-warning btn-sm" onclick="location.href='${pageContext.request.contextPath }/boardList.do'">목록보기</button>
						</td>
					</tr>
				</table>
			</form>
			</div>
			    <div class="panel-footer"><small>&copy; 2024 Yeegok3. All Right Reserved.</small></div>
			</div>
	</div>

</body>
</html>