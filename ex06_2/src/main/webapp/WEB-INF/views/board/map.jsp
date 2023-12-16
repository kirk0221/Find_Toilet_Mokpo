<%@ page import="java.util.List" %>
<%@ page import="org.zerock.domain.InfoVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>

<%
    List<InfoVO> infoList = (List<InfoVO>) request.getAttribute("infoList");
    String auth = (String) request.getAttribute("auth");
    // Spring Security의 Principal 객체에서 username을 가져옴
    String username = null;
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    if (principal instanceof org.springframework.security.core.userdetails.UserDetails) {
        username = ((org.springframework.security.core.userdetails.UserDetails) principal).getUsername();
    }
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>화장실 지도</title>
    <style>
        body {
            font-family: 'Malgun Gothic', 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
            background-color: #f2f2f2;
        }

        #container {
            display: flex;
            height: 100vh;
        }

        #map {
            width: 50%;
            height: 100%;
            position: relative;
        }

        #info-container {
            margin-top: 50px;
            width: 50%;
            background-color: #f2f2f2;
            overflow-y: auto;
            padding: 20px;
            box-sizing: border-box;
            position: relative;
        }

        #info-container table {
            width: calc(100% + 20px);
            margin-left: -20px;
            border-collapse: collapse;
            border-spacing: 0;
            background-color: #f2f2f2;
        }

        #info-container th,
        #info-container td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 12px;
            font-size: 14px;
            color: #333;
        }

        #info-container th {
            background-color: #f8f8f8;
        }

        #info-container tbody tr:hover {
            background-color: #f5f5f5;
            cursor: pointer;
        }

        #info-container tbody tr td:first-child {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        #admin-container {
            position: absolute;
            top: 0;
            left: 50%;
            background-color: white;
            padding: 10px;
            z-index: 999;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        #admin-container button {
            padding: 8px 15px;
            border: 1px solid #007bff;
            border-radius: 3px;
            background-color: #007bff;
            color: #fff;
            font-size: 14px;
            cursor: pointer;
        }

        #admin-container button:hover {
            background-color: #0056b3;
        }

        #search-container {
            position: absolute;
            top: 0;
            right: 20px;
            background-color: white;
            padding: 10px;
            z-index: 999;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        #search-container input {
            padding: 8px;
            margin-right: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
            font-size: 14px;
        }

        #search-container button {
            padding: 8px 15px;
            border: 1px solid #007bff;
            border-radius: 3px;
            background-color: #007bff;
            color: #fff;
            font-size: 14px;
            cursor: pointer;
        }

        #search-container button:hover {
            background-color: #0056b3;
        }
    </style>
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f56f2f450ad40dc6a620c5c8b79b642"></script>
</head>

