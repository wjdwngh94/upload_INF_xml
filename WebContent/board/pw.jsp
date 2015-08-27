<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- pw.jsp : 비밀번호 입력 페이지 -->
<%
	//번호 받고
	String tmp = request.getParameter("no");
	int no = 0;
	//다음 페이지 주소
	String next = request.getParameter("next");
	try{
		no = Integer.parseInt(tmp);
		if(no<=0) throw new Exception();
		if(next==null||next.trim().equals(""))
				throw new Exception();
	}catch(Exception e){
		response.sendRedirect("list.jsp");
		return;
	}
%>
<%@ include file= "/top.jsp"%>
<script type="text/javascript">
	function checkForm(){
		if(!f.pw.value){
			alert("비밀번호 입력");
			f.pw.focus();
			return;
		}
		document.f.submit();//전송
	}
</script>
<div align="center">
	<h2>비밀번호 입력</h2>
	<form name="f" action="pwPro.jsp" method="post">
	
	<!-- 이전 페이지에서 전송된 데이터들도 hidden으로 첨부 -->
	<input type="hidden" name="no" value="<%=no%>">
	<input type="hidden" name="next" value="<%=next%>">
	
	<table class="outline" width="300">
		<tr>
			<th class="m3">
			<input type="password" name="pw" class="box">
			<input type="button" value="확인"
				onclick="checkForm();">
			</th>
		</tr>
	</table>
	</form>
</div>
<%@ include file="/bottom.jsp" %>










