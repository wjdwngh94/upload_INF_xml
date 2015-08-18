<%@page import="java.util.*"%>
<%@page import="my.miniboard.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- list.jsp : 목록 페이지 -->
<%
	//검색어 수신하기
	request.setCharacterEncoding("euc-kr");
	String name = request.getParameter("name");
	if (name == null || name.trim().equals("")) {
		response.sendRedirect("home.jsp");//쫓아내겠다.
		return;
	}

	//DB 접속 및 데이터 가져오기 = MiniDAO시켜서 처리
	MiniDAO dao = new MiniDAO();

	//name을 건내주고 find로 받겠다
	//즉 검색어를 건내주고 검색명단(ArrayList<게시글-MiniDTO>)을 받아야한다.

	ArrayList<MiniDTO> find = dao.find(name);
	//java.util.ArrayList<MiniDTO> find = dao.find(name);와 동일(import)

	//list에 들어가 있는 데이터 화면에 출력
%>

<%@ include file="/top.jsp"%>

<!-- / 처리만 하면 절대경로 처리 된다. -->
<div align="center">

	<!-- 목록 -->
	<%
		if (find == null || find.size() == 0) {
			//list가 없는경우와 비어있는 경우
	%>
	<h1>게시글이 없습니다.</h1>
	<%
		} else {
	%>
	<table border="1" width="600">
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th width="40%">내용</th>
			<th>등록일</th>
		</tr>
		<!-- 내용 : ArrayList<MiniDTO> list안의 내용 추출 -->
		<%
			for (MiniDTO dto : find) //확장 for문
				/*for(int i=0; i<list.size(); ++i){
					MiniDTO dto = list.get(i);
					//이후 출력
				}*/{
		%>
		<tr>
			<th><%=dto.getNo()%></th>
			<th><%=dto.getWriter()%></th>
			<th><%=dto.getContent()%></th>
			<th><%=dto.getRegdate()%></th>
		</tr>
		<%
			}
		%>
	</table>
	<%
		}
	%>
</div>
<h5 align="right">
	총<%=find.size()%>개의 데이터가 있습니다.
	</h3>
	<%@ include file="/bottom.jsp"%>