package com.miracle.service;

import com.miracle.bean.Employee;

import java.util.List;

/**
 * @author Miracle
 * @version v1.0
 * @description TODO
 * @date 2021-03-07 18:03
 */
public interface EmployeeService {

    /**
     * 查询所有员工
     * @return 员工列表
     */
    List<Employee> getAll();


    /**
     * 保存员工
     * @param employee 员工信息
     */
    void saveEmp(Employee employee);

    /**
     * 查询邮箱是否可用
     * @param email 邮箱
     * @return true则可用
     */
    boolean checkEmail(String email);

    /**
     * 通过id获取员工信息
     * @param id 员工id
     * @return 员工
     */
    Employee getEmp(Integer id);

    /**
     * 员工更新
     * @param employee 员工信息
     */
    void updateEmp(Employee employee);

    /**
     * 通过ID删除员工
     * @param empId 员工id
     */
    void deleteEmpById(Integer empId);

    void deleteBatch(List<Integer> empIds);
}
