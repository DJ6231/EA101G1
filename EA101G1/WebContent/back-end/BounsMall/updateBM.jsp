<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.BounsMall.model.*" %>

<% BMVO bmVO = (BMVO) request.getAttribute("bmVO"); %>

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
	<tr><td>
		<h3>修改紅利商品訊息</h3>
		<h4><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
</table>

</body>
</html>