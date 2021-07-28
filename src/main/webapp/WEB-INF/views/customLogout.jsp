<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>

<head>

<title></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>

	<form role="form" method='post' action="/customLogout">
		<fieldset>
			<a href="index.html" class="btn-success">Logout</a>
		</fieldset>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	${param.logout}

	<script>
  
  $(".btn-success").on("click", function(e){
    
    e.preventDefault();
    $("form").submit();
    
  });
  
  </script>
  


</body>

</html>