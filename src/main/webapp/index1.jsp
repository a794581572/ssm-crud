<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!-- 通过请求返回页面 -->
<%-- <jsp:forward page="/emps"></jsp:forward> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <!----${APP_PATH }---->
    <script type="text/javascript" src="static/js/jquery-1.12.4.min.js"></script>
	<link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <button class="btn btn-success">按钮</button>
	<script type="text/javascript">
	var people = { "programmers": [ { "firstName": "Brett", "lastName":"McLaughlin", "email": "aaaa" },

	                                { "firstName": "Jason", "lastName":"Hunter", "email": "bbbb" },

	                                { "firstName": "Elliotte", "lastName":"Harold", "email": "cccc" }

	                                ],

	                                "authors": [

	                                { "firstName": "Isaac", "lastName": "Asimov", "genre": "science fiction" },

	                                { "firstName": "Tad", "lastName": "Williams", "genre": "fantasy" },

	                                { "firstName": "Frank", "lastName": "Peretti", "genre": "christian fiction" }

	                                ],

	                                "musicians": [

	                                { "firstName": "Eric", "lastName": "Clapton", "instrument": "guitar" },

	                                { "firstName": "Sergei", "lastName": "Rachmaninoff", "instrument": "piano" }

	                                ] };
	console.log(people);	
	var newStringPeople = people.toJSONString();
	console.log(newStringPeople)
	</script>
</body>
</html>