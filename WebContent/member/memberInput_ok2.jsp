<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- memberInput_ok.jsp -->
<!-- 
	memberInput.jsp에서 넘어온 데이터를 가지고(8개)
	
	=========MemberDAO가 수행하는 작업=========
	1.아이디 중복 검사 수행
	
	2.회원 가입 처리(권한의 경우 무조건 normal로 설정)
	
	===================================
	
	처리 결과를 사용자에게 알려준 뒤
	1. 가입이 되었다면 창 닫기
	2. 가입이 거절되었다면 정보 입력 페이지로 되돌아가기	
 -->
 <%@ page import="my.member.*" %>
<%
		//데이터 수신
		request.setCharacterEncoding("euc-kr");
		
		//MemberDTO 생성 후에 포장하여 처리
		MemberDTO mbdto = new MemberDTO();
		mbdto.setName(request.getParameter("name"));
		mbdto.setId(request.getParameter("id"));
		mbdto.setPw(request.getParameter("pw"));
		mbdto.setBirth(request.getParameter("birth"));
		mbdto.setGender(request.getParameter("gender"));
		mbdto.setPost(request.getParameter("post"));
		mbdto.setAddr1(request.getParameter("addr1"));
		mbdto.setAddr2(request.getParameter("addr2"));
		mbdto.setPower("normal");
		
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
			window.close();
		</script>
<%	}else{%>
		<script type="text/javascript">
			alert("가입 처리 과정에서 문제 발생...\n잠시 후 다시 시도");
			history.back();
		</script>
<%	}%>
 
 
 
 
 
 
 
 
 
 
 
 
 
 