<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="my.board.*, java.util.*"%>
<!-- content.jsp : �Խñ� ��ȣ�� ������ ������ �����ִ� ������ -->
<jsp:useBean id="bdao" class="my.board.BoardDAO" />
<%
	String tmp = request.getParameter("no");
	int no = 0;
	try{
		no = Integer.parseInt(tmp);
		if(no<=0) throw new Exception();
	}catch(Exception e){
		response.sendRedirect("list.jsp");
		return;
	}
	
	//�ƹ����� ��ȸ���� ������Ű�� �ȵǹǷ�...session�� �̿�
	//session�� readTable �̶�� �̸��� Set�� ����ְ�
	//������ Ȯ���Ͽ� ���� �������� �����ϰڴ�..
	
	//session���� readTable ��������.
	HashSet<Integer> readTable = 
		(HashSet<Integer>)session.getAttribute("readTable");
	
	//������ ���� �����.
	if(readTable==null){
		readTable = new HashSet<Integer>();
	}
	
	//readTable�� ���� �д� �� ��ȣ�� �ִ��� Ȯ��
	if(readTable.add(no)){//readTable.add(no) == true
		//ó�� �д� ���� ���, ��ȸ�� 1 ����
		bdao.plusCount(no);
		session.setAttribute("readTable", readTable);//����
	}
	
	//no�� �Խñ��� ��� ������ �ҷ��;� �Ѵ�.
	BoardDTO bdto = bdao.getBoard(no); 
	//null�� ��� ����
	if(bdto==null){
		response.sendRedirect("list.jsp");
		return;
	}
%>
<%@ include file="/top.jsp"%>
<script type="text/javascript">
	function sendReply(){
		//alert("���� ���� �غ����̿���");
		//replyForm�̶�� �̸��� ���� ����
		document.replyForm.submit();
	}
	function sendRec(){
		alert("��õ ����Դϴ�.");
	}
	function sendEdit(no){
		//alert("���� ����Դϴ�.");
		location.href="pw.jsp?no="+no+"&next=edit.jsp";
	}
	function sendDel(no){
		//alert("���� ����Դϴ�.");
		location.href="pw.jsp?no="+no+"&next=delete.jsp";
	}
</script>
<div align="center">
	<form name="replyForm" method="post" action="reply.jsp">
		<input type="hidden" name="no" value="<%=no%>"> <input
			type="hidden" name="title" value="<%=bdto.getTitle()%>"> <input
			type="hidden" name="ref" value="<%=bdto.getRef()%>"> <input
			type="hidden" name="re_step" value="<%=bdto.getRe_step()%>">
		<input type="hidden" name="re_level" value="<%=bdto.getRe_level()%>">
	</form>
	<h1>�� �� ��</h1>
	<table class="outline" width="650">
		<tr>
			<th class="m2" width="20%">��ȣ</th>
			<td class="m3" width="30%"><%=no%></td>
			<th class="m2" width="20%">��ȸ��</th>
			<th class="m3"><%=bdto.getReadcount()%></th>
		</tr>
		<tr>
			<th class="m2">�ۼ���</th>
			<td class="m3"><%=bdto.getWriter()%></td>
			<th class="m2">��õ��</th>
			<th class="m3"><%=bdto.getRecommand()%></th>
		</tr>
		<tr>
			<th class="m2">����</th>
			<td class="m3" colspan="3"><%=bdto.getTitle()%></td>
		</tr>
		<tr height="200">
			<th class="m2">����</th>
			<td class="m3" colspan="3" valign="top"
				style="word-break: break-all;">
				<!-- �ٰ��� �Ӽ� --> <%=bdto.getContent()%>
			</td>
		</tr>
		<!-- 줄자체에 조건을 걸던가 내용만 조건을 걸던가 -->
		<!-- 첨부파일이 있는 경우에만 첨부파일 줄 표시를 한다. -->
		<%
			if (bdto.getFilesize() > 0) {
		%>
		<tr>
			<th class="m2">첨부 파일</th>
			<td class="m3" colspan="3">
				<%
					String path = request.getContextPath() + "/board/file";
				String fullPath = path+"/"+bdto.getFilename();
				double filesize = bdto.getFilesize()/Math.pow(1024,2);
				DecimalFormat df = new DecimalFormat("#.##");
				%> <a href="<%=fullPath%>">다운로드</a>, 
				<h4>이름 : <%=bdto.getFilename()%></h4>
				<h4>크기 : <%=df.format(filesize)%>MB</h4>
				<!--  byte로 출력된다. -->
			</td>

		</tr>
		<%
			}
		%>
		<tr>
			<th class="m2" colspan="4"><input type="button" value="�۾���"
				onclick="location.href='write.jsp';"> <input type="button"
				value="��۾���" onclick="sendReply();"> <input type="button"
				value="��õ�ϱ�" onclick="sendRec();"> <input type="button"
				value="����" onclick="sendEdit(<%=no%>);"> <input
				type="button" value="����" onclick="sendDel(<%=no%>);"> <input
				type="button" value="���" onclick="location.href='list.jsp';">
			</th>
		</tr>
	</table>
</div>
<%@ include file="/bottom.jsp"%>

















