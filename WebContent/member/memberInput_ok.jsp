<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- memberInput_ok.jsp -->
<%@ page import="my.member.*" %>
<!-- 데이터가 10만개면 10만줄 써서 받을거냐? 그럴리가... -->
<!-- jsp 액션태그를 활용하여 데이터를 자동으로 수신 -->
<%	request.setCharacterEncoding("euc-kr"); %>

<!-- MemberDTO 생성 -->
<jsp:useBean id="mbdto" class="my.member.MemberDTO"/>

<!-- request에서 전송되는 모든 데이터를 mbdto에서 수신 -->
<jsp:setProperty name="mbdto" property="*"/>

<%		
		//권한은 따로 설정
		mbdto.setPower("normal");//일반회원으로 설정

		//필요하다면 유효성 검사
		if(mbdto.getId() == null || mbdto.getId().trim().equals("")){
			response.sendRedirect("memberInput.jsp");
			return;
		}
		
		MemberDAO mbdao = new MemberDAO();
		boolean check = mbdao.checkMember(mbdto.getId()); 
		//true : 가입, false : 거절
		if(!check){//check == false%>
		<script type="text/javascript">
		alert("이미 사용중인 아이디입니다.");
		//location.href="memberInput.jsp";
		history.back();//뒤로 1페이지 이동
		</script>
<%		return;		
		}
		
		//가입 처리
		boolean result = mbdao.insertMember(mbdto); 
		if(result){%>
		<script type="text/javascript">
			alert("가입이 성공적으로 완료되었습니다\n로그인하세요");
			//부모창의 주소를 login 페이지로 변경
			window.opener.parent.location.href=
			"<%=request.getContextPath()%>/login/login.jsp";
			window.close();
		</script>
<%	}else{%>
		<script type="text/javascript">
			alert("가입 처리 과정에서 문제 발생...\n잠시 후 다시 시도");
			history.back();
		</script>
<%	}%>
 
 
 
 
 
 
 
 
 
 
 
 
 
 