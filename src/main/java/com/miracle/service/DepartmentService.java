package com.miracle.service;

import com.miracle.bean.Department;

import java.util.List;

/**
 * @author Miracle
 * @version v1.0
 * @description TODO
 * @date 2021-03-08 17:34
 */
public interface DepartmentService {
    /**
     * 获取所有部门信息
     * @return 部门列表
     */
    List<Department> getAll();
}
