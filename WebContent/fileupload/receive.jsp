<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="java.io.*"%>
<!-- receive.jsp : send.jsp���� ������ ���� �ޱ� -->
<%
	request.setCharacterEncoding("euc-kr");
	String uploader = request.getParameter("uploader");
	String file = request.getParameter("file");
%>
<h1>���� ������δ� ���۵� ���� ���� �� ����.</h1>
<h1>
	uploader :
	<%=uploader%></h1>
<h1>
	file :
	<%=file%></h1>

<%
	//com.oreilly.servlet.MultipartRequest�� �̿��� ���ο� ���
	//��ü ������ �ʿ��� ����
	//[1] ������ ���� ��� : 					request
	//[2] ��� ����? �������
	//[3] ��ŭ ����? ��� �뷮(byte)	10*1024*1024
	//[4] ��� ����? ���� �۲�			euc-kr
	//[5] �۸� ��å... �̸��� ��ġ��?		1~4�������� �� ��� ����

	//���񽺰�� : WebContent ���� �����ϴ� ������ ����
	String servicePath = request.getContextPath();
%>
<h2>
	���� ��� :
	<%=servicePath%>/fileupload/file
</h2>
<br>
<br>
<%
	//������� : ���񽺰���� ������ ������ �����ϴ� �ϵ��ũ ����
	String upPath = config.getServletContext().getRealPath(
			"/fileupload/file");
%>
<h2>
	���� ��� :
	<%=upPath%></h2>

<%
	//	Multipartr Request��ü ����- import com.oreilly.servlet
	MultipartRequest mr = null;
	//�۸� ��å ��ü ���� - import com.oreilly.servlet.multipart
	DefaultFileRenamePolicy dp = null;
	try {
		dp = new DefaultFileRenamePolicy();
		mr = new MultipartRequest(request, upPath, 10 * 1024 * 1024,
				"euc-kr", dp);
	} catch (IOException e) {
		System.out.println("mr��ü ����");
	}
%>

<h1>mr�� ���� ����</h1>
<h2>
	uploader :
	<%=mr.getParameter("uploader")%></h2>
<!-- ���� ���õ� �׸���� ������ �޼ҵ带 �̿��Ͽ��� �Ѵ�. -->
<h2>
	file :
	<%=mr.getFilesystemName("file")%></h2>
<%
	//���� ���� �� ���� ���
	File test = mr.getFile("file");
%>
<h2>���� �м�</h2>
<h2>
	���� �̸� :
	<%=test.getName()%></h2>
<h2>
	���� ��� :
	<%=test.getPath()%></h2>
<h2>
	���� ũ�� :
	<%=test.length()%>
	bytes
</h2>
<h2>
	���� ���翩�� :
	<%=test.exists()%></h2>
<h2>
	���� ���� :
	<%=mr.getContentType("file")%></h2>

<!-- ������ �����̶�� �ڹ� �ڵ�� �ۼ��� �������� ��ñ� �̿��Ͽ� 
���� �ٿ�ε带 �����ؾ� ������ a�±׸� �̿��ص� �����ϰ� ������ �����ϴ�.
(�������� �����ϰڴ�.) -->

<a href="<%=servicePath %>/fileupload/file/<%=test.getName()%>">�ٿ� �ε�</a>
<!-- ������� ������ ���� �ȴ�. -->





