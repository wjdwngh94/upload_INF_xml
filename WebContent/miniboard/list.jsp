<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!-- list.jsp : �Խ��� ��� -->
<%
		//DB �����۾�
		//1. ����̹� �˻�
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//2. �α���
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "jsp1", pass="jsp1";
		
		Connection con = DriverManager.getConnection(url, user, pass);
		
		//3. ���� ����
		String sql = "select * from miniboard order by no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		//����ǥ ����
		
		//4. ���� �� ���Ȯ��
		ResultSet rs = ps.executeQuery();
		
		//rs�� �ִ� �����͸� ȭ�鿡 ���
%>
<%@ include file="../top.jsp" %>
<div align="center">
	<!-- ��� ��� -->
	<table border="1" width="600">
		<!-- ���� ��� -->
		<tr>
			<th>��ȣ</th>
			<th>�ۼ���</th>
			<th width="40%">����</th>
			<th>�ۼ���</th>
		</tr>
		<!-- ���� ��� : while -->
		<%while(rs.next()){ %>
		<tr>
			<td><%=rs.getInt("no")%></td>
			<td><%=rs.getString("writer")%></td>
			<td><%=rs.getString("content")%></td>
			<td><%=rs.getString("joindate")%></td>
		</tr>
		<%} %>
	</table>
</div>
<%@ include file="../bottom.jsp"%>
<%
		//5. ���� ���� - rs, ps, con �� ���
		rs.close();
		ps.close();
		con.close();
%>













