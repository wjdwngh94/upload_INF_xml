<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- find.jsp : �˻���� ������ ����� ��� ��� -->
<%
	//�˻���� ���õ� �κ��� �����ϰ�� list.jsp�� ����
	
	//�ѱ�ó��?
	request.setCharacterEncoding("euc-kr");
	
	//�Ķ���� ����? 1��(search)
	String search = request.getParameter("search");
			
	//��ȿ�� �˻�?
	if(search==null||search.trim().equals("")){
		response.sendRedirect("home.jsp");
		return;//_jspService() �� �����ϴ� ���
	}
%>
<%@ page import="java.sql.*" %>
<%
		//DB �����۾�
		//1. ����̹� �˻�
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//2. �α���
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "jsp1", pass="jsp1";
		
		Connection con = DriverManager.getConnection(url, user, pass);
		
		//3. ���� ����
		String sql = "select * from miniboard "
					+"where writer like ? or content like ? "
					+"order by no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		//����ǥ 2��
		ps.setString(1, "%"+search+"%");
		ps.setString(2, "%"+search+"%");
		
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















