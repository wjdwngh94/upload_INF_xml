<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!--  home.jsp : DBConnect의 send.jsp와 같은 역할을 수행하는 페이지 입니다. -->

<!-- top.jsp를 불러온다. -->
<%@ include file="../top.jsp"%>

<div align="center">

	<br>
	<h1>도서 등록 페이지</h1>
	<form action="insert_library.jsp" method="post">
		<table border="1" width="80%">
			<tr>
				<th colspan="2" width="30%">도서 등록</th>
			</tr>
			<tr>
				<th width="5%">지은이</th>
				<td><input type="text" name="writer">
			</tr>
			<tr>
				<th height="10%">도서명</th>
				<td><input type="text" name="name">
			</tr>
			<tr>
				<th height="10%">가격</th>
				<td><input type="text" name="price">
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="등록"> <input
					type="reset" value="취소"></th>
			</tr>
		</table>
	</form>

	<hr color="green">

	<h1>도서 목록 페이지</h1>
	
	<hr color="green">
	
	<table border="1">
		<tr>
			<th><a href="list_library.jsp"> <input type="submit" value="이동">
			</a></th>
		</tr>
	</table>

	<hr color="green">

	<h1>도서 삭제 페이지</h1>
	<form action="delete_library.jsp" method="post">
		<table border="1" width="90%">

			<tr>
				<th>도서명</th>
				<td><input type="text" name="name"></td>
				<th colspan="1"><input type="submit" value="삭제">
				</th>
			</tr>
			
		</table>
	</form>

	<hr color="green">

	<br>
	<h1>도서 검색 페이지</h1>
	<form action="find_library.jsp" method="post">
		<table border="1" width="90%">

			<tr>
				<td>검색어 입력 (도서명or지은이)</td>
				<td><input type="text" name="name"></td>
				<th colspan="1"><input type="submit" value="검색"></th>
			</tr>
		</table>
	</form>
	<br>
</div>
<!-- bottom.jsp를 불러온다. -->
<%@ include file="../bottom.jsp"%>






