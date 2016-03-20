<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.*" %>
<%
	String contextPath = request.getContextPath();
	List<Map<String,Object>> transList =(List<Map<String,Object>>) request.getAttribute("transList");
	String dtsession=(String)request.getParameter("dtsession");
	String todayDate=(String)request.getAttribute("todayDate");
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
		.entrySaveBtn,.successInd,.errorInd{display:none}
	</style>
	<script type="text/javascript" language="javascript">
	
	$(document).ready(function() {
		var toTable=$('#todayEntryTable').DataTable({
											"bPaginate": false,
											"bSort":false,
											"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
												
												$(nRow).on('click', function() {
													$(".entrySaveBtn,.successInd,.errorInd").hide();
													$(this).find(".entrySaveBtn").css('display', 'inline');
												});
												return nRow;
												}
										  }); 
		
		var poTable=$('#prevEntryTable').DataTable({
													"bPaginate": false,
													"bSort":false,
													"ajax":"transdata.do?date="+$("#prevdate").val()+"&dtsession="+$("#pdtsession").val(),
													"responsive": true,
											        "processing":true,
											        "serverSide":true});
		
		$( ".jdate" ).datepicker({ dateFormat: 'dd/mm/yy',showOtherMonths:true,selectOtherMonths: false });
		$(".jbutton").button();
		$(".jselectbox").selectmenu();
		
		$('#todaysearch').keyup(function(){
			toTable.search($(this).val()).draw() ;
		})
		
		$('#prevsearch').keyup(function(){
			poTable.search($(this).val()).draw() ;
		})
		
		$(".entrySaveBtn").click(function(){
			var $row = $(this).parent().parent();
			var dt=$("#todayDate").val();
			var seldtsession=$("#seldtsession").val();
			var custno=$row.find(".custno").html();
			var qty=$row.find(".qtytxt").val();
			var fat=$row.find(".fattxt").val();
			
			var params="?date="+dt+"&qty="+qty+"&fat="+fat+"&custno="+custno+"&dtsession="+seldtsession;
			$.ajax({url: "savetrans.do"+params,success: function(result){
		        if(result=="success"){
		       		 $row.find(".successInd").css('display', 'inline');
		        }else{
		       		$row.find(".errorInd").css('display', 'inline');
		        }
		       		
		    }});
		});
		
		$("#prevshow").click(function(){
			var prevdate = $("#prevdate").val();
			var prevdtsession = $("#pdtsession").val();
			var url = "transdata.do?date="+prevdate+"&dtsession="+prevdtsession;
			$("#prevTbleLbl").html(prevdate+" : "+prevdtsession);
			poTable.ajax.url(url).load();
		});
		
		var hightlightFlag=false;
		$("#todayHighlight").click(function(){
			if(hightlightFlag==false){
				hightlightFlag=true;
				toTable.rows().every(function (rowIdx, tableLoop, rowLoop) {
					var $row=$(toTable.row( rowIdx ).node());
					var custno=$row.find(".custno").html();
					var qty=$row.find(".qtytxt").val();
					var fat=$row.find(".fattxt").val();
					
					if(qty==""){
						$row.find(".qtytxt").css({"background-color":"#868A08"});
						
					}
				})
			}else if(hightlightFlag==true){
				hightlightFlag=false;
				toTable.rows().every(function (rowIdx, tableLoop, rowLoop) {
					var $row=$(toTable.row( rowIdx ).node());
					
					$row.find(".qtytxt").css({"background-color":""});
				
				})
			}
				
			
		});
	} );

	</script>
	
</head>

<body>

