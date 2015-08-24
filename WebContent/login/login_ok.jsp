<%@page import="my.member.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- login_ok.jsp - login 을 실제로 처리하는 page -->
<!-- 전송되어진 아이디와 비밀번호를 가지고 로그인 처리를 수행하세요
1. 로그인 성공 - 아이디와 비밀번호 모두 일치한 경우 : index.jsp로 이동시킨다.
2. 로그인 실패 - 정보오류(아이디 또는 비밀번호 중 하나가 오류) 서버 오류(SQLException발생) : login.jsp로 이동
		처리는 MemberDAO를 이용한다.
		-->

<!-- MemberDTO 생성 -->

<%
	request.setCharacterEncoding("euc-kr");

	//MemberDTO 생성 후에 포장하여 처리
	MemberDTO mbdto = new MemberDTO();
	mbdto.setId(request.getParameter("id"));
	mbdto.setPw(request.getParameter("pw"));

	if (mbdto.getId() == null || mbdto.getId().trim().equals("")) {
		if (mbdto.getPw() == null || mbdto.getPw().trim().equals("")) {
			response.sendRedirect("login.jsp");
		}
	}

	MemberDAO mbdao = new MemberDAO();
	String word = mbdao.loginMember(mbdto.getId(), mbdto.getPw());
	//true : 가입, false : 거절
%>
<script type="text/javascript">
		alert("<%=word%>");
			</script>
<%
		//가입 처리
	boolean result = mbdao.insertMember(mbdto);
	if (result) {
%>
<script type="text/javascript">
			alert("가입이 성공적으로 완료되었습니다\n로그인하세요");
			//부모창의 주소를 login 페이지로 변경
			window.opener.parent.location.href=
			"<%=request.getContextPath()%>
	/login/login.jsp";
	window.close();
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("가입 처리 과정에서 문제 발생...\n잠시 후 다시 시도");
	history.back();
</script>
<%
	}
%>


