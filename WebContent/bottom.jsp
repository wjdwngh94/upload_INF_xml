<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    
    
				</td>
			</tr>
			<tr height="50">
				<th colspan="2">
				<!-- �α��� �� ��Ÿ ������ ǥ�� -->
				����ID : <%=session.getId()%>, 
				�α��� : <%=(String)session.getAttribute("login")%>
				</th>
			</tr>
		</table>
	</div>
	</body>
</html>