<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
	<head>
		<title>���簡 ���� Ȩ������!</title>
		
		<!-- stylesheet ���(style.css) -->
		<link rel="stylesheet" type="text/css" 
			href="<%=request.getContextPath()%>/style.css">
		
		<!-- javascript �Լ��� ���� script �±� -->
		<script type="text/javascript">
			function openMember(){
				//��â�� �����ִ� �ڵ�
				//window.open("�ּ�","�̸�","���°�");
				window.open(
"<%=request.getContextPath()%>/member/memberInput.jsp", 
							"", "width=500, height=500");
			}
		</script>
		<!-- �α��� ���� �ڵ� -->
		<%
		//session�� login�� �ִ��� Ȯ��
		String loginTxt = (String)session.getAttribute("login");
		boolean isLogin;//true : �α���, false : �α׾ƿ�
		if(loginTxt==null){//�α׾ƿ�
			isLogin = false;
		}else{
			isLogin = true;
		}
		%>
	</head>
	<body>
	<div align="center">
		<!-- 3�� 2�� ���̺� -->
		<table border="1" width="900" height="600">
			<tr height="50">
				<th colspan="2">
					<a href="<%=request.getContextPath()%>/index.jsp">Ȩ����</a> | 
					<%if(isLogin){ %>
					<a href="<%=request.getContextPath()%>/login/logout.jsp">�α׾ƿ�</a> |
					<%}else{ %>
					<a href="<%=request.getContextPath()%>/login/login.jsp">�α���</a> | 
					<a href="javascript:openMember();">ȸ������</a> |
					<%} %>
					
					<a href="<%=request.getContextPath()%>/member/memberList.jsp">
						ȸ�����
					</a> | 
					<a href="<%=request.getContextPath()%>/board/list.jsp">�Խ���</a> |
					<a href="<%=request.getContextPath()%>/intro.jsp">�Ұ���</a>
				</th>
			</tr>
			<tr>
				<th width="20%" valign="top" align="left">
					<a href="<%=request.getContextPath()%>/miniboard/home.jsp">
					1.�̴ϰԽ���
					</a>
					<br>
					<a href="<%=request.getContextPath()%>/miniboard2/home.jsp">
					2.�̴ϰԽ���2
					</a>
				</th>
				<td>
				
				
				
				
				
				
				