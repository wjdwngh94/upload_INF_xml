<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- edit.jsp -->
<jsp:useBean id="bdao" class="my.board.BoardDAO"/>
<%
	//전송방식 추출
	String method = request.getMethod();

	//파라미터 추출
	String tmp = request.getParameter("no");
	int no = 0;
	String check = request.getParameter("check");
	try{
		no = Integer.parseInt(tmp);				//숫자가 아니면
		if(no<=0) throw new Exception();	//0 이하면 
		if(!method.equals("POST"))				//POST방식이 아니면
					throw new Exception();
		if(check==null||!check.equals("ok"))	//인증값이 ok가 아니면
					throw new Exception();
	}catch(Exception e){
		response.sendRedirect("list.jsp");
		return;
	}
	
	//no를 가지고 게시글 1개의 정보를 모두 불러온다.
	my.board.BoardDTO bdto = bdao.getBoard(no);
%>
<%@ include file="/top.jsp"%>
<script type="text/javascript">
	function formCheck(){
		//f라는 이름의 form을 검사(전부다)
		if(!f.title.value){
			alert("제목을 입력하세요");
			f.title.focus();
			return false;//거절
		}else if(!f.content.value){
			alert("내용을 입력하세요");
			f.content.focus();
			return false;//거절
		}
		
		//return true;//전송을 허락한다(생략 가능)
	}
</script>
<div align="center">
	<h1>글 수 정</h1>
	<form name="f" action="editPro.jsp" method="post"
				onsubmit="return formCheck();">
	<!-- onsubmit : submit을 실행하면 발생되는 이벤트
			return formCheck() 라고 적으면 
			formCheck() 의 반환값을 보고 결정하겠다는 뜻 -->
	<input type="hidden" name="no" value="<%=no%>">
	<table class="outline" width="650">
	<tr>
		<th class="m2" width="100">작성자</th>
		<td class="m3">
		<input type="text" name="writer" maxlength="10"
		size="10" class="box" readonly
		value="<%=bdto.getWriter()%>">
		</td>
	</tr>
	<tr>
		<th class="m2" width="100">제목</th>
		<td class="m3">
		<input type="text" name="title" maxlength="33"
		size="50" class="box" value="<%=bdto.getTitle()%>">
		</td>
	</tr>
	<tr>
		<th class="m2" width="100">내용</th>
		<td class="m3">
		<textarea name="content" class="box" rows="10"
		cols="55"><%=bdto.getContent()%></textarea>
		</td>
	</tr>
	<tr>
		<th class="m2" colspan="2">
			<input type="submit" value="수정">
			<input type="button" value="취소"
		onclick="location.href='content.jsp?no=<%=no%>'">
			<input type="button" value="목록"
					onclick="location.href='list.jsp';">
		</th>
	</tr>
	</table>
	</form>
</div>
<%@ include file="/bottom.jsp"%>

















