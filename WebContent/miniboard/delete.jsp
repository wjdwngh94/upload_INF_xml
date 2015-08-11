<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- delete.jsp : 입력된 데이터 삭제 -->
<%
	request.setCharacterEncoding("euc-kr");
	//2. 파라미터 수신
	String name = request.getParameter("name");
	//3. 유효성 검사
	if (name == null || name.trim().equals("")) {
		response.sendRedirect("home.jsp");//쫓아내겠다.
		return;
	}
	Class.forName("oracle.jdbc.driver.OracleDriver");

	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "jsp1";
	String pass = "jsp1";

	Connection con = DriverManager.getConnection(url, user, pass);

	String sql = "delete miniboard where writer=?";

	//연결 정보 con에서 전송 객체 추출
	PreparedStatement ps = con.prepareStatement(sql);
	//물음표 채우기 - 지정한 형식에 맞게 알아서 집어넣어준다.
	//ps.set자료형(물음표순서, 변수명);
	ps.setString(1, name);//자바 String 변수를 varchar2 형태로 저장

	//실행 후 결과 받기
	int result = ps.executeUpdate();
	//System.out.println("result = " + result);
	//result가 1이면 성공, 0이면 실패

	if (result > 0) {//성공 : 회원가입 성공! 알림창 , list.jsp 로 이동
%>

<script type="text/javascript">
	alert("글 삭제 성공!");
	location.href = "list.jsp";
</script>
<%
	} else {//실패 : 회원가입 실패... 알림창 , send.jsp 로 이동
%>
<script type="text/javascript">
	alert("글 삭제 실패...");
	location.href = "home.jsp";
</script>
<%
	}
%>