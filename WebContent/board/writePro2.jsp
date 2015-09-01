<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- writePro.jsp : 전송된 데이터 등록 -->

<% request.setCharacterEncoding("euc-kr"); %>
<!-- jsp 액션태그로 데이터 수신 -->
<jsp:useBean id="bdto" class="my.board.BoardDTO"/>
<jsp:setProperty name="bdto" property="*"/><!-- 4개 -->

<jsp:useBean id="bdao" class="my.board.BoardDAO"/>

<%
	boolean result = bdao.insertBoard(bdto); 
	if(result){
		//방금 들어간 글의 번호를 가져와야 한다.
		int no = bdao.findNumber(); 
	%>
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









