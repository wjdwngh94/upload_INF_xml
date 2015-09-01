<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!-- insert.jsp : home.jsp 에서 전달받은 데이터 저장 -->
<%
	//데이터 수신 과정
	//1. 한글처리
	request.setCharacterEncoding("euc-kr");
	//2. 파라미터 수신
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	//3. 유효성 검사
	if(writer==null||writer.trim().equals("")||
				content==null||content.trim().equals("")){
		response.sendRedirect("home.jsp");//쫓아내겠다.
		return;
	}

	//DB 연결 및 데이터 저장
	
	//드라이버 검색 - ojdbc6.jar 를 WebContent/Web-inf/lib에 저장
	//그 안의 oracle/jdbc/driver/OracleDriver.class 파일 실행
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	//로그인 - 위치, 아이디, 비밀번호
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "jsp1";
	String pass = "jsp1";
	
	//로그인 시도 - 로그인 실패하면 con == null
	//java.sql 패키지를 import
	Connection con = 
					DriverManager.getConnection(url, user, pass);
	
	System.out.println("con = " + con);
	
	//명령(쿼리) 전송
	String sql = "insert into miniboard values("+
						"miniboard_seq.nextval, ?, ?, sysdate)";
	//연결 정보 con에서 전송 객체 추출
	PreparedStatement ps = con.prepareStatement(sql);
	//물음표 채우기 - 지정한 형식에 맞게 알아서 집어넣어준다.
	//ps.set자료형(물음표순서, 변수명);
	ps.setString(1, writer);//자바 String 변수를 varchar2 형태로 저장
	ps.setString(2, content);
	
	//실행 후 결과 받기
	int result = ps.executeUpdate();
	//System.out.println("result = " + result);
	//result가 1이면 성공, 0이면 실패
	
		if(result>0){%>
		<script type="text/javascript">
			alert("글 등록 성공!");
			location.href="list.jsp";
		</script>
<%	}else{%>
		<script type="text/javascript">
			alert("글 등록 실패...");
			location.href="home.jsp";
		</script>
<%	}%>