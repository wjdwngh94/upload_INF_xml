<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, my.board.*" %>
<!-- list.jsp : �Խñ� ��� ������ -->
<%@ include file="/top.jsp"%>
<jsp:useBean id="bdao" class="my.board.BoardDAO"/>
<!-- javascript�� �̿��� �˻� ������ ���� ���� -->
<!-- ������ ����ϴ� �ּ� ���� : list.jsp?page=5 -->
<!-- ���Ŀ� ���Ǵ� �ּ� ���� : list.jsp?page=5&search=writer&searchString=aaa -->
<script type="text/javascript">
	function movePage(pageNo){
		//searchForm�� �ִ� hidden�±׿� �� ����
		searchForm.page.value = pageNo;
		document.searchForm.submit();
	}
</script>
<div align="center">
<%
	//������ ó�� �ڵ�
	int pageSize = 5;//���������� 5���� �����ְڴ�.
	
	//�Ķ���� ����(������ ��ȣ)
	String pageNo = request.getParameter("page");
	
	//�˻��� ����
	request.setCharacterEncoding("euc-kr");
	String search = request.getParameter("search");
	String searchString = request.getParameter("searchString");
	
	int curPage = 0;
	try{
		curPage = Integer.parseInt(pageNo);			//����
		if(curPage<=0) throw new Exception();	//0����
	}catch(Exception e){
		curPage = 1;//1page�� �������� ó��
	}
	
	//���� ���� = ������ũ�� * ���������� - (������ũ��-1)
	int startRow = pageSize * curPage - (pageSize - 1);
			
	//���� ���� = ���� ���� + ������ũ�� - 1;
	int endRow = startRow + pageSize - 1;
	
	//���� ������ �Խñ� ������ ���� �� ����
	int count = 0;
	if(search!=null&&searchString!=null
					&&!searchString.trim().equals("")){
		count = bdao.getBoardCount(search, searchString);
	}else{  
		count = bdao.getBoardCount();
	}
	if(endRow > count) endRow = count;
%>
<h3>curPage : <%=curPage%>,
		startRow : <%=startRow%>,
		endRow : <%=endRow%>,
		count : <%=count%></h3>

<%
	//��� ����
	ArrayList<BoardDTO> list;
	if(search!=null&&searchString!=null
					&&!searchString.trim().equals("")){
		//list = bdao.searchBoard(search, searchString);//�˻�
		list = bdao.searchBoard(search, searchString, startRow, endRow);
	}else{ 
		//list = bdao.listBoard();//���
		list = bdao.listBoard(startRow, endRow);
	}
%> 
<h2>search : <%=search%>, 
					searchString : <%=searchString%></h2>
<!-- �۾��� ��ư -->
<table width="700">
	<tr><td align="right">
	<input type="button" value="�۾���"
							onclick="location.href='write.jsp'">
	</td></tr>
</table>
<!-- ��� ��� -->
<table class="outline" width="700">
	<!-- ������ -->
	<tr>
		<th class="m2">��ȣ</th>
		<th class="m2">����</th>
		<th class="m2">�ۼ���</th>
		<th class="m2">�ۼ���</th>
		<th class="m2">��ȸ��</th>
		<th class="m2">��õ��</th>
	</tr>
	<!-- ������ -->
	<%for(BoardDTO bdto : list){ %>
	<tr align="center">
		<td class="m3"><%=bdto.getNo()%></td>
		<td class="m3" align="left" width="40%">
		<%if(bdto.getRe_level()>0){//����̶�� %>
		<!-- ���� : &nbsp; �Ǵ� �̹��� -->
		<img src="../img/level.gif" 
		width="<%=15*bdto.getRe_level()%>" height="15">	
		<img src="../img/re.gif" width="35" height="15"> 
		<%} %>
		<a href="content.jsp?no=<%=bdto.getNo()%>">
			<%=bdto.getTitle()%>
		</a>
		<!-- ÷������ ǥ�� -->
		<%
		if(bdto.getFilesize()>0){ // ������ ������%> 
		<img src="../img/folder.gif" width = "20" height ="15">
		<%
		}%>
		<!-- �α�� -->
		<%if(bdto.getReadcount()>=1){ %>
		<img src="../img/hot.gif" width="40" height="15">
		<%} %>
		</td>
		<td class="m3"><%=bdto.getWriter()%></td>
		<td class="m3"><%=bdto.getTime()%></td> 
		<td class="m3"><%=bdto.getReadcount()%></td>
		<td class="m3"><%=bdto.getRecommand()%></td>
	</tr>
	<%} %>
</table>
<br>
<%
	//�׺������ ����
	int pageBlock = 5;//���������� 5���� ��ũ�� ���
	int pageCount = //�� ������ ��
			count/pageSize+(count%pageSize==0?0:1);
	
	//���� �� = 1~5 -> 1, 6~10 -> 6
	int startBlock = (curPage-1) / pageBlock * pageBlock + 1;
	int endBlock = startBlock + pageBlock - 1;
	if(endBlock>pageCount) endBlock = pageCount;
%>
<h2>pageCount : <%=pageCount%>,
		startBlock : <%=startBlock%>,
		endBlock : <%=endBlock%></h2>
<%
		//���� ���
		if(startBlock>pageBlock){%>
		<a href="javascript:movePage(<%=startBlock-1%>)">[����]</a>
<%	}

	//��ȣ ��� ( startBlock ���� endBlock ���� )
	for(int i=startBlock; i<=endBlock; ++i){%>
	<%if(curPage==i){ %>
		<font size="5" color="black"><%=i%></font>	
	<%}else{ %>
		<a href="javascript:movePage(<%=i%>)"><%=i%></a>
	<%} %>
<%}
	
		//���� ���
		if(pageCount>endBlock){%>
		<a href="javascript:movePage(<%=startBlock+pageBlock%>)">[����]</a>	
<%	}%>
<br><br>
<!-- �˻�â -->
<form name="searchForm" method="post">
	<!-- ������ ������ ���� hidden �±� �߰� -->
	<input type="hidden" name="page">
	<select name="search" class="box">
		<option value="title" 
		<%if(search!=null&&search.equals("title")){%>
		selected<%}%>>����
		<option value="writer"
		<%if(search!=null&&search.equals("writer")){%>
		selected<%}%>>�ۼ���
	</select>
	<input type="text" class="box" name="searchString"
		value="<%=searchString==null?"":searchString%>">
	<input type="submit" value="�˻�"> 
</form>
</div>
<%@ include file="/bottom.jsp"%>

	











