<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	//자바에는 4가지 영역이 있다.
	//page, request, session, application
	//각각의 공간에 데이터를 첨부하여 어디까지 유지가 되는지 확인한다.

	//데이터 첨부 방법 : 공간명.setAttribute("이름", 값);
	//이름은 String, 값은 Object 형태로 저장된다.
	//아이디 - 비밀번호 / 변수명과 - 값 의 관계 Map 구조

	//page는 별도의 데이터 추가가 불가하다.
	int a = 10;//page의 영역에 할당된다.
	request.setAttribute("data", new Integer(10)); // 10의 data라는 이름으로 넣는다.
	session.setAttribute("data", new Integer(20)); // 20
	application.setAttribute("data", new Integer(30)); // 30

	//데이터 확인 : 공간명.getAttribute("이름"); -> 값(Object)
	Integer data1 = a;
	//int data2 = request.getAttribute("data"); //오른쪽이 object이므로 오류가 난다.
	
	Integer data2 = (Integer) request.getAttribute("data");
	Integer data3 = (Integer) session.getAttribute("data");
	Integer data4 = (Integer) application.getAttribute("data");
%>

<!-- 모두가 출력이 잘 된다. -->
<h1>
	page :
	<%=data1%></h1>
<h1>
	request :
	<%=data2%></h1>
<h1>
	session :
	<%=data3%></h1>
<h1>
	application :
	<%=data4%></h1>

<a href="scope2.jsp">다음 페이지</a>
<br>