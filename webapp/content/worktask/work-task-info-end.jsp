<%--
  
  User: wanghan
  Date: 2017\9\4 0004
  Time: 10:04
 
--%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/taglibs.jsp" %>
<%pageContext.setAttribute("currentHeader", "worktask");%>
<%pageContext.setAttribute("currentMenu", "workTask");%>
<!doctype html>
<html lang="en">

<head>
    <%@include file="/common/meta.jsp" %>
    <title>麦联</title>
    <%@include file="/common/s3.jsp" %>

    <!-- bootbox -->
    <script type="text/javascript" src="${cdnPrefix}/bootbox/bootbox.min1.js"></script>

    <script type="text/javascript">
        var config = {
            id: 'workTaskInfoGrid',
            pageNo: ${page.pageNo},
            pageSize: ${page.pageSize},
            totalCount: ${page.totalCount},
            resultSize: ${page.resultSize},
            pageCount: ${page.pageCount},
            orderBy: '${page.orderBy == null ? "" : page.orderBy}',
            asc: ${page.asc},
            params: {
                'filter_LIKES_title': '${param.filter_LIKES_title}',
                'filter_EQS_status': '${param.filter_EQS_status}',
                'filter_EQS_efficiency': '${param.filter_EQS_efficiency}',
                'filter_GED_committime': '${param.filter_GED_committime}',
                'filter_LED_committime': '${param.filter_LED_committime}'
            },
            selectedItemClass: 'selectedItem',
            gridFormId: 'workTaskInfoGridForm',
            exportUrl: 'work-task-info-export.do',
            //自定义js
            taskCCUrl: "${tenantPrefix}/rs/worktask/work-task-info-cc",//抄送人
            taskCommentUrl: "${tenantPrefix}/rs/worktask/work-task-comment-save",//备注
            taskDelUrl: "${tenantPrefix}/rs/worktask/work-task-info-del"
        };

        var table;
        $(function () {
            table = new Table(config);
            table.configPagination('.m-pagination');
            table.configPageInfo('.m-page-info');
            table.configPageSize('.m-page-size');

            //设置段时间
            var sectionJson = [{"begin": "#pickerStartTime", "end": "#pickerEndTime"}];
            fnSectionPickerTime(sectionJson)
        });
    </script>
    <script type="text/javascript" src="${cdnPrefix}/worktask/worktask.js"></script>
    <style type="text/css">
        body {
            padding-right: 0px !important;
        }

        .mytable {
            /*table-layout: fixed;*/
            border: 0px;
            margin: 0px;
            border-collapse: collapse;
            width: 100%;
        }

        .mytable tr td .workTask_title {
            width: 150px;
            display: block;
            overflow: hidden;
        }

        .table {
            width: 100%;
        }

        .mytable tr td, .mytable tr td .rwop {
            text-overflow: ellipsis; /* for IE */
            -moz-text-overflow: ellipsis; /* for Firefox,mozilla */
            overflow: hidden;
            white-space: nowrap;
            border: 0px solid;
            text-align: left
        }
    </style>
    <script>
        function fnSearch() {
            document.getElementById("workTaskInfoForm").action = "work-task-info-end.do";
        }
        function fnGoAction() {
            if (${page.resultSize==0}) {
                alert("没有数据需要导出！")
                return false;
            }
            if ($("#workTaskInfo_title").val() == "" &&
                $("#workTaskInfo_Status").val() == "" &&
                $("#workTaskInfo_Efficiency").val() == "" &&
                $("input[name='filter_GED_committime']").val() == "" &&
                $("input[name='filter_LED_committime']").val() == ""
            ) {
                alert("请选择导出条件！");
                return false;
            }
            document.getElementById("workTaskInfoForm").action = "end-export.do";
        }
    </script>
</head>

<body>
<%@include file="/header/navbar.jsp" %>

