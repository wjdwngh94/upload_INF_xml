<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!-- write.jsp : �� ���� ������ -->
<%@ include file="/top.jsp"%>
<script type="text/javascript">
	function formCheck() {
		//f��� �̸��� form�� �˻�(���δ�)
		if (!f.writer.value) {
			alert("�ۼ��ڸ� �Է��ϼ���");
			f.writer.focus();
			return false;//����
		} else if (!f.title.value) {
			alert("������ �Է��ϼ���");
			f.title.focus();
			return false;//����
		} else if (!f.content.value) {
			alert("������ �Է��ϼ���");
			f.content.focus();
			return false;//����
		} else if (!f.pw.value) {
			alert("��й�ȣ�� �Է��ϼ���");
			f.pw.focus();
			return false;//����
		}

		//return true;//������ ����Ѵ�(���� ����)
	}
</script>
<div align="center">
	<h1>�� �� ��</h1>
	<form name="f" action="writePro.jsp" method="post"
		onsubmit="return formCheck();" enctype="multipart/form-data">
		<!-- onsubmit : submit�� �����ϸ� �߻��Ǵ� �̺�Ʈ
			return formCheck() ��� ������ 
			formCheck() �� ��ȯ���� ���� �����ϰڴٴ� �� -->
		<table class="outline" width="650">
			<tr>
				<th class="m2" width="100">�ۼ���</th>
				<td class="m3"><input type="text" name="writer" maxlength="10"
					size="10" class="box"></td>
			</tr>
			<tr>
				<th class="m2" width="100">����</th>
				<td class="m3"><input type="text" name="title" maxlength="33"
					size="50" class="box"></td>
			</tr>
			<tr>
				<th class="m2" width="100">����</th>
				<td class="m3"><textarea name="content" class="box" rows="10"
						cols="55"></textarea></td>
			</tr>
			<tr>
				<!-- ���� �Է� �� �߰� -->
				<th class="m2">���� ����</th>
				<td class="m3"><input type="file" name="filename" class="box">
				</td>
				</th>
			</tr>
			<tr>
				<th class="m2" width="100">��й�ȣ</th>
				<td class="m3"><input type="password" name="pw" maxlength="15"
					size="15" class="box"></td>
			</tr>
			<tr>
				<th class="m2" colspan="2"><input type="submit" value="���">
					<input type="button" value="���" onclick="location.href='list.jsp';">
				</th>
			</tr>
		</table>
	</form>
</div>
<%@ include file="/bottom.jsp"%>



















