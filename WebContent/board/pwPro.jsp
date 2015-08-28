<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- pwPro.jsp : 비밀번호 확인 -->
<jsp:useBean id="bdao" class="my.board.BoardDAO"/>
<%
	//번호 받고
	String tmp = request.getParameter("no");
	int no = 0;
	//다음 페이지 주소
	String next = request.getParameter("next");
	//비밀번호
	String pw = request.getParameter("pw");
	try{
		no = Integer.parseInt(tmp);
		if(no<=0) throw new Exception();
		if(next==null||next.trim().equals(""))
				throw new Exception();
		if(pw==null||pw.trim().equals(""))
				throw new Exception();
	}catch(Exception e){
		response.sendRedirect("list.jsp");
		return;
	}
	
	//BoardDAO의 객체에게 비밀번호 검사 요청
	boolean result = bdao.checkPw(no, pw);
	if(result){//true, 비밀번호 일치, next로 전송(no 첨부)
		//response.sendRedirect(next+"?no="+no);%>
	<!-- post방식을 이용하기 위해 form을 만들어 전송 -->
	<form name="f" action="<%=next%>" method="post">
	<input type="hidden" name="no" value="<%=no%>">
	<!-- 인증과 관련된 값 -->
	<input type="hidden" name="check" value="ok">
	</form>
	<script type="text/javascript">
		document.f.submit();//post방식 전송
	</script>
<%}else{//false, 비밀번호 불일치%>
		<script type="text/javascript">
			alert("비밀번호가 맞지 않습니다.");
			history.back();//뒤로 1페이지
		</script>
<%}%>




















