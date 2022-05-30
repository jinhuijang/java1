<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${ pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<link href="css/q&a.css" rel="stylesheet">
<link href="css/header_footer.css" rel="stylesheet">
</head>
<body>
     <%@include file="header.jsp" %>
    <section>
        <div id="wrap_qna">
			<div id="qna">
				<div id="qna_head" class="fs_m2 fw_7">
					<div id="my_qna"> 문의내역 </div> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<div id="new_qna"><a href="${contextPath}/trip?action=qnaForm.do">새 문의 작성</a> </div>
				</div>
				<c:choose>
					<c:when test="${ empty questionList}">
						<div>등록된 글이 없습니다</div>
					</c:when>
	                <c:when test="${! empty questionList}">
		                <c:forEach var="question" items="${questionList}" begin="${beginPage-1}" end="${endPage-1}" varStatus="questionNum">
			                <div id="qna_main">
			                    <div class="qna_title">
			                        <div>
			                            <div class="fs_m fw_6">${question.question_title}</div>
			                            <div class="fs_s margin_top">작성일 ${question.question_date}</div>
			                        </div>
			                        <div class="answer_button">
			                            <button class="btn_doAnswer" data-id="${question.question_no}">답변하기</button>
			                            <button class="btn_open">▼</button>
			                            <button class="btn_doMod" data-id="${question.question_no}">수정하기</button>
			                            <button class="btn_doRemove" data-id="${question.question_no}">삭제하기</button>
			                        </div>
			                    </div>
			                    <!--/<hr>-->
			                    <div class="qna_contents">
			                    	<div>${question.member_id}</div>
			                        <div class="qna_contents2" class="fs_m"> ${question.question_contents} </div>
			                    	<c:forEach var="answerList" items="${answerList}"> 
				                    	<c:if test="${question.question_no == answerList.question_parentno}">
			                        	<div class="qna_answer fs_s2">
				                            <br>
				                            <div><span class="fw_6 fs_m2">답변 &nbsp;</span><span class="fs_s">작성일 ${answerList.question_date}</span></div>
				                            <div>
				                            	${answerList.question_contents}
				                            </div>
			                        	</div>
			                        	</c:if>
		                        	</c:forEach>
			                    </div>
			                </div>
		                </c:forEach>
	                </c:when>
                </c:choose>
            </div>
            <c:if test="${!empty questionList}">
            <div class="center">
	            <div class="paging">
					<c:if test="${nowPageCount != 1}">
						<form>
							<button class="pagebt" name="action" value="qna.do">이전</button>
							<input type="hidden" name="nowPage" value="${(nowPageCount-1)*5-1}">
						</form>
					</c:if>
					<c:if test="${nowPageCount != totalPageCount}">
						<c:forEach var="i" begin="${1+ (5 * (nowPageCount-1))}"
							end="${5 + (5 * (nowPageCount-1))}">
							<div class="">
								<form>
									<c:if test="${nowPage == i}">
										<button name="action" value="qna.do" class="pagebt nowpage">${i}</button>
									</c:if>
									<c:if test="${nowPage != i}">
										<button name="action" value="qna.do" class="pagebt">${i}</button>
									</c:if>
									<input type="hidden" name="nowPage" value="${i}">
								</form>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${nowPageCount == totalPageCount}">
						<c:forEach var="i" begin="${1+ (5 * (nowPageCount-1))}"
							end="${totalPage}">
							<div class="">
								<form>
									<c:if test="${nowPage == i}">
										<button name="action" value="qna.do" class="pagebt nowpage">${i}</button>
									</c:if>
									<c:if test="${nowPage != i}">
										<button name="action" value="qna.do" class="pagebt">${i}</button>
									</c:if>
									<input type="hidden" name="nowPage" value="${i}">
								</form>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${nowPageCount != totalPageCount}">
						<form>
							<button class="pagebt" name="action" value="qna.do">다음</button>
							<input type="hidden" name="nowPage" value="${(nowPageCount+1)*5-4}">
						</form>
					</c:if>
	            </div>
            </div>
            </c:if>
        </div>
    </section>

    <!--include-->
    <%@include file="footer.jsp"%>


</body>

<script>
    var open_button = document.querySelectorAll(".btn_open");

    var contents = document.querySelectorAll(".qna_contents");

    for (let i = 0; i < open_button.length; i++) {
        open_button[i].addEventListener("click", function () {


            if (contents[i].style.display == ("" || "none")) {
                open_button[i].innerHTML = "▲";
                contents[i].style.display = "flex";
            } else {
                open_button[i].innerHTML = "▼";
                contents[i].style.display = "none";
            }
        });
    }

    var list_answer = document.querySelectorAll(".btn_doAnswer");
    console.log(list_answer.length);
    for(let i=0; i<list_answer.length; i++){
        list_answer[i].addEventListener("click", function(event){
        	let product_no = event.target.getAttribute("data-id");
            window.open("http://localhost:8080/project_trip/trip?action=answerqna.do&product_no="+product_no,"answer","width: 600px");
        })
    }
    
    var list_mod = document.querySelectorAll(".btn_doMod");
    console.log(list_mod.length);
    for(let i=0; i<list_mod.length; i++){
        list_mod[i].addEventListener("click", function(event){
        	let select_no = event.target.getAttribute("data-id");
            window.open("http://localhost:8080/project_trip/trip?action=modwrite.do&select_no="+select_no,"mod","width: 600px");
        })
    }
    
    var list_remove = document.querySelectorAll(".btn_doRemove");
    console.log(list_mod.length);
    for(let i=0; i<list_remove.length; i++){
    	list_remove[i].addEventListener("click", function(event){
        	let remove_no = event.target.getAttribute("data-id");
        	var isDel = window.confirm("정말 삭제하시겠습니까?");
        	if(isDel){
        		location.href="http://localhost:8080/project_trip/trip?action=removeqna.do&remove_no="+remove_no;	
        	}
        })
    }
</script>

</html>