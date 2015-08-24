<%@page import="com.sun.corba.se.pept.transport.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%@page import="my.member.*"%>

<jsp:useBean id="mbdao" class="my.member.MemberDAO" />
<!-- delete.jsp : 이름을 받아 일치 삭제  -->
<%
	//DAO시켜서 데이터 삭제 요청한다.
	String tmp = request.getParameter("no");
	int no = 0;
	try {
		no = Integer.parseInt(tmp); //NumberFormatException
		//숫자가 아닌것들을 걸러낸다.
		if (no <= 0)
			throw new Exception(); // 강제 예외 처리
		//양수가 아닌 정수들을 걸러낸다
	} catch (Exception e) {
		//오류 발생시 쫒아 낸다 - 유효성 검사
		response.sendRedirect("memberList.jsp");

		return;
	}
	boolean result = mbdao.deleteMember(no);
	String msg = "", url = "";
	if (result) {

		msg = "삭제 성공";
		url = "memberList.jsp";

	} else {

		msg = "삭제 실패";
		url = "memberList.jsp";

	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href ="<%=url%>
	";
</script>
