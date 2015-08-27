<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, my.board.*" %>
<!-- list.jsp : 게시글 목록 페이지 -->
<%@ include file="/top.jsp"%>
<jsp:useBean id="bdao" class="my.board.BoardDAO"/>
<div align="center">
<%
	//검색어 수신
	request.setCharacterEncoding("euc-kr");
	String search = request.getParameter("search");
	String searchString = request.getParameter("searchString");
	
	//모드 판정
	ArrayList<BoardDTO> list;
	if(search!=null&&searchString!=null
					&&!searchString.trim().equals("")){
		list = bdao.searchBoard(search, searchString);//검색
	}else{
		list = bdao.listBoard();//목록
	}
%> 
<h1>search : <%=search%>, 
					searchString : <%=searchString%></h1>
<!-- 글쓰기 버튼 -->
<table width="700">
	<tr><td align="right">
	<input type="button" value="글쓰기"
							onclick="location.href='write.jsp'">
	</td></tr>
</table>
<br>
<!-- 목록 출력 -->
<table class="outline" width="700">
	<!-- 제목줄 -->
	<tr>
		<th class="m2">번호</th>
		<th class="m2">제목</th>
		<th class="m2">작성자</th>
		<th class="m2">작성일</th>
		<th class="m2">조회수</th>
		<th class="m2">추천수</th>
	</tr>
	<!-- 내용줄 -->
	<%for(BoardDTO bdto : list){ %>
	<tr align="center">
		<td class="m3"><%=bdto.getNo()%></td>
		<td class="m3" align="left" width="40%">
		<a href="content.jsp?no=<%=bdto.getNo()%>">
			<%=bdto.getTitle()%>
		</a>
		</td>
		<td class="m3"><%=bdto.getWriter()%></td>
		<td class="m3"><%=bdto.getTime()%></td> 
		<td class="m3"><%=bdto.getReadcount()%></td>
		<td class="m3"><%=bdto.getRecommand()%></td>
	</tr>
	<%} %>
</table>
<br><br>
<!-- 검색창 -->
<form method="post">
	<select name="search" class="box">
		<option value="title">제목
		<option value="writer">작성자
	</select>
	<input type="text" class="box" name="searchString">
	<input type="submit" value="검색"> 
</form>
</div>
<%@ include file="/bottom.jsp"%>

	











