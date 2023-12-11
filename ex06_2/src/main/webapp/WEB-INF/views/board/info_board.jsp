<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Info Board</title>
</head>
<body>

    <form action="<%= request.getContextPath() %>/board/list" method="get">
        <button type="submit">리스트로 돌아가기</button>
    </form>
    <form action="<%= request.getContextPath() %>/board/map" method="get">
        <button type="submit">지도로 돌아가기</button>
    </form>
    <h2>Information Board</h2>

    <%-- id와 title 값을 받아옵니다 --%>
    <% String id = request.getParameter("id"); %>
    <% String title = request.getParameter("title"); %>

	<p>Title: ${info.title}</p>
	<p>Address: ${info.address}</p>

</body>
</html>
