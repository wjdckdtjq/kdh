<%@page import="db.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<%
	String num = request.getParameter("pageNum");
	String search = request.getParameter("search");
	int pageNum = num.equals("undefined") ? 1 : Integer.parseInt(num);
	
	
	MemberDAO dao = new MemberDAO();	
	ArrayList<MemberDTO> member = dao.search(search);
	MemberDTO[][] pages = new MemberDTO[member.size()/10 + 1][10];
	
	int lastPage = member.size() % 10;
	int count = 0;
	int size = pageNum == pages.length ? lastPage : 10;
	
	int pg = 0, index = 0;
	while(count < member.size()){			
		pages[pg][index] = member.get(count);
		count++;
		index++;
		if(count % 10 == 0) {
			index = 0;
			pg += 1;
		}
	}
%>
		<table class="table table-hover">
			<tr>
				<td>No.</td>						
				<td>ID</td>						
				<td>pw</td>						
				<td>이름</td>						
				<td>연락처</td>						
				<td>주소</td>						
			</tr>

			<%
			for(int i = 0; i < size; i++){%>
			<tr onclick="javascript:location.href='#'">
				<td><%=(pageNum-1)*10 + (i+1) %></td>

				<td class="s-text13 p-t-5 p-b-5"><%=pages[pageNum-1][i].getId() %></td>											
				<td class="s-text13 p-t-5 p-b-5"><%=pages[pageNum-1][i].getPw() %></td>											
				<td class="s-text13 p-t-5 p-b-5"><%=pages[pageNum-1][i].getName() %></td>											
				<td class="s-text13 p-t-5 p-b-5"><%=pages[pageNum-1][i].getTel() %></td>											
				<td class="s-text13 p-t-5 p-b-5"><%=pages[pageNum-1][i].getAddr() %></td>											

			</tr>
			<%} %>

		</table>
		<div class="pagination flex-m flex-w p-r-50">
			<% for(int j = 1; j <= pages.length; j++){ 
				if(pageNum == j){	
			%>								
					<a onclick="memberList(<%=j %>)" href="#"
					 class="item-pagination flex-c-m trans-0-4 active-pagination"><%=j %></a>
				<%}else{%>										
					<a onclick="memberList(<%=j %>)" href="#"
					 class="item-pagination flex-c-m trans-0-4"><%=j %></a>
				<%}
			}%>
		</div>
</body>
</html>