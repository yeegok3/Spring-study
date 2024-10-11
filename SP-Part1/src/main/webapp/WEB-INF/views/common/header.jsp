<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="mvo" value="${SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:set var="auth" value="${SPRING_SECURITY_CONTEXT.authentication.authorities }"/>

<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	function logout() {
		$.ajax({
			url: "${contextPath}/logout",
			type: "post",
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(){
				location.href="${contextPath}/";
			},
			error: () => alert("logout error!!")
		});
	}
</script>

<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="${contextPath}/">Spring MVC Part 1</a>
    </div>
    <div id="myNavbar">
      	<ul class="nav navbar-nav">
	        <li class="active"><a href="${contextPath}/">Home</a></li>
	        <li><a href="boardMain.do">게시판</a></li>
	        <li><a href="#">Page 2</a></li>
      	</ul>
      	<security:authorize access="isAnonymous()">
	      <ul class="nav navbar-nav navbar-right">
	       
	        		<li><a href="${contextPath }/memLoginForm.do"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
	        		<li><a href="${contextPath }/memJoin.do"><span class="glyphicon glyphicon-user"></span> 회원가입</a></li>

	      </ul>
      	</security:authorize>
       	<security:authorize access="isAuthenticated()">
	      	<ul class="nav navbar-nav navbar-right">
	      		
		        	<li><a href="${contextPath}/memUpdateForm.do"><span class="glyphicon glyphicon-wrench"></span> 회원정보수정</a></li>
		        	<li><a href="${contextPath }/memImgForm.do"><span class="glyphicon glyphicon-camera"></span> 사진등록</a></li>
		        	<li><a href="javascript:logout()"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
					<li class="userName">	
						<c:if test="${empty mvo.member.memProfile}">
							<img class="person-img" src="${contextPath }/resources/images/person.png" />
						</c:if>
				
						<c:if test="${!empty mvo.member.memProfile}">
							<img class="person-img" src="${contextPath }/resources/upload/${mvo.member.memProfile}" />
						</c:if>
						${mvo.member.memName}
							(
								<security:authorize access="hasRole('ROLE_USER')">
								U
								</security:authorize>
								<security:authorize access="hasRole('ROLE_MANAGER')">
								M
								</security:authorize>
								<security:authorize access="hasRole('ROLE_ADMIN')">
								A
								</security:authorize>
							)
					</li>
					
					<hr>
	      	</ul>
      	</security:authorize>
    </div>
  </div>
</nav>









































