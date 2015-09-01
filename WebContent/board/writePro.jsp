<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.*"%>
<%@page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- writePro.jsp : 전송된 데이터 등록 -->

<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	//mr을 이용해서 데이터를 수신하겠다.
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
		System.out.println("파일 업로드 오류");
		return;
	}
%>

<jsp:useBean id="bdao" class="my.board.BoardDAO" />

<%
	boolean result = bdao.insertBoard(mr);
	if (result) {
		//방금 들어간 글의 번호를 가져와야 한다.
		int no = bdao.findNumber();
%>
<script type="text/javascript">
		alert("글 등록 성공!");
		location.href="content.jsp?no=<%=no%>";
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("등록 과정의 오류 발생");
	history.back();
</script>
<%
	}
%>









