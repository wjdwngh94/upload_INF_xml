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
	//원할 때 마다 원하는 함수를 만들어 준다
	function onlyA() {
		var key = event.keyCode;
		if ((key >= 65 && key <= 90) || (key >= 97 && key <= 122)
				|| (key >= 48 && key <= 57)) { //ASCII CODE를이용한다.
			event.returnValue = true;
			//통과
		} else {
			//event.returnValue = false; //이방법으로 걸러질 수 있는 것은 explorer10까지이다.
			event.preventDefault();
			//거절
		}
	}
	function onlyNum() {
		//alert("onluNum");
		//event : javascript의 이벤트 정보를 가지고 있는 객체
		//alert(event.keyCode);
		var key = event.keyCode;
		if (key >= 48 && key <= 57) { //ASCII CODE를이용한다.
			event.returnValue = true;
			//통과
		} else {
			//event.returnValue = false; //이방법으로 걸러질 수 있는 것은 explorer10까지이다.
			event.preventDefault();
			//거절
		}
	}
	function checkForm() {
		//Form 검사(name) - form이 여러개일때는 서로다른이름을 부여해서 검사한다.
		//정보 검사 (DOM구조)
		if (f.name.value == '') {
			alert("이름을 입력하지 않으셨네요");
			f.name.focus(); //커서를 name box안으로 이동한다.
			return;
		} else if (!f.id.value) {
			alert("아이디를 입력하지 않으셨네요");
			f.id.focus();
			return;
		} else if (!f.pw.value) {
			alert("패스워드를 입력하지 않으셨네요");
			f.pw.focus();
			return;
		} else if (!f.birth.value) {
			alert("생년월일을 입력하지 않으셨네요");
			f.birth.focus();
			return;
		} else if (f.id.value.length < 3) {
			alert("아이디가 좀 짧네요?");
			f.id.focut();
		} else if (f.pw.value.length < 3) {
			alert("패스워드가 좀 짧네요?");
			//f.pw.focus(); 
			f.pw.select();//해당 텍스트를 선택해준다(블럭처리)
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

<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = ''; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수

						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							fullAddr = data.roadAddress;

						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							fullAddr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('sample6_address').value = fullAddr;

						// 커서를 상세주소 필드로 이동한다.
						document.getElementById('sample6_address2').focus();
					}
				}).open();
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
					<td class="m3"><input type="text" name="name" class="box"
						maxlength="15" size="17"> <!-- maxlength를 사용하여 최대입력값을 제한한다. -->
					</td>
				</tr>
				<tr>
					<th class="m2">아이디</th>
					<td class="m3"><input type="text" name="id" class="box"
						maxlength="20" size="23" onkeypress="onlyA();"
						style="IME-MOD: disabled;" placeholder="최대 20자"></td>
				</tr>
				<tr>
					<th class="m2">비밀 번호</th>
					<td class="m3"><input type="password" name="pw" class="box"
						maxlength="20" size="23" style="IME-MOD: disabled;"
						onkeypress="onlyA();" placeholder="최대 20자"> <!-- type이 password로 지정되면 입력시 보이지 않는다. -->
						<!-- placeholder를 사용하여 입력전의 박스에 해당 메세지를 띄운다. --></td>
				</tr>
				<tr>
					<th class="m2">생년 월일</th>
					<td class="m3"><input type="text" name="birth" class="box"
						maxlength="8" size="11" onkeypress="onlyNum();"
						style="ime-mod: disabled;"> <!-- size 로 입력 박스의 크기를 조절한다. -->
						<!-- 
						onkeydown:입력값을 모두 숫자로 변경 
						onkeyup:숫자가 올라갔을 때 
						onkeypress 
						--> <!-- 인터넷 exproler용 한글입력 금지 style="ime-mod : disabled;" -->
						형식:20010101</td>
				<tr>
					<th class="m2">성별</th>
					<td class="m3"><select name="gender" class="box">
							<option value="남자">남자</option>
							<option value="여자">여자</option>
					</select></td>

				</tr>
				<tr>
					<th class="m2" rowspan="3">우편번호</th>
					<td class="m3"><input type="text" id="sample6_postcode"
						placeholder="우편번호" maxlength="6" size="8" class="box" readonly
						onclick="sample6_execDaumPostcode()"> <!-- 읽기전용 readonly를 사용하여 수정을 방지한다. -->
						<!-- disabled도 잠금 가능을 수행할 수 있지만 전송또한 되지 않는다. --> <input
						type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
				</tr>
				<tr>
					<td class="m3"><input type="text" id="sample6_address"
						placeholder="주소" name="addr1" class="box" maxlength="50" size="40"
						readonly></td>
				</tr>
				<tr>
					<td class="m3"><input type="text" id="sample6_address2"
						placeholder="상세주소" name="addr2" maxlength="50" size="40"></td>
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