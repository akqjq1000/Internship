<%@page import="dao.ClientsDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>


<%
String sDate = request.getParameter("startDate");
String eDate = request.getParameter("endDate");

String[] attArr = { ClientsDAO.CNT, ClientsDAO.RX, ClientsDAO.TX, ClientsDAO.CURRENT_TIMES };

ClientsDAO cdao = new ClientsDAO();
String data = cdao.getData(attArr, sDate, eDate);
out.print(data);
%>