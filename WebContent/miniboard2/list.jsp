<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="my.miniboard.*" %>
<%@ page import="java.util.*" %>
<!-- list.jsp : 목록 페이지 -->
<%
	//DAO 생성 후 DB 명단을 전부다 가져오라고 지시
	MiniDAO dao = new MiniDAO();
	ArrayList<MiniDTO> list = dao.list();  

	//list에 들어있는 데이터 화면에 출력 
%>
<%@ include file="/top.jsp" %>
<div align="center">
	<!-- 목록 -->
	<%if(list==null||list.size()==0){//게시글이 없으면... %>
	<h1>게시글이 없습니다.</h1>
	<%}else{ %>
	<table border="1" width="600">
		<!-- 제목 -->
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th width="40%">내용</th>
			<th>등록일</th>
		</tr>
		<!-- 내용 : ArrayList<MiniDTO> list 안의 내용 추출 -->
		<%-- <%for(int i=0; i<list.size(); ++i){
						MiniDTO dto = list.get(i);
						//이후 출력
					}%> --%>
		<!-- for(자료형 변수명 : 저장소){반복내용} -->
		<%for(MiniDTO dto: list){ %>
		<tr>
			<td><%=dto.getNo()%></td>
			<td><%=dto.getWriter()%></td>
			<td><%=dto.getContent()%></td>
			<td><%=dto.getJoindate()%></td>
		</tr>
		<%} %>
	</table>
	<%} %>
</div>
<%@ include file="/bottom.jsp" %>















