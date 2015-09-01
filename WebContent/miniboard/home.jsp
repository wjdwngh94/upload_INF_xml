<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- home.jsp : DBConnect의 send.jsp와 같은 역할을 수행하는 페이지 -->
<%@ include file="../top.jsp"%>
<div align="center">
	<hr color="red" width="300">
	<h1>게시글 등록</h1>
	<hr color="red" width="300">
	<form action="insert.jsp" method="post">
		<table border="1">
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="writer">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" rows="7" cols="50"></textarea>
				</td>
			</tr>
			<tr>
				<th colspan="2'">
					<input type="submit" value="등록">
				</th>
			</tr>
		</table>
	</form>
	
	<br>
	<h1>게시글 목록보기</h1>
	<a href="list.jsp">리스트 페이지로 이동</a>
	
	<br>
	<h1>게시글 삭제하기</h1>
	<form action="delete.jsp" method="post">
		<!-- 작성자 일치삭제 -->
		<table border="1">
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="writer">
				</td>
			</tr>
			<tr>
				<th colspan="2'">
					<input type="submit" value="삭제">
				</th>
			</tr>
		</table>
	</form>
	
	<br>
	<h1>게시글 검색하기</h1>
	<form action="find.jsp" method="post">
		<!-- 검색어 입력받아 전송 -->
		<table border="1">
			<tr>
				<th>작성자+내용</th>
				<td>
					<input type="text" name="search">
				</td>
			</tr>
			<tr>
				<th colspan="2'">
					<input type="submit" value="검색">
				</th>
			</tr>
		</table>
	</form>	
</div>
<%@ include file="../bottom.jsp"%>