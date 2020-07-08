<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService" />

<html>
<head>
<title>我的紅利最愛查詢</title>

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
				<h3>我的紅利最愛查詢 - /back-end/FavoriteBouns/select_page.jsp</h3>
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
			<li><a href="<%=request.getContextPath()%>/back-end/FavoriteBouns/ListAll.jsp">List</a> all BounsOrder.</li>
			
			<li>
				<form method="post" action="<%=request.getContextPath()%>/FavoriteBouns/FBS.do">
					<b>選擇會員名稱：</b>
					<select size="1" name="mem_id">
						<c:forEach var="memVO" items="${memSvc.all}">
							<option value="${memVO.mem_id}">${memVO.mem_name}
						</c:forEach>
					</select>
					<input type="hidden" name="action" value="getAllByMember">
					<input type="submit" value="送出" >
				</form>
			</li>
		</ul>
		
<%-- 		<form method="post" action="<%=request.getContextPath()%>"> --%>
<!-- 			<input type="hidden" name="action" value="insert"> -->
<!-- 			<input type="submit" value="新增訂單" > -->
<!-- 		</form> -->
	</table>
</body>
</html>