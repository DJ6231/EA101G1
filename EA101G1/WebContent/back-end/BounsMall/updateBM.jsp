<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.BounsMall.model.*" %>

<%
	BMVO bmVO = (BMVO) request.getAttribute("bmVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>修改紅利商品訊息</title>

<style>
	table#table-1 {
		background-color: #CCCCFF;
		border:2px solid black;
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
	table, th, td{
		border: 1px solid #CCCCFF;
	}
	th, td {
		padding: 5px;
		text-align: center;
	}
	img#display {
		width: 200px;
	}
</style>
</head>

<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>修改紅利商品訊息 - /back-end/updateBM.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/BounsMall/ListAll.jsp">
<%-- 					<a href="return"> --%>
						<img src="images/back1.gif" width="100" height="32" border="0">回上一頁</a>
				</h4>
			</td>
	</table>

	<c:if test="${not empty errorMsgs}">
		<font style="color:red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<form method="post"
		action="<%=request.getContextPath()%>/BounsMall/BounsMall.do"
		name="form1" enctype="multipart/form-data">
		<table>
		
			<tr>
				<td>紅利商品名稱：</td>
				<td>
					<input type="text" name="bon_name" size="45"
						value=<%=bmVO.getBon_name()%> />
				</td>
			</tr>
			
			<tr>
				<td>所需紅利點數：</td>
				<td>
					<input type="text" name="bon_price" size="45"
						value=<%=bmVO.getBon_price()%> />
				</td>
			</tr>
			
			<tr>
				<td>紅利商品圖片：</td>
				<td>
					<input type="file" name="bon_image" id="myFile"
						accept="image/gif, image/jpge, image/png"
						value="<%=bmVO.getBon_image()%>" />
					<br>
					<div class="row">
						<div id="preview">
							<from method="post"
								action="<%=request.getContextPath()%>/BounsMall/ImageServlet.do">
								<img src="<%=request.getContextPath()%>/BounsMall/ImageServlet.do?bon_id=${bmVO.bon_id}">
							</from>
						</div>
					</div>
				</td>
			</tr>
			
			<tr>
				<td>紅利商品描述：</td>
				<td>
					<textarea name="bon_info" rows="8" cols="45"
						value="<%=bmVO.getBon_info()%>" ><%=bmVO.getBon_info()%></textarea>
				</td>
			</tr>
			
			<tr>
				<td>現有總庫存：</td>
				<td>
					<input type="text" name="bon_stock" size="45"
						value=<%=bmVO.getBon_stock()%> />
				</td>
			</tr>
			
			<jsp:useBean id="ptSvc" scope="page" class="com.productType.model.PtService"/>
			<tr>
				<td>商品分類編號：<font color="red"><b>*</b></font></td>
				<td>
					<select size="1" name="pt_id">
						<c:forEach var="ptVO" items="${ptSvc.all}">
							<option value="${ptVO.pt_id}"
								${(bmVO.pt_id==ptVO.pt_id)? 'select':''}>${ptVO.typename}
						</c:forEach>
					</select>
				</td>
			</tr>
			
			<tr>
				<td>紅利商品上架狀態：</td>
				<td>
					<select size="1" name="bon_status">
						<option value=0 ${(bmVO.bon_status==0)? 'selected':'' } >上架
						<option value=1 ${(bmVO.bon_status==1)? 'selected':'' } >下架
					</select>
				</td>
			</tr>
		</table>
		<br>
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="bon_id" value="<%=bmVO.getBon_id()%>"> 
		<input type="hidden" name="bon_exchange" value="<%=bmVO.getBon_exchange()%>">
		<input type="hidden" name="bon_addDate" value="<%=bmVO.getBon_addDate()%>"> 
		<input type="submit" value="送出修改">
	</form>

	<script>
		function init() {
			var myFile = document.getElementById("myFile");
			var preview = document.getElementById("preview");

			myFile.addEventListener('change', function(e) {
				var files = myFile.files;

				if (files !== null && files.length > 0) {
					var file = files[0];

					console.log(file.type);
					if (file.type.indexOf('image') > -1) {
						var reader = new FileReader();

						reader.addEventListener('load', function(e) {
							var result = e.target.result;
							var img = document.createElement('img');

							img.src = result;
							preview.innerHTML = "";
							preview.append(img);
						});
						reader.readAsDataURL(file); 
					}
				}
			});
		}

		window.onload = init;
	</script>
</body>

</html>