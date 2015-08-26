<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 
	login_ok.jsp : 로그인을 실제로 처리하는 페이지
	
	전송되어진 아이디와 비밀번호로 로그인 처리를 수행하세요
	1. 로그인 성공 : 아이디와 비밀번호 모두 일치하는 경우
		- 로그인 처리 후 index.jsp로 이동
	2. 로그인 실패 : 
		- 정보 오류 : 아이디 또는 비밀번호 중 하나가 오류인 경우
		- 서버 오류 : SQLException이 발생한 경우
		- login.jsp로 이동
	처리는 MemberDAO를 이용하세요
 -->
 <%@ page import="my.member.*" %>
<!-- ConnectionPoolBean을 application 영역에 생성 -->
<jsp:useBean id="pool" class="my.db.ConnectionPoolBean" 
													scope="application"/>
<!-- mbdao라는 고객을 생성 -->													
<jsp:useBean id="mbdao" class="my.member.MemberDAO"/>
<!-- pool의 정보를 mbdao에게 주입 -->
<jsp:setProperty name="mbdao" property="pool"
												value="<%=pool%>"/>
 <%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String saveId = request.getParameter("saveId");//on | null
	if(id==null||id.trim().equals("")||
						pw==null||pw.trim().equals("")){
		response.sendRedirect("login.jsp");
		return;
	}
	
	//1 : 성공, 2 : 정보오류 , 3 : 서버오류
	int result = mbdao.login(id, pw); 
	String msg="", url="";
	if(result==MemberDAO.OK){//로그인 성공, index.jsp로 이동
		msg = id+"님 환영합니다.";
		//url = "../index.jsp";
		url = request.getContextPath()+"/index.jsp";
		
		//실제 로그인 통과 처리 수행
		session.setAttribute("login", "ok");
		session.setAttribute("userId", id);
		
		Cookie ck = new Cookie("saveId", id);
		if(saveId!=null){//아이디 저장하기가 체크되어 있으면
			ck.setMaxAge(1*24*60*60);
		}else{
			ck.setMaxAge(0);
		}
		response.addCookie(ck);
	}else if(result==MemberDAO.NOK){//정보 오류, login.jsp로 이동
		msg = "입력하신 정보가 잘못되었습니다.";
		url = "login.jsp";
	}else if(result==MemberDAO.ERROR){//서버 오류, login.jsp로 이동
		msg = "처리 과정에서 오류가 생겼습니다.";
		url = "login.jsp";
	}
 %>
 <script type="text/javascript">
 	alert("<%=msg%>");
 	location.href="<%=url%>";
 </script>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 