<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- writePro.jsp : ���۵� ������ ��� -->

<% request.setCharacterEncoding("euc-kr"); %>
<!-- jsp �׼��±׷� ������ ���� -->
<jsp:useBean id="bdto" class="my.board.BoardDTO"/>
<jsp:setProperty name="bdto" property="*"/><!-- 4�� -->

<jsp:useBean id="bdao" class="my.board.BoardDAO"/>

<%
	boolean result = bdao.insertBoard(bdto); 
	if(result){
		//��� �� ���� ��ȣ�� �����;� �Ѵ�.
		int no = bdao.findNumber(); 
	%>
	<script type="text/javascript">
		alert("�� ��� ����!");
		location.href="content.jsp?no=<%=no%>";
	</script>
<%} else{ %>
	<script type="text/javascript">
		alert("��� ������ ���� �߻�");
		history.back();
	</script>
<%} %>









