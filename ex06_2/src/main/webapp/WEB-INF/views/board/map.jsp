<%@ page import="java.util.List" %>
<%@ page import="org.zerock.domain.InfoVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    List<InfoVO> infoList = (List<InfoVO>) request.getAttribute("infoList");
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
        }

        #container {
            display: flex;
            height: 100%;
        }

        #map {
            width: 50%;
            height: 100%;
            position: relative;
        }

        #info-container {
            width: 50%;
            background-color: #f2f2f2;
            overflow-y: auto; /* 표가 너무 길 경우 스크롤 표시 */
            padding: 20px;
        }

        #info-container table {
            width: 100%;
            border-collapse: collapse;
            border-spacing: 0;
        }

        #info-container th, #info-container td {
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
    </style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f56f2f450ad40dc6a620c5c8b79b642"></script>
</head>
<body>
    <script>
        var infoList = [
            <%
            for(InfoVO info : infoList) {
            %>
                {
                    title: '<%=info.getTitle()%>',
                    latlng: new kakao.maps.LatLng(<%=info.getLat()%>, <%=info.getLng()%>),
                    id: <%=info.getId()%>
                },
            <%
            }
            %>
        ];

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var lat = position.coords.latitude,
                    lon = position.coords.longitude;
                var locPosition = new kakao.maps.LatLng(lat, lon);

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
            var locPosition = new kakao.maps.LatLng(34.8118309291849, 126.39223316548866);
            // 위치 정보가 사용 불가능한 경우에도 지도 초기화
            var map = initializeMap(locPosition);
            
            // 나머지 마커들 추가
            addMarkers(map, infoList);
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
                        window.location.href = '${pageContext.request.contextPath}/board/info_board?id=' + encodeURIComponent(markers[i].id);
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
            var distance = R * c;

            return distance * 1000; // 단위를 미터로 변환
        }

        function deg2rad(deg) {
            return deg * (Math.PI / 180);
        }

        function updateDistances(locPosition) {
            var tableRows = document.querySelectorAll("#info-container tbody tr");

            for (var i = 0; i < infoList.length; i++) {
                var targetPosition = infoList[i].latlng;
                var distance = calculateDistance(locPosition, targetPosition);
                var distanceCell = tableRows[i].querySelector("td:last-child");
                distanceCell.textContent = distance.toFixed(2) + "m";
            }
        }
    </script>
    
    <div id="container">
        <div id="map"></div>
        <div id="info-container">
            <h2>Information</h2>
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>address</th>
                        <th>Distance</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for(InfoVO info : infoList) {
                    %>
                        <tr>
                            <td><%=info.getTitle()%></td>
                            <td><%=info.getAddress()%></td>
                            <td></td> <!-- Empty cell for distance, to be filled dynamically -->
                        </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
