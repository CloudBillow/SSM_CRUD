<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Miracle
  Date: 2021/3/7
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.js"></script>
    <link type="text/css" rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css"/>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <%--    标题块--%>
        <div class="row">
            <div class="col-md-12">
                <h1> 员工列表 <small>com.miracle</small></h1>
            </div>
        </div>
        <%--    按钮块--%>
        <div class="row">
            <div class="col-md-3 col-md-offset-9" style="font-size:0">
                <button class="btn btn-primary" style="font-size:15px">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true" style="margin-right:5px"></span>新增
                </button>
                <button class="btn btn-danger" style="margin-left:20px;font-size:15px">删除所选</button>
            </div>
        </div>
        <div style="height:15px"></div>
        <%--    列表块--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr style="font-size: 20px;">
                        <th>ID</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>

                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr style="font-size:18px;">
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th style="font-size:0">
                                <button class="btn btn-info btn-xs" style="margin-right:15px;font-size:15px">
                                    编辑<span class="glyphicon glyphicon-pencil" aria-hidden="true"
                                            style="margin-left: 5px"></span>
                                </button>
                                <button class="btn btn-danger btn-xs" style="font-size:15px">
                                    删除<span class="glyphicon glyphicon-trash" aria-hidden="true"
                                            style="margin-left:5px;"></span>
                                </button>
                            </th>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <%--    分页块--%>
        <%--分页信息--%>
        <div class="col-md-4 col-md-offset-1" style="font-size: 15px">
            当前第<kbd>${pageInfo.pageNum}</kbd>页，共有<kbd>${pageInfo.pages}</kbd>页，总<kbd>${pageInfo.total}</kbd>条记录。
        </div>
        <div class="row">
            <%--分页条--%>
            <div class="col-md-6 col-md-offset-4">
                <div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:if test="${pageInfo.isFirstPage}">
                                <li class="disabled">
                                    <a href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${pageInfo.pageNum!=1}">
                                <li><a href="${APP_PATH}/emps?pageNo=1">首页</a></li>
                                <li>
                                    <a href="${APP_PATH}/emps?pageNo=${pageInfo.prePage}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>

                            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNo">
                                <c:if test="${pageInfo.pageNum == pageNo}">
                                    <li class="active"><a href="#">${pageNo}</a></li>
                                </c:if>
                                <c:if test="${pageInfo.pageNum != pageNo}">
                                    <li><a href="${APP_PATH}/emps?pageNo=${pageNo}">${pageNo}</a></li>
                                </c:if>
                            </c:forEach>

                            <c:if test="${pageInfo.isLastPage}">
                                <li class="disabled">
                                    <a href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${!pageInfo.isLastPage}">
                                <li>
                                    <a href="${APP_PATH}/emps?pageNo=${pageInfo.nextPage}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                                <li><a href="${APP_PATH}/emps?pageNo=${pageInfo.pages}">末页</a></li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
