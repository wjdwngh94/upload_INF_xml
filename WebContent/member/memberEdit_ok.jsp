<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	request.setCharacterEncoding("euc-kr"); %>
<!-- MemberDTO 생성 -->
<jsp:useBean id="mbdto" class="my.member.MemberDTO"/>
<!-- 파라미터를 mbdto에 수신 -->
<jsp:setProperty name="mbdto" property="*"/>

<jsp:useBean id="mbdao" class="my.member.MemberDAO"/>

<%
	boolean result = mbdao.editMember(mbdto);
	if(result){%>
		<script type="text/javascript">
		alert("회원 정보 수정 성공");
		window.close();
		</script>
<%}else{%>
		<script type="text/javascript">
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);//history.back();
		</script>
<%}%>

















