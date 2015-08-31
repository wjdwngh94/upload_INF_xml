<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- replyPro.jsp : 답글 처리 페이지 -->

<!-- 데이터 받고 -->
<%	request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="bdto" class="my.board.BoardDTO"/>
<jsp:setProperty name="bdto" property="*"/><!-- 8개 -->

<!-- 집어넣고 -->
<jsp:useBean id="bdao" class="my.board.BoardDAO"/>
<%
	boolean result = bdao.insertReply(bdto);
%>
<!-- 사용자 알림 -->
<% if(result){ 
	//방금 들어간 글의 번호를 가져와야 한다.
	int no = bdao.findNumber(); %>
	<script type="text/javascript">
		alert("글 등록 성공!");
		location.href="content.jsp?no=<%=no%>";
	</script>
<%} else{ %>
	<script type="text/javascript">
		alert("등록 과정의 오류 발생");
		history.back();
	</script>
<%} %>









