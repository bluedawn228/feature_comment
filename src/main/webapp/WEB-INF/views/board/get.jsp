<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 조회</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<!-- <script type="text/javascript">
$(document).ready(function() {
	console.log(replyService);
	console.log("=============");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	replyService.add(
			{reply: "JS Test", replyer:"tester", bno:bnoValue}
			, 
			function(result) {
				alert("RESULT: " + result);
			}
		);
});
</script> -->

<!-- <script type="text/javascript">
$(document).ready(function() {
	console.log(replyService);
	console.log("=============");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	replyService.getList(
			{bno:bnoValue, page:1}, 
			function(list) {
				for(var i = 0, len = list.length||0; i < len; i++) {
					console.log(list[i]);
				}
			}
		);
});
</script>
 -->
 
<!-- <script type="text/javascript">
$(document).ready(function() {
	console.log(replyService);
	console.log("=============");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	replyService.remove(2, function(count) {
		console.log(count);
		if(count === "success") {
			alert("REMOVED");
		}
	}, function(err) {
		alert("err...");
	});
});
</script> -->

<!-- <script type="text/javascript">
$(document).ready(function() {
	console.log(replyService);
	console.log("=============");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	replyService.update({
		rno: 3,
		bno: bnoValue,
		reply : "Modified Reply...."
	}, function(result) {
		alert("수정 완료...")
	});
});
</script> -->

<!-- <script type="text/javascript">
$(document).ready(function() {
	console.log(replyService);
	console.log("=============");
	console.log("JS TEST");
	
	/* var bnoValue = '<c:out value="${board.bno}"/>'; */
	
	replyService.get(3, function(data) {
		console.log(data);
	});
});
</script> -->

