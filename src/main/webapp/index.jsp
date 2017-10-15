<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 引入http://java.sun.com/jsp/jstl/core核心标签库 定义为c标签  就可以用里面的c:if  c:forEach-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    pageContext.setAttribute("APP_PATH", request.getContextPath());
			/* out.print(request.getContextPath()); */ /*打印APP_PATH*/
%>
<!-- web路径:
	不以/开头的相对路径,找资源,以当前资源的路径为基准,经常容易出问题.
	以/开头的相对路径,找资源,以服务器的路径为标准(本机:http://localhost:8080),需要加上项目名称
	例如:http://localhost:8080/ssm-crud
 -->
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js">
	
</script>
</head>
<body>
	<!-- bootstrap 搭建页面 -->
	<!-- 创建模态框 -->
	<!-- 编辑模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">编辑员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_update_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			    	<!-- 使用静态框,onlyRead -->
			      <p class="form-control-static" id="empName_update_static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_update_input" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="email_update_input" name="email" placeholder="email@163.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			  	<label for="gender_m_update_input" class="col-sm-2 control-label">gender</label>
			  	<div class="col-sm-10">
				    <label class="radio-inline">
				    	<!-- 单选框 -默认男 -->
					  <input type="radio" name="gender" id="gender_m_update_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender_f_update_input" value="F"> 女
					</label>
				</div>
			  </div>
			  <div class="form-group">
			  	<label for="deptName_update_select" class="col-sm-2 control-label">deptName</label>
			  	<div class="col-sm-8">
			  		<!-- 部门提交部门id -->
				    <select class="form-control" name="dId" id="deptName_update_select">
					</select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="empName_add_input" name="empName" placeholder="员工姓名">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add_input" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="email_add_input" name="email" placeholder="email@163.com">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			  	<label for="gender_m_add_input" class="col-sm-2 control-label">gender</label>
			  	<div class="col-sm-10">
				    <label class="radio-inline">
				    	<!-- 单选框 -默认男 -->
					  <input type="radio" name="gender" id="gender_m_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender_f_add_input" value="F"> 女
					</label>
				</div>
			  </div>
			  <div class="form-group">
			  	<label for="deptName_add_select" class="col-sm-2 control-label">deptName</label>
			  	<div class="col-sm-8">
			  		<!-- 部门提交部门id -->
				    <select class="form-control" name="dId" id="deptName_add_select">
					</select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 员工删除的模态框 -->
<!-- 
	<div class="modal fade" id="empDelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">删除员工</h4>
	      </div>
	      <div class="modal-body">
	        ...确定删除员工
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
 -->
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
				<!-- (这里的btn 我们用点击事件打开模态框) -->
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_del_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="checkbox_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条 4部分  首尾页按钮  中间连续的n页按钮  上一页下一页按钮-->
			<div class="col-md-6" id="page_nav_area">
			</div>
		</div>
	</div>
	<script type="text/javascript"  charset="utf-8">
		/*1.页面加载完成之后,直接去发送一个ajax请求,要到分页数据 
			找到这个"/emps"请求, 去执行Controller注解下的getEmpsWithJson方法 , 是get方式请求类型
		 */
		 var totalRecord,currentPage,globalEmpId;
		 
		$(function() {
			//去首页
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps", //请求url地址
				data : "pn=" + pn, //请求参数
				type : "GET", //请求类型
				//请求成功的回调函数
				success : function(result) { //result 就是服务器响应给浏览器的数据
					//控制台打印返回结果
					console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条数据
					build_page_nav(result);
				}
			});
		};

		//解析并显示员工数据
		function build_emps_table(result) {
			//清空table表格 通过id="emps_table tbody" 得到html元素
			//更改数据前,先清空里面的数据 不然会显示2次的数据
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index, item) {
				//复选框 
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				//员工编号
				var empIdTd = $("<td></td>").append(item.empId);
				//员工姓名
				var empNameTd = $("<td></td>").append(
						item.empName);
				//员工性别 M男 F女
				var genderTd = $("<td></td>").append(
						(item.gender == "男")
								|| (item.gender == "1")
								|| (item.gender == 'M') ? "男"
								: "女");
				//员工邮箱
				var emailTd = $("<td></td>").append(item.email);
				//所属部门 关联部门表
				var deptNameTd = $("<td></td>").append(
						item.department.deptName);
				//append方法执行完成之后还是返回原来的元素 所以可以一直往里面塞东西,最后把整个的放入表格的body里面

				//添加2个操作按钮,编辑和删除, 添加方式查看jqueryAPI文档
				var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个自定义的属性,来表示当前员工的id
				editBtn.attr("edit-id",item.empId);  //attr(k,v)添加属性
				
				/*
					2个btn 比较复杂的就是层级关系  ()的位置(层级关系)别写错了
					btn.addClass(加样式)  ---这是一层,给btn自身加样式
					.append[(往btn里面加子元素span标签).addClass(加span的样式)]      ---这是一层,加在btn里面的子元素,样式是给子元素加的,所以括在一起
					.append(给btn按钮上面加html文字)  ---这是一层,加在btn按钮上面的信息
				*/
				var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加一个自定义的属性,来表示当前员工的id,这样我们在操作这个按钮的时候 可以直接的得到这个id
				delBtn.attr("delBtn-id",item.empId);  //attr(k,v)添加属性
				
				//将2个btn 放到一个td里面 用一个空格隔开 好看
				var btnTb = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(checkBoxTd)
						.append(empIdTd)
						.append(empNameTd).append(genderTd)
						.append(emailTd).append(deptNameTd)
						.append(btnTb)
						.appendTo("#emps_table tbody");
			});
		};
		//解析并显示分页信息	id="page_info_area"
		function build_page_info(result){
			//清空分页信息div 通过id="page_info_area" 得到html元素
			//更改数据前,先清空里面的数据 不然会显示2次的数据
			$("#page_info_area").empty();
			var pageInfo = result.extend.pageInfo;
			/*
				先通过id得到html元素(这里是div)  
				id选择器 #page_info_area
				class选择器 .page_info_area
			*/
			$("#page_info_area").append("当前"+pageInfo.pageNum +"页,总"+pageInfo.pages +"页,总"+pageInfo.total +"条记录");
			totalRecord = pageInfo.total;
			currentPage = pageInfo.pageNum;
		};
		//解析并显示分页条数据,点击每个btn都有功能	id="page_nav_area"
		function build_page_nav(result) {
			//清空nav里面的数据 重新加入新数据
			$("#page_nav_area").empty();
			//解析json元素 获取到包装的pageInfo集合
			var pageInfo = result.extend.pageInfo;
			//创建ul		<ul class="pagination"></ul>
			var ul = $("<ul></ul>").addClass("pagination");
			//首页
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			//上一页
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			//isHasPreviousPage()--isHasNextPage()
			if(pageInfo.hasPreviousPage == false){	//判断如果当前页没有上一页 就将上一页和首页隐藏	
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{	//如果没有上一页, 上一页和首页按钮被隐藏 禁用  否则给他绑定事件 点击翻页
				//绑定点击事件 跳转上一页(当前页-1) 实现翻页
				prePageLi.click(function(){
					to_page(pageInfo.pageNum-1);
				});
				//绑定点击事件 跳转到第一页
				firstPageLi.click(function(){
					to_page(1);
				});
			}
			
			//下一页
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			//尾页
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			//isHasPreviousPage()--isHasNextPage()
			if(pageInfo.hasNextPage == false){	//判断如果当前页没有下一页 就将下一页和尾页隐藏
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{	//同理  点击事件 加到else 比在外面更合理
				//尾页绑定点击事件 跳转到最后一页
				lastPageLi.click(function(){
					to_page(pageInfo.pages);
				});
				//绑定点击事件 跳转下一页(当前页+1) 实现翻页
				nextPageLi.click(function(){
					to_page(pageInfo.pageNum+1);
				});
			}

			//添加首页和前一页到ul
			ul.append(firstPageLi).append(prePageLi);
			//连续的5页  使用 $.each 遍历 pageInfo.navigatepageNums 数组里面的数 就是连续的5页   然后加入到ul里面
			$.each(pageInfo.navigatepageNums,function(index,item){  
				//他们说index,item省略的话可以用this代替 I'm trying!!!  -- SUCCESS 
				var numLi =  $("<li></li>").append($("<a></a>").append(item));
				if(pageInfo.pageNum == item){
					numLi.addClass("active");	//判断,如果为当前页 给他加样式
				}
				//numLi绑定点击事件  被点击 跳转页面
				numLi.click(function(){
					to_page(item);
				});
				//添加连续页到ul
				ul.append(numLi);
			});
			//添加下一页和尾页到ul
			ul.append(nextPageLi).append(lastPageLi);	
			//把ul加入到nav元素中<nav aria-label="Page navigation"></nav>
			var navEle = $("<nav></nav>").append(ul);
			//将这个nav放入div中
			navEle.appendTo("#page_nav_area");
		};
		
		//表单完整重置
		function reset_form(ele){
			//清空表单数据
			$(ele)[0].reset(); //重置数据
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");  //表单中的所有内容中有has-error has-success的都去掉
			$(ele).find(".help-block").text("");  //.help-block  表单中span元素的id 的text改成""
		}
		
		//新增按钮的绑定事件,弹窗一个模态框	#emp_add_modal_btn
		$("#emp_add_modal_btn").click(function(){
			//发送ajax请求 查出部门信息,显示在下拉列表中
			//清除表单数据(表单完整重置,重置表单的数据和表单的样式)
			//$()[0].reset();
			reset_form("#empAddModal form");
			getDepts("#empAddModal select");
			
			//弹窗模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		//查出所有的部门信息并显示在下拉列表中   #empAddModal select 获取选择框对象
		function getDepts(ele){
			//清空之前下拉框的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					/* console.log(result); */
					//解析并显示部门信息 放到select列表
					build_depts_select(ele,result);
				}
			});
		};
		
		//解析显示部门信息列表
		function build_depts_select(ele,result){
			//获取部门集合
			var depts = result.extend.depts;
			//获取元素  -- #模态框 选择框
			$.each(depts,function(index,item){
				//构建option
				//append 往该元素里面追加内容
				//appendTo 将该元素放到另一个元素内部
				//addClass  加样式
				//attr 给元素的属性赋值  可参看jqueryAPI
				var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
				optionEle.appendTo(ele);
			});
		};
		

		//校验表单数据
		/*
			逻辑: 获取要校验的对象, 定义一个正则, 判断该对象写法是否符合, 
			如果不符合正则,给一个提示信息,返回fail 需要重新填写信息
			如果符合正则,返回true 继续下一步
		*/
		function validate_add_form(){
			//1、拿到要校验的数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			//console.log(empName);
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input", "success", "");
			};
			
			//2、校验邮箱信息
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				//应该清空这个元素之前的样式
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确"); */
				return false;
			}else{
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		}
		
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//校验用户名是否可用
		$("#empName_add_input").change(function(){
			//发送ajax请求校验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
		});
		
		//保存按钮 点击事件
		$("#emp_save_btn").click(function(){
			//1.模态框中填写的表单数据提交给服务器进行保存
			//1.先对要提交给服务器的数据进行校验
			//前端校验
			if(!validate_add_form()){
				return false;
			}; 
			//1、判断之前的ajax用户名校验是否成功。如果成功。
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//2.发送ajax请求保存员工
			/*
				serialize() 方法 序列表表格内容为字符串，用于 Ajax 请求。
				console.log($("#empAddModal form").serialize());
				注意点:serialize() 方法 会出现乱码, 所以打印结果是乱码的, 
					用post提交不会出现乱码
			*/
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),  //表格序列化后的字符串数据
				success:function(result){
					console.log($("#empAddModal form"));
					console.log($("#empAddModal form").serialize());
					//alert(result.msg);
					//1.关闭模态框 
					//关闭模态框之前, 点保存按钮 实现后端校验 输入信息是否合法
					if(result.code == 100){
						//如果合法,保存信息成功,关闭模态框 跳转到lastPage显示保存的员工
						$("#empAddModal").modal("hide");
						//2.来到最后一页 显示先加入的员工信息
						//发送ajax请求显示最后一页数据即可
						to_page(totalRecord);
					}else{ //不合法,给出错误信息
						//console.log(result); 
						//有哪个字段的错误信息就显示哪个字段的；
						if(undefined != result.extend.errorFields.email){  //如果有email的错误信息,在邮箱的<span>元素上面给出提示信息
							//显示邮箱错误信息
							show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName){	//如果有empName的错误信息,在empName的<span>元素上面给出提示信息
							//显示员工名字的错误信息
							show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
						}
					}
				}
			});
		});
		

		//编辑按钮 点击事件  id = emp_update_modal_btn
		$(document).on("click",".edit_btn",function(){
			//0.查出员工信息,显示员工信息
			//alert($(this).attr("edit-id"));
			//从html中获取员工id 
			var id = $(this).attr("edit-id");
			getEmp(id);
			//1.查出部门信息,显示部门信息
			getDepts("#empUpdateModal select");
			//弹窗模态框(同时,我们把得到的empId传给模态框的更新按钮)
			//把员工id传递给模态框的更新按钮,就是给模态框的更新按钮 加一个edit-id属性
			$("#emp_update_btn").attr("edit-id",id);
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		//获取列表信息
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					/* console.log(result); */
					//获取列表信息
					var empData = result.extend.emp;
					//console.log(empData);
					//分别将value放入对应的key
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		};
		//点击更新按钮,更新员工信息 员工名不可修改
		$("#emp_update_btn").click(function(){
			//1.邮箱校验
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_update_input", "success", "");
			}
			//2.发送请求,更新员工信息 和保存类似
			console.log($(this).attr("edit-id"));
			$.ajax({
				url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),  //表格序列化后的字符串数据
				success:function(result){
					//alert(result.msg);
					//1.关闭模态框 
					$("#empUpdateModal").modal("hide");
					//回到当前页面
					to_page(currentPage);
				}
			});
		});
		
		//删除按钮(下面的小的,初始不一定存在的,在点击时加载) 点击事件 ==>单个删除
		$(document).on("click",".delete_btn",function(){
			//获取员工名字
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			//alert(s);
			//判断
			if(confirm("确认删除【" + empName + "】吗?")){
				//确认,发送ajax请求删除员工
				$.ajax({
					url:"${APP_PATH}/emp/" + $(this).attr("delBtn-id"),
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
		//多选框和批量删除 id="checkbox_all"
		//th的多选框按钮的点击事件 ==>所有的tr的checked属性的值 会根据th的checked属性的值而改变
		$("#checkbox_all").click(function(){
			//dom原生的属性的值,用prop获取, attr获取自定义的属性的值.
			//prop修改和读取dom原生属性的值
			//attr修改和读取自定义的属性的值
			//$(this).prop("checked");  //返回true或false checked属性dom原生,用attr会报错undefined未定义,
			
			//全选 ==>修改tr中的多选框的属性和th的保存一致  tr的多选框跟th的走 但是th不跟tr走
			//$(this).prop("checked") 解析:this是当前按钮  意思是当前按钮的checked属性的值为xx
			$(".check_item").prop("checked",$(this).prop("checked")); //给.check_item元素的checked属性赋同样的值
		});
		//逆向-->tr的所有checked的属性的值保持一致时,th的checked跟随tr走 (前提必须是所有的tr的checked保持一致时)
		//因为不是初始就有的元素, 所以在点击的时候才加载 onclick事件
		$(document).on("click",".check_item",function(){
			//思路:判断当前页面的tr记录是否全部被选中,如果当前页有10条记录(pageInfo.)并且全部被选中,执行操作->
			//打印被选中的个数
			console.log($(".check_item:checked").length);
			//如果被选中的个数==记录条数 那么属性值一样 否则不一样
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#checkbox_all").prop("checked",flag);
		});
		
		//删除按钮(上面的大的,初始就存在,初始加载) 点击事件
		$("#emp_del_all_btn").click(function(){
			//遍历被选中的元素 得到第二个td的内容 就是empId
			//遍历被选中的元素 得到第三个td的内容 就是empName
			var empNames = ""; //定义empNames
			var empIds = ""; //定义empIds
			$.each($(".check_item:checked"),function(){
				//从当前按钮(td)的父元素(tr)里面找第三个tr的text文本 就是我们要的empName
				empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			//去除empNames最后那个,   substring截取字符串从0开始 到length-1结束
			empNames = empNames.substring(0,empNames.length-1);
			//去除员工id最后那个-
			empIds = empIds.substring(0,empIds.length-1);
			console.log(empNames);
			console.log(empIds);
			//判断
			if(confirm("确认删除【"+empNames+"】吗?")){
				//确认,发送ajax请求删除员工
				$.ajax({
					url:"${APP_PATH}/emp/" + empIds,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentPage);
					}
				});
			}
		});
		
	</script>
</body>
</html>