<body>

    <sec:authentication property="principal" var="pinfo" />
    <script>
        var locPosition;

        var originalInfoList = [
            <% for (InfoVO info : infoList) { %>
                {
                    title: '<%=info.getTitle()%>',
                    address: '<%=info.getAddress()%>',
                    latlng: new kakao.maps.LatLng(<%=info.getLat()%>, <%=info.getLng()%>),
                    id: <%=info.getId()%>
                },
            <% } %>
        ];

        // infoList는 검색 또는 초기화 시에 변경될 수 있는 배열이므로 원본을 보존하기 위해 originalInfoList를 사용
        var infoList = originalInfoList.slice();

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var lat = position.coords.latitude,
                    lon = position.coords.longitude;
                locPosition = new kakao.maps.LatLng(lat, lon);

                // 위치 정보를 받은 후에 지도 초기화
                var map = initializeMap(locPosition);

                // 현재 위치에 마커 추가
                addCurrentLocationMarker(map, locPosition);

                // 나머지 마커들 추가
                addMarkers(map, infoList);

                // 현재 위치와 각 위치의 거리 계산 및 업데이트
                updateDistances(locPosition);
            });
        } else {
            locPosition = new kakao.maps.LatLng(34.8118309291849, 126.39223316548866);
            // 위치 정보가 사용 불가능한 경우에도 지도 초기화
            var map = initializeMap(locPosition);

            // 나머지 마커들 추가
            addMarkers(map, infoList);

            // 현재 위치와 각 위치의 거리 계산 및 업데이트
            updateDistances(locPosition);
        }

        function initializeMap(locPosition) {
            var mapContainer = document.getElementById('map'),
                mapOption = {
                    center: locPosition,
                    level: 7
                };

            return new kakao.maps.Map(mapContainer, mapOption);
        }

        function addCurrentLocationMarker(map, locPosition) {
            var imageSize = new kakao.maps.Size(36, 36);
            var markerImage = new kakao.maps.MarkerImage(
                'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png',
                imageSize
            );

            var marker = new kakao.maps.Marker({
                map: map,
                position: locPosition,
                image: markerImage,
                clickable: true
            });

            kakao.maps.event.addListener(marker, 'click', function() {
                alert('현재 위치');
            });
        }

        function addMarkers(map, markers) {
            var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/2018/pc/img/marker_spot.png";

            // username 변수를 전역 범위로 이동
            var username = "<%= username %>";

            // username이 빈 문자열이거나 null이면 초기화
            if (!username || username.trim() === "") {
                username = null;
            }

            for (var i = 0; i < markers.length; i++) {
                var imageSize = new kakao.maps.Size(36, 36);
                var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

                var marker = new kakao.maps.Marker({
                    map: map,
                    position: markers[i].latlng,
                    title: markers[i].title,
                    image: markerImage
                });

                kakao.maps.event.addListener(marker, 'click', (function(marker, i) {
                    return function() {
                        window.location.href = '${pageContext.request.contextPath}/board/info_board?id=' + encodeURIComponent(markers[i].id) + '&userid=' + username;
                    };
                })(marker, i));
            }
        }

        function calculateDistance(locPosition, targetPosition) {
            // Haversine formula 사용하여 거리 계산
            var R = 6371; // 지구의 반지름 (단위: km)
            var dLat = deg2rad(targetPosition.getLat() - locPosition.getLat());
            var dLon = deg2rad(targetPosition.getLng() - locPosition.getLng());
            var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                Math.cos(deg2rad(locPosition.getLat())) * Math.cos(deg2rad(targetPosition.getLat())) *
                Math.sin(dLon / 2) * Math.sin(dLon / 2);
            var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            var distance = R * c; // 단위를 킬로미터로 변환

            return distance;
        }

        function deg2rad(deg) {
            return deg * (Math.PI / 180);
        }

        function updateDistances(locPosition) {
            // 거리 정보를 담은 배열 생성
            var distances = [];

            for (var i = 0; i < infoList.length; i++) {
                var distance = calculateDistance(locPosition, infoList[i].latlng);
                distances.push({ index: i, distance: distance });
            }

            // 거리에 따라 정렬
            distances.sort(function(a, b) {
                return a.distance - b.distance;
            });

            var infoContainer = document.getElementById('info-container');
            var table = document.createElement('table');
            var thead = document.createElement('thead');
            var tbody = document.createElement('tbody');

            // 테이블 헤더 추가
            var headerRow = document.createElement('tr');
            headerRow.innerHTML = '<th>Title</th><th>Address</th><th>Distance</th>';
            thead.appendChild(headerRow);
            table.appendChild(thead);

            // 테이블 바디 추가
            for (var i = 0; i < distances.length; i++) {
                var dataIndex = distances[i].index;
                var dataRow = document.createElement('tr');
                dataRow.innerHTML = '<td>' + infoList[dataIndex].title + '</td><td>' + infoList[dataIndex].address + '</td><td>' + formatDistance(distances[i].distance) + '</td>';
                tbody.appendChild(dataRow);
            }

            table.appendChild(tbody);
            infoContainer.innerHTML = ''; // 기존 내용 초기화
            infoContainer.appendChild(table);
        }

        function formatDistance(distance) {
            // 1km 이내인 경우 미터로 변환
            if (distance < 1) {
                return (distance * 1000).toFixed(2) + 'm';
            } else {
                return distance.toFixed(2) + 'km';
            }
        }

        // 검색 기능 추가
        function searchTitles() {
            var searchInput = document.getElementById('searchInput');
            var keyword = searchInput.value.trim(); // 앞뒤 공백 제거

            // 검색어가 비어 있으면 모든 데이터를 표시
            if (!keyword) {
                infoList = originalInfoList.slice();
            } else {
                // 검색어가 있는 경우 해당하는 title을 포함하는 데이터 필터링
                infoList = originalInfoList.filter(function(info) {
                    return info.title.includes(keyword);
                });
            }

            // 현재 위치와 각 위치의 거리 계산 및 업데이트
            updateDistances(locPosition);
        }

        // 초기화 기능 추가
        function resetTable() {
            // 검색어 입력창 비우기
            document.getElementById('searchInput').value = '';

            // 모든 데이터를 원래대로 복원
            infoList = originalInfoList.slice();

            // 현재 위치와 각 위치의 거리 계산 및 업데이트
            updateDistances(locPosition);
        }
        
        // '등록' 버튼 클릭 시 동작하는 함수
        function mapcontrol() {
        	window.location.href = '${pageContext.request.contextPath}/board/mapdb	';
        }

    </script>

    <!-- 검색 및 초기화 버튼을 추가한 부분 -->
    <div id="container">
        <!-- 검색창 및 버튼 추가 -->
        <div id="search-container">
            <input type="text" id="searchInput" placeholder="Search by title">
            <button onclick="searchTitles()">Search</button>
            <button onclick="resetTable()">Reset</button>
        </div>
        <!-- 등록 버튼이 있는 admin-container 추가 -->
        <sec:authorize access="hasRole('ROLE_ADMIN')">
	        <div id="admin-container">
	            <button onclick="mapcontrol()">화장실 정보 수정</button>
	        </div>
	    </sec:authorize>
        <div id="map"></div>
        <div id="info-container"></div>
    </div>
</body>

</html>
