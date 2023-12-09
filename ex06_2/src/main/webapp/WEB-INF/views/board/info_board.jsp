<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Info Board</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 20px;
        }

        form {
            margin-bottom: 10px;
        }

        button {
            padding: 8px;
            margin-right: 10px;
        }

        h2 {
            color: #333;
        }

        p {
            margin: 5px 0;
        }

        #address {
            font-weight: bold;
            color: #1e90ff;
        }
    </style>
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

    <p>Title: <%= title %></p>
    <p>Address: <span id="address"></span></p>

    <%-- JavaScript 코드를 선언합니다. --%>
    <script>
	var values = [
	    { id: 0, address: '전라남도 목포시 양을로 203' },
	    { id: 1, address: '전라남도 목포시 영산로 98' },
	    { id: 2, address: '전라남도 목포시 영산로 525' },
	    { id: 3, address: '전라남도 목포시 상동 1151' },
	    { id: 4, address: '전라남도 목포시 상동 1157' },
	    { id: 5, address: '전라남도 목포시 상동 1157' },
	    { id: 6, address: '전라남도 목포시 옥암동 1100' },
	    { id: 7, address: '전라남도 목포시 옥암동 1375' },
	    { id: 8, address: '전라남도 목포시 옥암동 538-12' },
	    { id: 9, address: '전라남도 목포시 옥암동 1021' },
	    { id: 10, address: '전라남도 목포시 옥암동 1025' },
	    { id: 11, address: '전라남도 목포시 상동 산102-33' },
	    { id: 12, address: '전라남도 목포시 용해동 924-1' },
	    { id: 13, address: '전라남도 목포시 용해동 11-4' },
	    { id: 14, address: '전라남도 목포시 용해동 338-2' },
	    { id: 15, address: '전라남도 목포시 상동 349-7' },
	    { id: 16, address: '전라남도 목포시 용해동 998' },
	    { id: 17, address: '전라남도 목포시 용해동 338-2' },
	    { id: 18, address: '전라남도 목포시 용해동 산34-3' },
	    { id: 19, address: '전라남도 목포시 용당동 881' },
	    { id: 20, address: '전라남도 목포시 산정동 267-13' },
	    { id: 21, address: '전라남도 목포시 산정동 1098-1' },
	    { id: 22, address: '전라남도 목포시 산정동 1487' },
	    { id: 23, address: '전라남도 목포시 산정동 1428' },
	    { id: 24, address: '전라남도 목포시 항동 6-10' },
	    { id: 25, address: '전라남도 목포시 대의동2가1-127' },
	    { id: 26, address: '전라남도 목포시 온금동 165-16' },
	    { id: 27, address: '전라남도 목포시 죽교동 462' },
	    { id: 28, address: '전라남도 목포시 죽교동 465-142' },
	    { id: 29, address: '전라남도 목포시 죽교동 674' },
	    { id: 30, address: '전라남도 목포시 죽교동 620-112' },
	    { id: 31, address: '전라남도 목포시 죽교동 620-225' },
	    { id: 32, address: '전라남도 목포시 옥암동 1318' },
	    { id: 33, address: '전라남도 무안군 삼향읍 남악리 2286' },
	    { id: 34, address: '전라남도 무안군 삼향읍 남악리 2321' }
	];

        // 선택한 ID에 해당하는 주소를 표시
        document.getElementById("address").innerText = values[<%= id %>].address;
    </script>

</body>
</html>
