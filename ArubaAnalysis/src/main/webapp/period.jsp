
<%@page import="dto.Clients"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDate"%>
<%@page import="dao.ClientsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- stylesheet -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.container {
	text-align: center;
	margin-top: 50px;
}

.date-input {
	display: inline-block;
	margin: 10px;
}

.btn-submit {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	cursor: pointer;
}

.btn-submit:hover {
	background-color: #45a049;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js" integrity="sha512-57oZ/vW8ANMjR/KQ6Be9v/+/h6bq9/l3f0Oc7vn6qMqyhvPd1cvKBRWWpzu0QoneImqr2SkmO4MSqU+RpHom3Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- javascript -->
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>

<style>
input[type=date] {
	border: none;
	padding-left: 10px;
}

input[type=date]::target {
	border: none;
}
</style>

</head>
<body>
	<div class="container">
		<div>
			<h1>무선랜 기간별 통계</h1>
		</div>
		<div class="date-input">
			<label for="startDate">시작 날짜:</label>
			<input type="date" id="startDate">
		</div>
		<div class="date-input">
			<label for="endDate">종료 날짜:</label>
			<input type="date" id="endDate">
		</div>
		<button class="btn-submit" id="submit-btn">전송</button>
	</div>
	<div id="barchart"></div>
	<div id="linechart"></div>


	<!-- Load Script -->
	<script src="js/analysis.js"></script>
</body>
</html>