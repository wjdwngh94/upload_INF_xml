<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- write.jsp : 글 쓰기 페이지 -->
<%@ include file="/top.jsp"%>
<script type="text/javascript">
	function formCheck() {
		//f라는 이름의 form을 검사(전부다)
		if (!f.writer.value) {
			alert("작성자를 입력하세요");
			f.writer.focus();
			return false;//거절
		} else if (!f.title.value) {
			alert("제목을 입력하세요");
			f.title.focus();
			return false;//거절
		} else if (!f.content.value) {
			alert("내용을 입력하세요");
			f.content.focus();
			return false;//거절
		} else if (!f.pw.value) {
			alert("비밀번호를 입력하세요");
			f.pw.focus();
			return false;//거절
		}

		//return true;//전송을 허락한다(생략 가능)
	}
</script>
<div align="center">
	<h1>글 쓰 기</h1>
	<form name="f" action="writePro.jsp" method="post"
		onsubmit="return formCheck();" enctype="multipart/form-data">
		<!-- onsubmit : submit을 실행하면 발생되는 이벤트
			return formCheck() 라고 적으면 
			formCheck() 의 반환값을 보고 결정하겠다는 뜻 -->
		<table class="outline" width="650">
			<tr>
				<th class="m2" width="100">작성자</th>
				<td class="m3"><input type="text" name="writer" maxlength="10"
					size="10" class="box"></td>
			</tr>
			<tr>
				<th class="m2" width="100">제목</th>
				<td class="m3"><input type="text" name="title" maxlength="33"
					size="50" class="box"></td>
			</tr>
			<tr>
				<th class="m2" width="100">내용</th>
				<td class="m3"><textarea name="content" class="box" rows="10"
						cols="55"></textarea></td>
			</tr>
			<tr>
				<!-- 파일 입력 줄 추가 -->
				<th class="m2">파일 선택</th>
				<td class="m3"><input type="file" name="filename" class="box">
				</td>
				</th>
			</tr>
			<tr>
				<th class="m2" width="100">비밀번호</th>
				<td class="m3"><input type="password" name="pw" maxlength="15"
					size="15" class="box"></td>
			</tr>
			<tr>
				<th class="m2" colspan="2"><input type="submit" value="등록">
					<input type="button" value="목록" onclick="location.href='list.jsp';">
				</th>
			</tr>
		</table>
	</form>
</div>
<%@ include file="/bottom.jsp"%>



















