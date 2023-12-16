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

    <!-- 폼 추가 -->
	<h2>Add Info</h2>
	<form id="addInfoForm" action="${pageContext.request.contextPath}/board/addInfo" method="post">
	    Title: <input type="text" name="title" required><br>
	    Latitude: <input type="text" name="lat" required><br>
	    Longitude: <input type="text" name="lng" required><br>
	    Address: <input type="text" name="address" required><br>
	    <!-- updatedate를 현재 시간으로 설정 -->
	    Update Date: <input type="text" name="updateDate" value="<%= new java.util.Date() %>" readonly><br>
	    <!-- infoscore를 입력 폼에서는 보이지 않게 설정 -->
	    <div style="display: none;">Info Score: <input type="text" name="infoscore" value="null" readonly></div>
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

	    <input type="submit" value="Add Info">
	</form>
	<script>
	    // 폼이 제출되기 전에 infoscore 필드를 설정
	    document.getElementById("addInfoForm").addEventListener("submit", function() {
	        document.getElementsByName("infoscore")[0].value = null;
	    });
	</script>

</body>

</html>
