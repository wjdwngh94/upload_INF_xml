<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    </td>
			</tr>
			<tr height="50">
				<th colspan="2">
				<!-- 로그인 및 기타 정보들 표시 -->
				세션ID : <%=session.getId() %>
				로그인 : <%=(String)session.getAttribute("login") %></th>
			</tr>
		</table>
	</div>
	</body>
</html>