<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, my.board.*" %>
<!-- list.jsp : 게시글 목록 페이지 -->
<%@ include file="/top.jsp"%>
<jsp:useBean id="bdao" class="my.board.BoardDAO"/>
<!-- javascript를 이용한 검색 페이지 유지 설정 -->
<!-- 기존에 사용하던 주소 형태 : list.jsp?page=5 -->
<!-- 향후에 사용되는 주소 형태 : list.jsp?page=5&search=writer&searchString=aaa -->
<script type="text/javascript">
	function movePage(pageNo){
		//searchForm에 있는 hidden태그에 값 설정
		searchForm.page.value = pageNo;
		document.searchForm.submit();
	}
</script>
<div align="center">
<%
	//페이지 처리 코드
	int pageSize = 5;//한페이지당 5개씩 보여주겠다.
	
	//파라미터 수신(페이지 번호)
	String pageNo = request.getParameter("page");
	
	//검색어 수신
	request.setCharacterEncoding("euc-kr");
	String search = request.getParameter("search");
	String searchString = request.getParameter("searchString");
	
	int curPage = 0;
	try{
		curPage = Integer.parseInt(pageNo);			//문자
		if(curPage<=0) throw new Exception();	//0이하
	}catch(Exception e){
		curPage = 1;//1page가 나오도록 처리
	}
	
	//시작 순서 = 페이지크기 * 현재페이지 - (페이지크기-1)
	int startRow = pageSize * curPage - (pageSize - 1);
			
	//종료 순서 = 시작 순서 + 페이지크기 - 1;
	int endRow = startRow + pageSize - 1;
	
	//종료 순서는 게시글 수보다 많을 수 없다
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
	//모드 판정
	ArrayList<BoardDTO> list;
	if(search!=null&&searchString!=null
					&&!searchString.trim().equals("")){
		//list = bdao.searchBoard(search, searchString);//검색
		list = bdao.searchBoard(search, searchString, startRow, endRow);
	}else{ 
		//list = bdao.listBoard();//목록
		list = bdao.listBoard(startRow, endRow);
	}
%> 
<h2>search : <%=search%>, 
					searchString : <%=searchString%></h2>
<!-- 글쓰기 버튼 -->
<table width="700">
	<tr><td align="right">
	<input type="button" value="글쓰기"
							onclick="location.href='write.jsp'">
	</td></tr>
</table>
<!-- 목록 출력 -->
<table class="outline" width="700">
	<!-- 제목줄 -->
	<tr>
		<th class="m2">번호</th>
		<th class="m2">제목</th>
		<th class="m2">작성자</th>
		<th class="m2">작성일</th>
		<th class="m2">조회수</th>
		<th class="m2">추천수</th>
	</tr>
	<!-- 내용줄 -->
	<%for(BoardDTO bdto : list){ %>
	<tr align="center">
		<td class="m3"><%=bdto.getNo()%></td>
		<td class="m3" align="left" width="40%">
		<%if(bdto.getRe_level()>0){//답글이라면 %>
		<!-- 띄어쓰기 : &nbsp; 또는 이미지 -->
		<img src="../img/level.gif" 
		width="<%=15*bdto.getRe_level()%>" height="15">	
		<img src="../img/re.gif" width="35" height="15"> 
		<%} %>
		<a href="content.jsp?no=<%=bdto.getNo()%>">
			<%=bdto.getTitle()%>
		</a>
		<!-- 첨부파일 표시 -->
		<%
		if(bdto.getFilesize()>0){ // 파일이 있으면%> 
		<img src="../img/folder.gif" width = "20" height ="15">
		<%
		}%>
		<!-- 인기글 -->
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
	//네비게이터 구현
	int pageBlock = 5;//한페이지에 5개의 링크를 출력
	int pageCount = //총 페이지 수
			count/pageSize+(count%pageSize==0?0:1);
	
	//시작 블럭 = 1~5 -> 1, 6~10 -> 6
	int startBlock = (curPage-1) / pageBlock * pageBlock + 1;
	int endBlock = startBlock + pageBlock - 1;
	if(endBlock>pageCount) endBlock = pageCount;
%>
<h2>pageCount : <%=pageCount%>,
		startBlock : <%=startBlock%>,
		endBlock : <%=endBlock%></h2>
<%
		//이전 출력
		if(startBlock>pageBlock){%>
		<a href="javascript:movePage(<%=startBlock-1%>)">[이전]</a>
<%	}

	//번호 출력 ( startBlock 부터 endBlock 까지 )
	for(int i=startBlock; i<=endBlock; ++i){%>
	<%if(curPage==i){ %>
		<font size="5" color="black"><%=i%></font>	
	<%}else{ %>
		<a href="javascript:movePage(<%=i%>)"><%=i%></a>
	<%} %>
<%}
	
		//다음 출력
		if(pageCount>endBlock){%>
		<a href="javascript:movePage(<%=startBlock+pageBlock%>)">[다음]</a>	
<%	}%>
<br><br>
<!-- 검색창 -->
<form name="searchForm" method="post">
	<!-- 페이지 유지를 위한 hidden 태그 추가 -->
	<input type="hidden" name="page">
	<select name="search" class="box">
		<option value="title" 
		<%if(search!=null&&search.equals("title")){%>
		selected<%}%>>제목
		<option value="writer"
		<%if(search!=null&&search.equals("writer")){%>
		selected<%}%>>작성자
	</select>
	<input type="text" class="box" name="searchString"
		value="<%=searchString==null?"":searchString%>">
	<input type="submit" value="검색"> 
</form>
</div>
<%@ include file="/bottom.jsp"%>

	











