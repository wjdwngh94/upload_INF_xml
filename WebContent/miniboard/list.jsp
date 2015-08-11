<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- list.jsp : 저장된 데이터 목록을 표시하는 페이지 -->
<%
	//(4단계를 거치자)
	//바로 db연결한다.
	//1.무슨페이지를 실행시킬지 모르기 때문에 우선 driver검색을 한다.
	Class.forName("oracle.jdbc.driver.OracleDriver");

	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	//localhost == 127.0.0.1
	String user = "jsp1";
	String pass = "jsp1";
	//로그인

	Connection con = DriverManager.getConnection(url, user, pass);
	//쿼리문(전체명단을 가져오는 것이므로 먼저 가입한 순서대로(번호가 낮은 순서))

	String sql = "select * from miniboard order by no asc";//쿼리문
	PreparedStatement ps = con.prepareStatement(sql);
	//물음표 없음
	ResultSet rs = ps.executeQuery();
%>
<!-- top.jsp를 불러온다. -->
<%@ include file="../top.jsp"%>

<h1>등록된 게시글</h1>
	<table border="1">


		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>내용</th>
			<th>작성일</th>
		</tr>
		<!-- 내용줄 : 데이터가 있을 때마다 1줄씩 생성 -->
		<%
			while (rs.next()) {//데이터가 있으면
		%>
		<tr>
			<th><%=rs.getInt("no")%></th>
			<th><%=rs.getString("writer")%></th>
			<th><%=rs.getString("content")%></th>
			<th><%=rs.getString("regdate")%></th>
		</tr>
		<%
			}
		%>

	</table>
<!-- bottom.jsp를 불러온다. -->
<%@ include file="../bottom.jsp"%>










