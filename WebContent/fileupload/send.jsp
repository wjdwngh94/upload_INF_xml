<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<!-- post����� 2������ �ִ�.
	post����� enctype�̶�� �Ӽ��� ���� ������ �ΰ����� ������.
	1. ������ �̸��� �����ϴ� ���(�⺻��)
		- application/x-www-form-urlencoded
	2. ������ �̸� + ���� �����ϴ� ���
		- multipart/form-data
	 -->
	<form action="receive.jsp" method="post"
		enctype="multipart/form-data">
		���δ� : <input type="text" name="uploader"><br>
		���ϼ��� : <input type="file" name="file"><br>
		<input type="submit" value="���ε�">
	</form>
</body>
</html>














