<%@page import="com.sun.corba.se.pept.transport.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%@page import="my.miniboard.*"%>
<!-- delete.jsp : 이름을 받아 일치 삭제  -->
<%
	//작성자(name)를 받기
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("name");
	if (name == null || name.trim().equals("")) {
		response.sendRedirect("home.jsp");//쫓아내겠다.
		return;
	}
	//DAO시켜서 데이터 삭제 요청한다.
	MiniDAO dao = new MiniDAO();

	//난 처리과정이아니라 결과만 알고 싶다
	//boolean char int모두 가능하다.
	boolean result = dao.delete(name);
	//dao.delete : 슈퍼가서 사와
	//dao.delete(name) : 슈퍼가서 a를 사와

	String msg = "", url = "";
	if (result) {

		msg = "삭제 성공";
		url = "list.jsp";

	} else {

		msg = "삭제 실패";
		url = "home.jsp";

	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>
