<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="dao" scope="page" class="com.BounsMall.model.BMDAO" />
<jsp:useBean id="ptSvc" scope="page" class="com.productType.model.PtService" />

<html>
<head>
<title>紅利商城前台首頁</title>

<style>
	table#table-1 {
		width: 450px;
		background-color: #CCCCFF;
		margin-top: 5px;
		margin-bottom: 10px;
		border:3px ridge Gray;
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
				<h3>紅利商城前台首頁 - /front-end/BounsMall/select_page.jsp</h3>
			</td>
		</tr>
	</table>

	${errorMsgs}<br>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤：</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${errorMsgs}</li>
			</c:forEach>
		</ul>
	</c:if>

	<ul>
		<li>
			<a href="<%=request.getContextPath()%>/front-end/BounsMall//ListAll.jsp">List</a> all Bouns.
		</li>
		<br>
		
<!-- 		<li> -->
<%-- 			<form method="post" action="<%=request.getContextPath()%>/BounsMall/BounsMall.do"> --%>
<!-- 				<b>選擇紅利商品編號：</b> -->
<!-- 				<select size="1" name="bon_id"> -->
<%-- 					<c:forEach var="bmVO" items="${dao.all}"> --%>
<%-- 						<option value="${bmVO.bon_id}">${bmVO.bon_id} --%>
<%-- 					</c:forEach> --%>
<!-- 				</select> -->
<!-- 				<input type="hidden" name="action" value="getOne_For_Display_front"> -->
<!-- 				<input type="submit" value="送出"> -->
<!-- 			</form> -->
<!-- 		</li> -->
		
		<li>
			<form method="post" action="<%=request.getContextPath()%>/BounsMall/BounsMall.do">
				<b>選擇紅利商品名稱：</b>
				<select size="1" name="bon_id">
					<c:forEach var="bmVO" items="${dao.all}">
						<option value="${bmVO.bon_id}">${bmVO.bon_name}
					</c:forEach>
				</select>
				<input type="hidden" name="action" value="getOne_For_Display_front">
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
				<input type="hidden" name="action" value="getAll_ByPtId_front">
				<input type="submit" value="送出">
			</form>
		</li>
		
		<li>
			<form method="post" action="<%=request.getContextPath()%>/front-end/BounsMall/BounsMall.do">
				<b>輸入關鍵字查詢：</b>
				<input type="text" name="bon_name">
				<input type="hidden" name="action" value="getByName_front">
				<input type="submit" value="送出">
			</form>
		</li>
		
		
	</ul>

</body>
</html>