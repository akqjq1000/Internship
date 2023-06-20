
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
					columns : [ [ '사용자 수' ].concat(datas) ],
					labels : {
						format : {
							'사용자 수' : function(v, id, i, j) {
								// 가장 큰 값만 라벨로 표시
								if (v === Math.max.apply(null, datas)) {
									return v;
								} else {
									return '';
								}
							}
						}
					},
					type : 'bar'
				},
				grid : {
					y : {
						show : true,
						lines : [ {
							value : 0
						} ]
					}
				},
				axis : {
					x : {
						type : 'category',
						categories : generateTimeLabels(48),
						tick : {
							culling : {
								count : 10
							},
							multiline : false
						}
					},
				}
			});
		}
		var chartdata =
	<%=todayClients%>
		;
		drawChart(chartdata);

		// 시간 레이블 생성
		function generateTimeLabels(count) {
			var labels = [];
			var minutes = 0;
			for (var i = 0; i < count; i++) {
				var hours = Math.floor(minutes / 60);
				var mins = minutes % 60;
				labels.push(padZero(hours) + ':' + padZero(mins));
				minutes += 30;
			}
			return labels;
		}

		// 숫자 앞에 0 추가
		function padZero(num) {
			return num.toString().padStart(2, '0');
		}

		function getData() {
			$.ajax({
				url : "getClientsToJSON.jsp", // 서버의 URL
				type : "GET", // 요청 메서드 (GET, POST 등)
				dataType : "json", // 응답 데이터 타입 (json으로 지정)
				success : function(data) {
					var html = '<ul>';
					$.each(data, function(index, item) {
						html += '<li>' + item.cnt + ' - ' + item.current_times
								+ '</li>';
					});
					html += '</ul>';
					$('#data-container').html(html);
				},
				error : function(xhr, status, error) {

				}
			});
		}
		getData();
	</script>
	<div id="data-container"></div>
</body>
</html>