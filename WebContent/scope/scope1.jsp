<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	//�ڹٿ��� 4���� ������ �ִ�.
	//page, request, session, application
	//������ ������ �����͸� ÷���Ͽ� ������ ������ �Ǵ��� Ȯ��
	
	
	//������ ÷�ι�� : ������.setAttribute("�̸�", ��);
	//�̸��� String, ���� Object ���·� ����ȴ�.(Map ����)
	
	//page�� ������ ������ �߰��� �Ұ��ϴ�.
	Integer a = 10;//page�� ������ �Ҵ�ȴ�.
	
	request.setAttribute("data", new Integer(10));//10
	session.setAttribute("data", new Integer(20));//20
	application.setAttribute("data", new Integer(30));//30
	
	//������ Ȯ�� : ������.getAttribute("�̸�"); -> ��(Object)
	Integer data1 = a;
	Integer data2 = (Integer)request.getAttribute("data");
	Integer data3 = (Integer)session.getAttribute("data");
	Integer data4 = (Integer)application.getAttribute("data");
%>
<h1>page : <%=data1%></h1>
<h1>request : <%=data2%></h1>
<h1>session : <%=data3%></h1>
<h1>application : <%=data4%></h1>
<a href="scope2.jsp">���� ������</a><br>













