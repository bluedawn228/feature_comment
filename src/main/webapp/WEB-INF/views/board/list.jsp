<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var result='<c:out value="${result}"/>';
	
	alertRegisteredBoardNumber(result);
	
	/*현재 페이지는 alert창을 띄울 필요가 없다고 표시를 해둔다*/
	history.replaceState({}, null, null);
	
	function alertRegisteredBoardNumber(result) {
		/*'/board/list'를 호출했을때 alert창이 나오지 않게*/
		if(result==='' || history.state) {
			return;
		}
		
		if(parseInt(result) > 0) {
			alert("게시글 " + parseInt(result) + "번이 등록되었습니다.");
		}
		
		if(result==="success") {
			alert("처리가 완료되었습니다.");
		}
	}
	  
	$("#registerButton").on("click", function() {
		self.location = "/board/register";
	});
	
	var actionForm = $("#actionForm");
	
	$(".paginate_button").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
	
	$(".move").on("click", function(e) {
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
		actionForm.attr("action", "/board/get");
		actionForm.submit();
	});
});

</script>

</head>
<body>
	<h1>게시글 목록</h1>
	<button id="registerButton" type="button">게시글 등록</button>
	<table>
		<thead>
			<tr>
				<th>#번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
		</thead>
		
		<c:forEach items="${list}" var="board">
		  <tr>
		    <td><c:out value="${board.bno}"/></td>
		    <td><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></td>
		    <td><c:out value="${board.writer}"/></td>
		    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
		    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
		  </tr>
		</c:forEach>
		
		
	</table>
	
		<c:if test="${pageMaker.prev}">
		  <a class= "paginate_button" href="${pageMaker.startPage-1}">이전</a>
		</c:if>
		
		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
		  <a class= "paginate_button"  href="${num}">${num} </a>
		</c:forEach>
		
		<c:if test="${pageMaker.next}">
		  <a class= "paginate_button" href="${pageMaker.endPage+1}">다음</a>
		</c:if>
		
		<form id="actionForm" action="/board/list" method="get">
		  <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>'>
		  <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>'>
		</form>
</body>
</html>