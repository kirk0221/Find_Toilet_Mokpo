<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Info Board</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #f2f2f2;
        }

        form {
            margin-top: 20px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }

        h2 {
            color: #333;
        }

        .info-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
            max-width: 600px;
            width: 100%;
        }

        p {
            margin: 10px 0;
            color: #555;
        }
    </style>
</head>
<body>
    <div class="info-container">
        <h2>Information Board</h2>

        <%-- id와 title 값을 받아옵니다 --%>
        <% String id = request.getParameter("id"); %>
        <sec:authentication property="principal" var="pinfo"/>
        <sec:authorize access="isAuthenticated()">
       	<c:if test="${result}">
        	<form action="/board/info_board_out" method="post">
    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>          
    			<div class="form-group">
        			<label></label> <input class="form-control" type="hidden" name='infoid' value="${info.id}">
    			</div>
    			<div class="form-group">
        			<label></label> <input class="form-control" type="hidden" name='userid' value='<sec:authentication property="principal.username"/>' readonly="readonly">
    			</div> 	 	       
    			<button type="submit" class="btn btn-default">즐겨찾기 삭제</button>
			</form>
        </c:if>
        <c:if test="${not result}">
        	<form action="/board/info_board_in" method="post">
    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>          
    			<div class="form-group">
        			<label></label> <input class="form-control" type="hidden" name='infoid' value="${info.id}">
    			</div>
    			<div class="form-group">
        			<label></label> <input class="form-control" type="hidden" name='userid' value='<sec:authentication property="principal.username"/>' readonly="readonly">
    			</div> 	 	       
    			<button type="submit" class="btn btn-default">즐겨찾기 등록</button>
			</form>
        </c:if>
        </sec:authorize>
		
        <p>Title: ${info.title}</p>
        <p>Score: ${info.infoscore}</p>
        <p>Address: ${info.address}</p>
    </div>
    
    <form action="<%= request.getContextPath() %>/board/list" method="get">
        <button type="submit">리스트로 돌아가기</button>
    </form>
    <form action="<%= request.getContextPath() %>/board/map" method="get">
        <button type="submit">지도로 돌아가기</button>
    </form>
</body>
</html>
