package com.miracle.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.miracle.bean.Employee;
import com.miracle.bean.Msg;
import com.miracle.service.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import sun.awt.SunHints;

import javax.validation.Valid;
import javax.xml.transform.Source;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Miracle
 * @version v1.0
 * @description 处理员工请求
 * @date 2021-03-07 17:53
 */
@Controller
public class EmployeeController {

    private final EmployeeService employeeService;

    public EmployeeController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    @RequestMapping(value = "/emps/{empIds}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable String empIds) {
        if (empIds.contains("-")) {
            List<Integer> delIds = new ArrayList<>();
            String[] split = empIds.split("-");
            for (String id : split) {
                delIds.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(delIds);
        } else {
            employeeService.deleteEmpById(Integer.parseInt(empIds));
        }

        return Msg.success();
    }


    @RequestMapping(value = "/emps/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 按照员工id查询员工
     *
     * @param id 员工id
     * @return 员工信息
     */
    @RequestMapping(value = "/emps/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    /**
     * 检查用户名是否可用
     *
     * @param email 邮箱
     * @return 邮箱是否可用信息
     */
    @RequestMapping("/checkemail")
    @ResponseBody
    public Msg checkEmail(@RequestParam("email") String email) {
        String regx = "^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$";
        if (!email.matches(regx)) {
            return Msg.fail().add("va_msg", "邮箱格式不正确!");
        }

        boolean isEmailAvailable = employeeService.checkEmail(email);
        if (isEmailAvailable) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "邮箱已存在!");
        }
    }

    @RequestMapping(value = "/emps", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            List<FieldError> errors = result.getFieldErrors();
            Map<String, Object> map = new HashMap<>();
            for (FieldError error : errors) {
                System.out.println("错误的字段名" + error.getField());
                System.out.println("错误信息" + error.getDefaultMessage());
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorInfo", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 返回Ajax的查询方法
     *
     * @param pageNo 页码
     * @param model  Model
     * @return Ajax字符串
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo, Model model) {
        if (pageNo < 1) {
            pageNo = 1;
        }
//        使用PageHelper进行分页查询
        PageHelper.startPage(pageNo, 10);
//        获取所有员工信息
        List<Employee> employeeList = employeeService.getAll();
//        将员工列表封装到PageInfo
        PageInfo<Employee> pageInfo = new PageInfo<>(employeeList, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 原始方法查询员工列表
     *
     * @param pageNo 页码
     * @param model  Model
     * @return 跳转页
     */
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo, Model model) {
        if (pageNo < 1) {
            pageNo = 1;
        }
//        使用PageHelper进行分页查询
        PageHelper.startPage(pageNo, 13);
//        获取所有员工信息
        List<Employee> employeeList = employeeService.getAll();
//        将员工列表封装到PageInfo
        PageInfo<Employee> pageInfo = new PageInfo<>(employeeList, 5);

        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }
}
