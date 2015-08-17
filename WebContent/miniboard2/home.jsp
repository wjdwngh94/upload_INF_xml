<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!--  home.jsp : DBConnect의 send.jsp와 같은 역할을 수행하는 페이지 입니다. -->

<!-- top.jsp를 불러온다. -->
<%@ include file="../top.jsp"%>

<div align="center">
	
	<br>
	<h1>게시글 등록</h1>
	<form action="insert.jsp" method="post">
		<table border="1" width="90%">
			<tr>
				<th colspan="2" width="30%">게시글 등록</th>
			</tr>
			<tr>
				<th width="5%">작성자</th>
				<td><input type="text" name="name">
			</tr>
			<tr>
				<th height="10%">내용</th>
				<td><textarea name="text" rows="5"></textarea></td>
				
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="입력"> <input
					type="reset" value="취소"></th>
			</tr>
		</table>
	</form>

<hr color ="black">

	<br>
	<h1>게시글 목록 
	<a href="list.jsp">
	<input type="submit" value="이동">
	</a></h1> <br>

<hr color ="black">

	<h1>게시글 삭제</h1>
	<form action="delete.jsp" method="post">
		<table border="1" width="90%">
			
			<tr>
				<th>작성자</th>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th colspan="1"><input type="submit" value="입력"> <input
					type="reset" value="취소"></th>
			</tr>
		</table>
	</form>

<hr color ="black">

	<br>
	<h1>게시글 검색</h1>
	<form action="find.jsp" method="post">
		<table border="1" width="90%">
		
			<tr>
				<th>작성자</th>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th colspan="1"><input type="submit" value="입력"> <input
					type="reset" value="취소"></th>
			</tr>
		</table>
	</form>
	<br>
</div>
<!-- bottom.jsp를 불러온다. -->
<%@ include file="../bottom.jsp"%>






