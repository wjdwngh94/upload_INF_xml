<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- memberEdit.jsp : no를 가지고 회원 정보를 불러온다. -->
<!-- ConnectionPoolBean을 application 영역에 생성 -->
<jsp:useBean id="pool" class="my.db.ConnectionPoolBean" 
													scope="application"/>
<!-- mbdao라는 고객을 생성 -->													
<jsp:useBean id="mbdao" class="my.member.MemberDAO"/>
<!-- pool의 정보를 mbdao에게 주입 -->
<jsp:setProperty name="mbdao" property="pool"
												value="<%=pool%>"/>
<%
	String tmp = request.getParameter("no");
	int no = 0;
	try{
		no = Integer.parseInt(tmp);//NumberFormatException
		if(no<=0) throw new Exception();//강제 예외 처리
	}catch(Exception e){
		//오류 발생시(tmp가 숫자로 바뀔 수 없는 경우)
		//창 닫는 코드 등을 추가할 수 있다.
		return;
	}
	
	//번호로 회원 1명의 모든 정보 불러오기
	my.member.MemberDTO info = mbdao.getMember(no); 
	if(info==null){
		//창 닫기 등의 처리 후
		return;
	}
%>
<!-- memberInput.jsp의 내용을 붙여넣고 수정 -->
<html>
<head>
	<title>회원 정보 수정</title>  
	<link rel="stylesheet" type="text/css" href="../style.css">
	<script type="text/javascript">
		function checkForm(){
			//폼 검사(name)
			if(!f.pw.value){
				alert("비밀번호를 입력하세요");
				f.pw.focus();
				return;
			}else if(f.pw.value.length < 3){
				alert("비밀번호가 좀 짧네요?");
				f.pw.select();//해당텍스트 선택
				return;
			}
			
			//폼 전송(document 문서 객체 활용)
			//f라는 form을 submit 버튼을 누른 것과 같이 처리하라
			document.f.submit();
		}
		function cancel(){
			var check = window.confirm("정말 창을 닫으시겠습니까?");
			//alert(check);
			if(check){//true
				window.close();
			}
		}
		function onlyNum(){
			//event : javascript의 이벤트 정보를 가지고 있는 객체
			//alert(event.keyCode);
			var key = event.keyCode;
			if(key>=48 && key <= 57){
				event.returnValue = true;//통과
			}else{
				//event.returnValue = false;//거절
				event.preventDefault();
			}
		}
	</script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
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
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
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
	<form name="f" action="memberEdit_ok.jsp" method="post">
	<!-- 필요한 데이터는 hidden으로 첨부한다. -->
	<input type="hidden" name="no" value="<%=no%>">
	<hr color="red" width="300"> 
	<h2>회원 정보 수정</h2> 
	<hr color="red" width="300">
	<table width="500" class="outline">
	<tr>
		<th class="m2">이름</th>
		<td class="m3">
			<input type="text" name="name" class="box"
			maxlength="5" size="10" readonly
			value="<%=info.getName()%>"> 
		</td>
	</tr>
	<tr>
		<th class="m2">아이디</th>
		<td class="m3">
			<input type="text" name="id" class="box"
			maxlength="20" size="20" readonly
			style="ime-mode : disabled;"
			placeholder="최대 20자"
			value="<%=info.getId()%>">
		</td>
	</tr>
	<tr>
		<th class="m2">비밀번호</th>
		<td class="m3">
			<input type="password" name="pw" class="box"
			maxlength="20" size="20" placeholder="최대 20자">
		</td>
	</tr>
	<tr>
		<th class="m2">생년월일</th>
		<td class="m3">
			<input type="text" name="birth" class="box"
			maxlength="8" size="8" onkeypress="onlyNum();"
			style="ime-mode : disabled;" readonly
			value="<%=info.getBirth()%>"><!-- IE용 한글금지 속성 -->
			형식 : 20010101	
		</td>
	</tr>
	<tr>
		<th class="m2">성별</th>
		<td class="m3">
			<%=info.getGender()%>
		</td>
	</tr>
	<tr>
		<th class="m2" rowspan="3">주소</th>
		<td class="m3">
			<input type="text" id="sample6_postcode"
			name = "post" placeholder="우편번호"
			maxlength="6" size="6" class="box" readonly
			onclick="sample6_execDaumPostcode()"
			value="<%=info.getPost()%>">
			<!-- disabled도 잠금 기능 수행 : 전송 안됨 -->
			<input type="button" value="우편번호 찾기"
			onclick="sample6_execDaumPostcode()">
		</td>
	</tr>
	<tr>
		<td class="m3"> 
			<input type="text" id="sample6_address" 
			placeholder="주소" name="addr1" class="box"
			maxlength="50" size="40" readonly
			value="<%=info.getAddr1()%>">
		</td>
	</tr>
	<tr>
		<td class="m3">
			<input type="text" id="sample6_address2" 
			placeholder="상세주소" name="addr2" class="box"
			maxlength="50" size="40"
			value="<%=info.getAddr2()%>">
		</td>
	</tr>
	<tr>
		<th class="m2" colspan="2">
		<input type="button" value="수정"
		onclick="checkForm();">
		<input type="button" value="취소"
		onclick="cancel();">
		</th>
	</tr>
	</table>	
	</form>	 
</div> 
</body>
</html>



















