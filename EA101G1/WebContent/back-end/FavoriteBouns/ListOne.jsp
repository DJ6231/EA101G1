<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.BounsOrder.model.*" %>

<%
	BOVO boVO = (BOVO) request.getAttribute("boVO");
%>

<jsp:useBean id="bmSvc" scope="page" class="com.BounsMall.model.BMService"/>

<html>
<head>
<title>單一紅利訂單查詢</title>
	<style>
		table#table-1 {
			background-color: #CCCCFF;
			border: 2px solid black;
			text-align: center;
		}
		table#table-1 h4 {
			color:red;
			display: block;
			margin-bottom: 1px;
		}
		h4 {
			color: red;
			display: block;
			margin-bottom: 1px;
		}
	</style>
	<style>
		table {
			width: 800px;
			background-color: white;
			margin-top: 5px;
			margin-bottom: 5px;
		}
		table, th, td{
			border: 1px solid #CCCCFF;
		}
		th, td {
			padding: 5px;
			text-align: center;
		}
		img#display {
			width: 200px;
		}
	</style>
</head>
<body bgcolor="white">
	<table id="table-1">
		<tr>
			<td>
				<h3>紅利商品資料 - /back-end/ListOne.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/FavoriteBouns/select_page.jsp">
					<img src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>
	
	<table>
		<tr>
			<th>會員</th>
			<th>紅利商品</th>
			<th>欲執行動作</th>
		</tr>
		
		<tr>
			<td>${fbVO.mem_id}</td>
			<td>${bmSvc.getByPK(fbVO.bon_id).bon_name}</td>
			<td>
				<form method="post" action="<%=request.getContextPath()%>/FavoriteBouns/FBServlet.do" style="margin-bottom: 0px;">
					<input type="hidden" name="mem_id" value="${fbVO.mem_id}">
					<input type="hidden" name="bon_id" value="${fbVO.bon_id}">
					<input type="hidden" name="action" value="delete" >
					<input type="submit" value="刪除" >
				</form>
			</td>
		</tr>
	</table>
</body>
</html>