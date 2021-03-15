import com.miracle.bean.Department;
import com.miracle.bean.Employee;
import com.miracle.controller.EmployeeController;
import com.miracle.dao.DepartmentMapper;
import com.miracle.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author Miracle
 * @version v1.0
 * @description TODO
 * @date 2021-03-07 15:15
 */
@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void dept(){

        departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));

    }

    @Test
    public void emp(){
        employeeMapper.insertSelective(new Employee(null,"谢云涛","M","taotao772008@163.com",1));
    }
    @Test
    public void allEmp(){
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);

        for(int i = 0; i < 500; i++){
            String empName = UUID.randomUUID().toString().substring(0, 5) + i;
            String gender = "M";
            String email = empName + "@163.com";
            Integer dId = 2;
            mapper.insertSelective(new Employee(null,empName,gender,email,dId));
        }

    }

}
