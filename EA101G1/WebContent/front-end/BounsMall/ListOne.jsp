<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.BounsMall.model.*" %>

<% BMVO bmVO = (BMVO) request.getAttribute("bmVO"); %>

<html>
<head>
<title>���Q�ӫ~�T��</title>

<style>
	table#table-1 {
		background-color: #CCCCFF;
		border:2px solid black;
		text-align: center;
	}
	table#table-1 h4 {
		color: red;
		display: block;
		margin-bottom: 1px;
	}
	h4 {
		color: blue;
		display: inline;
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
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		<h3>���Q�ӫ~���</h3>
		<h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
</table>

<table>
	<tr>
		<th>���Q�ӫ~�s��</th>
		<th>�ӫ~�����s��</th>
		<th>���Q�ӫ~�W��</th>
		<th>�һݬ��Q�I��</th>
		<th>���Q�ӫ~�Ϥ�</th>
		<th>���Q�ӫ~�y�z</th>
		<th>�w�I���ƶq</th>
		<th>�{���`�w�s</th>
		<th>�W�[���</th>
		<th>���Q�ӫ~�W�[���A</th>
	</tr>
	
	<tr>
		<td><%=bmVO.getBon_id()%></td>
		<td><%=bmVO.getPt_id()%></td>
		<td><%=bmVO.getBon_name()%></td>
		<td><%=bmVO.getBon_price()%></td>
		<td><img src="<%=request.getContextPath()%>/BounsMall/ImageServlet.do?bon_id=${bmVO.bon_id}" id="display"></td>
		<td><%=bmVO.getBon_info()%></td>
		<td><%=bmVO.getBon_exchange()%></td>
		<td><%=bmVO.getBon_stock()%></td>
		<td><%=bmVO.getBon_addDate()%></td>
		<td><%=bmVO.getBon_status()%></td>
	</tr>
</table>

</body>
</html>