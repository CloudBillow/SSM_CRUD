package com.miracle.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.miracle.bean.Department;
import com.miracle.bean.Employee;
import com.miracle.bean.Msg;
import com.miracle.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Miracle
 * @version v1.0
 * @description 处理部门请求
 * @date 2021-03-08 17:33
 */
@Controller
public class DepartmentController {

    private final DepartmentService departmentService;

    public DepartmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {
        List<Department> departmentList = departmentService.getAll();
        return Msg.success().add("depts", departmentList);
    }

}
