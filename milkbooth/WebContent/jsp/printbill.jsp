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
<title>MilkBooth Print Bill</title>
	<style>
		#BillOuterDiv{
			
		    margin: auto;
		    text-align: center;
		}
		
		table#billDiv{
			 border-collapse: collapse;
			 font-size:14px
		}
		table#billDiv thead th,table#billDiv tbody td{
			border:1px solid black;
		}
	</style>
</head>

<body onload="window.print()">

<div id="wrapper" >

	<div id="content" style="width:900px">
		<input style="float:right" type="button" value="print" name="print" onclick="window.print();"/>
		<div id="BillOuterDiv" style="">
		 		<div style="font-size:18;font-weight:bold">Govardana Milk Center</div>
		 		<div>Bill has been generated from <%=fromDate %> to <%=toDate %></div>
				
				<br/>
		 	
			<table border="0" id="billDiv" cellpadding="3" cellspacing="3" width="500px" style="margin-left:20%">
					<thead>
						<tr>
							<th width="25%">Customer No</th>
							<th  width="25%">Bill Amount</th>
							<th  width="50%">Remarks</th>
						</tr>
					</thead>
					<tbody>
					<%
						if(bills != null){
						 for(Map<String,Object> bill : bills){
							
						%>
							<tr>
								<td><%=bill.get("CUSTOMER_NO")%></td>
								<td><img class="rupeeInd" src="<%=contextPath%>/jsp/images/indian-rupee-16.png" alt="rupee"/><%=bill.get("BILL_AMOUNT")%></td>
								<td>&nbsp;</td>
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
