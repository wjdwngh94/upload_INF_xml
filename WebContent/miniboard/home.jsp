<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!--  home.jsp : DBConnect의 send.jsp와 같은 역할을 수행하는 페이지 입니다. -->

<!-- top.jsp를 불러온다. -->
<%@ include file="../top.jsp"%>

	<h1>게시글 등록</h1>
	<form action="insert.jsp" method="post">
		<table border="1">
			<tr>
				<th colspan ="1" width = "30%">게시글 등록</th>
			</tr>
			<tr>
				<th>작성자</th>
				<td> <input type="text" name="name"> </td>
			</tr>
			<tr>
				<th>내용</th>
				<td> <input type="text" name="text"> </td>
			</tr>
			<tr>
				<th colspan ="1">
				<input type="submit" value="입력">
				  <input type = "reset" value = "취소">
				</th>
			</tr>
		</table>
	</form>
	
	<br>
	<h1>게시글 목록</h1>
	<a href="list.jsp"><input type="submit" value="이동"></a>
	
	<br>
	<h1>게시글 삭제</h1>
	<form action="delete.jsp" method="post">
		<table border="1">
			<tr>
				<th colspan ="1" width = "30%">게시글 삭제</th>
			</tr>
			<tr>
				<th>작성자</th>
				<td> <input type="text" name="name"> </td>
			</tr>
			<tr>
				<th colspan ="1">
				<input type="submit" value="입력">
				  <input type = "reset" value = "취소">
				</th>
			</tr>
		</table>
	</form>
	
	<br>
	<h1>게시글 검색</h1>
	<form action="find.jsp" method="post">
		<table border="1">
			<tr>
				<th colspan ="1" width = "30%">게시글 검색</th>
			</tr>
			<tr>
				<th>작성자</th>
				<td> <input type="text" name="name"> </td>
			</tr>
			<tr>
				<th colspan ="1">
				<input type="submit" value="입력">
				  <input type = "reset" value = "취소">
				</th>
			</tr>
		</table>
	</form>
	
<!-- bottom.jsp를 불러온다. -->
<%@ include file="../bottom.jsp"%>






