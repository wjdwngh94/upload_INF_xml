<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<!-- post방식은 2가지가 있다.
	post방식은 enctype이라는 속성에 따라 다음의 두가지로 나뉜다.
	1. 파일의 이름만 전송하는 방식(기본값)
		- application/x-www-form-urlencoded
	2. 파일의 이름 + 내용 전송하는 방식
		- multipart/form-data
	 -->
	<form action="receive.jsp" method="post"
		enctype="multipart/form-data">
		업로더 : <input type="text" name="uploader"><br>
		파일선택 : <input type="file" name="file"><br>
		<input type="submit" value="업로드">
	</form>
</body>
</html>














