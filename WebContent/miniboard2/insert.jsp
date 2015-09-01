<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="my.miniboard.*" %>
<%
	//������ ���� ����
	//1. �ѱ�ó��
	request.setCharacterEncoding("euc-kr");
	//2. �Ķ���� ����
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	//3. ��ȿ�� �˻�
	if(writer==null||writer.trim().equals("")||
				content==null||content.trim().equals("")){
		response.sendRedirect("home.jsp");//�ѾƳ��ڴ�.
		return;
	}
	
	//DB ���� �� ó��
	//�ù���(DAO) �ҷ��� ��Ű�� ���ǹޱ�
	//my.miniboard.MiniDAO dao = new my.miniboard.MiniDAO();
	MiniDAO dao = new MiniDAO();
	int result = dao.insert(writer, content);
	
	//����� �˸�
	if(result>0){%>
	<script type="text/javascript">
		alert("�� ��� ����!");
		location.href="list.jsp";
	</script>
<%	}else{%>
	<script type="text/javascript">
		alert("�� ��� ����...");
		location.href="home.jsp";
	</script>
<%	}%>