<!-- 댓글 목록 -->
<script>
$(document).ready(function() {
	var bnoValue='<c:out value="${board.bno}"/>';
	var replyUL=$(".chat");
	
	showList(1);
	
	function showList(page) {
		
		console.log("show list " + page);
		
		replyService.getList({bno:bnoValue, page: page || 1}, function(replyCnt, list) {
			console.log("replyCnt:" + replyCnt);
			console.log("list: " + list);
			console.log(list);
			
			if(page == -1) {
				pageNum = Math.ceil(replyCnt/10.0);
				showList(pageNum);
				return;
			}
			
			var str = "";
			if(list==null||list.length==0) {
				/* replyUL.html(""); */
				return;
			}
			for(var i = 0, len = list.length || 0; i < len; i++) {
				str +="<li data-rno='" + list[i].rno+"'>";
				str +="  <strong> [" + list[i].rno + "] " + list[i].replyer + "</strong>";
				str +="  <small>" + replyService.displayTime(list[i].replyDate) + "</small>";
				str +="  <p>" + list[i].reply + "</p></li>";
			}
			replyUL.html(str);
			showReplyPage(replyCnt);
		}); // end function
	} // end showList
	
	/*새댓글 모달*/
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
    var replyer = null;
    
    /*로그인한 사용자가 댓글작성자가 된다*/
    <sec:authorize access="isAuthenticated()">
      replyer = '<sec:authentication property="principal.username"/>';   
    </sec:authorize>
 
    var csrfHeaderName ="${_csrf.headerName}"; 
    var csrfTokenValue="${_csrf.token}";
	
    $("#addReplyBtn").on("click", function(e){
        
        modal.find("input").val("");
        modal.find("input[name='replyer']").val(replyer);
        modalInputReplyDate.closest("div").hide();
        modal.find("button[id !='modalCloseBtn']").hide();
        
        modalRegisterBtn.show();
        
        $(".modal").modal("show");
        
      });

    /*모든 Ajax 전송시 CSRF 토큰을 같이 전송하도록 세팅
      매번 Ajax사용시 beforeSend를 호출해야하는 번거로움을 줄일수 있다.
    */
    $(document).ajaxSend(function(e, xhr, options) { 
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
      }); 
	
	modalRegisterBtn.on("click", function(e) {
		var reply = {
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				bno: bnoValue
		};
		replyService.add(reply, function(result) {
			alert(result);
			/*등록한 내용으로 다시 등록할 수 없도록 입력항목을 비운다*/
			modal.find("input").val("");
			modal.modal("hide");
			
			/*댓글 추가 후 댓글 목록 갱신*/
			showList(-1);
		});
	});
	
	/*댓글 클릭*/
	/*on()을 이용하면 쉽게 이벤트 위임을 할 수 있다!*/
	$(".chat").on("click", "li", function(e) {
		/*this가 .chat이 아닌 li인 것이다*/
		var rno = $(this).data("rno");
		replyService.get(rno, function(reply) {
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly", "readonly");
			/*data-rno 속성을 만들어서 추가해둔다*/
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
		});
	});
	
	modalModBtn.on("click", function(e) {
		/*위에서 추가한 data-rno*/
		var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
		replyService.update(reply, function(result) {
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	modalRemoveBtn.on("click", function(e) {
		var rno = modal.data("rno");
		replyService.remove(rno, function(result) {
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt) {
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		if(endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt) {
			next = true;
		}
		
		var str = "<ul>";
		if(prev) {
			str+="<li><a href='"+(startNum - 1) + "'>이전</a></li>"
		}
		
		for(var i = startNum; i <= endNum; i++) {
			str += "<a href='"+i+"'>"+i+"</a> ";
		}
		
		if(next) {
			str += "<li><a href='"+(enfNum+1)+"'>다음</a></li>";
		}
		
		str +="</ul></div>";
		console.log(str);
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click", "a", function(e) {
		e.preventDefault();
		console.log("page click");
		var targetPageNum = $(this).attr("href");
		console.log("targetPagNum: " + targetPageNum);
		pageNum = targetPageNum;
		showList(pageNum);
	});
});
</script>

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
    
    <!-- authentication 태그를 계속 쓰는게 불편하니 principal을 pinfo에 담아두자 -->
    <sec:authentication property="principal" var="pinfo"/>
    <!-- 로그인한 사용자만 접근 가능 -->
	    <sec:authorize access="isAuthenticated()">
	    <!-- 해당 게시글 작성자만 수정 버튼이 보임 -->
		    <c:if test="${pinfo.username eq board.writer}">
		      <button data-oper='modify'>수정</button>
	      </c:if>
	    </sec:authorize>
	    
    <button data-oper='list'>목록</button><br>
    
    <sec:authorize access="isAuthenticated()">
		  <button id='addReplyBtn' type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addReplyModal" data-bs-whatever="@mdo">새 댓글</button>
    </sec:authorize>
    <!-- <button id='addReplyBtn'>새 댓글</button> -->
    <!-- start reply -->
    <ul class="chat">
    </ul>
    
    <div class = "panel-footer">
    </div>
    <!-- end reply -->
    

		<!-- start 새 댓글 modal -->
		<div class="modal fade" id="addReplyModal" tabindex="-1" aria-labelledby="addReplyModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="addReplyModalLabel">새 댓글</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <!-- <form> -->
		          <div class="mb-3">
		            <label for="reply" class="col-form-label">내용:</label>
		            <input class="form-control" name='reply' value="New Reply!!!">
		          </div>
		          <div class="mb-3">
		            <label for="replyer" class="col-form-label">작성자:</label>
		            <input class="form-control" name='replyer' value="replyer">
		          </div>
		          <div class="mb-3">
		            <label for="replyDate" class="col-form-label">입력 날짜:</label>
		            <input class="form-control" name='replyDate' value="replyDate">
		          </div>
		        <!-- </form> -->
		      </div>
		      <div class="modal-footer">
		        <button id= 'modalCloseBtn' type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        <button id= 'modalModBtn' type="button" class="btn btn-warning">수정</button>
		        <button id= 'modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
		        <button id= 'modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- end 새댓글 modal -->
    
    <form id="operForm" action="/board/modify" method="get">
      <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
      <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
      <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
      <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
      <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
    </form>
    

</body>
</html>