<%@ page import="java.util.List" %>
<%@ page import="org.zerock.domain.InfoVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>

<%
    List<InfoVO> infoList = (List<InfoVO>) request.getAttribute("infoList");
    String auth = (String) request.getAttribute("auth");
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>map controller</title>
</head>

<body>

    <h1>Info List</h1>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Latitude</th>
            <th>Longitude</th>
            <th>Address</th>
            <th>Update Date</th>
            <th>Info Score</th>
        </tr>

        <% for (InfoVO info : infoList) { %>
            <tr>
                <td><%= info.getId() %></td>
                <td><%= info.getTitle() %></td>
                <td><%= info.getLat() %></td>
                <td><%= info.getLng() %></td>
                <td><%= info.getAddress() %></td>
                <td><%= info.getUpdateDate() %></td>
                <td><%= info.getInfoscore() %></td>
            </tr>
        <% } %>

    </table>

</body>

</html>
