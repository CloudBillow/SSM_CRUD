import com.github.pagehelper.PageInfo;
import com.miracle.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author Miracle
 * @version v1.0
 * @description TODO
 * @date 2021-03-07 18:28
 */
@RunWith(value = SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml",
        "file:web/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
    @Autowired
    WebApplicationContext context;
    //模拟MVC请求
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNo", "5"))
                .andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo empList = (PageInfo) request.getAttribute("empList");

        System.out.println("当前页码" + empList.getPageNum());
        System.out.println("总页码" + empList.getPages());
        System.out.println("总记录数" + empList.getTotal());
        System.out.println("在页面需要连续显示的页码");
        for (int num : empList.getNavigatepageNums()) {
            System.out.println(" / " + num);
        }
        List<Employee> list = empList.getList();
        for (Employee employee : list) {
            System.out.println(employee);
        }

    }

}
