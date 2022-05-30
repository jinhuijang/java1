<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="contextPath" value="${ pageContext.request.contextPath}" />
<c:set var="URL" value="${pageContext.request.requestURL}" />

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사적모임 | My page</title>
<link rel="stylesheet"
	href="${contextPath}/resources/css/header_footer.css">
<link rel="stylesheet"
	href="${contextPath}/resources/css/mypage-style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
	.underline{
		text-decoration: underline;
		font-weight: 600;
	}
</style>
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		//닉네임
		$('.input1').click(function() {
			$('.re_input').show();
			$('.re_input1').show();
			$('.re_input1').show();
		});
		$('.re_input1').click(function() {
			$('.re_input').hide();
			$('.re_input1').hide();
			$('.re_input1').hide();
		});
		//전화번호
		$('.input2').click(function() {
			$('.re_input2').show();
			$('.re_input2_1').show();
			$('.re_input2_1').show();
		});
		$('.re_input2_1').click(function() {
			$('.re_input2').hide();
			$('.re_input2_1').hide();
			$('.re_input2_1').hide();
		});

	});
</script>


<body>
	<%@ include file="header.jsp"%>
	<div id="wrap_mypage">	
	<%@include file = "mypage_nav.jsp" %>
		<section>
			<div class="mypage_main">
				<div class="mypage_header">
					<div>
						<h2>마이페이지</h2>
						<!--로그인한 회원 정보에 맞게 출력되야함-->
						<p>${member.member_id}</p>
					</div>
				</div>
				<hr>

				<%-- 백단에서 조건걸어서 수정하기 --%>
				<form method="post" id="modify_form" class="mypage_form1"
					action="${contextPath}/trip/modifyMember.do">
					<input type="hidden" name="member_id" value="${member.member_id}">
					<br>
					<div>
						<span>닉네임
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${member.member_names}</span> <input
							id="tab" class="input1" type="button" value="수정"><br>
						<input id="input_name" name="member_name" style="display: none;"
							class="re_input" type="text"> <input
							style="display: none;" onclick="modify_button_event()"
							class="re_input1 modifyEvent" id="submit_name" value="수정하기">
						<input style="display: none;" class="re_input1" type="button"
							value="취소">
					</div>
					<br>
					<br>
					<br>
					<div>
						<span> 전화번호 &nbsp;&nbsp;${member.member_tel}</span> <input
							id="tab" class="input2" type="button" value="수정"><br>
						<input id="input_tel" name="member_tel" style="display: none;"
							class="re_input2" type="tel"> <input
							style="display: none;" onclick="modify_button_event()"
							class="re_input2_1 modifyEvent btn_tel" id="submit_tel"
							value="수정하기"> <input style="display: none;"
							class="re_input2_1" type="button" value="취소">
					</div>
				</form>
				<br>
				<hr>
				
				<div id="modify_pw">비밀번호 변경하기</div>

				<div id="wrap_pw" class="hidden">
					<h3>비밀번호 수정</h3>
					<div id="input_pw">
						<div>
							<label for="member_pw"> 현재 비밀번호 :</label>
							<input id="member_pw" type="password">
						</div>
						<div>
							<label for="new_pw"> 새 비밀번호 :</label> 
							<input id="new_pw" 	type="password">
						</div>
						<div>
							<label for="check_pw"> 새 비밀번호 확인 :</label>
							 <input id="check_pw"  type="password">
						</div>
						<button id="submit_pw">수정</button>
						<button id="reset_pw">취소</button>
					</div>
				</div>

				<div class="memberOut">
					<br>
					<p>사적모임 사이트를 더이상 이용하고 싶지 않으신가요?</p>
					<div class="wrap_form2">
						<form method="get" id="logout_form" class="mypage_form2"
							action="${contextPath}/trip/logoutCheck.do">
							<input type="button" onclick="out_button_event()" value="로그아웃">
						</form>
						<form method="post" id="removeMember_form" class="mypage_form2"
							action="${contextPath}/trip/removeMember.do">
							<input type="hidden" name="member_id" value="${member.member_id}">
							<input type="button" onclick="del_button_event()" value="회원탈퇴">
						</form>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@ include file="footer.jsp"%>
