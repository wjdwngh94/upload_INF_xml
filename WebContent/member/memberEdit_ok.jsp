<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!-- MemberDTO 생성 -->
<jsp:useBean id="mbdto" class="my.member.MemberDTO" />
<!-- 파라미터를 mbdto에 수신 -->
<jsp:setProperty name="mbdto" property="*" />
<jsp:useBean id="mbdao" class="my.member.MemberDAO" />

<%
	boolean result = mbdao.editMember(mbdto); // mbdao에서 만든다.
	//false를 반환 할때는 비밀번호 오류일 확률이 높으므로...
	if (result) {
%>
<script type="text/javascript">
	alert("회원 정보 수정 성공");
	window.close();
</script>
<%
	} else {
%>

<script type="text/javascript">
	alert("비밀번호가 일치하지 않습니다.");
	history.go(-1);//한페이지 뒤로 가라는 뜻으로 history.back();과 동일하다.
</script>
<%
	}
%>