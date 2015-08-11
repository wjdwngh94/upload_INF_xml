<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!-- top.jsp를 불러온다. -->
<%@ include file="top.jsp"%>
<a href="javascript:alert('환영합니다.');"> <%
 	//Atag(링크태그)를통해 alert를 쓰려면 javascript라는 것을 표시해 주어야 한다.
 %> <img src="Fruit.jpg" width=300 height=280>
</a>
<!-- bottom.jsp를 불러온다. -->
<%@ include file="bottom.jsp"%>