</body>
<script>
	let input_name = document.querySelector("#input_name");
	let input_tel = document.querySelector("#input_tel");
	let pattern = /\s/g;

	let btn_modify = document.querySelectorAll(".modifyEvent");
	for (let i = 0; i < btn_modify.length; i++) {
		btn_modify[i].addEventListener("click", function(event) {
			let evtID = event.target.id;
			if (confirm("수정 하시겠습니까?") == true) { //확인
				if (evtID == "submit_name") {
					if (input_name.value != ""
							&& !(input_name.value.match(pattern))
							&& input_name.value.length >= 2) {
						input_tel.value = "";
						console.log("tel val :" + input_tel.value);
						console.log("name_val :" + input_name.value);
						document.getElementById('modify_form').submit();
					} else {
						alert("수정할 닉네임을 다시 입력해주세요 (공백없이 2자리 이상입력)");
						return;
					}
				}
				if (evtID == "submit_tel") {
					if (input_tel.value != ""
							&& !(input_tel.value.match(pattern))) {
						input_name.value = "";
						document.getElementById('modify_form').submit();
					} else {
						alert("수정할 전화번호를 다시 입력해주세요 (공백없이 입력)");
						return;
					}
				}
			} else { //취소
				return;
			}
		})
	}

	function out_button_event() {
		if (confirm("로그아웃 하시겠습니까?") == true) { //확인
			document.getElementById('logout_form').submit();
		} else { //취소
			return;
		}
	}

	// 회원탈퇴 아작스 
	function del_button_event() {
		if (confirm("사적모임 페이지를 탈퇴하시겠습니까?탈퇴한 회원은 복구되지 않습니다.") == true) { //확인
			$.ajax({
				url : "${contextPath}/trip/pwCheck.do",
				type : "POST",
				dataType : "json",
				data : {
					member_pw : prompt("비밀번호를 입력하세요")
				},
				success : function(obj) {
					console.log("result : " + obj.result);
					if (obj.result == "true") {
						$.ajax({
							url : "${contextPath}/trip/removeMember.do",
							type : "POST",
							dataType : "json",
							data : {
								member_id : "${member.member_id}"
							},
							complete : function() {
								alert("탈퇴 되었습니다. ");
								window.location.reload();
							}
						});
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

	// 비밀번호 수정관련 

	$("#modify_pw").off("click").on("click", function() {
		console.log("클릭");
		$("#wrap_pw").removeClass("hidden");
		$("body").not("#wrap_pw *").addClass("background_dark");
		$("input").not("#wrap_pw *").addClass("background_dark");
	})

	$("#reset_pw").off("click").on("click", function() {
		$("#wrap_pw").addClass("hidden");
		$("body").not("#wrap_pw *").removeClass("background_dark");
		$("input").not("#wrap_pw *").removeClass("background_dark");
	})

	
	
	let member_pw = $("#member_pw").val;
	let new_pw = $("#new_pw").val;
	let check_pw = $("#check_pw").val;

	$("#submit_pw").off("click").on("click", function() {
		//alert("a");
		let member_pw = $("#member_pw").val();
		let new_pw = $("#new_pw").val();
		let check_pw = $("#check_pw").val();

		if (new_pw == check_pw) {
			console.log("new: " + new_pw);
			$.ajax({
				url : "${contextPath}/trip/pwCheck.do",
				type : "POST",
				dataType : "json",
				data : {
					member_pw : member_pw
				},
				success : function(obj) {
					console.log("result : " + obj.result);
					if (obj.result == "true") {
						$.ajax({
							url : "${contextPath}/trip/modifyPw.do",
							type : "POST",
							dataType : "json",
							data : {
								member_id : "${member.member_id}",
								member_pw : new_pw
							},
							complete : function() {
								alert("수정되었습니다. ");
								window.location.reload();
							}
						});
					} else {
						alert("비밀번호가 틀립니다. 다시 시도해주세요. ");
						return;
					}
				}
			})
		} else {
			alert("새 비밀번호가 서로 일치하지 않습니다.");
			return;
		}
	})
</script>

</html>