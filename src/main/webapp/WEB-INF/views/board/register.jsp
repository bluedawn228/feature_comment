<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
</head>
<body>
<h1>게시글 등록</h1>
  <form role="form" action="/board/register" method="post">
    <label>제목</label> <input name="title"><br>
    <label>내용</label> <textarea name="content"></textarea><br>
    <label>작성자</label> <input name="writer" value='<sec:authentication property="principal.username"/>' readonly="readonly"><br>
    <button type="submit">등록</button>
    <button type="reset">리셋</button>
  </form>
</body>
</html>