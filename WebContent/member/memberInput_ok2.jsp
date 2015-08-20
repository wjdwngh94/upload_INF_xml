<%@page import="my.member.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	//데이터 수신
	request.setCharacterEncoding("euc-kr");

	//MemberDTO 생성후에 포장하여 처리
	MemberDAO dao = new MemberDAO();
	MemberDTO mbdto = new MemberDTO();

	mbdto.setName(request.getParameter("name"));
	mbdto.setId(request.getParameter("id"));
	mbdto.setGender(request.getParameter("gender"));
	mbdto.setBirth(request.getParameter("birth"));
	mbdto.setPw(request.getParameter("pw"));
	mbdto.setPost(request.getParameter("post"));
	mbdto.setAddr1(request.getParameter("addr1"));
	mbdto.setAddr2(request.getParameter("addr2"));
	mbdto.setPower("normal");

	if (mbdto.getId() == null || mbdto.getId().trim().equals("")) {
		response.sendRedirect("memberInput.jsp");
		return;
	}
	boolean check = dao.find(mbdto.getId());
	if (!check) {
%>

<script type="text/javascript">
	alert("이미 사용중인 아이디 입니다.");
	history.back(); //뒤로 1페이지 이동 response.sendRedirect(); 와 동일
</script>
<%
	return;
	} else {
		//가입처리 한다.
		boolean result = mbdto.insertMember(mbdto);
		if (result) {
%>
<script type="text/javascript">
	alert("게시글 입력 성공");
	window.close();
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("게시글 입력 실패...");
	history.back();
</script>
<%
	}
	}
%>

