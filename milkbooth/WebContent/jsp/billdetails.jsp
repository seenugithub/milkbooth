<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.*" %>
<%
	String contextPath = request.getContextPath();
	List<Map<String,Object>> billdetails =(List<Map<String,Object>>) request.getAttribute("billdetails");
	
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
		.dataTables_filter {
		   display: none;
		}
		
	</style>
	<script type="text/javascript" language="javascript">
	
	$(document).ready(function() {

	} );
	
	
	</script>
	
</head>

<body>

<div id="wrapper">

	<div id="content" style="width:900px">

		 <div class="BillingDiv" style="margin:auto; width:600px;padding:10px 10px;text-align:center">
			<table id="billingTable" border="1" class="display" cellspacing="0" width="600px">
					<thead>
						<tr>
							<th rowspan="1">&nbsp;</th>
							<th colspan="3" width="30%">AM</th>
							<th colspan="3" width="30%">PM</th>
							<th>&nbsp;</th>
						</tr>
						</thead>
						<thead>
						<tr>
						    <th>Date</th>
							<th>Quantity</th>
							<th>Fat</th>
							<th>Total</th>
							<th>Quantity</th>
							<th>Fat</th>
							<th>Total</th>
							<th>Total</th>
						</tr>
					</thead>
					<tbody>
					<%
						if(billdetails != null){
						 for(Map<String,Object> bill : billdetails){
							
						%>
							<tr>
								<td  class="custno"><%=bill.get("TRANS_DATE")%></td>
								<td  class="custno"><%=bill.get("AM_QTY")%></td>
								<td  class="custno"><%=bill.get("AM_FAT")%></td>
								<td  class="custno"><%=bill.get("AM_AMOUNT")%></td>
								<td  class="custno"><%=bill.get("PM_QTY")%></td>
								<td  class="custno"><%=bill.get("PM_FAT")%></td>
								<td  class="custno"><%=bill.get("PM_AMOUNT")%></td>
								<td  class="custno"><%=bill.get("TOTAL")%></td>
								
							</tr>
						
						<%}
						 }%>
						
					</tbody>
				</table>
		 </div>
	</div>

</div>

</body>
</html>
