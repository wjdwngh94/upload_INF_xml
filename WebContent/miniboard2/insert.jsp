<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="my.miniboard.*" %>
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
	
	//DB 연결 및 처리
	//택배기사(DAO) 불러서 시키고 물건받기
	//my.miniboard.MiniDAO dao = new my.miniboard.MiniDAO();
	MiniDAO dao = new MiniDAO();
	int result = dao.insert(writer, content);
	
	//사용자 알림
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
