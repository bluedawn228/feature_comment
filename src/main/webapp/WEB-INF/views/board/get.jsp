<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 조회</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var operForm = $("#operForm");
	$("button[data-oper='modify']").on("click", function(e) {
		operForm.attr("action", "/board/modify").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e) {
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list").submit();
		operForm.submit();
	});
});
</script>

</head>
<body>
<h1>게시글 조회</h1>
    <label>번호</label> <input name="bno" value='<c:out value="${board.bno}"/>' readonly="readonly"><br>
    <label>제목</label> <input name="title" value='<c:out value="${board.title}"/>' readonly="readonly"><br>
    <label>내용</label> <textarea name="content" readonly="readonly"><c:out value="${board.content}"/></textarea><br>
    <label>작성자</label> <input name="writer" value='<c:out value="${board.writer}"/>' readonly="readonly"><br>
    
    <button data-oper='modify'>수정</button>
    <button data-oper='list'>목록</button>
    
    <form id="operForm" action="/board/modify" method="get">
      <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
      <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
      <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
    </form>
</body>
</html>