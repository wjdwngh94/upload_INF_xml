<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	//자바에는 4가지 영역이 있다.
	//page, request, session, application
	//각각의 공간에 데이터를 첨부하여 어디까지 유지가 되는지 확인
	
	
	//데이터 첨부방법 : 공간명.setAttribute("이름", 값);
	//이름은 String, 값은 Object 형태로 저장된다.(Map 구조)
	
	//page는 별도의 데이터 추가가 불가하다.
	Integer a = 10;//page의 영역에 할당된다.
	
	request.setAttribute("data", new Integer(10));//10
	session.setAttribute("data", new Integer(20));//20
	application.setAttribute("data", new Integer(30));//30
	
	//데이터 확인 : 공간명.getAttribute("이름"); -> 값(Object)
	Integer data1 = a;
	Integer data2 = (Integer)request.getAttribute("data");
	Integer data3 = (Integer)session.getAttribute("data");
	Integer data4 = (Integer)application.getAttribute("data");
%>
<h1>page : <%=data1%></h1>
<h1>request : <%=data2%></h1>
<h1>session : <%=data3%></h1>
<h1>application : <%=data4%></h1>
<a href="scope2.jsp">다음 페이지</a><br>













