<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- memberDelete.jsp : no 전송받아서 해당하는 회원을 삭제 -->
<jsp:useBean id="mbdao" class="my.member.MemberDAO"/>
<%
	String tmp = request.getParameter("no");
	int no = 0;
	try{
		no = Integer.parseInt(tmp);//NumberFormatException
		if(no<=0) throw new Exception();//강제 예외 처리
	}catch(Exception e){
		//오류 발생시(tmp가 숫자로 바뀔 수 없는 경우)
		response.sendRedirect("memberList.jsp");
		return;
	}
	boolean result = mbdao.deleteMember(no);
	String msg="";
	if(result){
		msg="탈퇴처리가 성공적으로 완료되었습니다.";
	}else{
		msg="탈퇴처리 중 오류가 발생하였습니다.";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="memberList.jsp";
</script>













