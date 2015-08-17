<%@page import="java.util.ArrayList"%>
<%@page import="my.miniboard.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- list.jsp : 목록 페이지 -->
<%
	//DAO 생성 후 DB 명단으 ㄹ전부다 가져오라고 지시한다.
	MiniDAO dao = new MiniDAO();
	//resultSet로 저장하면 데이터가 몇개인지 알수가 없다.
	ArrayList<MiniDTO> list = dao.list(); //게시글이 들어있는 ArrayList

	//list에 들어가 있는 데이터 화면에 출력
%>