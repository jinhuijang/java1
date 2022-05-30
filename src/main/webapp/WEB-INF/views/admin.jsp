<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사적모임 | Document</title>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header_footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>

<body>
    <%@include file="header.jsp" %>
    <nav>
    	<div class="nav">
	        <div class="tap">
	            <div data-tap="st0" class="tap_list">내 정보</div>
                <div data-tap="st1" class="tap_list tap_state">회원 관리</div>
	            <div data-tap="st2" class="tap_list tap_state">숙소 관리</div>
 	            <div data-tap="st3" class="tap_list tap_state">문의 관리</div> 
 	            <div data-tap="st4" class="tap_list tap_state">객실 관리</div> 
	        </div>
    	</div>
    </nav>
    <div id="wrap_admin">
    <div id="hidden_bg" class="nodisplay"></div>
    <div id="hidden_contents" class="nodisplay"></div>
    <div id="insert_type" data-type="insert"></div>
    <div id="nextpage" class="nodisplay" value=""></div>
    <section>
        <div class="fl_center">
        <div id="st0">
                    <div class="my_info">
                        <div>
                            <img src="${contextPath }/resources/image/main2.jpg" style="width: 500px">
                        </div>

                        <div id="info_contents" >
                            <div>
                                <h3>관리자 페이지</h3>
                                <p>환영합니다. ${memberDTO.member_names} 님</p>
                            </div>
                            <div>
                                아이디 &nbsp;&nbsp;<span class="mem_info">${memberDTO.member_id}</span> <br>
                                닉네임&nbsp;&nbsp;<span class="mem_info"> ${memberDTO.member_names} </span><br>
                                전화번호<span class="mem_info">${memberDTO.member_tel} </span><br>
                            </div>
                             <div id="admin_form">
                                <form id="logout_form" action="${contextPath}/trip/logoutCheck.do">
                                    <input id="btn_logout" type="button" value="로그아웃">
                                </form>
                                <form id="withdraw_form" method="post" action="${contextPath}/trip/removeMember.do">
                                    <input id="btn_withdraw" type="button" onclick="del_button_event()"  value="회원탈퇴">
                                    <input type="hidden" name="member_id" value="${memberDTO.member_id}">
                                </form>
                            </div>
                        </div>
                        <br>
                    </div>
                </div>
                <!---->
            <div id="st1" class="nodisplay">
            	<div class="nodisplay" style="text-align:center;"><button data-type="mem" class="insert_bt" type="button">추가</button></div>
                <table>
                    <thead>
                        <tr>
                            <th>아이디</th>
                            <th>비밀번호</th>
                            <th>닉네임</th>
                            <th>전화번호</th>
                            <th>권한</th>
                            <th>수정</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="member" items="${membersList}">
                        <tr>
                            <td>${member.member_id}</td>
                            <input type="hidden" id="id" name="id" value="${member.member_id}">
                            <td><input type="text" id="pw" name="pw" readonly value="${member.member_pw}"></td>
                            <td><input type="text" id="name" name="name" readonly value="${member.member_names}"></td>
                            <td><input type="text" id="tel" name="tel" readonly value="${member.member_tel}"></td>
                            <td><input type="text" id="authority" name="authority" readonly value="${member.member_authority}"></td>
                            <td style="text-align: center;"><button class="bt" name="type" value="mem">수정하기</button></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div id="st2" class="nodisplay">
            	<div style="text-align:right;"><button data-type="dorm" class="insert_bt" type="button">숙소추가</button></div>
                <table> 
                    <thead>
                        <tr>
                            <th>숙소번호</th>
                            <th>카테고리</th>
                            <th>이름</th>
                            <th>소개</th>
                            <th>주소</th>
                            <th>그림 파일</th>
                            <th colspan="5">옵션</th>
                            <th>수정</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="dorm" items="${dormsList}" varStatus="i">
                        <tr>
                            <input type="hidden" id="dormno" class="td_dorm" name="dormno" value="${dorm.dorm_no}">
                            <td>${dorm.dorm_no}</td>
                            <td>
                            	<select id="category" class="td_dorm" name="category" disabled>
                            		<option value="1" ${dorm.dorm_category_no eq 1 ? 'selected' : ''}>호텔</option>
                            		<option value="2" ${dorm.dorm_category_no eq 2 ? 'selected' : ''}>펜션</option>
                            		<option value="3" ${dorm.dorm_category_no eq 3 ? 'selected' : ''}>리조트</option>
                            		<option value="4" ${dorm.dorm_category_no eq 4 ? 'selected' : ''}>게스트하우스</option>
                            	</select>
                            </td>
                            <td><input type="text" id="name" name="name" readonly value="${dorm.dorm_name}"></td>
                            <td><button type="button" class="contents_bt" name="content" value="${dorm.dorm_contents}">내용 보기</button></td>
                            <input type="hidden" id="contents_val" name="contents" value="${dorm.dorm_contents}">
                            <td><input type="text" id="addr" name="addr" readonly value="${dorm.dorm_addr}"></td>
                            <td><input type="text" id="picture" name="picture" readonly value="${dorm.dorm_picture}"></td>
                            <td>
                                wifi<input type="checkbox" id="wifi" name="wifi"  onClick="return false;" value="1" ${dorm.opt_wifi==1 ? 'checked' : ''}>
                            </td>
                            <td>
                                parking<input type="checkbox" id="parking" name="parking" onClick="return false;" value="1" ${dorm.opt_parking==1 ? 'checked' : ''}>
                            </td>
                            <td>
                                aircon<input type="checkbox" id="aircon" name="aircon" onClick="return false;" value="1" ${dorm.opt_aircon==1 ? 'checked' : ''}>
                            </td>
                            <td>
                                dryer<input type="checkbox" id="dryer" name="dryer" onClick="return false;" value="1" ${dorm.opt_dryer==1 ? 'checked' : ''}>
                            </td>
                            <td>
                                port<input type="checkbox" id="port" name="port" onClick="return false;" value="1" ${dorm.opt_port==1 ? 'checked' : ''}>
                            </td>
                            <td style="text-align: center;"><button class="bt" name="type" value="dorm" data-i="${i.index}">수정하기</button></td>
                        </tr>
                        <tr id="tr_time${i.index}">
                        	<td colspan="12" id="hidden_checkinout" class="nodisplay">
                        		<div style="text-align:right;">
                        			체크인 : <input type="text" id="in_time" class="times" name="in_time" value="${dorm.in_time}">
                        			체크아웃 : <input type="text" id="out_time" class="times" name="out_time" value="${dorm.out_time}">
                        		</div>
                        	</td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <div id="st3" class="nodisplay">
                <table>
                    <thead>
                        <tr>
                        	<th>문의 번호</th>
                            <th>제목</th>
                            <th>내용</th>
                            <th>아이디</th>
                            <th>게시 날짜</th>
                            <th>답변달기</th>
                            <th>글삭제</th>
                            <th>답변보기</th>
                        </tr>
                    </thead>
                    <tbody>
						<c:forEach var="question" items="${questionList}" begin="${beginPage}" end="${endPage}">
						<c:if test="${question.question_parentno==0}">
							<tr>
	                            <td>${question.question_no}</td>
	                            <td>${question.question_title}</td>
	                            <td><button type="button" class="contents_bt" value="${question.question_contents}">내용 보기</button></td>
	                            <td>${question.member_id }</td>
	                            <td>${question.question_date}</td>
	                            <td><button class="btn_doAnswer" data-id="${question.question_no}">답변하기</button></td>
	                            <td style="text-align: center;"><button class="btn_adminRemove" data-id="${question.question_no}">삭제하기</button></td>
	                            <td class="answer_view" data-no="${question.question_no}">답변 보기</td>
                        	</tr>
						</c:if>
						<c:forEach var="answers" items="${answersList}" varStatus="questionNum">
						<c:if test="${answers.question_parentno==question.question_no }">
							<tr id="answers" data-parents="${answers.question_parentno}" class="nodisplay">
	                            <td colspan="8">
	                            <div>
	                            	<div>
	                            		${answers.question_title}
	                            	</div>
	                            	<hr>
	                            	<div>
		  	                          	${answers.question_contents}
	                            	</div>
	                            	<div style="text-align:right;">
		                            	${answers.member_id }<br>${answers.question_date}
	                            	</div>
	                            	  <button class="reply_doMod" data-id="${answers.question_no}" data-parentid="${answers.question_parentno}">답변수정</button>
				                      <button class="reply_doRemove" data-id="${answers.question_no}">답변삭제</button> 
	                            </div> 
	                            </td>
                        	</tr>
						</c:if>
						</c:forEach>
                    </c:forEach>
                    </tbody>
                </table>
                <div class="center">
	            <div class="paging">
					<c:if test="${nowPageCount != 1}">
						<form>
							<button class="pagebt">이전</button>
							<input type="hidden" name="nowPage" value="${(nowPageCount-1)*5}">
							<input type="hidden" name="tabMove" value="st3">
						</form>
					</c:if>
					<c:if test="${nowPageCount != totalPageCount}">
						<c:forEach var="i" begin="${1+ (5 * (nowPageCount-1))}"
							end="${5 + (5 * (nowPageCount-1))}">
							<div class="">
								<form>
									<c:if test="${nowPage == i}">
										<button class="pagebt nowpage">${i}</button>
									</c:if>
									<c:if test="${nowPage != i}">
										<button class="pagebt">${i}</button>
									</c:if>
									<input type="hidden" name="nowPage" value="${i}">
									<input type="hidden" name="tabMove" value="st3">
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
									<input type="hidden" name="tabMove" value="st3">
								</form>
							</div>
						</c:forEach>
					</c:if>
					<c:if test="${nowPageCount != totalPageCount}">
						<form>
							<button class="pagebt">다음</button>
							<input type="hidden" name="nowPage" value="${(nowPageCount+1)*5-4}">
							<input type="hidden" name="tabMove" value="st3">
						</form>
					</c:if>
	            </div>
            </div>
            </div>
            
            
                   <!--  ===========================  -->
            
            
                <div id="st4" class="nodisplay">
               <div style="text-align:right;"><button data-type="room" class="insert_bt" type="button">객실 추가</button></div>
                <table > 
                    <thead>
                        <tr>
                            <th>숙소번호</th>
                            <th>숙소명</th>
                            <th>객실번호</th>
                            <th>객실명</th>
                            <th>객실정보</th>
                            <th>객실사진</th>
                            <th>당일요금</th>
                            <th>1박 요금</th>
                            <th class="no">객실인원</th>
                            <th>수정</th>
                        </tr>
                    </thead>
                    <tbody>
                       <c:forEach var="room" items="${roomsList}">
                       	<c:if test="${room.room_no eq '0'}">
                       	<tr>
                       	    <td class="no">${room.dorm_no}</td>
                            <td>${room.dorm_name}</td>
                            <td class="no_room" colspan="8"> 객실 없음 </td>
                            </tr>
                       	</c:if>
                       	<c:if test="${room.room_no ne '0'}">
                        <tr>
                            <td class="no">${room.dorm_no}</td>
                            <td>${room.dorm_name}</td>
                            <td class="no">${room.room_no}</td>
                            <input type="hidden" id="room_no" name="room_no" class="no" value="${room.room_no}">
                            <td><input type="text" id="room_name" name="room_name" readonly value="${room.room_name}"></td>
                            <td><button type="button" class="contents_bt" name="content" readonly  value="${room.room_contents}">내용 보기</button></td>
                             <input type="hidden" id="room_contents_val" name="contents" value="${room.room_contents}">
                            <td><input type="text" id="room_picture" name="picture" readonly value="${room.room_picture}"></td>
                            <td><input type="text" id="room_pay_day" name="room_pay_day" class="pay" readonly value="${room.room_pay_day}"></td>
                           <td><input type="text"  id="room_pay_night" name="room_pay_night" class="pay " readonly value="${room.room_pay_night}"></td>
                           <td><input  type="number"  id="room_person" name="room_person"  class="no"  readonly  value="${room.room_person}"></td>
                            <td style="text-align: center;">
                               <button class="bt" name="type" value="room">수정하기</button>
                            </td>
                        </tr>
                        </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
  
            
            <!-- =====================  -->

            
        </div>
    </section>
  </div>

    <script>
    	let tabMove = '${tabMove}';
    	$(function(){
    		if(tabMove != ""){
    			$("section > div > div").addClass("nodisplay");
                $(".tap_list").addClass("tap_state");
                $("#" + tabMove).removeClass("nodisplay");
                $("[data-tap="+tabMove+"]").removeClass("tap_state");
                console.log(tabMove);
    		}
    	});
    	
    	
        let modify_text;
        $(".tap_list").off("click").on("click", function () {
            let tap_name = $(this).attr("data-tap");
            $("section > div > div").addClass("nodisplay");
            $(".tap_list").addClass("tap_state");
            $("#" + tap_name).removeClass("nodisplay");
            $(this).removeClass("tap_state");
        });
        
        $(".bt").off("click").on("click", function () {
      
            modify_text = ($(this).closest("div").find("thead").html());
            modify_text += ($(this).parent().parent().html());
            $("#nextpage").attr("value", modify_text);
            console.log($("#nextpage").html(modify_text));

            var _width = '1400';
            var _height = '250';
            var _left = Math.ceil(( window.screen.width - _width )/2);
            var _top = Math.ceil(( window.screen.height - _height )/2); 
            var _window = window.open("modify_admin.do", "modify", "width="+_width+",height="+_height+", left="+_left+",top="+_top);
        });
        
        $(".contents_bt").off("click").on("click", function () {
        	$("#hidden_bg").addClass("contents_bg_on");
        	$("#hidden_bg").removeClass("nodisplay");
        	$("#hidden_contents").removeClass("nodisplay");
        	let contents = $(this).val();
        	contents = contents.replaceAll(" ", "&nbsp");
        	$("#hidden_contents").html(contents);
        });
        
        $("#hidden_bg").off("click").on("click", function () {
        	$("#hidden_bg").addClass("nodisplay");
        	$("#hidden_bg").removeClass("contents_bg_on");
        	$("#hidden_contents").addClass("nodisplay");
        });
        
        $(".insert_bt").off("click").on("click", function () {
            $("#insert_type").attr("data-type", $(this).attr("data-type"));
           	insert_text = ($(this).closest("div").find("thead").html());
            let temp_text = $(this).parent().parent().html();

            var _width = '500';
            var _height = '1000';
            var _left = Math.ceil(( window.screen.width - _width )/2);
            var _top = Math.ceil(( window.screen.height - _height )/2); 
            var _window = window.open("insert_admin.do", "insert", "width="+_width+",height="+_height+", left="+_left+",top="+_top);
        });
        
        /*-----*/

        $("#btn_logout").off("click").on("click", function(){
            if(confirm("로그아웃하시겠습니까?")==true){
                $("#logout_form").submit();
            }else{
                return;
            }
        })

        $("#btn_withdraw").off("click").on("click", function(){
            if(confirm("탈퇴하시겠습니까?탈퇴한 회원은 복구되지 않습니다.")==true){
                $("#withdraw_form").submit();
            }else{
                return;
            }
        })
        
      var admin_remove = document.querySelectorAll(".btn_adminRemove");
    console.log(admin_remove.length);
    for(let i=0; i<admin_remove.length; i++){
    	admin_remove[i].addEventListener("click", function(event){
        	let admin_remove = event.target.getAttribute("data-id");
        	var isDel = window.confirm("정말 삭제하시겠습니까?");
        	if(isDel){
        		location.href="${contextPath}/trip/removeadminqna.do?admin_remove="+admin_remove;	
        	}
        })
    }
    
    var list_answer = document.querySelectorAll(".btn_doAnswer");
    console.log(list_answer.length);
    for(let i=0; i<list_answer.length; i++){
        list_answer[i].addEventListener("click", function(event){
        	let product_no = event.target.getAttribute("data-id");
            window.open("${contextPath}/trip/adminanswerqna.do?product_no="+product_no,"answer","width=600, height=570");
        })
    }
        function del_button_event() {
        	
        if (confirm("사적모임 페이지를 탈퇴하시겠습니까?탈퇴한 회원은 복구되지 않습니다.") == true) { //확인
            $.ajax({
                url: "${contextPath}/trip/pwCheck.do",
                type: "POST",
                dataType: "json",
                data: {
                    member_pw : prompt("비밀번호를 입력하세요")
                },
                success: function (obj) {
                	   if (obj.result == "true") {
                           alert("탈퇴되었습니다.");
                           location.replace("${contextPath}/trip/main.do}");
                       } else {
                           alert("비밀번호가 틀립니다. 다시 시도해주세요. ");
                           return;
                       }
                }
            });
        } else {
            return;
        }
    }
    
    $(".answer_view").off("click").on("click", function(){
    	console.log("in");
    	let questionNo = $(this).attr("data-no");
    	console.log("부모번호 : "+questionNo);
    	let answers = $("[data-parents="+questionNo+"]");
    	console.log("답글 : "+answers.attr("data-parents"));
    	if(answers.attr("class").includes("nodisplay")){
    		answers.removeClass("nodisplay");
    	}else {
    		answers.addClass("nodisplay");
    	}
    });
    
    var admin_modreply = document.querySelectorAll(".reply_doMod");
    console.log(admin_modreply.length);
    for(let i=0; i<admin_modreply.length; i++){
    	admin_modreply[i].addEventListener("click", function(event){
        	let reply_no = event.target.getAttribute("data-id");
        	let parent_no = event.target.getAttribute("data-parentid");
            window.open("${contextPath}/trip/adminmodreplywrite.do?reply_no="+reply_no+"&parent_no="+parent_no,"mod","width=700, height=400");
        })
    }
    
    var admin_removereply = document.querySelectorAll(".reply_doRemove");
    console.log(admin_removereply.length);
    for(let i=0; i<admin_removereply.length; i++){
    	admin_removereply[i].addEventListener("click", function(event){
        	let removereply_no = event.target.getAttribute("data-id");
        	var isDel = window.confirm("정말 삭제하시겠습니까?");
        	if(isDel){
        		location.href="${contextPath}/trip/adminremovereply.do?removereply_no="+removereply_no;	
        	}
        })
    }
    </script>
</body>

</html>