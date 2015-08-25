<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- session에 login이라는 항목을 지워서 로그아웃 처리한다. -->
<%
	//session data삭제

	//法1. login 항목막 삭제한다.
	session.removeAttribute("login");
	session.removeAttribute("userId");

	//法2. 세션 데이터 모두 삭제
	//session.invalidate();
	//세션을 통으로 날린다.
	//하지만 다른 데이터를 같이 날릴수도있으니 주의하여야 한다.
%>
<script type="text/javascript">
	alert("로그아웃 되었습니다.");
	location.href = "../index.jsp";
</script>