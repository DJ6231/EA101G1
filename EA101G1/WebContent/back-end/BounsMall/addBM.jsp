<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.BounsMall.model.*" %>

<%
	BMVO bmVO = (BMVO) request.getAttribute("bmVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>新增紅利商品資料</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		<h3>新增紅利商品資料</h3>
		<h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="images/tomcat.png">回首頁</a></h4>
	</td></tr>
</table>

<h3>新增商品資料</h3>

<!-- 錯誤列表 -->
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤：</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<form method="post" action="beBM.do" name="form1">
	<table>
		<tr>
			<td>商品名稱：</td>
			<td><input type="text" name="bon_name" size="45"
				value="<%= (bmVO==null)? "碧藍幻想 Versus" : bmVO.getBon_name()%>" /></td>
		</tr>
		<tr>
			<td>
			所需紅利點數：
			</td>
			<td><input type="TEXT" name="bon_price" size="45"
			 value="<%= (bmVO==null)? "50" : bmVO.getBon_price()%>" /></td>
		</tr>
		
		<tr>
			<td>紅利商品描述：</td>
			<td><input type="TEXT" name="bon_info" size="45"
			 value="<%= (bmVO==null)? "50" : bmVO.getBon_info()%>"/></td>
		</tr>
		<tr>
			<td>紅利商品總量：</td>
			<td><input type="TEXT" name="bon_stock" size="45"
			 value="<%= (bmVO==null)? "50" : bmVO.getBon_stock()%>"/></td>
		</tr>
		
		<jsp:useBean id="bmSvc" scope="page" class="com.BounsMall.model.BMService"/>
		<tr>
			<td>紅利商品圖片：</td>
			<td><input type="image" name="bon_image" size="45"
			 value="<%= (bmVO==null)? "50" : bmVO.getBon_info()%>"/></td>
		</td>
		<tr>
			<td>商品分類編號：<font color=red><b>*</b></font></td>
		<td><select size="1" name="pt_id">
			<c:forEach var="bmVO" items="${bmSvc.all}">
				<option value="${bsVO.pt_id}" ${(bsVO.pt_id==bmVO.pt_id)? 'selected':'PT001' } >${bmVO.pt_id}
			</c:forEach>
		</select></td>
		</td>
	</table>
	<br>
	<input type="hidden" name="action" value="insert">
	<input type="submit" value="送出新增">
</form>


</body>
</html>