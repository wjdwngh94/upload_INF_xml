<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.*"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- writePro.jsp : ���۵� ������ ��� -->

<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	//mr�� �̿��ؼ� �����͸� �����ϰڴ�.
	String upPath = config.getServletContext().getRealPath(
			"/board/file");

	MultipartRequest mr = null;
	DefaultFileRenamePolicy dp = null;

	try {
		dp = new DefaultFileRenamePolicy();
		mr = new MultipartRequest(request, upPath, 10 * 1024 * 1024,
				"euc-kr", dp);
	} catch (IOException e) {
		response.sendRedirect("write.jsp");
		System.out.println("���� ���ε� ����");
		return;
	}
%>

<jsp:useBean id="bdao" class="my.board.BoardDAO" />

<%
	boolean result = bdao.insertBoard(mr);
	if (result) {
		//��� �� ���� ��ȣ�� �����;� �Ѵ�.
		int no = bdao.findNumber();
%>
<script type="text/javascript">
		alert("�� ��� ����!");
		location.href="content.jsp?no=<%=no%>";
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("��� ������ ���� �߻�");
	history.back();
</script>
<%
	}
%>









