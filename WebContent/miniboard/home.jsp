<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- home.jsp : DBConnect�� send.jsp�� ���� ������ �����ϴ� ������ -->
<%@ include file="../top.jsp"%>
<div align="center">
	<hr color="red" width="300">
	<h1>�Խñ� ���</h1>
	<hr color="red" width="300">
	<form action="insert.jsp" method="post">
		<table border="1">
			<tr>
				<th>�ۼ���</th>
				<td>
					<input type="text" name="writer">
				</td>
			</tr>
			<tr>
				<th>����</th>
				<td>
					<textarea name="content" rows="7" cols="50"></textarea>
				</td>
			</tr>
			<tr>
				<th colspan="2'">
					<input type="submit" value="���">
				</th>
			</tr>
		</table>
	</form>
	
	<br>
	<h1>�Խñ� ��Ϻ���</h1>
	<a href="list.jsp">����Ʈ �������� �̵�</a>
	
	<br>
	<h1>�Խñ� �����ϱ�</h1>
	<form action="delete.jsp" method="post">
		<!-- �ۼ��� ��ġ���� -->
		<table border="1">
			<tr>
				<th>�̸�</th>
				<td>
					<input type="text" name="writer">
				</td>
			</tr>
			<tr>
				<th colspan="2'">
					<input type="submit" value="����">
				</th>
			</tr>
		</table>
	</form>
	
	<br>
	<h1>�Խñ� �˻��ϱ�</h1>
	<form action="find.jsp" method="post">
		<!-- �˻��� �Է¹޾� ���� -->
		<table border="1">
			<tr>
				<th>�ۼ���+����</th>
				<td>
					<input type="text" name="search">
				</td>
			</tr>
			<tr>
				<th colspan="2'">
					<input type="submit" value="�˻�">
				</th>
			</tr>
		</table>
	</form>	
</div>
<%@ include file="../bottom.jsp"%>