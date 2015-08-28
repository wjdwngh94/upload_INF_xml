<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- editPro.jsp : 수정 처리 페이지 -->

<%	request.setCharacterEncoding("euc-kr"); %>

<!-- BoardDTO 객체 생성하여 데이터 수신 -->
<jsp:useBean id="bdto" class="my.board.BoardDTO"/>
<jsp:setProperty name="bdto" property="*"/>

<jsp:useBean id="bdao" class="my.board.BoardDAO"/>
<%
	//System.out.println(bdto.getNo());
	//System.out.println(bdto.getWriter());
	//System.out.println(bdto.getTitle());
	//System.out.println(bdto.getContent());
	
	boolean result = bdao.editBoard(bdto); 
	if(result){%>
	<script type="text/javascript">
		alert("게시글 수정 완료!");
		location.href="content.jsp?no=<%=bdto.getNo()%>";
	</script>
<%}else{ %>
	<script type="text/javascript">
		alert("게시글 수정 실패...");
		history.back();
	</script>
<%} %>


















