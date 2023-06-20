
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
<!-- stylesheet -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css" />
<script src="js/c3-0.7.20/c3.min.js"></script>
</head>
<body>
	<!-- javascript -->
	<script src="https://d3js.org/d3.v3.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
	<div id="linechart"></div>
	<script>
		function drawChart(datas) {
			var chart = c3.generate({
				bindto : "#linechart",
				data : {
					columns : [ datas ]
				}
			});
		}
		drawChart(<%=todayClients%>);
	</script>
</body>
</html>