<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.BounsOrder.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    BOService bmSvc = new BOService();
    List<BOVO> list = bmSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<jsp:useBean id="deptSvc" scope="page" class="com.BounsMall.model.BMService" />

<html>
<head>
<title>所有訂單資料</title>

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
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr><td>
			<h3>所有訂單資料-/back-end/selsct_page.jsp</h3>
<!-- 			<h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4> -->
		</td></tr>
	</table>
	
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤：</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<table>
		<tr>
			<td>訂單編號</td>
			<td>會員編號</td>
			<td>紅利商品編號</td>
			<td>下定日期</td>
			<td>訂單狀態編號</td>
			<th colspan="2">欲執行之動作</th>
		</tr>
		<%@ include file="/back-end/page1.file" %>
		<c:forEach var="bmVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<tr>
				<td>${boVO.ord_id}</td>
				<td>${boVO.mem_id}</td>
				<td>${boVO.bon_id}</td>
				<td>${boVO.ord_date}</td>
				<td>${boVO.bs_id}</td>
				<td>
					<form method="post" action="<%=request.getContextPath()%>/">
					</form>
				</td>
				<td>
					<form method="post" action="<%=request.getContextPath()%>/front-end/BounsMall/BounsMall.do" style="margin-bottom: 0px;">
						<input type="hidden" name="bon_id" value="${bmVO.bon_id}">
						<input type="hidden" name="action" value="getOne_For_Update">
						<input type="submit" value="修改">
					</form>
				</td>
				<td>
					<form method="post" action="<%=request.getContextPath()%>/front-end/BounsMall/BounsMall.do" style="margin-bottom: 0px;">
						<input type="hidden" name="bon_id" value="${bmVO.bon_id}">
						<input type="hidden" name="action" value="delete">
						<input type="submit" value="刪除">
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>