<%@ page import="java.util.List" %>
<%@ page import="org.zerock.domain.InfoVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
            align-items: center;
            height: 100vh;
        }

        #map {
            width: 100%;
            height: 100%;
        }
    </style>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f56f2f450ad40dc6a620c5c8b79b642"></script>
</head>
<body>
    <div id="map"></div>

    <script>
        var infoList = [
            <%
            List<InfoVO> infoList = (List<InfoVO>) request.getAttribute("infoList");
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
    </script>
</body>
</html>
