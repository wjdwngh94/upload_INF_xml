<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="my.miniboard.*" %>
<!-- delete.jsp : �̸��� �޾� ��ġ ���� -->
<%
	//�ۼ���(writer) �ޱ�
	request.setCharacterEncoding("euc-kr");
	String writer = request.getParameter("writer");
	if(writer==null||writer.trim().equals("")){
		response.sendRedirect("home.jsp");
		return;
	}
	
	//DAO ���Ѽ� ������ ���� ��û
	MiniDAO dao = new MiniDAO();
	boolean result = dao.delete(writer); 
	
	//����ڿ��� �˸�
	String msg = "", url = "";
	if(result){
		msg = "���� ����!";
		url = "list.jsp";
	}else{
		msg = "���� ����...";
		url = "home.jsp";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>















