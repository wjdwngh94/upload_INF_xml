<%@page import="my.board.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!-- ConnectionPoolBean을 application 영역에 생성 -->
<jsp:useBean id="pool" class="my.db.ConnectionPoolBean"
	scope="application" />

<jsp:useBean id="bddao" class="my.board.BoardDAO" />

<jsp:setProperty name="bddao" property="pool" value="<%=pool%>" />

<%@ include file="../top.jsp"%>

<script type="text/javascript">
			function openWrite(){
				//새창을 열어주는 코드
				//window.open("주소","이름","상태값");
				window.open("<%=request.getContextPath()%>/board/write.jsp", "",
				"width=600, height=700");
	}
</script>

<div align="center">

	<a href="javascript:openWrite();">글쓰기</a>
	
	<table class="outline" width="600">
		<!-- 제목 -->

		<tr>
			<th class="m2">번호</th>
			<th class="m2">제목</th>
			<th class="m2">작성자</th>
			<th class="m2">작성일</th>
			<th class="m2">조회수</th>
			<th class="m2">추천수</th>
		</tr>
		<!-- 데이터 -->

		<%
			ArrayList<BoardDTO> list = bddao.listBoard();
			for (BoardDTO bddto : list) {
		%>
		<tr>
			<th class="m3"><%=bddto.getNo()%></th>
			<th class="m3"><%=bddto.getTitle()%></th>
			<th class="m3"><%=bddto.getWriter()%></th>
			<th class="m3"><%=bddto.getRegdate()%></th>
			<th class="m3"><%=bddto.getReadcount()%></th>
			<th class="m3"><%=bddto.getRecommand()%></th>
		</tr>
		<%
			}
		%>
	</table>
	<br>
</div>
<%@ include file="../bottom.jsp"%>


