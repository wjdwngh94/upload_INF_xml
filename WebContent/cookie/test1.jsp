<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- test1.jsp : ��Ű ���� ������ -->
<%
	//[1] Cookie Ŭ���� ��ü ����
	//Cookie ��Ű�� = new Cookie("�̸�ǥ", "������");
	Cookie ck = new Cookie("userId", "admin");//String,String

	//[2] ��ȿ ���� ����(�ʴ���)
	ck.setMaxAge(1*24*60*60);//1��
	//ck.setMaxAge(0);//��Ű ����
	
	//[3] ���Ϸ� �������� - response �̿�
	response.addCookie(ck);	
%>












