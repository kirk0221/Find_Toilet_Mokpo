<%@ page import="java.util.List" %>
<%@ page import="org.zerock.domain.InfoVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>화장실 지도</title>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f56f2f450ad40dc6a620c5c8b79b642"></script>
</head>
<body>
    <div id="map" style="width:100%;height:450px;"></div>

    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(34.8118309291849, 126.39223316548866),
                level: 7
            };

        var map = new kakao.maps.Map(mapContainer, mapOption);

        var positions = [
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

        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

        for (var i = 0; i < positions.length; i ++) {
            var imageSize = new kakao.maps.Size(24, 35);
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

            var marker = new kakao.maps.Marker({
                map: map,
                position: positions[i].latlng,
                title: positions[i].title,
                image: markerImage
            });

            kakao.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                    window.location.href = '${pageContext.request.contextPath}/board/info_board?title=' + encodeURIComponent(positions[i].title) + '&id=' + encodeURIComponent(positions[i].id);
                };
            })(marker, i));
        }
    </script>
</body>
</html>
