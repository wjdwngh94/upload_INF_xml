<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	//데이터 확인 : 공간명.getAttribute("이름"); -> 값(Object)
	//Integer data1 = a;
	Integer data2 = (Integer)request.getAttribute("data");
	Integer data3 = (Integer)session.getAttribute("data");
	Integer data4 = (Integer)application.getAttribute("data");
%>
<h1>page 데이터 확인 불가</h1>
<h1>request : <%=data2%></h1>
<h1>session : <%=data3%></h1>
<h1>application : <%=data4%></h1>
<a href="scope1.jsp">설정 페이지</a><br>
<a href="scope2.jsp">이전 페이지</a><br>