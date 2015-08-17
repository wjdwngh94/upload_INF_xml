<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- list.jsp : 저장된 데이터 목록을 표시하는 페이지 -->
<%
	//DB연결단계

	//1.드라이버 검색
	//무슨페이지를 실행시킬지 모르기 때문에 우선 driver검색을 한다.
	Class.forName("oracle.jdbc.driver.OracleDriver");

	//2.로그인
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	//localhost == 127.0.0.1
	String user = "jsp1";
	String pass = "jsp1";
	Connection con = DriverManager.getConnection(url, user, pass);

	//3.쿼리전송
	String sql = "select * from miniboard order by no asc";//desc asc
	PreparedStatement ps = con.prepareStatement(sql);

	//물음표 없음

	//4.실행 및 결과확인
	ResultSet rs = ps.executeQuery();

	//rs에 있는 데이터를 화면에 출력
%>
<!-- top.jsp를 불러온다. -->
<%@ include file="../top.jsp"%>
<div align="center">
	<!-- 목록 출력 -->
	<h1>등록된 게시글</h1>
	<table border="1" width="600">
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th width="40%">내용</th>
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
</div>
<!-- bottom.jsp를 불러온다. -->
<%@ include file="../bottom.jsp"%>
<%
	//5.연결 종료 - rs,ps,con을 폐기
	rs.close();
	ps.close();
	con.close();
%>