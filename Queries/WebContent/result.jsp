<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*" %>
    <%@ page import="citi.test.beans.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


	<%
	List<Stats> stats = (List<Stats>) request.getAttribute("stats");
	Iterator<Stats> it = stats.iterator();
	%>


<script type="text/javascript" src="https://www.google.com/jsapi"></script>      
	<!-- <script type="text/javascript" src="js/jsapi.js"></script> -->

	<script type="text/javascript">
		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChart);
		
		function drawChart() {
			var data = new google.visualization.DataTable();
			data.addColumn('string', 'Date');
			data.addColumn('number', 'SumIO');
			data.addColumn('number', 'rowct');
			
			var data2 = new google.visualization.DataTable();
			data2.addColumn('string', 'Date');
			data2.addColumn('number', 'cpuskw');
			data2.addColumn('number', 'ioskw');
			data2.addColumn('number', 'pji');
			data2.addColumn('number', 'uii');

			var myArray2 = 	[];

			
			<%
			String string="";
			for (Stats stat : stats) {
				 string += "myArray2.push( new Array(\\'" + stat.getLogDate()
				 		+ "\\'," + stat.getSumIO() + ","+ stat.getRowCount() +"));";
				 		//string+=stat.getSumIO();
			}
			%>
			eval('<%=string%>');
			
			var myArray3 = 	[];

			
			<%
			String string3="";
			for (Stats stat : stats) {
				 string3 += "myArray3.push( new Array(\\'" + stat.getLogDate()
				 		+ "\\'," + stat.getCpuSkw() + ","+ stat.getIoSkw() +","+stat.getPji()+","+ stat.getUii()+"));";
				 		//string+=stat.getSumIO();
			}
			%>
			eval('<%=string3%>');
			//myArray2.push( new Array( '01/02/2011', 12000000, 20000000) );
			
			//alert(myArray2[1]);

			//var myArray3 = new Array();
			
			//alert(myArray3[1]);
			data.addRows(myArray2);
			data2.addRows(myArray3);

			var options = {title: 'Company Performance'};
			var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
			var chart2 = new google.visualization.LineChart(document.getElementById('chart_div2'));
			chart.draw(data, options);       
			chart2.draw(data2, options);
			}     
	</script>   
<div id="chart_div" style="width: 1024; height: 600px;">
		</div>  
		<div id="chart_div2" style="width: 1024; height: 600px;">
		</div>  
		
		<table border="2">
		<tr>
			<td >logDate</td>
			<td>QryRespTime</td>	
			<td>
			SumCPU
			</td>
			<td>
			SumIO
			</td>
			<td>
			CPUSKW
			</td>
			<td>
			IOSKW
			</td>
			<td>
			PJI
			</td>
			<td>
			UII
			</td>
			<td>
			ImpactCPU
			</td>
			<td>
			rowct
			</td>
		</tr>
		<%
			
			while (it.hasNext()) {
				Stats s = it.next();
				out.print("<tr>");
				out.println("<td>" + s.getLogDate() + "</td>");
				out.println("<td>" + s.getQueryResponseTime() + "</td>");
				out.println("<td>" + s.getSumCPU() + "</td>");
				out.println("<td>" + s.getSumIO() + "</td>");
				out.println("<td>" + s.getCpuSkw() + "</td>");
				out.println("<td>" + s.getIoSkw() + "</td>");
				out.println("<td>" + s.getPji() + "</td>");
				out.println("<td>" + s.getUii() + "</td>");
				out.println("<td>" + s.getImpactCpu() + "</td>");
				out.println("<td>" + s.getRowCount() + "</td>");
				out.print("</tr>");
			}
		%>
			
		
	</table>

</body>
</html>