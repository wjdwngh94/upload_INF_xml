<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- ��Ű Ȯ�� -->
<%
	//PC���� ���� �� �ִ� ��� ������ ��Ű�� �����´�. - request
	Cookie[] ckList = request.getCookies();
%>
<h1>��Ű�� ���� : <%=ckList.length%></h1>
<%
		//for(int i=0; i<ckList.length; ++i){
		for(Cookie ck : ckList){%>
			<h2>��Ű�� : <%=ck.getName()%>, 
					��Ű�� : <%=ck.getValue()%></h2>
<%	}%>









