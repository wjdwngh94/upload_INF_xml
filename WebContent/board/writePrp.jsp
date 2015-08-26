<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="my.board.*"%>
<%
	//데이터 수신
	request.setCharacterEncoding("euc-kr");

	//MemberDTO 생성 후에 포장하여 처리
	BoardDTO bddto = new BoardDTO();
	bddto.setWriter(request.getParameter("writer"));
	bddto.setTitle(request.getParameter("title"));
	bddto.setContent(request.getParameter("content"));
	bddto.setPw(request.getParameter("pw"));
	//필요하다면 유효성 검사
	if (bddto.getWriter() == null
			|| bddto.getWriter().trim().equals("")) {
		response.sendRedirect("boardInput.jsp");
		return;
	}

	BoardDAO bddao = new BoardDAO();
	//가입 처리
	boolean result = bddao.insertBoard(bddto);
	if (result) {
%>
<script type="text/javascript">
	alert("등록이 완료되었습니다.");
	window.close();
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("게시글 등록 과정에서 문제 발생...\n잠시 후 다시 시도");
	history.back();
</script>
<%
	}
%>













