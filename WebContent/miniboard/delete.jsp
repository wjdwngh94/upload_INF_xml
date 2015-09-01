<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!-- delete.jsp : �Ѿ���� �ۼ��ڿ� ��ġ�ϴ� �׸��� ���� -->
<%
	//������ ���� ����
	//1. �ѱ�ó��
	request.setCharacterEncoding("euc-kr");
	//2. �Ķ���� ����
	String writer = request.getParameter("writer");
	//3. ��ȿ�� �˻�
	if(writer==null||writer.trim().equals("")){
		response.sendRedirect("home.jsp");//�ѾƳ��ڴ�.
		return;
	}

	//DB ���� �� ������ ����
	
	//����̹� �˻� - ojdbc6.jar �� WebContent/Web-inf/lib�� ����
	//�� ���� oracle/jdbc/driver/OracleDriver.class ���� ����
	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	//�α��� - ��ġ, ���̵�, ��й�ȣ
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "jsp1";
	String pass = "jsp1";
	
	//�α��� �õ� - �α��� �����ϸ� con == null
	//java.sql ��Ű���� import
	Connection con = 
					DriverManager.getConnection(url, user, pass);
	
	//���(����) ����
	String sql = "delete miniboard where writer = ?";
	//���� ���� con���� ���� ��ü ����
	PreparedStatement ps = con.prepareStatement(sql);
	//����ǥ ä��� - ������ ���Ŀ� �°� �˾Ƽ� ����־��ش�.
	//ps.set�ڷ���(����ǥ����, ������);
	ps.setString(1, writer);//�ڹ� String ������ varchar2 ���·� ����
	
	//���� �� ��� �ޱ�
	int result = ps.executeUpdate();
	//System.out.println("result = " + result);
	//result�� 1�̸� ����, 0�̸� ����
	
		if(result>0){%>
		<script type="text/javascript">
			alert("�� ���� ����!");
			location.href="list.jsp";
		</script>
<%	}else{%>
		<script type="text/javascript">
			alert("�� ���� ����...");
			location.href="home.jsp";
		</script>
<%	}%>