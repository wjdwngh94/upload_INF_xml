<%@page import="com.sun.corba.se.pept.transport.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%@page import="my.miniboard.*"%>
<%
	//기능 분리
	//데이터 수신
	//DB연결 및 처리 -> java file
	//사용자 알림
%>
<!-- insert.jsp : DB에 정보를 집어넣는 페이지 -->
<!-- Oracle의 TEST 테이블에 정보를 집어넣는 것이 목표 -->
<%
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("name");
	String text = request.getParameter("text");
	//3. 유효성 검사
	if (name == null || name.trim().equals("") || text == null) {
		response.sendRedirect("home.jsp");//쫓아내겠다.
		return;
	}

	//DB연결 및 처리
	//택배기사 (DAO) 불러서 시키고 물건받기
	//my.miniboard.MiniDAO dao = new my.miniboard.MiniDAO();
	MiniDAO dao = new MiniDAO();
	int result = dao.inset(name, text);
	
	if (result > 0) {
%>
<script type="text/javascript">
	alert("게시글 입력 성공");
	location.href = "list.jsp";
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("게시글 입력 실패...");
	location.href = "home.jsp";
</script>
<%
	}
%>

