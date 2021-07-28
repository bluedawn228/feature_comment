<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title></title>
</head>

<body>

		<form role="form" method='post' action="/login">
			<fieldset>
				<div class="form-group">
				<!-- name 속성을 스프링 시큐리티에 맞게 써야한다 -->
					<input placeholder="userid" name="username" type="text" autofocus>
				</div>
				
				<div class="form-group">
					<input placeholder="Password" name="password" type="password" value="">
				</div>
				
				<div class="checkbox">
					<label> <input name="remember-me" type="checkbox">로그인 상태 유지</label>
				</div>
				<a href="index.html" class="btn-success">로그인</a>
			</fieldset>
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>


	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<script>
  $(".btn-success").on("click", function(e){
    
    e.preventDefault();
    $("form").submit();
    
  });
  </script>
  
    <c:if test="${param.logout != null}">
      <script>
      $(document).ready(function(){
        alert("로그아웃하였습니다.");
      });
      </script>
  </c:if> 
</body>

</html>
