<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- delete.jsp : 게시글 삭제 -->
<jsp:useBean id="bdao" class="my.board.BoardDAO"/>
<%
	//전송방식 추출
	String method = request.getMethod();

	//파라미터 추출
	String tmp = request.getParameter("no");
	int no = 0;
	String check = request.getParameter("check");
	try{
		no = Integer.parseInt(tmp);				//숫자가 아니면
		if(no<=0) throw new Exception();	//0 이하면 
		if(!method.equals("POST"))				//POST방식이 아니면
					throw new Exception();
		if(check==null||!check.equals("ok"))	//인증값이 ok가 아니면
					throw new Exception();
	}catch(Exception e){
		response.sendRedirect("list.jsp");
		return;
	}
	
	//no에 저장된 번호의 글을 삭제한다.
	boolean result = bdao.deleteBoard(no);
	if(result){//성공 : list.jsp%>
		<script type="text/javascript">
			alert("글 삭제 성공!");
			location.href="list.jsp";
		</script>
<%}else{//실패 : content.jsp (+no)%>
		<script type="text/javascript">
			alert("글 삭제 실패...");
			location.href="content.jsp?no=<%=no%>";
		</script>
<%}%>

























