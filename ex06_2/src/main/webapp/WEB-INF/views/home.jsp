<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>        
<%@ page session="false" %>
<html>
<head>
    <title>인권지킴이</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #fff; /* 흰색 배경으로 변경 */
            text-align: center;
            margin: 0;
            padding: 0;
        }

        h1 {
            color: #4285f4; /* 신선한 파랑색 */
            font-size: 36px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        .image-container {
            margin-top: 20px; /* h1과 button 사이 간격 20px로 설정 */
        }

        img {
            width: 100%; /* 이미지를 100%의 너비로 설정 */
            max-width: 650px; /* 최대 너비 설정 */
            height: auto; /* 자동으로 높이 조절 */
        }

        .new-button {
            position: absolute;
            top: 0; /* 맨 위에 위치 */
            right: 0; /* 화면 오른쪽 끝에 위치 */
        }

        .button-container {
            display: flex;
            justify-content: center;
            align-items: flex-end;
            height: calc(30px); /* 창 아래보다 130px 떨어지게 설정 (30px 간격 + 100px 간격) */
            margin-top: 30px; /* 버튼과 이미지 사이 간격 30px로 설정 */
        }

        .button-wrapper {
            position: relative;
            animation: bounceUpDown 2s infinite alternate; /* 애니메이션 설정 */
        }

        button {
            padding: 10px 20px;
            font-size: 18px;
            margin: 5px; /* 버튼 간격 5px로 설정 */
            cursor: pointer;
            border: none;
            border-radius: 5px;
            background-color: #4285f4; /* 신선한 파랑색 */
            color: #fff;
            text-decoration: none;
        }

        @keyframes bounceUpDown {
            0%, 100% {
                top: 0;
            }
            50% {
                top: -7px; /* 7px 위로 이동 */
            }
        }

        .button-wrapper:nth-child(2) {
            animation-name: bounceUpDown; /* 두 번째 버튼은 애니메이션 방향 반대로 */
            animation-delay: 2s; /* 두 번째 버튼은 2초 지연 후 애니메이션 시작 */
        }
    </style>
</head>
<body>
    <h1>인권지킴이(공중화장실 찾기)</h1>
    <div class="image-container">
        <img src="${pageContext.request.contextPath}/resources/img/jogging.png" alt="Your Image Alt Text">
    </div>
    <div class="new-button">
    	<sec:authorize access="isAnonymous()">
    		<a href="/customLogin"> <button>로그인</button></a>
    	</sec:authorize>
    	<sec:authorize access="isAuthenticated()">
    		<a href="/customLogout"> <button>로그아웃</button></a>
    	</sec:authorize>
       
    </div>
    <div class="button-container">
        <div class="button-wrapper"><a href="/board/map"><button>인권 찾기 시작</button></a></div>
        <div class="button-wrapper"><a href="/board/list"><button>인권 찾은 사람들</button></a></div>
    </div>
    <script>
    </script>
</body>
</html>
