<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="bmSvc" scope="page" class="com.BounsMall.model.BMService"/>
<jsp:useBean id="ptSvc" scope="page" class="com.productType.model.PtService"/>

<html>
<head>
<title>���Q��x�D��</title>
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
				<h3>���Q�ӫ���x���� - /back-end/BounsMall/select_page.jsp</h3>
			</td>
		</tr>
	</table>
	
<%--	���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color:red">�Эץ��H�U���~:</font>
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
					<b>��ܬ��Q�ӫ~�W�١G</b>
					<select size="1" name="bon_id">
						<c:forEach var="bmVO" items="${bmSvc.all}">
							<option value="${bmVO.bon_id}">${bmVO.bon_name}
						</c:forEach>
					</select>
					<input type="hidden" name="action" value="getOne_For_Display">
					<input type="submit" value="�e�X">
				</form>
			</li>
		
			<li>
				<form method="post" action="<%=request.getContextPath()%>/BounsMall/BounsMall.do">
					<b>��ܰӫ~�����G</b>
					<select size="1" name="pt_id">
						<c:forEach var="ptVO" items="${ptSvc.all}">
							<option value="${ptVO.pt_id}">${ptVO.typename}
						</c:forEach>
					</select>
					<input type="hidden" name="action" value="getAll_ByPtId">
					<input type="submit" value="�e�X" >
				</form>
			</li>
			
			<li>
				<form method="post" action="<%=request.getContextPath()%>/BounsMall/BounsMall.do">
					<b>��J���N����r�G</b>
					<input type="text" name="bon_name">
					<input type="hidden" name="action" value="getByName">
					<input type="submit" value="�e�X">
				</form>
			</li>
		</ul>
		
		<form method="post" action="addBM.jsp">
			<input type="hidden" name="action" value="addBM">
			<input type="submit" value="�s�W�ӫ~">
		</form>
	</table>
</body>
</html>