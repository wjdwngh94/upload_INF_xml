<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="my.miniboard.*" %>
<%@ page import="java.util.*" %>
<!-- list.jsp : ��� ������ -->
<%
	//DAO ���� �� DB ����� ���δ� ��������� ����
	MiniDAO dao = new MiniDAO();
	ArrayList<MiniDTO> list = dao.list();  

	//list�� ����ִ� ������ ȭ�鿡 ��� 
%>
<%@ include file="/top.jsp" %>
<div align="center">
	<!-- ��� -->
	<%if(list==null||list.size()==0){//�Խñ��� ������... %>
	<h1>�Խñ��� �����ϴ�.</h1>
	<%}else{ %>
	<table border="1" width="600">
		<!-- ���� -->
		<tr>
			<th>��ȣ</th>
			<th>�ۼ���</th>
			<th width="40%">����</th>
			<th>�����</th>
		</tr>
		<!-- ���� : ArrayList<MiniDTO> list ���� ���� ���� -->
		<%-- <%for(int i=0; i<list.size(); ++i){
						MiniDTO dto = list.get(i);
						//���� ���
					}%> --%>
		<!-- for(�ڷ��� ������ : �����){�ݺ�����} -->
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















