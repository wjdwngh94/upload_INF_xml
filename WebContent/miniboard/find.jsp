<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- find.jsp : 검색어로 가져온 결과를 목록 출력 -->
<%
	//검색어와 관련된 부분을 제외하고는 list.jsp와 동일
	
	//한글처리?
	request.setCharacterEncoding("euc-kr");
	
	//파라미터 수신? 1개(search)
	String search = request.getParameter("search");
			
	//유효성 검사?
	if(search==null||search.trim().equals("")){
		response.sendRedirect("home.jsp");
		return;//_jspService() 를 종료하는 명령
	}
%>
<%@ page import="java.sql.*" %>
<%
		//DB 연결작업
		//1. 드라이버 검색
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//2. 로그인
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "jsp1", pass="jsp1";
		
		Connection con = DriverManager.getConnection(url, user, pass);
		
		//3. 쿼리 전송
		String sql = "select * from miniboard "
					+"where writer like ? or content like ? "
					+"order by no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		//물음표 2개
		ps.setString(1, "%"+search+"%");
		ps.setString(2, "%"+search+"%");
		
		//4. 실행 및 결과확인
		ResultSet rs = ps.executeQuery();
		
		//rs에 있는 데이터를 화면에 출력
%>
<%@ include file="../top.jsp" %>
<div align="center">
	<!-- 목록 출력 -->
	<table border="1" width="600">
		<!-- 제목 출력 -->
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th width="40%">내용</th>
			<th>작성일</th>
		</tr>
		<!-- 내용 출력 : while -->
		<%while(rs.next()){ %>
		<tr>
			<td><%=rs.getInt("no")%></td>
			<td><%=rs.getString("writer")%></td>
			<td><%=rs.getString("content")%></td>
			<td><%=rs.getString("joindate")%></td>
		</tr>
		<%} %>
	</table>
</div>
<%@ include file="../bottom.jsp"%>
<%
		//5. 연결 종료 - rs, ps, con 을 폐기
		rs.close();
		ps.close();
		con.close();
%>















