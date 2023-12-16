<%@ page import="java.util.List" %>
<%@ page import="org.zerock.domain.InfoVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    List<InfoVO> infoList = (List<InfoVO>) request.getAttribute("infoList");
    String auth = (String) request.getAttribute("auth");
%>

<%
    // 현재 날짜를 가져오기
    Date currentDate = new Date();
    
    // 날짜를 "yyyy/MM/dd" 형식으로 포맷
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
    String formattedDate = sdf.format(currentDate);
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
	<form id="addInfoForm" action="${pageContext.request.contextPath}/board/mapdb" method="post">
	    Title: <input type="text" name="title" required><br>
	    Latitude: <input type="text" name="lat" required><br>
	    Longitude: <input type="text" name="lng" required><br>
	    Address: <input type="text" name="address" required><br>
	    <div style="display: none;">updatedate: <input type="text" name="infoscore" value="${formattenDate}" readonly></div>
	    <!-- infoscore를 입력 폼에서는 보이지 않게 설정 -->
	    <div style="display: none;">Info Score: <input type="text" name="infoscore" value=0 readonly></div>
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
