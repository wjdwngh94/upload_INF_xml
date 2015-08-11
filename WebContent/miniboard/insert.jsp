<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- insert.jsp : DB에 정보를 집어넣는 페이지 -->
<!-- Oracle의 TEST 테이블에 정보를 집어넣는 것이 목표 -->

<%
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("name");
	String text = request.getParameter("text");
	//3. 유효성 검사
	if(name==null||name.trim().equals("")||text==null){
		response.sendRedirect("home.jsp");//쫓아내겠다.
		return;
	}
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	//로그인 - 위치, 아이디, 비밀번호
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "jsp1";
	String pass = "jsp1";
	
	Connection con = DriverManager.getConnection(url, user, pass);
	//명령(쿼리) 전송
	String sql = "insert into miniboard values(miniboard_seq.nextval,?,?,sysdate)";
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, name);//자바 String 변수를 varchar2 형태로 저장
	ps.setString(2, text);
	
	int result = ps.executeUpdate();
	
		if(result>0){%>
		<script type="text/javascript">
			alert("게시글 입력 성공");
			location.href="list.jsp";
		</script>
<%	}else{%>
		<script type="text/javascript">
			alert("게시글 입력 실패...");
			location.href="home.jsp";
		</script>
<%	}%>










