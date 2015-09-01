<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- test1.jsp : 쿠키 생성 페이지 -->
<%
	//[1] Cookie 클래스 객체 생성
	//Cookie 쿠키명 = new Cookie("이름표", "데이터");
	Cookie ck = new Cookie("userId", "admin");//String,String

	//[2] 유효 수명 설정(초단위)
	ck.setMaxAge(1*24*60*60);//1일
	//ck.setMaxAge(0);//쿠키 삭제
	
	//[3] 파일로 내보내기 - response 이용
	response.addCookie(ck);	
%>












