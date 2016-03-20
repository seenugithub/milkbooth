<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.*" %>
<%
	String contextPath = request.getContextPath();
	List<Map<String,Object>> bills =(List<Map<String,Object>>) request.getAttribute("bills");
	String fromDate=request.getParameter("fromdate");
	String toDate=request.getParameter("todate");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>MilkBooth Daily Entry</title>
<link href="<%=contextPath%>/jsp/style.css" rel="stylesheet"  type="text/css" media="screen" />
<link href="<%=contextPath%>/jsp/jquery-ui.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%=contextPath%>/jsp/css/jquery.dataTables.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%=contextPath%>/jsp/css/common.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="<%=contextPath%>/jsp/jquery.js"></script>
<script src="<%=contextPath%>/jsp/jquery-ui.js"></script>
<script src="<%=contextPath%>/jsp/jquery.dataTables.js"></script> 

	<style>
	
		p {text-indent: 1em; margin-top: 0; margin-bottom: 0; line-height: 200%;}
	</style>
	<script type="text/javascript" language="javascript">
	
	
	
	</script>
	
</head>

<body>

<div id="wrapper">

	<%@ include file="header.jsp" %>
	
	<div id="content" style="width:900px">
		<br/>
		<br/>
		<br/>
		 <p>
		 Govardana Milkbooth is registered on 1 December 1992 as a response to the exploitation of marginal milk producers by traders or agents of the only existing dairy, 
		 the Polson dairy, in the small city distances to deliver milk,
		  which often went sour in summer, to Polson. The prices of milk were 
		  arbitrarily determined. Moreover, the government had given monopoly rights to Polson to collect milk from mikka and supply it to Andhra Pradesh
		 </p>
	</div>
	
	<%@ include file="footer.jsp" %>

</div>

</body>
</html>
