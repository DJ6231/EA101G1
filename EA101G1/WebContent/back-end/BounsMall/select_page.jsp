<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="bmSvc" scope="page" class="com.BounsMall.model.BMService"/>
<jsp:useBean id="ptSvc" scope="page" class="com.productType.model.PtService"/>

<html>
<head>
<title>紅利後台主頁</title>
<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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
				<h3>紅利商城後台首頁 - /back-end/BounsMall/select_page.jsp</h3>
			</td>
		</tr>
	</table>
	
<%--	錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
		    <c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<table>
		<ul>
			<li><a href="<%=request.getContextPath()%>/back-end/BounsMall//ListAll.jsp">List</a> all BounsMall.</li>
			
			<li>
				<form method="post" action="<%=request.getContextPath()%>/BounsMall/BounsMall.do">
					<b>選擇紅利商品名稱：</b>
					<select size="1" name="bon_id">
						<c:forEach var="bmVO" items="${bmSvc.all}">
							<option value="${bmVO.bon_id}">${bmVO.bon_name}
						</c:forEach>
					</select>
					<input type="hidden" name="action" value="getOne_For_Display">
					<input type="submit" value="送出">
				</form>
			</li>
		
			<li>
				<form method="post" action="<%=request.getContextPath()%>/BounsMall/BounsMall.do">
					<b>選擇商品種類：</b>
					<select size="1" name="pt_id">
						<c:forEach var="ptVO" items="${ptSvc.all}">
							<option value="${ptVO.pt_id}">${ptVO.typename}
						</c:forEach>
					</select>
					<input type="hidden" name="action" value="getAll_ByPtId">
					<input type="submit" value="送出" >
				</form>
			</li>
			
			<li>
				<form method="post" action="<%=request.getContextPath()%>/BounsMall/BounsMall.do">
					<b>輸入任意關鍵字：</b>
					<input type="text" name="bon_name">
					<input type="hidden" name="action" value="getByName">
					<input type="submit" value="送出">
				</form>
			</li>
		</ul>
		
		<form method="post" action="addBM.jsp">
			<input type="hidden" name="action" value="addBM">
			<input type="submit" value="新增商品">
		</form>
	</table>
</body>
</html>