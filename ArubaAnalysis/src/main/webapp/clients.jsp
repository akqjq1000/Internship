
<%@page import="dto.Clients"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDate"%>
<%@page import="dao.ClientsDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
ClientsDAO cdao = new ClientsDAO();
LocalDate today = LocalDate.now();
ArrayList<Clients> todayClientsList = cdao.getClientsList(today);
ArrayList<Integer> todayClients = cdao.getClients(today);
ArrayList<Integer> yesterdayClients = cdao.getClients(today.minusDays(1));

Clients maxClients = cdao.getMaximumTraffic(today);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
}

.grid-container {
	display: grid;
	width: 100%;
	grid-template-columns: 50% 50%;
	grid-template-rows: 1fr 1fr;
}
</style>
</head>
<body>
	<div class="grid-container">
		<div class="chart-container">
			<label for="datePicker">날짜 선택:</label>
			<input type="date" id="datePicker">
			<h2 id="todayHeader" style="text-align: center">오늘</h2>
			<canvas id="todayChart"></canvas>
		</div>
		<div class="chart-container">
			<h2 id="yesterdayHeader" style="text-align: center">어제</h2>
			<canvas id="yesterdayChart"></canvas>
		</div>
		<div>
			<span><%=today%>
				가장 많은 사용자 :
				<strong><%=maxClients.getCnt()%></strong>
			</span>

		</div>
	</div>


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
		function drawChart(datas, chart) {
			// 차트 데이터 준비
			var data = {
				labels : getTime(),
				datasets : [ {
					label : "사용자 수",
					data : datas,
					backgroundColor : "rgba(75, 192, 192, 0.8)",
					borderColor : "rgba(75, 192, 192, 1)",
					borderWidth : 1
				} ]
			};

			// 차트 생성
			var ctx = document.getElementById(chart).getContext("2d");
			var barChart = new Chart(ctx, {
				type : "bar",
				data : data,
				options : {
					scales : {
						x : {
							display : true,
							title : {
								display : true,
								text : "시간"
							}
						},
						y : {
							display : true,
							title : {
								display : true,
								text : "사용자수(명)"
							}
						}
					},
					plugins : {
						tooltip : {
							enabled : true,
							mode : "index",
							intersect : false,
							callbacks : {
								label : function(context) {
									var label = context.dataset.label || "";
									if (label) {
										label += ": ";
									}
									if (context.parsed.y !== null) {
										label += context.parsed.y + " 명";
									}
									return label;
								}
							}
						}
					},
					title : {
						display : true,
						text : "제목",
						fontSize : 18,
						fontColor : "#333"
					}
				}
			});
		}

		drawChart(
	<%=todayClients%>
		, "todayChart");
		drawChart(
	<%=yesterdayClients%>
		, "yesterdayChart");
	</script>
</body>
</html>