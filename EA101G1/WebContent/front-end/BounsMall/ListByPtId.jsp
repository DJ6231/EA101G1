<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="com.BounsMall.model.*" %>

<%
	List<BMVO> list = (java.util.List<BMVO>) request.getAttribute("list");
%>

<jsp:useBean id="ptSvc" scope="page" class="com.productType.model.PtService" />

<html>
<head>
<title>���Q�ӫ~�İӫ~�����d��</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
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
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
  td>img{
  width:200px;
  }
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>���Q�ӫ~�İӫ~�����d�� - /back-end/ListByPtId.jsp</h3>
			 	<h4>
			 		<a href="<%=request.getContextPath()%>/front-end/BounsMall/select_page.jsp">
				 	<img src="images/back1.gif" width="100" height="32" border="0">�^����</a>
				 </h4>
			</td>
		</tr>
	</table>

	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">�Эץ��H�U���~:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
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
			<th>�O�_�I���H</th>
		</tr>
		<%@ include file="/front-end/page1.file" %>
		<c:forEach var="bmVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<td>${bmVO.bon_id}</td>
			<td>${ptSvc.getOneProductType(bmVO.pt_id).typename}</td>
			<td>${bmVO.bon_name}</td>
			<td>${bmVO.bon_price}</td>
			<td><img src="<%=request.getContextPath()%>/BounsMall/ImageServlet.do?bon_id=${bmVO.bon_id}" id="display"></td>
			<td id="info">${bmVO.bon_info}</td>
			<td>${bmVO.bon_exchange}</td>
			<td>${bmVO.bon_stock}</td>
			<td>${bmVO.bon_addDate}</td>
			<td>${(bmVO.bon_status==0)? "�W�[":"�U�["}</td>
			
			<td>
				<form method="post" action="">
					<input type="hidden" name="action" value="buy">
					<input type="submit" value="�ڭn�I��" >
				</form>
			</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/front-end/page2.file" %>
</body>
</html>