<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <!-- 引入http://java.sun.com/jsp/jstl/core核心标签库 定义为c标签  就可以用里面的c:if  c:forEach-->
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>员工列表</title>
<!-- request.getContextPath() 获取当前项目路径 以/开始 不以/结束,所以我们用相对路径的第二种,以/开始的 
	例如: request.getContextPath() 返回/ssm-crud
	那么这个路径就是  "服务器地址" + "/ssm-crud" + "/../../../..文件"
-->
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
	/* out.print(request.getContextPath()); */   /*打印APP_PATH*/
%>
<!-- web路径:
	不以/开头的相对路径,找资源,以当前资源的路径为基准,经常容易出问题.
	以/开头的相对路径,找资源,以服务器的路径为标准(本机:http://localhost:8080),需要加上项目名称
	例如:http://localhost:8080/ssm-crud
 -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js">
</script>
</head>
<body>
	<!-- bootstrap 搭建页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-2 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<!-- pageInfo.list()是我们得到的当前页面的list集合 -->
					<c:forEach items="${pageInfo.list }" var="emp">
					<tr>
						<th>${emp.empId }</th>
						<th>${emp.empName }</th>
						<th>${(emp.gender == "M")||(emp.gender == "男")||(emp.gender == "1")?"男":"女" }</th>
						<th>${emp.email }</th>
						<th>${emp.department.deptName }</th>
						<th>
							<button class="btn btn-primary btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
							</button>
						</th>
					</tr>
					</c:forEach>
				</table>			
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6">当前${pageInfo.pageNum }页,总${pageInfo.pages }页,总${pageInfo.total }条记录</div>
			<!-- 分页条 4部分  首尾页按钮  中间连续的n页按钮  上一页下一页按钮-->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  <!-- ①首页按钮 写死的url 直接跳到首页-->
				  	<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
				  	<!-- ②上一页按钮 if判断 如果是首页就不显示上一页按钮,否则显示上一页按钮 -->
				    <c:if test="${pageInfo.hasPreviousPage }">
				    	<li>
					      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1 }" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
					      </a>
				    	</li>
				    </c:if>
				    <!-- ③获得连续的页码 -->
				    <c:forEach items="${pageInfo.navigatepageNums }" var="pnum">
				    	<!-- 判断遍历中的所有页码是否是 当前页(pageInfo.pageNum), 给当前页加样式 -->
					    <c:if test="${pnum == pageInfo.pageNum }">
					    	<li class="active"><a href="#">${pnum }</a></li>
					    </c:if>
					    <c:if test="${pnum != pageInfo.pageNum }">
					    	<li><a href="${APP_PATH}/emps?pn=${pnum }">${pnum }</a></li>
					    </c:if>
				    </c:forEach>
				    <!-- ④上一页按钮 if判断 如果是末页就不显示下一页按钮,否则显示下一页按钮  -->
				    <c:if test="${pageInfo.hasNextPage }">
				    	<li>
					      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1 }" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
				    	</li>
				    </c:if>
				    <!-- ⑤尾页按钮 写死的url 直接跳到尾页-->
				    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages }">末页</a></li>
				  </ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>