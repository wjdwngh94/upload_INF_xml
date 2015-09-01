<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 쿠키 확인 -->
<%
	//PC에서 읽을 수 있는 모든 종류의 쿠키를 가져온다. - request
	Cookie[] ckList = request.getCookies();
%>
<h1>쿠키의 개수 : <%=ckList.length%></h1>
<%
		//for(int i=0; i<ckList.length; ++i){
		for(Cookie ck : ckList){%>
			<h2>쿠키명 : <%=ck.getName()%>, 
					쿠키값 : <%=ck.getValue()%></h2>
<%	}%>









