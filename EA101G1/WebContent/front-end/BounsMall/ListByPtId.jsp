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
<title>紅利商品＿商品種類查詢</title>

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
				<h3>紅利商品＿商品種類查詢 - /back-end/ListByPtId.jsp</h3>
			 	<h4>
			 		<a href="<%=request.getContextPath()%>/front-end/BounsMall/select_page.jsp">
				 	<img src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
				 </h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<table>
		<tr>
			<th>紅利商品編號</th>
			<th>商品分類編號</th>
			<th>紅利商品名稱</th>
			<th>所需紅利點數</th>
			<th>紅利商品圖片</th>
			<th>紅利商品描述</th>
			<th>已兌換數量</th>
			<th>現有總庫存</th>
			<th>上架日期</th>
			<th>紅利商品上架狀態</th>
			<th>是否兌換？</th>
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
			<td>${(bmVO.bon_status==0)? "上架":"下架"}</td>
			
			<td>
				<form method="post" action="">
					<input type="hidden" name="action" value="buy">
					<input type="submit" value="我要兌換" >
				</form>
			</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/front-end/page2.file" %>
</body>
</html>