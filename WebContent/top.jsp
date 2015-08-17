<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<title>강사가 만든 홈페이지 !</title>
<!-- stylesheet 등록(style.css) -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/style.css">
</head>
<body>
	<div align="center">
		<!-- 3행 2열 테이블 -->
		<table border="1" width="700" height="600">
			<tr height="70">
				<%
					//줄의 높이
				%>
				<th colspan="2"><a
					href="<%=request.getContextPath()%>/index.jsp">홈으로</a> | 로그인 | 회원가입
					| <a href="<%=request.getContextPath()%>/intro.jsp"> 소개글</a></th>
			</tr>
			<tr>
				<th width="27%" valign="top" align="center"><br><a
					href="<%=request.getContextPath()%>/miniboard/home.jsp">
						1.미니게시판 </a><br><a
					href="<%=request.getContextPath()%>/miniboard2/home.jsp">
						2.미니게시판2 </a></th>

				<td>