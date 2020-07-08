<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="fbSvc" scope="page" class="com.FavoriteBouns.model.FBService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService" />

<html>
<head>
<title>最愛紅利查詢</title>

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
				<h3>最愛紅利查詢 - /back-end/FavoriteBouns/select_page.jsp</h3>
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
<%-- 				<form method="post" action="<%=request.getContextPath()%>/FavoriteBouns/FBS.do"> --%>
				<form method="post" action="<%=request.getContextPath()%>/FavoriteBouns/FBServlet.do">
					<b>選擇會員名稱：</b>
					<select size="1" name="mem_id">
						<c:forEach var="fbVO" items="${fbSvc.all}">
							<option value="${fbVO.mem_id}">${fbVO.mem_id}
						</c:forEach>
					</select>
					<input type="hidden" name="action" value="getAllByMember">
					<input type="submit" value="送出" >
				</form>
			</li>
			
<%-- 		<form method="post" action="<%=request.getContextPath()%>"> --%>
<!-- 			<input type="hidden" name="action" value="insert"> -->
<!-- 			<input type="submit" value="新增訂單" > -->
<!-- 		</form> -->
	</table>
</body>
</html>