<div class="row-fluid">
    <%@include file="/menu/sidebar.jsp" %>

    <!-- start of main -->
    <section id="m-main" class="col-md-10" style="padding-top:65px;">

        <div class="panel panel-default">
            <div class="panel-heading">
                查询
                <div class="pull-right ctrl">
                    <a class="btn btn-default btn-xs"><i id="workTaskInfoSearchIcon"
                                                         class="glyphicon glyphicon-chevron-up"></i></a>
                </div>
            </div>
            <div class="panel-body">
                <form id="workTaskInfoForm" name="workTaskInfoForm" method="post" action="work-task-info-end.do" class="form-inline">
                    <label for="workTaskInfo_title">标题:</label>
                    <input type="text" id="workTaskInfo_title" name="filter_LIKES_title"
                           value="${param.filter_LIKES_title}" class="form-control" maxlength="20">
                    &nbsp;&nbsp;
                    <label for="workTaskInfo_Status">状态:</label>
                    <select id="workTaskInfo_Status" class="form-control" name="filter_EQS_status" title="">
                        <option value=""  ${param.filter_EQS_status==""?"selected='selected'":""}>全部</option>
                        <option value="2" ${param.filter_EQS_status=="2"?"selected='selected'":""}>已完成</option>
                        <option value="3" ${param.filter_EQS_status=="3"?"selected='selected'":""}>已关闭</option>
                        <option value="4" ${param.filter_EQS_status=="4"?"selected='selected'":""}>已评价</option>
                    </select>
                    &nbsp;&nbsp;
                    <label> 完成/关闭时间:</label>
                    <div id="pickerStartTime" class="input-group date">
                        <input style="width:160px;" type="text" name="filter_GED_committime"
                               value="${param.filter_GED_committime}" class="form-control required valid" readonly>
                        <span class="input-group-addon">
				<i class="glyphicon glyphicon-calendar"></i>
			</span>
                    </div>
                    至
                    <div id="pickerEndTime" class="input-group date">
                        <input style="width:160px;" type="text" name="filter_LED_committime"
                               value="${param.filter_LED_committime}" class="form-control required valid" readonly>
                        <span class="input-group-addon">
				<i class="glyphicon glyphicon-calendar"></i>
			</span>
                    </div>
                    &nbsp;&nbsp;

                    <label for="workTaskInfo_Efficiency">完成效率:</label>
                    <select id="workTaskInfo_Efficiency" class="form-control" name="filter_EQS_efficiency" title="">
                        <option value="" ${param.filter_EQS_efficiency=="0"?"selected='selected'":""}>全部</option>
                        <option value="0" ${param.filter_EQS_efficiency=="0"?"selected='selected'":""}>准时</option>
                        <option value="1" ${param.filter_EQS_efficiency=="1"?"selected='selected'":""}>提前</option>
                        <option value="2" ${param.filter_EQS_efficiency=="2"?"selected='selected'":""}>延期</option>
                    </select>

                    <button id="btn_Search" class="btn btn-default a-search" onclick="fnSearch()" type="submit">查询
                    </button>
                    &nbsp;
                    <button id="btn_Export" class="btn btn-default a-search" onclick="fnGoAction()" type="submit">导出
                    </button>
                </form>
            </div>
        </div>
        <div style="margin-bottom: 20px;">
            <div class="pull-right">
                每页显示
                <select class="m-page-size form-control" style="display:inline;width:auto;">
                    <option value="10">10</option>
                    <option value="20">20</option>
                    <option value="50">50</option>
                </select>
                条
            </div>
            <div class="clearfix"></div>
        </div>

        <form id="workTaskInfoGridForm" name="workTaskInfoGridForm" method='post' action="work-task-info-end.do"
              class="m-form-blank">
            <div class="panel panel-default">
                <div class="panel-heading">
                    列表
                </div>
                <table id="workTaskInfoGrid" class="table table-hover mytable">
                    <thead>
                    <tr>
                        <th>操作</th>
                        <th>标题</th>
                        <th>状态</th>
                        <th>抄送人</th>
                        <th>计划完成时间</th>
                        <th>完成/关闭时间</th>
                        <th>效率</th>
                        <th>发布人</th>
                        <th>发布时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.result}" var="item">
                        <tr>
                            <td>
                                <c:if test="${item.status=='2'}">
                                    <a href="javascript:" onclick="fnTaskComment(${item.id})">备注</a>
                                </c:if>
                                    <%--&nbsp;&nbsp;<a href="javascript:" onclick="fnTaskDel(${item.id})">删除</a> --%>
                           
                           					<!-- cz add 2018/12/12  新增抄送功能 -->
<a href="${tenantPrefix}/worktask/worktask-CC-input-new.do?id=${item.id}">[抄送]</a>
                           
                            </td>
                            <td>
                                <a class="workTask_title rwop" title="${item.title}"
                                   href='work-task-info-detail.do?id=${item.id}'>
                                        ${item.title}
                                </a>
                            </td>
                            <td>
                                <c:if test='${item.status=="2"}'>已完成</c:if>
                                <c:if test='${item.status=="3"}'>已关闭</c:if>
                                <c:if test='${item.status=="4"}'>已评价</c:if>
                            </td>
                            <td>
                                [<a href="javascript:" onclick='showCCMan("${item.id}")'>查看</a>]
                            </td>
                            <td><fmt:formatDate value="${item.plantime}" type="both" pattern='yyyy-MM-dd HH:mm'/></td>
                            <td><fmt:formatDate value="${item.committime}" type="both" pattern='yyyy-MM-dd HH:mm'/></td>
                            <td>
                                <c:if test='${item.efficiency=="0"}'>准时</c:if>
                                <c:if test='${item.efficiency=="1"}'>提前</c:if>
                                <c:if test='${item.efficiency=="2"}'>延期</c:if>
                            <td><tags:isDelUser userId="${item.publisher}"></tags:isDelUser></td>
                            <td><fmt:formatDate value="${item.publishtime}" type="both"
                                                pattern='yyyy-MM-dd HH:mm'/></td>

                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </form>
        <div>
            <div class="m-page-info pull-left">
                共100条记录 显示1到10条记录
            </div>
            <div class="btn-group m-pagination pull-right">
                <button class="btn btn-default">&lt;</button>
                <button class="btn btn-default">1</button>
                <button class="btn btn-default">&gt;</button>
            </div>
        </div>

    </section>
    <!-- end of main -->
</div>

</body>

</html>
