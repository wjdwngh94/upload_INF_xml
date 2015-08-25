<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<title>강사가 만든 홈페이지!</title>

<!-- stylesheet 등록(style.css) -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/style.css">

<!-- javascript 함수를 위한 script 태그 -->
<script type="text/javascript">
			function openMember(){
				//새창을 열어주는 코드
				//window.open("주소","이름","상태값");
				window.open("<%=request.getContextPath()%>/member/memberInput.jsp", "",
				"width=500, height=500");
	}
</script>
<!-- 로그인 판정 코드 -->
<%
	//session에 login이 있는지 확인
	//저장되는 값은 언제나 object이다.
	String loginTxt = (String) session.getAttribute("login");
	boolean isLogin = false; // true : 로그인, false : 로그아웃
	if (loginTxt == null) {
		isLogin = false;
	} else {
		isLogin = true;
	}
%>
</head>
<body>
	<div align="center">
		<!-- 3행 2열 테이블 -->
		<table border="1" width="900" height="600">
			<tr height="50">
				<th colspan="2"><a
					href="<%=request.getContextPath()%>/index.jsp">홈으로</a> | 
					<!-- 로그인과 회원가입은 로그인성공인 상태에서는 가려져야 한다. -->
					<% if(isLogin){ %>
					<a href="<%=request.getContextPath()%>/login/login.jsp">로그아웃 </a>|
					<%} else{%>
					<a href="<%=request.getContextPath()%>/login/login.jsp">로그인 </a>|
					<%} %>
					<a href="javascript:openMember();">회원가입</a> | <a
					href="<%=request.getContextPath()%>/member/memberList.jsp">회원목록</a>
					| <a href="<%=request.getContextPath()%>/intro.jsp">소개글</a></th>
			</tr>
			<tr>
				<th width="20%" valign="top" align="left"><a
					href="<%=request.getContextPath()%>/miniboard/home.jsp">
						1.미니게시판 </a> <br> <a
					href="<%=request.getContextPath()%>/miniboard2/home.jsp">
						2.미니게시판2 </a></th>
				<td>