<div id="wrapper">

	<%@ include file="header.jsp" %>
	
	<div id="content" style="width:900px">
	
		<div class="entry" >
		   <div class="todayDiv divBorder" style="float:left;width:400px">
		   		<input type="hidden" name="seldtsession" id="seldtsession" value="<%=dtsession%>"/>
		   		<input type="hidden" name="todayDate" id="todayDate" value="<%=todayDate%>"/>
				<form method="post" action="load.do">
					<table cellpadding="3" cellspacing="3">
			   				<tr>
			   					<td width="100">Today Date</td>
			   					<td valign="middle" width="100">: <%=todayDate%></td>
			   					<td> 
			   						<select name="dtsession" id="dtsession">
			   							<option value="AM" <%=(dtsession!=null&&dtsession.equalsIgnoreCase("AM"))?"selected=selected":"" %>>AM</option>
			   							<option value="PM" <%=(dtsession!=null&&dtsession.equalsIgnoreCase("PM"))?"selected=selected":"" %>>PM</option>
			   						</select>
			   					</td>
			   					<td><input type="submit" name="Show" id="todayshow" value="Show" class="jbutton"/></td>
			   					<td><input type="button" name="HighLight" id="todayHighlight" value="HighLight" class="jbutton"/></td>
			   				</tr>
			   				<tr>
			   					<td width="100">Search</td>
			   					<td colspan="4"> &nbsp;: &nbsp;<input type="text" name="todaysearch" id="todaysearch"/></td>
			   				</tr>
			   			</table>
		   		</form>
		   		
				<table id="todayEntryTable" class="display" cellspacing="0" width="400px" style="">
					<thead>
						<tr>
							<th rowspan="2" width="20%">Cust No</th>
							<th colspan="3" width="80%">Today Entry (<%=todayDate%> : <%=dtsession==null?"AM":dtsession %>) </th>
						</tr>
						<tr>
							<th>Quantity(Ltr)</th>
							<th>Fat</th>
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<%
						if(transList != null){
						 for(Map<String,Object> map : transList){
							
						%>
						<tr>
							<td class="custno"><%=map.get("CUSTOMER_NO")%></td>
							<td><input type="text" name="qty" class="qtytxt" value="<%=map.get(dtsession+"_QTY")==null?"":map.get(dtsession+"_QTY")%>" size="6"/></td>
							<td><input type="text" name="fat" class="fattxt" value="<%=map.get(dtsession+"_FAT")==null?"":map.get(dtsession+"_FAT")%>" size="6"/></td>
							<td width="80px">
								<input type="button" class="entrySaveBtn jbutton" value="Save"/>
								<img class="successInd" src="<%=contextPath%>/jsp/images/check-mark-3-16.png" alt="Success"/>
								<img class="errorInd" src="<%=contextPath%>/jsp/images/x-mark-3-16.png" alt="Error"/>
							</td>
						</tr>
						<%} 
						}%>
					</tbody>
				</table>
			</div>
			 <div class="PrevDiv divBorder" style="float:right;">
			 		<table cellpadding="3" cellspacing="3">
		   				<tr>
		   					<td width="100">Prev Date</td>
		   					<td> &nbsp;: &nbsp;<input type="text" name="prevdate" id="prevdate" class="jdate"/></td>
		   					<td> 
		   						<select name="pdtsession" id="pdtsession">
		   							<option value="AM">AM</option>
		   							<option value="PM">PM</option>
		   						</select>
		   					</td>
		   					<td><input type="button" name="Show" id="prevshow" value="Show" class="jbutton"/></td>
		   					
		   				</tr>
		   				<tr>
		   					<td width="100">Search</td>
		   					<td colspan="2"> &nbsp;: &nbsp;<input type="text" name="prevsearch" id="prevsearch"/></td>
		   				</tr>
		   			</table>
		   			
			 		<table id="prevEntryTable" class="display" cellspacing="0" width="400px">
					<thead>
						<tr>
							
							<th colspan="4" width="100%" style="text-align: center">Entry for <span id="prevTbleLbl"></span> </th>
						</tr>
						<tr>
							<th width="25%">Cust No</th>
							<th width="25%">Qty(Ltr)</th>
							<th width="20%">Fat</th>
							<th width="30%">Total</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			 </div>
			 <div style="clear:both"></div>
		</div>
	</div>
	
	<%@ include file="footer.jsp" %>

</div>

</body>
</html>
