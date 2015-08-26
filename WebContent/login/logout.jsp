<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- session에 login이라는 항목을 지워서 로그아웃 처리 -->
<%
		//login 항목만 삭제
		session.removeAttribute("login");
		session.removeAttribute("userId");
		
		//세션 데이터 모두 삭제
		//session.invalidate();
%>
<script type="text/javascript">
	alert("로그아웃 되었습니다.");
	location.href="../index.jsp";
</script>







