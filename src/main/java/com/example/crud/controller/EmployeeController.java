package com.example.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.crud.bean.Employee;
import com.example.crud.bean.Msg;
import com.example.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * file : EmployeeController
 * user : LMB 
 * <pre>
 *  网站跳转逻辑的控制
 *  员工控制器
 *  处理和员工有关的请求
 * </pre>
 * date : 2017/9/21 0021 下午 10:07.
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;
    
    
    /**
     * 删除员工
     * 单个批量二合一
     * @param ids 要删除的所有员工的员工id
     * @return
     */
    @RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpId(@PathVariable("ids")String ids){
        List<Integer> del_ids = new ArrayList<Integer>();
        if(ids.contains("-")){
            //将前端发送的以"-"隔开的ids字符串 解析成String数组 
            String[] str_ids = ids.split("-");
            //组装id集合
            for (String id : str_ids) {
                //把每一个String类型的id 转成Integer在装入list集合
                del_ids.add(Integer.parseInt(id));
            }
            //批量删除
            employeeService.deleteBatch(del_ids);
        }else {
            //String类型id 转Integer类型
            Integer id = Integer.parseInt(ids);
            //单个删除
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }
    
    /**
     * 通过员工id查询员工
     * @param id  使用@PathVariable注解 从前端获取动态参数
     * @return
     */
    @RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id")Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }
    /**
     * 保存员工时
     * 校验员工姓名是否可以
     * @param empName
     * @return Msg对象信息 可用返回SUCCESS 不可用返回fail
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName")String empName){  //参数加注解,告诉springmvc传的参数是从页面传来的
        //先判断用户名是否是合法的表达式;
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        //str.matches(正则表达式)   检查str是否符合正则表达式
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }
        
        //判断用户名是否可以
        boolean b = employeeService.checkUser(empName);
        //返回结果 可用返回SUCCESS 不可用返回fail
//        return b ? Msg.success() : Msg.fail();
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }
    
    /**
     * 更新员工信息
     * @param employee 员工信息
     * @return
     */
    @RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    
    /**
     * <pre>
     * 员工保存
     * 1、支持JSR303校验
     * 2、导入Hibernate-Validator依赖包,使用注解,实现后端校验
     *  首先在bean里面 给属性加正则注解 可以使用包里面提供的注解,
     *  也可以使用javax.validation.constraints.Pattern包的"@Pattern("regexp="正则表达式",message="提示信息")"注解自定义
     *  然后在Controller中,在方法要传递的参数前加@Valid注解 === 表示要校验的参数
     *  在方法上面还要加BindingResult result参数 === 表示校验返回的结果
     * </pre> 
     * @param employee 员工对象
     * @return Msg对象信息
     */
    @RequestMapping(value = "/emp",method=RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee,BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }
    /*
    /**
     * <pre>
     * 分页查询所有员工信息
     * 过时的方法
     * </pre>
     * @param pn 分页查询中的 页数, 默认第一页 
     * @param model mvc模型 把数据放入到Model中,然后展示到前端页面上
     * @return 返回的是页面
     */
    /*
    @Deprecated
    @RequestMapping("/emps")  //请求url
    public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn, Model model){
        //使用MyBatis分页插件-PageHelper
        //在查询之前只需要调用PageHelper.startPage(设置的起始页码, 每页记录条数);
        PageHelper.startPage(pn, 8);
        //这个分页方法后面的查询就是分页查询了
        List<Employee> employees = employeeService.getAll();
        //分页查询的结果可以进行包装放入PageInfo中 可以查看非常全面的分页信息,我们可以试一下Let's go!!!
        //将所有员工信息包装,并传人连续显示的页数
        PageInfo pi = new PageInfo(employees, 5);
//        System.out.println(pageInfo.getEndRow());
//        System.out.println(pageInfo.getFirstPage());
//        System.out.println(pageInfo.getLastPage());
//        System.out.println(pageInfo.getNavigateFirstPage());
//        System.out.println(pageInfo.getNavigateLastPage());
//        System.out.println(pageInfo.getNavigatePages());
//        System.out.println(pageInfo.getNextPage());
//        System.out.println(pageInfo.getPageNum());
//        System.out.println(pageInfo.getPages());
//        System.out.println(pageInfo.getPageSize());
//        System.out.println(pageInfo.getPrePage());
//        System.out.println(pageInfo.getSize());
//        System.out.println(pageInfo.getStartRow());
//        System.out.println(pageInfo.getTotal());
//        System.out.println(pageInfo.getNavigatepageNums());
        
        //getList() 得到的就是我们要的所以员工信息
//        System.out.println(pageInfo.getList());
        
        model.addAttribute("pageInfo", pi);
        //跳转到这个页面 这个在springmvc.xml(dispatcherServlet-servlet)里面配置了视图解析器，方便页面返回,
        //前缀是"/WEB-INF/views/",后缀是".jsp"的  所以文件就是/WEB-INF/views/list.jsp文件
        return "list";
    }
    
    
    */
    
    /**
     * <pre>
     *  新的方法
     *  分页查询所有员工信息
     *  在maven/pom.xml中依赖com.fasterxml.jackson.core包,就可以将返回的对象信息转成json返回到浏览器上
     *  否则解析不出来,会报错500
     * </pre>
     * @param pn
     * @return 返回PageInfo对象 
     */
    @RequestMapping("/emps")
    @ResponseBody 
    public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
        //使用MyBatis分页插件-PageHelper
        //在查询之前只需要调用PageHelper.startPage(设置的起始页码, 每页记录条数);
        PageHelper.startPage(pn, 8);
        //这个分页方法后面的查询就是分页查询了
        List<Employee> employees = employeeService.getAll();
        //分页查询的结果可以进行包装放入PageInfo中 可以查看非常全面的分页信息,我们可以试一下Let's go!!!
        //将所有员工信息包装,并传人连续显示的页数
        PageInfo<Employee> pi = new PageInfo<>(employees, 5);
        return Msg.success().add("pageInfo", pi);
    }
}
