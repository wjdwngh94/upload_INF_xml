<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="java.io.*"%>
<!-- receive.jsp : send.jsp에서 보내는 정보 받기 -->
<%
	request.setCharacterEncoding("euc-kr");
	String uploader = request.getParameter("uploader");
	String file = request.getParameter("file");
%>
<h1>기존 방식으로는 전송된 값을 받을 수 없다.</h1>
<h1>
	uploader :
	<%=uploader%></h1>
<h1>
	file :
	<%=file%></h1>

<%
	//com.oreilly.servlet.MultipartRequest를 이용한 새로운 방식
	//객체 생성시 필요한 정보
	//[1] 데이터 추출 대상 : 					request
	//[2] 어디에 저장? 물리경로
	//[3] 얼만큼 저장? 허용 용량(byte)	10*1024*1024
	//[4] 어떻게 저장? 적용 글꼴			euc-kr
	//[5] 작명 정책... 이름이 겹치면?		1~4번까지만 할 경우 생략

	//서비스경로 : WebContent 내에 존재하는 공개된 공간
	String servicePath = request.getContextPath();
%>
<h2>
	서비스 경로 :
	<%=servicePath%>/fileupload/file
</h2>
<br>
<br>
<%
	//물리경로 : 서비스경로의 내용이 실제로 존재하는 하드디스크 공간
	String upPath = config.getServletContext().getRealPath(
			"/fileupload/file");
%>
<h2>
	물리 경로 :
	<%=upPath%></h2>

<%
	//	Multipartr Request객체 생성- import com.oreilly.servlet
	MultipartRequest mr = null;
	//작명 정책 객체 생성 - import com.oreilly.servlet.multipart
	DefaultFileRenamePolicy dp = null;
	try {
		dp = new DefaultFileRenamePolicy();
		mr = new MultipartRequest(request, upPath, 10 * 1024 * 1024,
				"euc-kr", dp);
	} catch (IOException e) {
		System.out.println("mr객체 오류");
	}
%>

<h1>mr의 정보 추출</h1>
<h2>
	uploader :
	<%=mr.getParameter("uploader")%></h2>
<!-- 파일 관련된 항목들은 별도의 메소드를 이용하여야 한다. -->
<h2>
	file :
	<%=mr.getFilesystemName("file")%></h2>
<%
	//파일 추출 후 정보 출력
	File test = mr.getFile("file");
%>
<h2>파일 분석</h2>
<h2>
	파일 이름 :
	<%=test.getName()%></h2>
<h2>
	파일 경로 :
	<%=test.getPath()%></h2>
<h2>
	파일 크기 :
	<%=test.length()%>
	bytes
</h2>
<h2>
	파일 존재여부 :
	<%=test.exists()%></h2>
<h2>
	파일 유형 :
	<%=mr.getContentType("file")%></h2>

<!-- 원래는 서블릿이라는 자바 코드로 작성된 웹페이지 양시글 이용하여 
파일 다운로드를 진행해야 하지만 a태그를 이용해도 간단하게 구현은 가능하다.
(브라우저에 의존하겠다.) -->

<a href="<%=servicePath %>/fileupload/file/<%=test.getName()%>">다운 로드</a>
<!-- 물리경로 적으면 나만 된다. -->





