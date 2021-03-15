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
    <%--修改员工模态框--%>
    <div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 450px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <div class="modal-body">
                    <%--                    表单--%>
                    <form class="form-horizontal" id="updateEmpForm">
                        <div class="form-group">
                            <label for="inputEmpName" class="col-sm-3 control-label">姓名</label>
                            <div class="col-sm-7">
                                <p class="form-control-static" id="staticEmpName"></p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="updateEmail" class="col-sm-3 control-label">邮箱</label>
                            <div class="col-sm-7">
                                <input name="email" type="text" class="form-control" id="updateEmail"
                                       placeholder="email@miracle.com">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">性别</label>
                            <div class="col-sm-5">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="updateGender1" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="updateGender2" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputDept" class="col-sm-3 control-label">部门</label>
                            <div class="col-sm-4">
                                <select class="form-control" id="updateDept" name="dId">
                                </select>
                            </div>

                        </div>
                    </form>
                </div>
                <div class="modal-footer" style="font-size: 0">
                    <button type="button" class="btn btn-default" data-dismiss="modal"
                            style="font-size: 15px;margin-right: 20px">关闭
                    </button>
                    <button type="button" class="btn btn-primary" style="font-size: 15px" id="updateEmpBtn">更新</button>
                </div>
            </div>
        </div>
    </div>


    <%--添加员工模态框--%>
    <div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 450px">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <%--                    表单--%>
                    <form class="form-horizontal" id="addEmpForm">
                        <div class="form-group">
                            <label for="inputEmpName" class="col-sm-3 control-label">姓名</label>
                            <div class="col-sm-7">
                                <input name="empName" type="email" class="form-control" id="inputEmpName"
                                       placeholder="name">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="inputEmail" class="col-sm-3 control-label">邮箱</label>
                            <div class="col-sm-7">
                                <input name="email" type="text" class="form-control" id="inputEmail"
                                       placeholder="email@miracle.com">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">性别</label>
                            <div class="col-sm-5">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="inputGender1" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="inputGender2" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputDept" class="col-sm-3 control-label">部门</label>
                            <div class="col-sm-4">
                                <select class="form-control" id="inputDept" name="dId">
                                </select>
                            </div>

                        </div>
                    </form>
                </div>
                <div class="modal-footer" style="font-size: 0">
                    <button type="button" class="btn btn-default" data-dismiss="modal"
                            style="font-size: 15px;margin-right: 20px">关闭
                    </button>
                    <button type="button" class="btn btn-primary" style="font-size: 15px" id="saveEmpBtn">保存</button>
                </div>
            </div>
        </div>
    </div>

    <%--基本布局--%>
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
                <button class="btn btn-primary" style="font-size:15px" id="add_emp_btn">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true" style="margin-right:5px"></span>新增
                </button>
                <button id="deleteAllBtn" class="btn btn-danger" style="margin-left:20px;font-size:15px">删除所选</button>
            </div>
        </div>
        <div style="height:15px"></div>

        <%--    列表块--%>
        <div class="row">
            <div class="col-md-12" style="height: 500px;">
                <table class="table table-hover">
                    <thead style="font-size: 20px;">
                    <tr>
                        <th>
                            <input type="checkbox" id="checkAll"/>
                        </th>
                        <th>ID</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="emp_tbody" style="font-size: 18px;">

                    </tbody>


                </table>
            </div>
        </div>

        <%--分页信息--%>
        <div class="col-md-4 col-md-offset-1" style="font-size: 15px" id="page_info_area">

        </div>

        <%--分页条--%>
        <div class="row">
            <div class="col-md-6 col-md-offset-4">
                <div id="page_nva_area">

                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var totalEmp, currentPage, thisPageSize;
        // 页面加载完成进入第一页
        $(function () {
            toPage(1);
        });

        // 查询指定页数据
        function toPage(pageNo) {
            $.ajax({
                url: "${APP_PATH}/emps",
                data: "pageNo=" + pageNo,
                type: "GET",
                success: function (result) {
                    build_emps_table(result);
                    build_page_info(result);
                    build_page_nva(result);
                }
            });
        }

        // 员工列表展示
        function build_emps_table(result) {
            //清空
            $("#emp_tbody").empty();
            const empList = result.extend.pageInfo.list;
            thisPageSize = result.extend.pageInfo.size;
            $.each(empList, function (index, item) {
                const checkBoxTd = $("<td><input type='checkbox' class='checkItem'/></td>");
                const empIdTd = $("<td></td>").append(item.empId);
                const empNameTd = $("<td></td>").append(item.empName);
                const gender = item.gender === "M" ? "男" : "女";
                const genderTd = $("<td></td>").append(gender);
                const emailTd = $("<td></td>").append(item.email);
                const deptNameTd = $("<td></td>").append(item.department.deptName);
                const editBtn = $("<button></button>").addClass("btn btn-info btn-xs edit_btn").attr("style", "margin-right:15px")
                    .append($("<span></span>")
                        .addClass("glyphicon glyphicon-pencil"))
                    .append(" 编辑");
                editBtn.attr("edit_id", item.empId);
                const delBtn = $("<button></button>").addClass("btn btn-danger btn-xs delete_btn")
                    .append($("<span></span>")
                        .addClass("glyphicon glyphicon-trash"))
                    .append(" 删除");
                delBtn.attr("del_id", item.empId);
                const btnTd = $("<td></td>").append(editBtn).append(delBtn);
                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emp_tbody");
            });
        }

        // 页面数据信息
        function build_page_info(result) {
            const pageNum = $("<kbd></kbd>").append(result.extend.pageInfo.pageNum);
            const pages = $("<kbd></kbd>").append(result.extend.pageInfo.pages);
            const total = $("<kbd></kbd>").append(result.extend.pageInfo.total);
            totalEmp = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
            $("#page_info_area").empty().append("当前第").append(pageNum)
                .append("页，共有").append(pages)
                .append("页，共").append(total)
                .append("条记录。");
        }

        // 分页条
        function build_page_nva(result) {
            $("#page_nva_area").empty();

            var ul = $("<ul></ul>").addClass("pagination");

            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
            var previousPage = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));


            if (!result.extend.pageInfo.hasPreviousPage) {
                firstPageLi.addClass("disabled");
                previousPage.addClass("disabled");
            } else {
                firstPageLi.click(function () {
                    toPage(1);
                });
                previousPage.click(function () {
                    toPage(result.extend.pageInfo.prePage);
                });
            }

            var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));


            if (!result.extend.pageInfo.hasNextPage) {
                nextPage.addClass("disabled");
                lastPageLi.addClass("disabled");
            } else {
                nextPage.click(function () {
                    toPage(result.extend.pageInfo.nextPage);
                });
                lastPageLi.click(function () {
                    toPage(result.extend.pageInfo.pages);
                });
            }

            ul.append(firstPageLi).append(previousPage);

            $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
                if (result.extend.pageInfo.pageNum === item) {
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    toPage(item);
                });
                ul.append(numLi);
            });

            ul.append(nextPage).append(lastPageLi);

            // 页码搜索按钮
            var serchBtn = $("<button></button>").addClass("btn btn-default").attr("type", "button").append("Go");

            // 页码搜索框
            var serch = $("<div></div>").addClass("col-lg-3")
                .append($("<div></div>").addClass("input-group")
                    .append($("<input>").attr("type", "text").attr("id", "inputNo").val(result.extend.pageInfo.pageNum).addClass("form-control"))
                    .append($("<span></span>").addClass("input-group-btn")
                        .append(serchBtn)));
            // 页码搜索按钮点击跳转到指定页面
            serchBtn.click(function () {
                toPage($("#inputNo").val());
            });


            ul.append(serch);
            var navEle = $("<nav></nav>").attr("aria-label", "Page navigation").append(ul);
            navEle.appendTo("#page_nva_area");
        }

        function reset_form(ele) {
            $(ele)[0].reset();
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        // 新增员工按钮点击#add_emp_btn
        $("#add_emp_btn").click(function () {
            //表单重置
            reset_form("#addEmpModal form");

            getDepts("#inputDept");
            $("#addEmpModal").modal({
                backdrop: false
            });
        });

        // 查询所有部门
        function getDepts(ele) {
            $(ele).empty();
            $("#inputDept").text("")
            $.ajax({
                url: "${APP_PATH}/depts",
                type: "GET",
                success: function (result) {
                    console.log(result);
                    const depts = result.extend.depts;
                    $.each(depts, function (index, item) {
                        const departOption = $("<option></option>").append(item.deptName).attr("value", item.deptId);
                        departOption.appendTo(ele);
                    });
                }
            });
        }


        //校验表单数据
        function validationAddForm() {
            const inputName = $("#inputEmpName");
            let inputNameVal = inputName.val();
            if (inputNameVal === "" || inputNameVal == null) {
                // alert("请输入用户名!");
                showMsg("#inputEmpName", "error", "请输入姓名!");
                return false;
            } else {
                showMsg("#inputEmpName", "success", "");
            }

            let inputEmailVal = $("#inputEmail").val();
            let emailFormat = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
            if (inputEmailVal === "" || inputEmailVal == null) {
                // alert("邮箱不合法!");
                showMsg("#inputEmail", "error", "请输入邮箱");
                return false;
            }
            // else if (!emailFormat.test(inputEmailVal)) {
            //     // alert("请输入邮箱");
            //     showMsg("#inputEmail", "error", "邮箱格式不正确!");
            //     return false;
            // } else {
            //     showMsg("#inputEmail", "success", "");
            // }
            return true;
        }

        function showMsg(ele, status, msg) {
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if ("success" === status) {
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            } else if ("error" === status) {
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        //校验邮箱是否重复
        $("#inputEmail").change(function () {
            let email = this.value;
            $.ajax({
                url: "${APP_PATH}/checkemail",
                data: "email=" + email,
                type: "POST",
                success: function (result) {
                    if (result.code === 100) {
                        showMsg("#inputEmail", "success", "邮箱可用!");
                        $("#saveEmpBtn").attr("ajax-va", "success");
                    } else {
                        showMsg("#inputEmail", "error", result.extend.va_msg);
                        $("#saveEmpBtn").attr("ajax-va", "error");
                    }
                }
            });
        });

        $("#inputEmpName").change(function () {
            const inputName = $("#inputEmpName");
            let inputNameVal = inputName.val();
            if (inputNameVal === "" || inputNameVal == null) {
                // alert("请输入用户名!");
                showMsg("#inputEmpName", "error", "请输入姓名!");
                return false;
            } else {
                showMsg("#inputEmpName", "success", "");
            }
        });

        // 保存按钮
        $("#saveEmpBtn").click(function () {
            if (!validationAddForm()) {
                return false;
            }
            if ($(this).attr("ajax-va") === "error") {
                return false;
            }
            $.ajax({
                url: "${APP_PATH}/emps",
                type: "POST",
                data: $("#addEmpForm").serialize(),
                success: function (result) {
                    $("#addEmpModal").modal('hide');
                    toPage(totalEmp);
                }
            });
        });

        //编辑按钮
        $(document).on("click", ".edit_btn", function () {
            reset_form("#updateEmpModal form");
            //查询员工信息
            getEmp($(this).attr("edit_id"));
            //查询部门信息
            getDepts("#updateEmpModal select");
            //把员工id传给更新按钮
            $("#updateEmpBtn").attr("edit_id", $(this).attr("edit_id"))
            $("#updateEmpModal").modal({
                backdrop: "static"
            });
        });


        //单个删除按钮
        $(document).on("click", ".delete_btn", function () {
            //弹出是否删除对话框
            const empName = $(this).parents("tr").find("td:eq(2)").text();
            let empId = $(this).attr("del_id");
            let isFlag = confirm("确认删除 " + empName + "（" + empId + "） 吗？");
            if (isFlag) {
                $.ajax({
                    url: "${APP_PATH}/emps/" + empId,
                    type: "DELETE",
                    success: function (result) {
                        toPage(currentPage);
                    }
                });
            }
        });

        //查询员工信息
        function getEmp(id) {
            $.ajax({
                url: "${APP_PATH}/emps/" + id,
                type: "GET",
                success: function (result) {
                    let empEle = result.extend.emp;
                    $("#staticEmpName").text(empEle.empName);
                    $("#updateEmail").val(empEle.email);
                    $("#updateEmpModal input[name=gender]").val([empEle.gender]);
                    $("#updateEmpModal select").val([empEle.dId]);
                }
            });
        }

        //点击更新，更新员工信息
        $("#updateEmpBtn").click(function () {

            $.ajax({
                url: "${APP_PATH}/emps/" + $(this).attr("edit_id"),
                type: "PUT",
                data: $("#updateEmpModal form").serialize(),
                success: function (result) {
                    $("#updateEmpModal").modal("hide");
                    toPage(currentPage);
                }
            });


        });

        $("#updateEmail").change(function () {
            let email = this.value;
            $.ajax({
                url: "${APP_PATH}/checkemail",
                data: "email=" + email,
                type: "POST",
                success: function (result) {
                    if (result.code === 100) {
                        showMsg("#updateEmail", "success", "邮箱可用!");
                        $("#updateEmpBtn").attr("ajax-va", "success");
                    } else {
                        showMsg("#updateEmail", "error", result.extend.va_msg);
                        $("#updateEmpBtn").attr("ajax-va", "error");
                    }
                }
            });
        });

        $("#checkAll").click(function () {
            $(".checkItem").prop("checked", $(this).prop("checked"));
        });

        $(document).on("click", ".checkItem", function () {
            const flag = $(".checkItem:checked").length === thisPageSize;
            $("#checkAll").prop("checked", flag);
        });

        //点击全部删除
        $("#deleteAllBtn").click(function () {
            let empName = "";
            let del_idstr = "";
            $.each($(".checkItem:checked"), function () {
                empName += "{" + $(this).parents("tr").find("td:eq(2)").text() + "}";
                del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
            });

            del_idstr = del_idstr.substring(0, del_idstr.length - 1);

            if (confirm("确认删除" + empName + "吗?")) {
                $.ajax({
                    url: "${APP_PATH}/emps/" + del_idstr,
                    type: "DELETE",
                    success: function (result) {
                        toPage(currentPage);
                    }
                });
            }

        });

    </script>
</body>
</html>
