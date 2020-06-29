<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.BounsMall.model.*" %>

<% BMVO bmVO = (BMVO) request.getAttribute("bmVO"); %>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>�ק���Q�ӫ~�T��</title>

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
		<h3>�ק���Q�ӫ~�T��</h3>
		<h4><a href="<%=request.getContextPath()%>/back-end/BounsMall/ListAll.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
</table>

<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<form method="post" action="BounsMall.do" name="form1">
	<table>
		<tr>
			<td>���Q�ӫ~�s���G<font color=red><b>*</b></font></td>
<%-- 			<td><%=bmVO.getBon_id()%></td> --%>
			<td>${bmVO.bon_id}</td>
		</tr>
		
		<jsp:useBean id="bmSvc" scope="page" class="com.BounsMall.model.BMService"/>
		<tr>
			<td>�ӫ~�����s���G<font color="red"><b>*</b></font></td>
			<td>
				<select size="1" name="pt_id">
					<c:forEach var="bmVO" items="${bmSvc.all}">
						<option value="${bmVO.pt_id}" ${(bmVO.pt_id==PtVO.pt_id)? 'select':''}>${PtVO.typename}
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr>
			<td>���Q�ӫ~�W�١G</td>
<%-- 			<td><input type="text" name="bon_name" size="45" value=<%=bmVO.getBon_name()%> /></td> --%>
			<td><input type="text" name="bon_name" size="45" value="${bmVO.bon_name}" /></td>
		</tr>
		<tr>
			<td>�һݬ��Q�I�ơG</td>
<%-- 			<td><input type="text" name="bon_price" size="45" value=<%=bmVO.getBon_price()%> /></td> --%>
			<td><input type="text" name="bon_price" size="45" value="${bmVO.bon_price}" /></td>
		</tr>
		<tr>
			<td>���Q�ӫ~�Ϥ��G</td>
			<td>
				<input type="file" name="bon_image" />
				<img src="<%=request.getContextPath()%>/BounsMall/ImageServlet.do?bon_id=${bmVO.bon_id}" id="display">
			</td>
		</tr>
		<tr>
			<td>���Q�ӫ~�y�z�G</td>
<%-- 			<td><input type="text" name="bon_info" size="45" value=<%=bmVO.getBon_info()%> /></td> --%>
			<td><input type="text" name="bon_info" size="45" value="${bmVO.bon_info}" /></td>
		</tr>
		<tr>
			<td>�w�I���ƶq�G</td>
<%-- 			<td><input type="text" name="bon_exchange" size="45" value=<%=bmVO.getBon_exchange()%> /></td> --%>
			<td><input type="text" name="bon_exchange" size="45" value="${bmVO.bon_exchange}" /></td>
		</tr>
		<tr>
			<td>�{���`�w�s�G</td>
<%-- 			<td><input type="text" name="bon_stock" size="45" value=<%=bmVO.getBon_stock()%>/></td> --%>
			<td><input type="text" name="bon_stock" size="45" value="${bmVO.bon_stock}"/></td>
		</tr>
		
		<tr>
			<td>�W�[����G</td>
			<td><input name="bon_addDate" id="f_date1" type="text"/></td>
		</tr>
		
		<tr>
			<td>���Q�ӫ~�W�[���A�G</td>
<%-- 			<td><input type="text" name="bon_status" size="45" value=<%=bmVO.getBon_status()%>/></td> --%>
			<td><input type="text" name="bon_status" size="45" value="${bmVO.bon_status}"/></td>
		</tr>
	</table>
</form>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="bon_id" value=${bmVO.bon_id}>
<input type="submit" value="�e�X�ק�">
</body>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
	
</style>

<script>
	
</script>

</html>