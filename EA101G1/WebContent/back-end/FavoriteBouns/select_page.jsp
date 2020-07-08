<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="fbSvc" scope="page" class="com.FavoriteBouns.model.FBService" />
<jsp:useBean id="memSvc" scope="page" class="com.member.model.MemberService" />
<jsp:useBean id="bmSvc" scope="page" class="com.BounsMall.model.BMService" />

<html>
<head>
<title>�̷R���Q�d��</title>

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
				<h3>�̷R���Q�d�� - /back-end/FavoriteBouns/select_page.jsp</h3>
			</td>
		</tr>
	</table>
	
<!-- 	���~�C�� -->
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">�Эץ��H�U���~�G</font>
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
				<form method="post" action="<%=request.getContextPath()%>/FavoriteBouns/FBServlet.do">
					<b>��ܷ|���G</b>
					<select size="1" name="mem_id">
						<c:forEach var="memVO" items="${memSvc.all}">
							<option value="${memVO.mem_id}">${memVO.mem_id}
						</c:forEach>
					</select>
					<input type="hidden" name="action" value="getAllByMember">
					<input type="submit" value="�e�X" >
				</form>
			</li>
			
			<li>
				<form method="post" action="<%=request.getContextPath()%>/FavoriteBouns/FBServlet.do">
					<b>��ܷ|���G</b>
					<select size="1" name="mem_id">
						<c:forEach var="memVO" items="${memSvc.all}">
							<option value="${memVO.mem_id}">${memVO.mem_id}
						</c:forEach>
					</select>
					<br>
					<b>��ܰӫ~�G</b>
					<select size="1" name="bon_id">
						<c:forEach var="bmVO" items="${bmSvc.all}">
							<option value="${bmVO.bon_id}">${bmVO.bon_name}
						</c:forEach>
					</select>
					<input type="hidden" name="action" value="getOneForDisplay">
					<input type="submit" value="�e�X" >
				</form>
			</li>
			
		<form method="post" action="<%=request.getContextPath()%>/back-end/FavoriteBouns/insert.jsp">
			<input type="hidden" name="action" value="insert">
			<input type="submit" value="�s�W�̷R" >
		</form>
	</table>
</body>
</html>