<%@page import="java.time.LocalDate"%>
<%@page import="dao.ClientsDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>


<%
LocalDate startDate = LocalDate.of(2023, 6, 10);
LocalDate endDate = LocalDate.of(2023, 6, 12);
ClientsDAO cdao = new ClientsDAO();
String data = cdao.getBehindTheDateClients(startDate, endDate);
out.print(data);
%>