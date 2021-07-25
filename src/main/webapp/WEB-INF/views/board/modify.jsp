<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	var formObject = $("form");
	
	$("button").on("click", function(e) {
	
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === "remove") {
			formObject.attr("action", "/board/remove");
		} else if(operation === "list") {
		      formObj.attr("action", "/board/list").attr("method", "get");
		      formObj.empty();
		}
		
		formObject.submit();
	});
});
</script>
</head>
<body>
<h1>게시글 수정</h1>
	<form role="form" action="/board/modify" method="post">
	    <label>번호</label> <input name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly"><br>
	    <label>제목</label> <input name="title" value='<c:out value="${board.title}"/>'><br>
	    <label>내용</label> <textarea name="content"><c:out value="${board.content}"/></textarea><br>
	    <label>작성자</label> <input name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly"><br>
	    <label>등록일</label> <input name="regdate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/>' readonly="readonly"><br>
	    <label>수정일</label> <input name="updateDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/>' readonly="readonly"><br>
	    
	    <button type="submit" data-oper="modify" >수정</button>
	    <button type="submit" data-oper="remove">삭제</button>
	    <button type="submit" data-oper="list">목록</button>
	</form>
</body>
</html>