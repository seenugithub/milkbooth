<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>MilkBooth Daily Entry</title>
<link href="style.css" rel="stylesheet"  type="text/css" media="screen" />
<link href="jquery-ui.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="css/jquery.dataTables.css" rel="stylesheet" type="text/css" media="screen"/>
<link href="css/common.css" rel="stylesheet" type="text/css" media="screen"/>
<script src="jquery.js"></script>
<script src="jquery-ui.js"></script>
<script src="jquery.dataTables.js"></script> 

	<style>
		.dataTables_filter {
		   display: none;
		}
	</style>
	<script type="text/javascript" language="javascript">
	
	$(document).ready(function() {
		$('#todayEntryTable').DataTable({"bPaginate": false,"bSort":false}); 
		$('#prevEntryTable').DataTable({"bPaginate": false,"bSort":false});
		
		$( ".jdate" ).datepicker();
		$(".jbutton").button();
		$(".jselectbox").selectmenu();
	} );

	</script>
	
</head>

<body>

<div id="wrapper">

	<%@ include file="header.jsp" %>
	
	<div id="content" style="width:900px">
	
		<div class="entry" >
		   <div class="todayDiv divBorder" style="float:left;width:400px">
				<table>
		   				<tr>
		   					<td width="100">Today Date</td>
		   					<td> &nbsp;: &nbsp;05/03/2016</td>
		   					<td> 
		   						<select name="dtsession" id="dtsession">
		   							<option value="AM">AM</option>
		   							<option value="PM">PM</option>
		   						</select>
		   					</td>
		   					<td><input type="button" name="Show" id="todayshow" value="Show" class="jbutton"/></td>
		   				</tr>
		   				<tr>
		   					<td width="100">Search</td>
		   					<td colspan="2"> &nbsp;: &nbsp;<input type="text" name="todaysearch" id="todaysearch"/></td>
		   				</tr>
		   			</table>
		   		
		   		
				<table id="todayEntryTable" class="display" cellspacing="0" width="400px" style="">
					<thead>
						<tr>
							<th rowspan="2" width="30%">Cust No</th>
							<th colspan="3" width="70%">Today Entry (05/03/2016 : AM) </th>
						</tr>
						<tr>
							<th>Quantity(Ltr)</th>
							<th>Fat</th>
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td><input type="text" name="qty" value="9.5" size="6"/></td>
							<td><input type="text" name="fat" value="8.5" size="6"/></td>
							<td><input type="button" value="Save"/></td>
						</tr>
						<tr>
							<td>2</td>
							<td><input type="text" name="qty" value="9.5" size="6"/></td>
							<td><input type="text" name="fat" value="8.5" size="6"/></td>
							<td><input type="button" value="Save"/></td>
						</tr>
						<tr>
							<td>3</td>
							<td><input type="text" name="qty" value="9.5" size="6"/></td>
							<td><input type="text" name="fat" value="8.5" size="6"/></td>
							<td><input type="button" value="Save"/></td>
						</tr>
						<tr>
							<td>40</td>
							<td><input type="text" name="qty" value="9.5" size="6"/></td>
							<td><input type="text" name="fat" value="8.5" size="6"/></td>
							<td><input type="button" value="Save"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			 <div class="PrevDiv divBorder" style="float:right;">
			 		<table>
		   				<tr>
		   					<td width="100">Prev Date</td>
		   					<td> &nbsp;: &nbsp;<input type="text" name="prevdate" id="prevdate" class="jdate"/></td>
		   					<td> 
		   						<select name="dtsession" id="dtsession">
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
							<th rowspan="2" width="30%">Cust No</th>
							<th colspan="2" width="70%">Entry for 04/03/2016 : PM </th>
						</tr>
						<tr>
							<th>Quantity(Ltr)</th>
							<th>Fat</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>9.5</td>
							<td>8.5</td>
						</tr>
						<tr>
							<td>2</td>
							<td>9.5</td>
							<td>8.5</td>
						</tr>
						<tr>
							<td>3</td>
							<td>9.5</td>
							<td>8.5</td>
						</tr>
						<tr>
							<td>40</td>
							<td>9.5</td>
							<td>8.5</td>
						</tr>
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
