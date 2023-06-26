<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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

.container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	height: 100vh;
	width: 100%;
	align-items: center;
}

button {padding 10px;
	background: #4bc0c0cc;
	border-color: #4bc0c0;
	opacity: 0.8;
	color: #fff;
	margin: 10px;
	padding: 10px;
}

button:hover {
	opacity: 1;
	transition: 0.1s;
}
</style>
</head>
<body>
	<div class="container">
		<div>
			<h1>무선랜 통계</h1>
		</div>
		<div>
			<button onclick="location.href='clients-c3js.jsp'">기간별 통계</button>
			<button onclick="location.href='traffic.jsp'">비교 통계</button>
		</div>
	</div>

</body>
</html>