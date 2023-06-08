<%@page import="java.util.Collections"%>
<%@page import="dto.Clients"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDate"%>
<%@page import="dao.ClientsDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
ClientsDAO cdao = new ClientsDAO();
LocalDate today = LocalDate.now();

ArrayList<Double> todayTXtraffic = cdao.getTrafficData(today, "tx");
ArrayList<Double> todayRXtraffic = cdao.getTrafficData(today, "rx");
ArrayList<Double> yesterdayTXtraffic = cdao.getTrafficData(today.minusDays(1), "tx");
ArrayList<Double> yesterdayRXtraffic = cdao.getTrafficData(today.minusDays(1), "rx");
%>
<html>
<head>
<title>Line Chart Example</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<h2 id="todayHeader" style="text-align: center">오늘</h2>
	<canvas id="todayChart"></canvas>
	<h2 id="yesterdayHeader" style="text-align: center">어제</h2>
	<canvas id="yesterdayChart"></canvas>
	<script>
		function getTime() {
			var labels = [];
			var hour = 0;
			var minute = 0;

			for (var i = 0; i < 48; i++) {
				var time = ("0" + hour).slice(-2) + ":"
						+ ("0" + minute).slice(-2);
				labels.push(time);

				minute += 30;
				if (minute === 60) {
					hour++;
					minute = 0;
				}
			}
			return labels;
		}

		function drawChart(tx, rx, chart) {
			var ctx = document.getElementById(chart).getContext("2d");
			var chart = new Chart(ctx, {
				type : "line",
				data : {
					labels : getTime(),
					datasets : [ {
						label : "tx",
						data : tx,
						borderColor : "rgba(255, 99, 132, 1)",
						borderWidth : 1,
						pointStyle : "circle",
						pointRadius : 5,
						pointBackgroundColor : "rgba(255, 99, 132, 1)",
						fill : false,
						borderDash : [ 5, 5 ],
					}, {
						label : "rx",
						data : rx,
						borderColor : "rgba(54, 162, 235, 1)",
						borderWidth : 1,
						pointStyle : "circle",
						pointRadius : 5,
						pointBackgroundColor : "rgba(54, 162, 235, 1)",
						fill : false,
						borderDash : [ 5, 5 ],
					}, ],
				},
				options : {
					responsive : true,
					scales : {
						x : {
							display : true,
							title : {
								display : true,
								text : "시간",
							},
						},
						y : {
							display : true,
							title : {
								display : true,
								text : "Traffic(GB)",
							},
						},
					},
					plugins : {
						tooltip : {
							enabled : true,
							mode : "nearest",
							intersect : false,
						},
					},
				},
			});
		}

		drawChart(
	<%=todayTXtraffic%>
		,
	<%=todayRXtraffic%>
		, "todayChart");
		drawChart(
	<%=yesterdayTXtraffic%>
		,
	<%=yesterdayRXtraffic%>
		,
				"yesterdayChart");
	</script>
</body>
</html>
