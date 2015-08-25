<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- Cookie확인 쿠키는 분별해서 가져오는것이아니라 모두를 가져온 후 비교해 선택한다.-->
<!-- 쿠키확인 -->
<%
	//	PC에서 읽을 수 있는 모든 종류의 쿠키를 가져온다.
	//	C# 등, 다른 방식의 쿠키는 읽을 수 없다.
	// request.getCookies(); - 모든 쿠키를 가져온다. 반환형태는 Cookie배열 혹은 Collection이다.
	Cookie[] ckList = request.getCookies();
%>
<h1>쿠키의 개수 : <%=ckList.length %></h1> <!-- 쿠키배열의 길이 : 쿠키의 갯수 -->
<%
//for(int i=0; i<ckList.length;++i){
	for(Cookie ck : ckList){ //확장 for문으로 위의 내용과 동일
	%>
	<h2>쿠키명 : <%=ck.getName() %>,
	쿠키값: <%=ck.getValue() %></h2>
	<%}
%>