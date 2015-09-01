<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="my.miniboard.*" %>
<!-- delete.jsp : 이름을 받아 일치 삭제 -->
<%
	//작성자(writer) 받기
	request.setCharacterEncoding("euc-kr");
	String writer = request.getParameter("writer");
	if(writer==null||writer.trim().equals("")){
		response.sendRedirect("home.jsp");
		return;
	}
	
	//DAO 시켜서 데이터 삭제 요청
	MiniDAO dao = new MiniDAO();
	boolean result = dao.delete(writer); 
	
	//사용자에게 알림
	String msg = "", url = "";
	if(result){
		msg = "삭제 성공!";
		url = "list.jsp";
	}else{
		msg = "삭제 실패...";
		url = "home.jsp";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>















