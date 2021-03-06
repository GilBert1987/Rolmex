<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/taglibs.jsp"%>
<%pageContext.setAttribute("currentHeader", "bpm-console");%>
<%pageContext.setAttribute("currentMenu", "bpm-category");%>
<%pageContext.setAttribute("currentMenuName", "流程管理");%>
<%pageContext.setAttribute("currentChildMenu", "流程配置");%>
<!doctype html>
<html lang="en">

  <head>
    <%@include file="/common/meta.jsp"%>
    <title><spring:message code="dev.bpm-conf-node.list.title" text="麦联"/></title>
    <%@include file="/common/s3.jsp"%>
    <script type="text/javascript">

    </script>
  </head>

  <body>
    <%@include file="/header/bpm-console.jsp"%>

    <div class="row-fluid">
	  <%@include file="/menu/bpm-console.jsp"%>

	  <!-- start of main -->
      <section id="m-main" class="col-md-10" style="padding-top:65px;">

	  <ul class="breadcrumb">
	    <li><a href="bpm-process-list.do">流程配置</a></li>
	    <li class="active">${bpmConfBase.processDefinitionKey}</li>
	  </ul>
<button type="button" class="btn btn-default a-insert" onclick="location.href='bpm-conf-form-nodes-oneTomany-list.do?bpmConfBaseId=${bpmConfBase.id}'">批量配置表单</button>
<br/><br/>
<form id="bpm-conf-nodeGridForm" name="bpm-conf-nodeGridForm" method='post' action="bpm-conf-node-remove.do" class="m-form-blank">
      <div class="panel panel-default">
        <div class="panel-heading">
		  <i class="glyphicon glyphicon-list"></i>
		  流程配置
		</div>

	<table class="table">
      <thead>
        <tr>
          <th>编号</th>
          <th>类型</th>
          <th>节点</th>
          <th>人员</th>
          <th>事件</th>
          <th>规则</th>
          <th>表单</th>
          <th>操作</th>
          <th>提醒</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${bpmConfNodes}" var="item">
        <tr>
          <td>${item.id}</td>
		  <td>${item.type}</td>
          <td>${item.name}</td>
          <td>
		    <c:if test="${item.confUser == 0}">
			  <a href="bpm-conf-user-list.do?bpmConfNodeId=${item.id}" class="btn"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
		    <c:if test="${item.confUser == 1}">
			  <a href="bpm-conf-user-list.do?bpmConfNodeId=${item.id}" class="btn btn-primary"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
			<c:if test="${not empty item.bpmConfUsers}">
              <i class="badge">${fn:length(item.bpmConfUsers)}</i>
			</c:if>
			&nbsp;
	      </td>
          <td>
		    <c:if test="${item.confListener == 0}">
			  <a href="bpm-conf-listener-list.do?bpmConfNodeId=${item.id}" class="btn"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
		    <c:if test="${item.confListener == 1}">
			  <a href="bpm-conf-listener-list.do?bpmConfNodeId=${item.id}" class="btn btn-primary"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
			<c:if test="${not empty item.bpmConfListeners}">
              <i class="badge">${fn:length(item.bpmConfListeners)}</i>
			</c:if>
			&nbsp;
	      </td>
          <td>
		    <c:if test="${item.confRule == 0}">
			  <a href="bpm-conf-rule-list.do?bpmConfNodeId=${item.id}" class="btn"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
		    <c:if test="${item.confRule == 1}">
			  <a href="bpm-conf-rule-list.do?bpmConfNodeId=${item.id}" class="btn btn-primary"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
			<c:if test="${not empty item.bpmConfRules}">
              <i class="badge">${fn:length(item.bpmConfRules)}</i>
			</c:if>
			&nbsp;
	      </td>
          <td>
		    <c:if test="${item.confForm == 0}">
			  <a href="bpm-conf-form-list.do?bpmConfNodeId=${item.id}" class="btn"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
		    <c:if test="${item.confForm == 1}">
			  <a href="bpm-conf-form-list.do?bpmConfNodeId=${item.id}" class="btn btn-primary"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
			<c:if test="${not empty item.bpmConfForms}">
              <i class="badge">${fn:length(item.bpmConfForms)}</i>
			</c:if>
			&nbsp;
	      </td>
          <td>
		    <c:if test="${item.confOperation == 0}">
			  <a href="bpm-conf-operation-list.do?bpmConfNodeId=${item.id}" class="btn"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
		    <c:if test="${item.confOperation == 1}">
			  <a href="bpm-conf-operation-list.do?bpmConfNodeId=${item.id}" class="btn btn-primary"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
			<c:if test="${not empty item.bpmConfOperations}">
              <i class="badge">${fn:length(item.bpmConfOperations)}</i>
			</c:if>
			&nbsp;
	      </td>
          <td>
		    <c:if test="${item.confNotice == 0}">
			  <a href="bpm-conf-notice-list.do?bpmConfNodeId=${item.id}" class="btn"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
		    <c:if test="${item.confNotice == 1}">
			  <a href="bpm-conf-notice-list.do?bpmConfNodeId=${item.id}" class="btn btn-primary"><i class="glyphicon glyphicon-edit"></i></a>
			</c:if>
			<c:if test="${not empty item.bpmConfNotices}">
              <i class="badge">${fn:length(item.bpmConfNotices)}</i>
			</c:if>
			&nbsp;
	      </td>
        </tr>
        </c:forEach>
      </tbody>
	</table>
      </div>
</form>
      <div class="m-spacer"></div>
      </section>
	  <!-- end of main -->
	</div>
  </body>
</html>

