<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="my.board.*, java.util.*" %>
<!-- content.jsp : 게시글 번호를 가지고 내용을 보여주는 페이지 -->
<jsp:useBean id="bdao" class="my.board.BoardDAO"/>
<%
	String tmp = request.getParameter("no");
	int no = 0;
	try{
		no = Integer.parseInt(tmp);
		if(no<=0) throw new Exception();
	}catch(Exception e){
		response.sendRedirect("list.jsp");
		return;
	}
	
	//아무때나 조회수를 증가시키면 안되므로...session을 이용
	//session에 readTable 이라는 이름의 Set을 집어넣고
	//꺼내서 확인하여 읽은 글인지를 판정하겠다..
	
	//session에서 readTable 꺼내본다.
	HashSet<Integer> readTable = 
		(HashSet<Integer>)session.getAttribute("readTable");
	
	//없으면 새로 만든다.
	if(readTable==null){
		readTable = new HashSet<Integer>();
	}
	
	//readTable에 지금 읽는 글 번호가 있는지 확인
	if(readTable.add(no)){//readTable.add(no) == true
		//처음 읽는 글인 경우, 조회수 1 증가
		bdao.plusCount(no);
		session.setAttribute("readTable", readTable);//갱신
	}
	
	//no로 게시글의 모든 정보를 불러와야 한다.
	BoardDTO bdto = bdao.getBoard(no); 
	//null인 경우 퇴출
	if(bdto==null){
		response.sendRedirect("list.jsp");
		return;
	}
%>
<%@ include file="/top.jsp"%>
<script type="text/javascript">
	function sendReply(){
		alert("아직 구현 준비중이에요");
	}
	function sendRec(){
		alert("추천 기능입니다.");
	}
	function sendEdit(no){
		//alert("수정 기능입니다.");
		location.href="pw.jsp?no="+no+"&next=edit.jsp";
	}
	function sendDel(no){
		//alert("삭제 기능입니다.");
		location.href="pw.jsp?no="+no+"&next=delete.jsp";
	}
</script>
<div align="center">
	<h1>글 읽 기</h1>
	<table class="outline" width="650">
	<tr>
		<th class="m2" width="20%">번호</th>
		<td class="m3" width="30%"><%=no%></td>
		<th class="m2" width="20%">조회수</th>
		<th class="m3"><%=bdto.getReadcount()%></th>
	</tr>
	<tr>
		<th class="m2">작성자</th>
		<td class="m3"><%=bdto.getWriter()%></td>
		<th class="m2">추천수</th>
		<th class="m3"><%=bdto.getRecommand()%></th>
	</tr>
	<tr>
		<th class="m2">제목</th>
		<td class="m3" colspan="3"><%=bdto.getTitle()%></td>
	</tr>
	<tr height="200">
		<th class="m2">내용</th>
		<td class="m3" colspan="3" valign="top"
			style="word-break:break-all;"><!-- 줄개행 속성 -->
		<%=bdto.getContent()%>
		</td>
	</tr>
	<tr>
		<th class="m2" colspan="4">
			<input type="button" value="글쓰기"
									onclick="location.href='write.jsp';">
			<input type="button" value="답글쓰기"
									onclick="sendReply();">
			<input type="button" value="추천하기"
									onclick="sendRec();">
			<input type="button" value="수정"
									onclick="sendEdit(<%=no%>);">
			<input type="button" value="삭제"
									onclick="sendDel(<%=no%>);">
			<input type="button" value="목록"
									onclick="location.href='list.jsp';">
		</th>
	</tr>
	</table>
</div>
<%@ include file="/bottom.jsp"%>

















