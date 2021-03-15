package com.miracle.service;

import com.miracle.bean.Department;
import com.miracle.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Miracle
 * @version v1.0
 * @description TODO
 * @date 2021-03-08 17:35
 */
@Service
public class DepartmentServiceImpl implements DepartmentService{
    private final DepartmentMapper departmentMapper;

    public DepartmentServiceImpl(DepartmentMapper departmentMapper) {
        this.departmentMapper = departmentMapper;
    }


    @Override
    public List<Department> getAll() {
        return departmentMapper.selectByExample(null);
    }
}
