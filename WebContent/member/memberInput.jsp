<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- 숙제 
	1.모든 필수입력항목을 검사 후 문제 발생시 전송 중지
	2.입력 항목의 길이를 제한
	3.입력창 크기도 길이에 맞게 변경
	4.생년월일 같은 경우 숫자만 입력 가능하도록 변경
	5.id는 한글이 입력되지 않도록 변경한다 -->
<html>
<head>
<title>회원 가입</title>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/style.css">
<script type="text/javascript">
	function checkForm() {
		//Form 검사(name) - form이 여러개일때는 서로다른이름을 부여해서 검사한다.
		//정보 검사 (DOM구조)
		if (f.name.value == '') {
			alert("이름을 입력하지 않으셨네요");
			f.name.focus(); //커서를 name box안으로 이동한다.
			return;
		}
		//Form 전송(document 문서 내장 객체)
		//f라는 form을 submiot버튼을 누를 때 검사를 한다.
		document.f.submit();
	}
	function cancel() {
		var check = window.confirm("정말로 창을 닫으시겠습니까?"); //true(확인) false(취소)
		if (check) {
			//true
			window.close();
		}
	}
</script>
</head>
<body>
	<div align="center">
		<form name="f" action="memberInput_ok.jsp" method="post">
			<!-- get으로하면 입력값이 주소에 날라감으로 post로 한다. -->

			<hr color="red" width="300">
			<!-- 선 긋기 -->
			<h2>회원 가입 정보 입력</h2>
			<hr color="red" width="300">
			<!-- 선 긋기 -->

			<table width="500" class="outline">
				<tr>
					<th class="m2">이름</th>
					<td class="m3"><input type="text" name="name" class="box">
					</td>
				</tr>
				<tr>
					<th class="m2">아이디</th>
					<td class="m3"><input type="text" name="id" class="box">
					</td>
				</tr>
				<tr>
					<th class="m2">비밀 번호</th>
					<td class="m3"><input type="password" name="pw" class="box">
						<!-- type이 password로 지정되면 입력시 보이지 않는다. --></td>
				</tr>
				<tr>
					<th class="m2">생년 월일</th>
					<td class="m3"><input type="text" name="birth" class="box">
						형식 : 20010101</td>
				<tr>
					<th class="m2">성별</th>
					<td class="m3"><select name="gender" class="box">
							<option value="남자">남자</option>
							<option value="여자">여자</option>
					</select></td>
				</tr>
				<tr>
					<th class="m2" rowspan="3">우편번호</th>
					<td class="m3">우편번호 입력창 [버튼]</td>
				</tr>
				<tr>
					<td class="m3">기본주소 입력창</td>
				</tr>
				<tr>
					<td class="m3">상세주소 입력창</td>
				</tr>
				<tr>
					<th class="m2" colspan="2"><input type="button" value="가입"
						onclick="checkForm();"> <!-- on~ : ~했을 때 --> <input
						type="button" value="취소" onclick="cancel();"></th>

				</tr>
			</table>
		</form>
	</div>
</body>
</html>