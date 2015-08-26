<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<jsp:useBean id="pool" class="my.db.ConnectionPoolBean"
	scope="application" />
<!-- mbdao라는 고객을 생성 -->
<jsp:useBean id="bddao" class="my.board.BoardDAO" />
<!-- pool의 정보를 mbdao에게 주입 -->
<jsp:setProperty name="bddao" property="pool" value="<%=pool%>" />

<!-- memberInput.jsp의 내용을 붙여넣고 수정 -->
<html>
<head>
<title>새로운 글쓰기</title>
<link rel="stylesheet" type="text/css" href="../style.css">
<script type="text/javascript">
	function checkForm() {
		//폼 검사(name)
		if (!f.pw.value) {
			alert("비밀번호를 입력하세요");
			f.pw.focus();
			return;
		} else if (f.pw.value.length < 3) {
			alert("비밀번호가 좀 짧네요?");
			f.pw.select();//해당텍스트 선택
			return;
		}

		//폼 전송(document 문서 객체 활용)
		//f라는 form을 submit 버튼을 누른 것과 같이 처리하라
		document.f.submit();
	}
	function cancel() {
		var check = window.confirm("정말 창을 닫으시겠습니까?");
		//alert(check);
		if (check) {//true
			window.close();
		}
	}
</script>
</head>
<body>
	<div align="center">
		<form name="f" action="writePro.jsp" method="post">
			<!-- 필요한 데이터는 hidden으로 첨부한다. -->
			<h2>글쓰기</h2>
			<hr color="red" width="300">
			<table width="500" class="outline">
				<tr>
					<th class="m2">등록자</th>
					<td class="m3"><input type="text" name="writer" class="box"
						maxlength="15" size="10"></td>
				</tr>
				<tr>
					<th class="m2">제목</th>
					<td class="m3"><input type="text" name="title" class="box"
						maxlength="15" size="10"></td>
				</tr>
				<tr>
					<th class="m2" rowspan="10">내용</th>
					<td class="m3" rowspan="10"><textarea name="content" class="box"></textarea></td>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
					<th class="m2">비밀번호</th>
					<td class="m3"><input type="password" name="pw" class="box"
						maxlength="20" size="20"></td>
				</tr>
				<tr>
					<th class="m2" colspan="2"><input type="button" value="등록"
						onclick="checkForm();"> <input type="button" value="취소"
						onclick="cancel();"></th>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>



















