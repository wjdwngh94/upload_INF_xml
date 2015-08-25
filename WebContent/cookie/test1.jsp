<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- test1.jsp : cookie생성 페이지 -->
<%
	//[1]Cookie 클래스 객체 생성(파일은 생성되지 않고 정보만 만든다.)
	//[2]유효 수명 설정(Session은 하나기 때문에 일괄이지만 cookie는 개개마다 설정가능)
	//[3]파일로 내보내기(파일이 생성된다.)

	//[1]Cookie 클래스 객체 생성
	//Cookie 쿠키명 = new Cookie("이름표", "데이터");
	Cookie ck = new Cookie("userId", "admin"); //String, String 만 입력 가능

	//[2]Cookie 의 유효수명을 초단위로 설정한다.
	ck.setMaxAge(1 * 24 * 60 * 60);//1일 (초단위)
	//ck.setMaxAge(0); 은 쿠키를 만들지 않겠다, 즉 삭제 명력이다(session.removeAttribute와 동일)

	//[3]파일로 내보내기 - response를 이용한다.
	response.addCookie(ck); //이페이지를 실행시킬 때 알아서 cookie를 만들어 준다.
%>