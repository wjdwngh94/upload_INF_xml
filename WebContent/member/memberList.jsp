<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="my.member.*"%>


<!-- DB의 연결방식 바꾸기 -->

<!-- Connection Pool Bean 을 Application영역에 생성한다. -->
<jsp:useBean id="pool" class="my.db.ConnectionPoolBean"
	scope="application"></jsp:useBean>

<!-- mbdao라는 고객을 생성하고 pool의 정보를 mbdao에게 주입 -->
<!-- 손님은 컴퓨터를 이용하는 고객임으로 -->
<jsp:useBean id="mbdao" class="my.member.MemberDAO" />

<jsp:setProperty property="pool" name="mbdao" value="<%=pool%>" />


<!-- memberList.jsp : 회원 목록 + 검색 페이지 -->
<!-- 검색창을 만들고 검색어의 유무에 따라 모드를 설정 -->
<%@ include file="/top.jsp"%>
<!-- javascript 함수 -->
<script type="text/javascript">
	function openEdit(no){
		//alert(no+"번 회원 수정!");
		//새창을 띄워 사용자의 정보를 변경하도록 화면에 표시
		window.open("memberEdit.jsp?no="+no,"", 
							"width=500, height=500");
	}
	function openDel(no){
		//alert(no+"번 회원 삭제!");
		//확인창 출력 후 예를 선택하면 삭제 페이지로 전송
		var check = window.confirm("정말 삭제하시겠습니까?");
		if(check){//예를 눌렀으면
			location.href="memberDelete.jsp?no="+no;
		}
	}
</script>

<div align="center">
	<!-- 검색어 수신 코드 -->
	<%
		request.setCharacterEncoding("euc-kr");
		String search = request.getParameter("search");
		String searchString = request.getParameter("searchString");
	%>
	<h2>
		search :
		<%=search%>, searchString :
		<%=searchString%></h2>
	<%
		String mode = "";

		ArrayList<MemberDTO> list = null;
		if (search != null && searchString != null
				&& !searchString.trim().equals("")) {
			mode = "검색 모드";//검색	
			list = mbdao.findMember(search, searchString);
		} else {
			mode = "목록 모드";//목록
			list = mbdao.listMember();
		}
	%>
	<h1>
		현재
		<%=mode%></h1>

	<!-- 목록 출력 부분 -->
	<table class="outline" width="600">
		<!-- 제목 -->
		<tr>
			<th class="m2">번호</th>
			<th class="m2">아이디</th>
			<th class="m2">이름</th>
			<th class="m2">성별</th>
			<th class="m2">권한</th>
			<th class="m2">수정</th>
			<th class="m2">삭제</th>
		</tr>
		<!-- 데이터 -->
		<%
			for (MemberDTO mbdto : list) {
		%>
		<tr>
			<th class="m3"><%=mbdto.getNo()%></th>
			<th class="m3"><%=mbdto.getId()%></th>
			<th class="m3"><%=mbdto.getName()%></th>
			<th class="m3"><%=mbdto.getGender()%></th>
			<th class="m3"><%=mbdto.getPower()%></th>
			<th class="m3"><a
				href="javascript:openEdit(<%=mbdto.getNo()%>);">수정</a></th>
			<th class="m3"><input type="button" value="삭제"
				onclick="openDel(<%=mbdto.getNo()%>);"></th>
		</tr>
		<%
			}
		%>
	</table>
	<br>
	<br>
	<!-- 검색어 입력창 : action이 없으면 동일한 페이지로의 전송 -->
	<form method="post">
		<select name="search" class="box">
			<option value="name">이름
			<option value="id">아이디
		</select> <input type="text" name="searchString" class="box" size="30">
		<input type="submit" value="검색">
	</form>
</div>
<%@ include file="/bottom.jsp"%>














