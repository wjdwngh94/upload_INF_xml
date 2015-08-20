<%@page import="my.member.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- 데이터가 10만개면 10만줄 써서 받을 꺼냐?? -->
<!-- jsp 액션 테그를 활용하여 테이터를 자동으로 수신 -->
<!-- jsp액션 테그 : jsp란 이름으로 시작하는 태그 -->
<!-- 
	1.jsp : useBean - 객체 생성 테그이다.
		(사용 예) 
		<jsp : useBean id="객체명" class="클래스 경로" scope="생성지역"/>
		id : 사용할 객체의 이름을 내마음대로 지정
		class : 객체 생성할 클래스 경로를 다 적는다.(생략적기 없다) - import불필요
		scope : 객체를 생성할 지역(범위)
		
		(주의 사항) 객체 생성시 해당 클래스의 기본 생성자를 호출하여 객체를 생성한다.
		기본생성자가 없는 클래스는 useBean 을 사용할 수 없다.
		(장점) scope 설정가능, setProperty 이용 가능
		
	2. jsp : setProperty - 데이터 설정 태그 이다.
		(사용 예)
		<jsp : setProperty name = "객체명" property="항목" value="값"/>
		name : 이미 만들어진 객체의 이름 
		property : 설정할 항목 이름, 다 집어넣을 거면 *
		value : 설정할 데이터 / 적지않으면 request에서 찾아 설정하낟.
		
		(장점)
		-아무리 많아도 항목만 있으면 다 알아서 집어넣는다.
		-int형태의 경우 int로 자동 변환해 준다.
		
		(주의 사항) 만약 name="mbdto" property="id"라면 반드시 mbdto안에 setId()가 존재해야 한다.
				-그래서 getter setter를 자동으로 만들어 주는것이 좋다.
				
	3. jsp : getProperty - 데이터 확인 태그 이다.
	-->

<%
	MemberDAO dao = new MemberDAO();
%>
<!-- MemberDTO create -->
<jsp:useBean id="mbdto" class="my.member.MemberDTO" />

<!-- request에서 전송되는 모든 데이터를 mbdto에서 수신한다. -->

<jsp:setProperty name="mbdto" property="*" />

<%
	//데이터 수신
	request.setCharacterEncoding("euc-kr");

	//MemberDTO 생성후에 포장하여 처리
	MemberDTO mbdto = new MemberDTO();

	mbdto.setName(request.getParameter("name"));
	mbdto.setId(request.getParameter("id"));
	mbdto.setGender(request.getParameter("gender"));
	mbdto.setBirth(request.getParameter("birth"));
	mbdto.setPw(request.getParameter("pw"));
	mbdto.setPost(request.getParameter("post"));
	mbdto.setAddr1(request.getParameter("addr1"));
	mbdto.setAddr2(request.getParameter("addr2"));
	mbdto.setPower("normal");

	if (mbdto.getId() == null || mbdto.getId().trim().equals("")) {
		response.sendRedirect("memberInput.jsp");
		return;
	}
	boolean check = dao.find(mbdto.getId());
	if (!check) {
%>

<script type="text/javascript">
	alert("이미 사용중인 아이디 입니다.");
	history.back(); //뒤로 1페이지 이동 response.sendRedirect(); 와 동일
</script>
<%
	return;
	} else {
		//가입처리 한다.
		boolean result = mbdto.insertMember(mbdto);
		if (result) {
%>
<script type="text/javascript">
	alert("가입 성공");
	//부모창의 주소를 login 페이지로 변경
	window.opener.parent.location.href="<%=request.getContextPath()%>
	/ login / login.jsp";
	//부모창(나를 열은 놈)의 주소를 변경
	window.close();
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("게시글 입력 실패...");
	history.back();
</script>
<%
	}
	}
%>

