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
		.dataTables_filter {
		   display: none;
		}
		
	</style>
	<script type="text/javascript" language="javascript">
	
	var fromdate="<%=fromDate%>";
	var todate="<%=toDate%>";
	
	$(document).ready(function() {

		var billTable=$('#billingTable').DataTable({
			"bPaginate": false,
			"bSort":false
		  }); 
		$(".jbutton").button();
		$( ".jdate" ).datepicker({ dateFormat: 'dd/mm/yy',showOtherMonths:true,selectOtherMonths: false });
		
		$("#printBill").click(function(){
			if(fromdate!="" && todate!=""){
				var url="printbill?fromdate="+fromdate+"&todate="+todate;
				var myPrintWindow = window.open(url, "Print Bill", "location=no,width=900, height=900,menubar=no,titlebar=no,toolbar=no,scrollbars=yes");
			}
		});
		
		
	} );
	
	function openBillDetails(custno,fromdate,todate){
		var url="viewbilldetails?custno="+custno+"&fromdate="+fromdate+"&todate="+todate;
		var myWindow = window.open(url, "Bill Details", "location=no,width=900, height=900");
	}
	
	</script>
	
</head>

<body>

<div id="wrapper">

	<%@ include file="header.jsp" %>
	
	<div id="content" style="width:900px">

		 <div class="BillingDiv" style="margin:auto; width:600px;padding:10px 10px;">
			
			 	<form method="post" action="load.do">
			 		<table cellpadding="3" cellspacing="3" width="600px" style="border:1px solid #CCC;padding:10px 10px">
		   				<tr>
		   					<td width="100">From Date</td>
		   					<td> &nbsp;: &nbsp;<input type="text" name="fromdate" id="fromdate" class="jdate"/></td>
		   					
		   					
		   				</tr>
		   				<tr>
		   					<td width="100">To Date</td>
		   					<td> &nbsp;: &nbsp;<input type="text" name="todate" id="todate" class="jdate"/></td>
		   				</tr>
		   				<tr>
		   					<td>&nbsp;</td>
		   					<td> &nbsp; &nbsp; <input type="submit" name="generateBill" id="generateBill" value="Generate Bill" class="jbutton"/>
		   					<input type="button" onclick="printBill('<%=fromDate%>','<%=toDate%>');" name="printBill" id="printBill" value="Print Bill" class="jbutton"/></td>
		   				</tr>
		   			</table>
		   		</form>
		   			<br/>
		   			<br/>
			 		<table id="billingTable" class="display" cellspacing="0" width="600px">
					<thead>
						<tr>
							<th rowspan="2" width="30%">Cust No</th>
							<th colspan="2" width="70%">Bill from <span id="fromdatelbl"><%=fromDate!=null?fromDate:"N/A" %></span> To <span id="todatelbl"><%=toDate!=null?toDate:"N/A" %></span> </th>
						</tr>
						<tr>
							<th>Amount</th>
							<th>Details</th>
						</tr>
					</thead>
					<tbody>
					<%
						if(bills != null){
						 for(Map<String,Object> bill : bills){
							
						%>
							<tr>
								<td  class="custno"><%=bill.get("CUSTOMER_NO")%></td>
								<td><img class="rupeeInd" src="<%=contextPath%>/jsp/images/indian-rupee-16.png" alt="rupee"/><%=bill.get("BILL_AMOUNT")%></td>
								<td><a style="cursor:pointer" onclick="javascript:openBillDetails('<%=bill.get("CUSTOMER_NO")%>','<%=fromDate%>','<%=toDate%>')">View Records</a></td>
							</tr>
						
						<%}
						 }%>
						
					</tbody>
				</table>
			 </div>
	</div>
	
	<%@ include file="footer.jsp" %>

</div>

</body>
</html>
