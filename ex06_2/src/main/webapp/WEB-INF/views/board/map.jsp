<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <title>화장실 지도</title>
</head>
<body>
    <!-- 지도를 표시할 div -->
    <div id="map" style="width:100%;height:450px;"></div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f56f2f450ad40dc6a620c5c8b79b642"></script>
    <script>
        // 지도를 표시할 div와 옵션 설정
        var mapContainer = document.getElementById('map'),
            mapOption = {
                center: new kakao.maps.LatLng(34.82325805894606, 126.40218358099294), // 지도의 중심좌표
                level: 6 // 지도의 확대 레벨
            };

        // 지도 생성
        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 마커 표시할 위치와 정보 배열
        var positions = [
        	//{ title: '여기에 장소 이름', latlng: new kakao.maps.LatLng(위도,경도), content : '<div>html로 표시되는 글씨</div>' }
            { title: '목포시청', latlng: new kakao.maps.LatLng(34.82325805894606, 126.40218358099294) },
            { title: '목포역', latlng: new kakao.maps.LatLng(34.79115650080805, 126.3866567192007) },
            { title: '목포 버스터미널', latlng: new kakao.maps.LatLng(34.8127853844176, 126.41783346036843) },
            { title: '달맞이공원', latlng: new kakao.maps.LatLng(34.79356511675937, 126.42632481851312) },
            { title: '평화광장 2호매점', latlng: new kakao.maps.LatLng(34.795866412135275, 126.43219310247406) },
            { title: '평화광장 1호매점', latlng: new kakao.maps.LatLng(34.796642363465, 126.43380500356332) },
            { title: '평화광장공원(평화다리 앞)', latlng: new kakao.maps.LatLng(34.798606885863315, 126.43855593182505) },
            { title: '카누경기장', latlng: new kakao.maps.LatLng(34.80180714456387, 126.44205027092681) },
            { title: '부흥산공원(만남의 폭포)', latlng: new kakao.maps.LatLng(34.803879761248666, 126.43897916066479) },
            { title: '둥근근린공원(부흥동사무소옆)', latlng: new kakao.maps.LatLng(34.80430904140245, 126.43483720277274) },
            { title: '부영어린이공원(부영5차옆)', latlng: new kakao.maps.LatLng(34.803678153708624, 126.43437160089888) },
            { title: '입암산내등산로', latlng: new kakao.maps.LatLng(34.79738565536757, 126.42269509090625) },
            { title: '문화예술회관야외', latlng: new kakao.maps.LatLng(34.79209591430474, 126.42015875475134) },
            { title: '갓바위해양관광지', latlng: new kakao.maps.LatLng(34.793599886397665, 126.41798472854458) },
            { title: '중화어린이공원(상동현대@앞)', latlng: new kakao.maps.LatLng(34.811533070549416, 126.41467555506077) },
            { title: '수원지웰빙공원', latlng: new kakao.maps.LatLng(34.822366592286166, 126.41115033786713) },
            { title: '용해어린이공원', latlng: new kakao.maps.LatLng(34.81902451757934, 126.39640208629959) },
            { title: '양을산체육공원', latlng: new kakao.maps.LatLng(34.811348322735654, 126.40584888582636) },
            { title: '양을체육(테니스)공원', latlng: new kakao.maps.LatLng(34.81183209812421, 126.40570060196379) },
            { title: '동목포근린공원', latlng: new kakao.maps.LatLng(34.80945791698712, 126.39266588415155) },
            { title: '청호근린공원(동초등학교 밑)', latlng: new kakao.maps.LatLng(34.80753559164996, 126.3872512167638) },
            { title: '삼학도성당', latlng: new kakao.maps.LatLng(34.793303955333144, 126.39202221661502) },
            { title: '삼학도중앙공연장', latlng: new kakao.maps.LatLng(34.78433107353347, 126.3943878848356) },
            { title: '삼학도물양장', latlng: new kakao.maps.LatLng(34.785963356240615, 126.392278213345) },
            { title: '연안여객선터미널 1층', latlng: new kakao.maps.LatLng(34.7820378061742, 126.3842141543786) },
            { title: '국도시점놀이터(유달동)', latlng: new kakao.maps.LatLng(34.78709705243033, 126.38202142464473) },
            { title: '인어바위', latlng: new kakao.maps.LatLng(34.78230101517544, 126.36872840625107) },
            { title: '유달유원지 B(원형)', latlng: new kakao.maps.LatLng(34.78773122547153, 126.3672912426623) },
            { title: '유달유원지 A(기와)', latlng: new kakao.maps.LatLng(34.78811815703288, 126.36716263863914) },
            { title: '북항물양장(2부두)', latlng: new kakao.maps.LatLng(34.80153832665657, 126.36383093640528) },
            { title: '북항주차장', latlng: new kakao.maps.LatLng(34.8030535937114, 126.36790089017246) },
            { title: '북항횟집거리', latlng: new kakao.maps.LatLng(34.80403539685983, 126.3668962058978) },
            { title: '옥암지구 어린이공원', latlng: new kakao.maps.LatLng(34.80919207080617, 126.45654131618686) },
            { title: '대죽도근린공원', latlng: new kakao.maps.LatLng(34.8082445878687, 126.46087257567862) },
            { title: '남악수변공원', latlng: new kakao.maps.LatLng(34.808295074613845, 126.46721910464056) }
            //{ title: '', latlng: new kakao.maps.LatLng(,) },
        ];

        // 마커 이미지 주소
        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
        
        // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
		var iwContent = '<div style="padding:5px;">Hello World!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
        
        for (var i = 0; i < positions.length; i++) {
            var imageSize = new kakao.maps.Size(24, 35);
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

            var marker = new kakao.maps.Marker({
                map: map,
                position: positions[i].latlng,
                title: positions[i].title,
                image: markerImage
            });

            // 마커에 클릭 이벤트를 추가합니다
            kakao.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                    // 정보창을 생성하고 마커 위에 표시합니다
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="padding:5px;font-size:12px;">' + positions[i].title + '</div>'
                    });
                    infowindow.open(map, marker);
                };
            })(marker, i));
        }
    </script>
</body>
</html>
