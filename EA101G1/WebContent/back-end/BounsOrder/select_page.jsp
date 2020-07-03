<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>紅利訂單查詢</title>

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

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>紅利訂單查詢 - /back-end/BounsOrder/select_page.jsp</h3>
				<h4>Home page for BounsOrder</h4>
			</td>
		</tr>
	</table>
	
<!-- 	錯誤列表 -->
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤：</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<table>
		<ul>
<%-- 			<li><a href="<%=request.getContextPath()%>/back-end/BounsOrder/ListAll.jsp">List</a> all BounsOrder.</li> --%>
			<li><a href="ListAll.jsp">List</a> all BounsOrder.</li>
			
			<li>
				<form method="post" action="BounsOrder.do">
				
				</form>
			</li>
		</ul>
	</table>
</body>
</html>