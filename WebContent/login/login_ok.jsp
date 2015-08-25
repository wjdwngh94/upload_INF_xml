<%@page import="my.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- 
	login_ok.jsp : 로그인을 실제로 처리하는 페이지
	
	전송되어진 아이디와 비밀번호로 로그인 처리를 수행하세요
	1. 로그인 성공 : 아이디와 비밀번호 모두 일치하는 경우
		- 로그인 처리 후 index.jsp로 이동
	2. 로그인 실패 : 
		- 정보 오류 : 아이디 또는 비밀번호 중 하나가 오류인 경우
		- 서버 오류 : SQLException이 발생한 경우
		- login.jsp로 이동
	처리는 MemberDAO를 이용하세요
 -->
<jsp:useBean id="mbdao" class="my.member.MemberDAO" />
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String saveId = request.getParameter("saveId");//on | null
	if (id == null || id.trim().equals("") || pw == null
			|| pw.trim().equals("")) {
		response.sendRedirect("login.jsp");
		return;
	}

	//1 : 성공, 2 : 정보오류 , 3 : 서버오류
	int result = mbdao.login(id, pw);
	String msg = "", url = "";
	//if (result == 1)대신에 값 활용과 가독성을 위해 아래와 같이 사용한다(import要).
	if (result == MemberDAO.OK) {//로그인 성공, index.jsp로 이동
		msg = id + "님 환영합니다.";
		//url = "../index.jsp";
		url = request.getContextPath() + "/index.jsp";

		//실제 로그인 통과 처리 수행 - session에 추가된 정보들
		session.setAttribute("login", "ok"); //로그인 성공
		session.setAttribute("userId", "id"); //로그인 성공된 id
		//top.jsp가 가장먼저 실행되기 때문에 그곳에 login판정을 만들어 둔다.
		if (saveId != null) { //아이디 저장하기가 체크되어 있으면
			Cookie ck = new Cookie("saveId", id); //id저장
			ck.setMaxAge(1 * 24 * 60 * 60);
			response.addCookie(ck);
		}
	} else if (result == MemberDAO.NOK) {//정보 오류, login.jsp로 이동
		msg = "입력하신 정보가 잘못되었습니다.";
		url = "login.jsp";
	} else if (result == MemberDAO.ERROR) {//서버 오류, login.jsp로 이동
		msg = "처리 과정에서 오류가 생겼습니다.";
		url = "login.jsp";
	}
%>
<script type="text/javascript">
 	alert("<%=msg%>");
 	location.href="<%=url%>
	";
</script>















