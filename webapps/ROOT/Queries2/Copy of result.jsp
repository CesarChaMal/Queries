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
		List<Stats> stats = (List<Stats>) request.getAttribute("dbStats");
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
			
			var data3 = new google.visualization.DataTable();
			data3.addColumn('string', 'Date');
			data3.addColumn('number', 'queryResponseTime');
			data3.addColumn('number', 'sumCpu');

			var data4 = new google.visualization.DataTable();
			data4.addColumn('string', 'Months');
			
/*			
			data4.addColumn('number', '2011');
			data4.addColumn('number', '2012');
			var myArray5 = 	[
							['Enero', 20, 10],
							['Febrero', 10, 10],
							['Marzo', 40, 50],
							['Abril', 10, 5],
							['Mayo', 11, 10],
							['Junio', 1, 20],
							['Julio', 6, 6],
							['Agosto', 10, 10],
							['Septiembre', 10, 5],
							['Octubre', 12, 4],
							['Noviembre', 11, 20],
							['Diciembre', 2, 5]
							];
*/			
			//alert(myArray5)

			var data = { }
			//alert(data)
			
			//works
			//data["2011"] =  1
			//alert(data["2011"])
			
			//works too
			/*
			data["2010"] =  []
			data["2010"]["Enero"] = 1
			data["2010"]["Febrero"] = 10
			alert(data["2010"]["Enero"])
			alert(data["2010"]["Febrero"])
			*/
			
			var myArray2 = 	[];

			
			<%String string = "";
			int maxYear = 0;
			maxYear = Integer.parseInt(stats.get(0).getLogDate().substring(0,stats.get(0).getLogDate().indexOf('-')));

			String string2 = "";
			string2 = "data[\\'" + maxYear + "\\'] = [];";
			string2 += "data[\\'" + maxYear + "\\'][\\'Febrero\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Enero\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Marzo\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Abril\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Mayo\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Junio\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Julio\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Agosto\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Septiembre\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Octubre\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Noviembre\\'] = 0;";
			string2 += "data[\\'" + maxYear + "\\'][\\'Diciembre\\'] = 0;";
			%>eval('<%=string2%>');<%
			
			for (Stats stat : stats) {
				int year = Integer.parseInt(stat.getLogDate().substring(0,stat.getLogDate().indexOf('-')));
				int month = Integer.parseInt(stat.getLogDate().substring(stat.getLogDate().indexOf('-') + 1,stat.getLogDate().lastIndexOf('-')));
				int day = Integer.parseInt(stat.getLogDate().substring(stat.getLogDate().lastIndexOf('-') + 1,stat.getLogDate().length()));

				if (year>maxYear){
					maxYear = year;
					string2 = "data[\\'" + maxYear + "\\'] = [];";
					string2 += "data[\\'" + maxYear + "\\'][\\'Febrero\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Enero\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Marzo\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Abril\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Mayo\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Junio\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Julio\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Agosto\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Septiembre\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Octubre\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Noviembre\\'] = 0;";
					string2 += "data[\\'" + maxYear + "\\'][\\'Diciembre\\'] = 0;";
				}
				
				%>eval('<%=string2%>');<%
				/* 				
				System.out.println(year);                            
				System.out.println(month);                            
				System.out.println(day);                            
				*/
				 
				string += "myArray2.push( new Array(\\'" + stat.getLogDate()
						+ "\\'," + stat.getSumIO() + "," + stat.getRowCount()
						+ "));";
				//string+=stat.getSumIO();


				switch (month) {
				case 1:
					string2 = "data[\\'" + year + "\\'][\\'Enero\\'] = ++data[\\'" + year + "\\'][\\'Enero\\'];";
					break;
				case 2:
					string2 = "data[\\'" + year + "\\'][\\'Febrero\\'] = ++data[\\'" + year + "\\'][\\'Febrero\\'];";
					break;
				case 3:
					string2 = "data[\\'" + year + "\\'][\\'Marzo\\'] = ++data[\\'" + year + "\\'][\\'Marzo\\'];";
					break;
				case 4:
					string2 = "data[\\'" + year + "\\'][\\'Abril\\'] = ++data[\\'" + year + "\\'][\\'Abril\\'];";
					break;
				case 5:
					string2 = "data[\\'" + year + "\\'][\\'Mayo\\'] = ++data[\\'" + year + "\\'][\\'Mayo\\'];";
					break;
				case 6:
					string2 = "data[\\'" + year + "\\'][\\'Junio\\'] = ++data[\\'" + year + "\\'][\\'Junio\\'];";
					break;
				case 7:
					string2 = "data[\\'" + year + "\\'][\\'Julio\\'] = ++data[\\'" + year + "\\'][\\'Julio\\'];";
					break;
				case 8:
					string2 = "data[\\'" + year + "\\'][\\'Agosto\\'] = ++data[\\'" + year + "\\'][\\'Agosto\\'];";
					break;
				case 9:
					string2 = "data[\\'" + year + "\\'][\\'Septiembre\\'] = ++data[\\'" + year + "\\'][\\'Septiembre\\'];";
					break;
				case 10:
					string2 = "data[\\'" + year + "\\'][\\'Octubre\\'] = ++data[\\'" + year + "\\'][\\'Octubre\\'];";
					break;
				case 11:
					string2 = "data[\\'" + year + "\\'][\\'Noviembre\\'] = ++data[\\'" + year + "\\'][\\'Noviembre\\'];";
					break;
				case 12:
					string2 = "data[\\'" + year + "\\'][\\'Diciembre\\'] = ++data[\\'" + year + "\\'][\\'Diciembre\\'];";
					break;
				}
				%>eval('<%=string2%>');<%

			}%>
			<%-- alert('<%=string2%>'); --%>
			eval('<%=string%>');
			alert(data.lenght)
			alert(data["2012"]["Enero"])
			alert(data["2012"]["Febrero"])
			alert(data["2012"]["Marzo"])
			alert(data["2012"]["Abril"])
			//alert(data.2012.lenght)
			
			/*
			for (i=0; i<data.2012.lenght;i++)
			{
				alert(data.2012[i]);
			}
			*/
			
			var myArray3 = 	[];

			
			<%String string3 = "";
			for (Stats stat : stats) {
				string3 += "myArray3.push( new Array(\\'" + stat.getLogDate()
						+ "\\'," + stat.getCpuSkw() + "," + stat.getIoSkw()
						+ "," + stat.getPji() + "," + stat.getUii() + "));";
				//string+=stat.getSumIO();
			}%>
			eval('<%=string3%>');
			
			var myArray4 = [];

			
			<%String string4 = "";
			for (Stats stat : stats) {
				string4 += "myArray4.push( new Array(\\'" + stat.getLogDate()
						+ "\\'," + stat.getQueryResponseTime() + ","
						+ stat.getSumCPU() + "));";
				//string+=stat.getSumIO();
			}%>
			eval('<%=string4%>');
			//myArray2.push( new Array( '01/02/2011', 12000000, 20000000) );
			
			//alert(myArray2[1]);

			//var myArray3 = new Array();
			
			//alert(myArray3[1]);
			data.addRows(myArray2);
			data2.addRows(myArray3);
			data3.addRows(myArray4);
			data4.addRows(myArray5);

			var options = {title: 'Company Performance'};
			var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
			var chart2 = new google.visualization.LineChart(document.getElementById('chart_div2'));
			var chart3 = new google.visualization.LineChart(document.getElementById('chart_div3'));
			var chart4 = new google.visualization.LineChart(document.getElementById('chart_div4'));
			chart.draw(data, options);       
			chart2.draw(data2, options);
			chart3.draw(data3,options);
			chart4.draw(data4,options);
			}     
	</script>   
		<div id="chart_div" style="width: 1024; height: 600px;">
		</div>  
		
		<div id="chart_div2" style="width: 1024; height: 600px;">
		</div>
		
		<div id="chart_div3" style="width: 1024; height: 600px;">
		</div>   
		
		<div id="chart_div4" style="width: 1024; height: 600px;">
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
				out.println("<td>" + s.getRowCount() + "</td>");
				out.print("</tr>");
			}
		%>
			
		
	</table>

</body>
</html>