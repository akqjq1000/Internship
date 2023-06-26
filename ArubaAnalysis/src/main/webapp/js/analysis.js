/**
 * 
 */
$(document).ready(function() {
	$('#startDate').val(getCurrentDate());
	$('#endDate').val(getCurrentDate());
	getClientData();
});
function drawLineChart(tx, rx, times) {
	var chart = c3.generate({
		bindto: "#linechart",
		data: {
			columns: [['RX'].concat(rx), ['TX'].concat(tx)],
			labels: {
				format: {
					'RX': function(v, id, i, j) {
						// 가장 큰 값만 라벨로 표시
						if (v === Math.max.apply(null, rx)) {
							return v;
						} else {
							return '';
						}
					},
					'TX': function(v, id, i, j) {
						// 가장 큰 값만 라벨로 표시
						if (v === Math.max.apply(null, tx)) {
							return v;
						} else {
							return '';
						}
					}
				}
			}
		},
		grid: {
			y: {
				show: true,
				lines: [{
					value: 0
				}]
			}
		},
		axis: {
			x: {
				type: 'category',
				categories: times,
				tick: {
					culling: {
						max: 5
					},
					multiline: false
				}
			},
		}
	});
}
function drawBarChart(clients, times) {
	var chart = c3.generate({
		bindto: "#barchart",
		data: {
			columns: [['Client'].concat(clients)],
			labels: {
				format: {
					'Client': function(v, id, i, j) {
						// 가장 큰 값만 라벨로 표시
						if (v === Math.max.apply(null, clients)) {
							return v;
						} else {
							return '';
						}
					}
				}
			},
			type: 'bar'
		},
		grid: {
			y: {
				show: true,
				lines: [{
					value: 0
				}]
			}
		},
		axis: {
			x: {
				type: 'category',
				categories: times,
				tick: {
					culling: {
						max: 5
					},
					multiline: false
				}
			},
		}
	});
}
$(document).ready(function() {
	$('#submit-btn').click(function() {
		getClientData();
	});
});

function getCurrentDate() {
	var today = new Date();
	var year = today.getFullYear();
	var month = String(today.getMonth() + 1).padStart(2, '0');
	var day = String(today.getDate()).padStart(2, '0');
	return year + '-' + month + '-' + day;
}

function getClientData() {
	var sDate = $('#startDate').val();
	var eDate = $('#endDate').val();

	// Ajax 요청 보내기
	$.ajax({
		url: 'getPeriodData.jsp',
		method: 'GET',
		data: {
			startDate: sDate,
			endDate: eDate
		},
		dataType: "json", // 응답 데이터 타입 (json으로 지정)
		success: function(data) {
			// 성공적으로 요청을 처리한 후의 동작
			var cntList = [];
			var rxList = [];
			var txList = [];
			var current_timesList = [];
			$.each(data, function(index, item) {
				cntList.push(item.cnt);
				rxList.push(item.rx);
				txList.push(item.tx);
				current_timesList.push(item.current_times);
			});
			drawBarChart(cntList, current_timesList);
			drawLineChart(txList, rxList, current_timesList);
			console.log(data);
		},
		error: function(xhr, status, error) {
			// 요청 실패 시의 동작
			console.log(error);
		}
	});
}