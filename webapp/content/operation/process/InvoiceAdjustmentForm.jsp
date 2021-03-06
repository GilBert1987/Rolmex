<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/taglibs.jsp"%>
<%pageContext.setAttribute("currentHeader", "bpm-workspace");%>
<%pageContext.setAttribute("currentMenu", "bpm-process");%>
<!doctype html>
<html lang="en">

  <head>
    <%@include file="/common/meta.jsp"%>
    <title><spring:message code="demo.demo.input.title" text="麦联"/></title>
    <%@include file="/common/s3.jsp"%>

	<!-- bootbox -->
    <script type="text/javascript" src="${cdnPrefix}/bootbox/bootbox.min1.js"></script>
	<link href="${cdnPrefix}/xform3/styles/xform.css" rel="stylesheet">
    <script type="text/javascript" src="${cdnPrefix}/xform3/xform-packed.js"></script>

    <link type="text/css" rel="stylesheet" href="${cdnPrefix}/userpicker3-v2/userpicker.css">
    <script type="text/javascript" src="${cdnPrefix}/userpicker3-v2/userpickerbybpm.js"></script>
	<script type="text/javascript" src="${cdnPrefix}/operation/TaskOperation.js"></script>
	
	<style type="text/css">
		.xf-handler {
			cursor: auto;
		}
		input{border : 1px solid #F2F2F2;height:25px}
		textarea{border : 1px solid #F2F2F2;}
		pre { 
			white-space: pre-wrap;
		    word-wrap: break-word;
		    background-color:white;
		    border:0px
		}
	</style>

	<script type="text/javascript">
		document.onmousedown = function(e) {};
		document.onmousemove = function(e) {};
		document.onmouseup = function(e) {};
		document.ondblclick = function(e) {};

		var xform;
		function maxWords(){
			var textPublic = $("#invoiceDetailPublic").val();
			var textPerson = $("#invoiceDetailPerson").val();
			if(textPublic.length > 5000){
				document.getElementById("invoiceDetailPublic").value = textPublic.substr(0,5000);
			}
			if(textPerson.length > 5000){
				document.getElementById("invoiceDetailPerson").value = textPerson.substr(0,5000);
			}
		}
		$(function() {
			
			createUserPicker({
				modalId: 'userPicker',
				showExpression: true,
				searchUrl: '${tenantPrefix}/rs/user/search',
				treeUrl: '${tenantPrefix}/rs/party/treeNoAuth?partyStructTypeId=1',
				childUrl: '${tenantPrefix}/rs/party/searchUser'
			});
			
			setTimeout(function() {
				$('.datepicker').datepicker({
					autoclose: true,
					language: 'zh_CN',
					format: 'yyyy-mm-dd'
				})
			}, 500);
		})
		
		ROOT_URL = '${tenantPrefix}';
		taskOperation = new TaskOperation();
		
		 //调用接口，根据经销商编号，获取直销oa上存的对应信息：姓名 电话 等
		 $(function() {
					$("#shopId").keydown(function(event) {    
						if (event.keyCode == 13) {  
							var id = $("#shopId").val();
							//alert(id);
		                	if (id !="") {
			                    $.getJSON('${tenantPrefix}/rs/varUser/userInfo', {
			                    	customerInfoId: id
			                    }, function(data) {
			                    	//alert(JSON.stringify(data)); 
			          				//$("#realName").html(''+''+data.name);
				          			$("#shopName").val(data.name);
				          			//$("#welfare").html(data.rank);
				          			$("#shopTel").val(data.mobile);
				          			
				          		});
		                    } else {
		                    	alert("必须输入客户编号!");
		                    }
		                }    
		            });
		}) 
		
		          //接收返回申请单的数据
		    		$(function() {
		    		 	var id=$("#processInstanceId").val(); 
		    				if (id !="") {
   			                    $.getJSON('${tenantPrefix}/rs/Invoice/getInvoiceInfo', {
   			                    	id: id
   			                    }, function(data) {
   			                    	for (var i = 0; i < data.length; i++) {
   			                    		//alert(JSON.stringify(data)); 
   			                    		$("#ucode").val(data[i].ucode);  
   			                    		$("#shopName").val(data[i].shopName);
   			                    		$("#shopTel").val(data[i].shopTel);  
   			                    		$("#applyDate").val(data[i].invoiceDate);  
   			                    		$("#orderNumber").val(data[i].orderNumber); 
   			                    		
   			                    		if(data[i].ucode.length == 11){
   			                    			changeMallDiv();
   			                    			$("#area").val(data[i].area);
   			                    			$("#branchOffice").val(data[i].branchOffice); 
   			                    			$("#h1Id").html("罗麦随行发票申请单");
   			                    			$("#shopTels").html("无");
   			                    		}else{
   			                    			changeOaDiv();
   			                    			$("#area").val(data[i].area);
   			                    			var systemId = "";
   	   			                    		if(data[i].system == "恒旭"){
   	   			                    			systemId = 1;
   	   			                    			$("#systemName").val(data[i].system);
   	   			                    		}else if(data[i].system == "大家和"){
   	   			                    			systemId = 2;
   	   			                    			$("#systemName").val(data[i].system);
   	   			                    		}else if(data[i].system == "易成"){
   	   			                    			systemId = 3;
   	   			                    			$("#systemName").val(data[i].system);
   	   			                    		}else if(data[i].system == "正泰"){
   	   			                    			systemId = 4;
   	   			                    			$("#systemName").val(data[i].system);
   	   			                    		}else if(data[i].system == "二部"){
   	   			                    			systemId = 5;
   	   			                    			$("#systemName").val(data[i].system);
   	   			                    		}
   	   			                    		$("#system").val(systemId);
   	   			                    		$("#branchOffice").val(data[i].branchOffice);
   	   			                    		$("#h1Id").html("发票申请单");
   	   			                    		$("#shopTels").html(data[i].shopTel);
   			                    		}
   			                    		
   			                    		
   			                    		
   			                    		//附件返回
   			                    		$("#xf-24-0").val(data[i].name);
   			                    		//alert(data[i].storeInfos);
   			                    		  
   			                    		$("#idNumber").val(data[i].idNumber);
										$("#invoiceMailAddress").val(data[i].invoiceMailAddress);   			                    		
   			                    		
   			                    		$("#addressee").val(data[i].addressee); 
   			                    		$("#addresseeTel").val(data[i].addresseeTel); 
   			                    		$("#addresseeSpareTel").val(data[i].addresseeSpareTel); 
   			                    		$("#invoiceId").val(data[i].id);
   			                    		$("#enclosure").val(data[i].path);
   			                    		
   			                    		if(data[i].invoiceType == "普通发票"){
   			                    			$("#commonId").attr("checked",true);
   			                    		}
   			                    		if(data[i].invoiceType == "增值税普通发票"){
   			                    			$("#appreciationid1").attr("checked",true);
   			                    		}
   			                    		if(data[i].invoiceType == "增值税专用发票"){
   			                    			$("#appreciationid2").attr("checked",true);
   			                    		}
   			                    		
   			                    		
   		                    			if(data[i].category == "个人"){
   		                    				//$("#person").html(data[i].category);
   		                    				$("#person").attr("checked",true);
   		                    				$("#public").attr("disabled",true);
   		                    				$("#appreciationid1").attr("disabled",true);
   		                    				$("#appreciationid2").attr("disabled",true);
   		                    				$("#invoiceTitlePerson").val(data[i].invoiceTitle);
   			                    			$("#invoiceDetailPerson").val(data[i].invoiceDetail);
   			                    			$("#invoiceMoneyPerson").val(data[i].invoiceMoney);
   			                    			//发票类别是个人时，给对公的输入框输置灰
   			                    			//$("#public").attr("checked",false);
   		                    				$("#invoiceTitlePublic").attr("disabled",true);
   			                    			$("#invoiceDetailPublic").attr("disabled",true);
   			                    			$("#invoiceMoneyPublic").attr("disabled",true);
   			                    			$("#enterpriseName").attr("disabled",true);
   			                    			$("#taxNumber").attr("disabled",true);
   			                    			$("#openingBank").attr("disabled",true);
   			                    			$("#accountNumber").attr("disabled",true);
   			                    			$("#enterpriseAddress").attr("disabled",true);
   		                    			}else if(data[i].category == "对公"){
   		                    				$("#public").attr("checked",true);
   		                    				$("#person").attr("disabled",true);
   		                    				$("#commonId").attr("disabled",true);
   		                    				$("#invoiceTitlePublic").val(data[i].invoiceTitle);
   			                    			$("#invoiceDetailPublic").val(data[i].invoiceDetail);
   			                    			$("#invoiceMoneyPublic").val(data[i].invoiceMoney);
   			                    			$("#enterpriseName").val(data[i].enterpriseName);
   			                    			$("#taxNumber").val(data[i].taxNumber);
   			                    			$("#openingBank").val(data[i].openingBank);
   			                    			$("#accountNumber").val(data[i].accountNumber);
   			                    			$("#enterpriseAddress").val(data[i].enterpriseAddress);
   			                    			//发票类别是对公时，给个人的相关输入框置灰
   			                    			//$("#person").attr("checked",false);
   		                    				$("#invoiceTitlePerson").attr("disabled",true);
   			                    			$("#invoiceDetailPerson").attr("disabled",true);
   			                    			$("#invoiceMoneyPerson").attr("disabled",true);
   			                    			$("#idNumber").attr("disabled",true);
   		                    			}
   			                    	 }
   			                    });
   			                    
	   			               	//获取抄送人  
	   			                 $.getJSON('${tenantPrefix}/workOperationCustom/getFormCopyName.do', {
	   			                 	id: id
	   			                 }, function(data) {
	   			                 	if(data != ''){
	   			                 		$("#copyNames").html(data);
	   			                 	}
	   			                 });
   			                    
   			                    
   		                    };
   		               //根据条件注掉其中一个撤销申请按钮
   				         $.ajax({      
					            url: '${tenantPrefix}/rs/bpm/removeButton',      
 					            datatype: "json",
 					            data:{"processInstanceId": $("#processInstanceId").val()},
 					            type: 'get',      
 					            success: function (e) {
 					            	//alert(JSON.stringify(e));
 					            	if(e == "normalReject"){
 										  $("#endProcess").css('display',"none");
 									}else{
 										  $("#revoke").css('display',"none");
 									}
 					            },      
 					            error: function(e){      
 					            	loading.modal('hide');
 					                alert("服务器请求失败,请重试");  
 					            }
   					       });
		    		})
		 
		 
    		//相关button操作
    		function completeTask(flag) {
			   if(flag == 4){
					var msg = "确定要撤销申请吗,请确认？";  
		            if (!confirm(msg)){  
		                return false;  
		            }  
				}
			   if($("#orderNumber").val().replace(/(^\s*)|(\s*$)/g, "") == ''){
				   alert("单据号不能为空");
				   return
			   }
			 //调整人重新申请和撤销申请先检验该流程的状态是否是已撤回或驳回发起人
	            $.ajax({      
		            url: '${tenantPrefix}/rs/bpm/getStatus',      
		            datatype: "json",
		            data:{"processInstanceId": $("#processInstanceId").val(),"humanTaskId":$("#humanTaskId").val(),"userId":$("#userId").val(),"resource":'adjustment'},
		            type: 'get',      
		            success: function (e) {
		            	if(e == 'error'){
		            		alert("该申请状态已变更，您已无权操作。");
		            		return false;
		            	}
		            	if(e == 'noAuth'){
		            		alert("您无权操作。");
		            		return false;
		            	}
		            	var loading = bootbox.dialog({
			                message: '<p style="width:90%;margin:0 auto;text-align:center;">提交中...</p>',
			                size: 'small',
			                closeButton: false
			         	});
		    			$('#xform').attr('action', '${tenantPrefix}/Invoice/process-operationInvoiceApproval-completeTask.do?flag='+flag);
		    			$('#xform').submit();
		            },      
		            error: function(e){      
		            	loading.modal('hide');
		                alert("服务器请求失败,请重试"); 
		            }
		       });
    		}
	       //获取当前系统时间
	      /*  function time(){
				var now = new Date();
				var year = now.getFullYear();
				var month = now.getMonth();
				var day = now.getDate();
				if(month<9&&day<10){
					document.getElementById("applyDate").value = year+"-"+"0"+(month+1)+"-"+"0"+day;
				}else if(month<9){
					document.getElementById("applyDate").value = year+"-"+"0"+(month+1)+"-"+day;
				}else if(day<10){
					document.getElementById("applyDate").value = year+"-"+(month+1)+"-"+"0"+day;
				} else{
					document.getElementById("applyDate").value = year+"-"+(month+1)+"-"+day;
				}
		} */
	       function getSystemName() {
				var  myselect=document.getElementById("system");
				var index=myselect.selectedIndex ;  
				var text=myselect.options[index].text;
				$("#systemName").val(text);
		}  
		
		//流程撤回后点击撤销申请，确认框提示
		function confirmOperation(){
			var msg = "确定要撤销申请吗,请确认？";  
            if (!confirm(msg)){  
                return false;  
            }
          //调整人撤销申请先检验该流程的状态是否是已撤回或驳回发起人
            $.ajax({      
	            url: '${tenantPrefix}/rs/bpm/getStatus',      
	            datatype: "json",
	            data:{"processInstanceId": $("#processInstanceId").val(),"humanTaskId":$("#humanTaskId").val(),"userId":$("#userId").val(),"resource":'adjustment'},
	            type: 'get',      
	            success: function (e) {
	            	if(e == 'error'){
	            		alert("该申请状态已变更，您已无权操作。");
	            		return false;
	            	}
	            	if(e == 'noAuth'){
	            		alert("您无权操作。");
	            		return false;
	            	}
	            	var loading = bootbox.dialog({
	                    message: '<p style="width:90%;margin:0 auto;text-align:center;">提交中...</p>',
	                    size: 'small',
	                    closeButton: false
	             	});
	            	$('#xform').attr('action', '${tenantPrefix}/bpm/workspace-endProcessInstance.do?processInstanceId=${processInstanceId}&humanTaskId=${humanTaskId}');
	    			$('#xform').submit();
	            },      
	            error: function(e){      
	            	loading.modal('hide');
	                alert("服务器请求失败,请重试"); 
	            }
	       });
		}
		
		
		function changeMallDiv(){
			$("#form-tfoot").html('<tr id="xf-2-3">'
					+'<td id="xf-2-3-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-left" width="25%">'
					+'<div class="xf-handler">'
					+'	<label style="display:block;text-align:center;margin-bottom:0px;">所属区域</label>'
					+'</div>'
					+'</td>'
					+'<td id="xf-2-3-1" class="xf-cell xf-cell-right xf-cell-bottom" width="25%">'
					+'<div class="xf-handler">'
					+'	<input type="text" id="area" name="area" style="border:0px;text-align:center" readonly>'
					+'</div>'
					+'</td>'
					+'<td id="xf-2-3-2" class="xf-cell xf-cell-right xf-cell-bottom"  width="25%">'
					+'<div class="xf-handler">'
					+'	<label style="display:block;text-align:center;margin-bottom:0px;">所属分公司</label>'
					+'</div>'
					+'</td>'
					+'<td id="xf-2-3-3" class="xf-cell xf-cell-right xf-cell-bottom" width="25%">'
					+'<div class="input-group userPicker" style="width: 175px;" >'
					+'<input type="text" id="branchOffice" name="branchOffice" style="width:100%" readonly>'
					+'</div>'
					+'</td>'
					+'	<input type="hidden" id="system" name="system" value="">'
					+'	<input type="hidden" id="systemName" name="systemName" value="">'
					+'</tr>');
		}
		
		function changeOaDiv(){
			$("#form-tfoot").html('<tr id="xf-2-3">'
					+'<td id="xf-2-3-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-left" width="25%">'
					+'<div class="xf-handler">'
					+'	<label style="display:block;text-align:center;margin-bottom:0px;">所属区域</label>'
					+'</div>'
					+'</td>'
					+'<td id="xf-2-3-1" class="xf-cell xf-cell-right xf-cell-bottom" width="25%">'
					+'<div class="xf-handler">'
					+'	<input type="text" id="area" name="area" style="border:0px;text-align:center" readonly>'
					+'</div>'
					+'</td>'
					+'<td id="xf-2-3-2" class="xf-cell xf-cell-right xf-cell-bottom"  width="25%">'
					+'<div class="xf-handler">'
					+'	<label style="display:block;text-align:center;margin-bottom:0px;">所属体系</label>'
					+'</div>'
					+'</td>'
					+'<td id="xf-2-3-3" class="xf-cell xf-cell-right xf-cell-bottom" width="25%">'
					+'<div class="xf-handler">'
					+'<select class="form-control required" id="system" name="system" onchange="getSystemName()">'
					+'		<option value="">请选择</option>'
					 +'		<c:forEach items="${systemlist}" var="item">'
					+'			<option value="${item.value}" >${item.name}</option>'
					+'		</c:forEach>' 
					+'	</select>'
					+'	<input type="hidden" id="systemName" name="systemName">'
					+'</div>'
					+'</td>'
					+'</tr>'
					+'<tr id="xf-2-4">'
					+'<td id="xf-2-4-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">'
					+'<div class="xf-handler">'
					+'	<label style="display:block;text-align:center;margin-bottom:0px;">所属分公司</label>'
					+'</div>'
					+'</td>'
					+'<td id="xf-2-4-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top" colspan="3"  width="25%">'
					+'<div class="input-group userPicker" style="width: 175px;" >'
					+'	<input type="text" id="branchOffice" name="branchOffice" style="width:100%" readonly>'
					+'</div>'
					+'</td>'
					+'</tr>');
		}
		
		
    </script>
  </head>

  <body onload="time()">
    <%@include file="/header/bpm-workspace3.jsp"%>
<form id="xform" method="post" action="${tenantPrefix}/Invoice/process-operationInvoice-startProcessInstance.do" class="xf-form" enctype="multipart/form-data">
    <div class="container">

	  <!-- start of main -->
      <section id="m-main" class="col-md-12" style="padding-top:65px;">
		<%-- <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="xf-table">
			  <tbody>
			    <tr>
				  <td width="25%" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
				    <label style="display:block;text-align:center;margin-bottom:0px;padding-top:10px;padding-bottom:10px;">审核环节&nbsp;</label>
				  </td>
				  <td width="75%" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top" colspan="3" rowspan="1">
				    <div id="nextStep"></div>
				  </td>
				</tr>
			  </tbody>
			</table>
		<script>
		  $.getJSON('${tenantPrefix}/rs/bpm/whole', {
			  processDefinitionId: '<%= request.getParameter("processDefinitionId")%>',
			  activityId: '<%= request.getParameter("activityId")%>',
			  isWhole:true
		  }, function(data) {
			  $('#nextStep').append('&nbsp;');
			  for (var i = 0; i < data.length; i++) {
				  $('#nextStep').append(data[i].name);
			  }
		  });
		</script> --%>

      <input type="hidden" name="shopTel" id="shopTel" style="width:100%;text-align:center" readonly>
		<input id="processInstanceId" type="hidden" name="processInstanceId" value="${processInstanceId}">
		<input id="humanTaskId" type="hidden" name="humanTaskId" value="${humanTaskId}">
		<input id="autoCompleteFirstTask" type="hidden" name="autoCompleteFirstTask" value="false">
		<input id="activityId" type="hidden" name="activityId" value="">
		<input id="invoiceId" type="hidden" name="invoiceId">
		<input id="userId" type="hidden" name="userId" value="<%=userId %>">
		<div id="xf-form-table">
			<div id="xf-1" class="xf-section">
				<h1 id="h1Id" style="text-align:center;">发票调整单</h1>
			</div>
			
			<div id="xf-2" class="xf-section">
				<table class="xf-table" width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
					<tbody>
						<tr id="xf-2-0">
							<td id="xf-2-0-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">专卖店编号/手机号</label>
								</div>
							</td>
							<td id="xf-2-0-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left"  width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">专卖店姓名</label>
								</div>
							</td>
							<td id="xf-2-0-2" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top"  width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">专卖店电话</label>
								</div>
							</td>
							<td id="xf-2-0-3" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top"  width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">申请发票日期</label>
								</div>
							</td>
						</tr>
						<tr id="xf-2-1">
							<td id="xf-2-1-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-left" width="25%">
								<div class="xf-handler">
									<input type="text" name="ucode" id="ucode" style="width:100%;text-align:center" readonly>
								</div>
							</td>
							<td id="xf-2-1-1" class="xf-cell xf-cell-right xf-cell-bottom"  width="25%">
								<div class="xf-handler">
									<input type="text" name="shopName" id="shopName" style="width:100%;text-align:center" readonly>
								</div>
							</td>
							<td id="xf-2-1-2" class="xf-cell xf-cell-right xf-cell-bottom"  width="25%">
								<div class="xf-handler" id="shopTels">
									
								</div>
								
							</td>
							<td id="xf-2-1-3" class="xf-cell xf-cell-right xf-cell-bottom"  width="25%">
								<div class="xf-handler" >
									<input type="text" id="applyDate" name="invoiceDate" readonly="readonly" style="width:100%;text-align:center" >
								</div>
							</td>
						</tr>
						<tr id="xf-2-2">
							<td id="xf-2-2-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">订单单据号</label>
								</div>
							</td>
							<td id="xf-2-2-1" class="xf-cell xf-cell-right xf-cell-bottom" width="25%" colspan="3">
								<div class="xf-handler">
									<textarea rows="3" id="orderNumber" name="orderNumber" style="width:100%"></textarea>
								</div>
							</td>
							
						</tr>
						<tbody id="form-tfoot">
						<tr id="xf-2-3">
							<td id="xf-2-3-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">所属区域</label>
								</div>
							</td>
							<td id="xf-2-3-1" class="xf-cell xf-cell-right xf-cell-bottom" width="25%">
								<div class="xf-handler">
									<input type="text" id="area" name="area" style="width:100%" readonly>
								</div>
							</td>
							<td id="xf-2-3-2" class="xf-cell xf-cell-right xf-cell-bottom"  width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">所属体系</label>
								</div>
							</td>
							<td id="xf-2-3-3" class="xf-cell xf-cell-right xf-cell-bottom" width="25%">
								<div class="xf-handler">
									<!-- <input type="text" id="system" name="system" style="width:100%" readonly> -->
									<select class="form-control required" id="system" name="system" onchange="getSystemName()">
										<c:forEach items="${systemlist}" var="item">
		  									<option value="${item.value}" >${item.name}</option>
		  								</c:forEach>
									</select>
									<input type="hidden" id="systemName" name="systemName">
								</div>
							</td>
						</tr>
						<tr id="xf-2-4">
							<td id="xf-2-4-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">所属分公司</label>
								</div>
							</td>
							<td id="xf-2-4-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top" colspan="3"  width="25%">
								<div class="xf-handler">
									<input type="text" id="branchOffice" name="branchOffice" style="width:100%" readonly>
							    </div>
							</td>
						</tr>
						</tbody>
						<tr id="xf-2-5">
							<td id="xf-2-5-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">发票类型</label>
								</div>
							</td>
							<td id="xf-2-5-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%" colspan="3">
								<div class="xf-handler">
									<input type="radio" id="commonId" name="invoiceType" value="普通发票">普通发票&nbsp;&nbsp;<input type="radio" id="appreciationid1" name="invoiceType" value="增值税普通发票">增值税普通发票
									&nbsp;&nbsp;<input type="radio" id="appreciationid2" name="invoiceType" value="增值税专用发票">增值税专用发票
								</div>
							</td>
						</tr>
						 <tr id="xf-9-9">
							<td id="xf-2-9-9" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">抄送</label>
								</div>
							</td>
							<td id="xf-3-9-9" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%" colspan="3">
								<div class="xf-handler" id="copyNames">
								</div>
							</td>
						</tr>
						<tr id="xf-2-6">
							<td id="xf-2-6-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%" rowspan="4" align="center">
								<div class="xf-handler">
									<input type="radio" id="person" name="category"  value="个人" onclick="check()"><label>个人</label>
								</div>
							</td>
							<td id="xf-2-6-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">发票抬头</label>
								</div>
							</td>
							<td id="xf-2-6-2" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<input type="text" id="invoiceTitlePerson" name="invoiceTitle" style="width:100%">
								</div>
							</td>
						</tr>
						<tr id="xf-2-7" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-7-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">发票明细(产品名称、价格、数量)</label>
								</div>
							</td>
							<td id="xf-2-7-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<textarea rows="5" id="invoiceDetailPerson" name="invoiceDetail" style="width:100%" onkeyup="maxWords()"  onblur="maxWords()"></textarea>
								</div>
							</td>
						</tr>
						<tr id="xf-2-8" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-8-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;"> 发票开具总金额</label>
								</div>
							</td>
							<td id="xf-2-8-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<input type="text" id="invoiceMoneyPerson" name="invoiceMoney" style="width:100%" onblur="var reg = /^[0-9]+([.]{1}[0-9]{1,2})?$/; if(!reg.test(this.value)) this.value = ''; ">
								</div>
							</td>
						</tr>
						<tr id="xf-2-9" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-9-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;"> 身份证号码</label>
								</div>
							</td>
							<td id="xf-2-9-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="75%" colspan="3">
								<div class="xf-handler">
									<input id="idNumber" name="idNumber" type="text" style="width:100%">
								</div>
							</td>
						</tr>
						<tr id="xf-2-10" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-10-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" align="center" rowspan="8" width="25%">
								<div class="xf-handler">
									<input id="public" type="radio" name="category"  value="对公" onclick="disableElement()"><label>对公</label>
								</div>
							</td>
							<td id="xf-2-10-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">发票抬头</label>
								</div>
							</td>
							<td id="xf-2-10-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<input type="text" id="invoiceTitlePublic" name="invoiceTitle" style="width:100%">
								</div>
							</td>
						</tr>
						<tr id="xf-2-11" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-11-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;">发票明细(产品名称、价格、数量)</label>
								</div>
							</td>
							<td id="xf-2-11-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<textarea rows="5" id="invoiceDetailPublic" name="invoiceDetail" style="width:100%" onkeyup="maxWords()"  onblur="maxWords()"></textarea>
								</div>
							</td>
						</tr>
						<tr id="xf-2-12" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-12-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;"> 发票开具总金额</label>
								</div>
							</td>
							<td id="xf-2-12-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<input type="text" id="invoiceMoneyPublic" name="invoiceMoney" style="width:100%" onblur="var reg = /^[0-9]+([.]{1}[0-9]{1,2})?$/; if(!reg.test(this.value)) this.value = ''; ">
								</div>
							</td>
						</tr>
						<tr id="xf-2-13" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-13-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;"> 企业名称</label>
								</div>
							</td>
							<td id="xf-2-13-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<input type="text" id="enterpriseName" name="enterpriseName" style="width:100%">
								</div>
							</td>
						</tr>
						<tr id="xf-2-14" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-14-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;"> 税务登记号</label>
								</div>
							</td>
							<td id="xf-2-14-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<input type="text" id="taxNumber" name="taxNumber" style="width:100%">
								</div>
							</td>
						</tr>
						<tr id="xf-2-15" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-15-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;"> 开户行</label>
								</div>
							</td>
							<td id="xf-2-15-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<input type="text" id="openingBank" name="openingBank" style="width:100%">
								</div>
							</td>
						</tr>
						<tr id="xf-2-16" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-16-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;"> 开户行账号</label>
								</div>
							</td>
							<td id="xf-2-16-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<input type="text" id="accountNumber" name="accountNumber" style="width:100%">
								</div>
							</td>
						</tr>
						<tr id="xf-2-17" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
							<td id="xf-2-17-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<div class="xf-handler">
									<label style="display:block;text-align:center;margin-bottom:0px;"> 企业地址及电话</label>
								</div>
							</td>
							<td id="xf-2-17-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="50%" colspan="2">
								<div class="xf-handler">
									<input type="text" id="enterpriseAddress" name="enterpriseAddress" style="width:100%">
								</div>
							</td>
						</tr>
							
						<tr id="xf-18">
							<td id="xf-18-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%">
								<label style="display:block;text-align:center;margin-bottom:0px;">发票邮寄地址</label>
							</td>
							<td id="xf-18-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" colspan="3">
								<input id="invoiceMailAddress" name="invoiceMailAddress" type="text" style="width:100%">
							</td>
						</tr>
						<tr id="xf-19">
							<td id="xf-19-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" colspan="2" width="50%">
								<label style="display:block;text-align:center;margin-bottom:0px;">收件人姓名</label>
							</td>
							<td id="xf-19-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%"><label style="display:block;text-align:center;margin-bottom:0px;">收件人电话</label></td>
							<td id="xf-19-2" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" width="25%"><label style="display:block;text-align:center;margin-bottom:0px;">收件人备用电话</label></td>
						</tr>
					
						<tr id="xf-20">
							<td id="xf-20-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" colspan="2"><input id="addressee" name="addressee" type="text" style="width:100%"></td>
							<td id="xf-20-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left"><input id="addresseeTel" name="addresseeTel" type="text" style="width:100%"></td>
							<td id="xf-20-2" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left"><input id="addresseeSpareTel" name="addresseeSpareTel" type="text" style="width:100%"></td>
						</tr>
						<tr id="xf-21">
							<td id="xf-21-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" colspan="4">
								<label style="display:block;text-align:left;margin-bottom:0px;">注：产品明细可选日用品、化妆品、保健品统称，增值税专用发票除外</label>
							</td>
						</tr>
						<tr id="xf-22">
							<td id="xf-22-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" colspan="4">
								<label style="display:block;margin-bottom:0px;">注：1.普通发票、增值税普通发票可针对个人或对公开具，增值税专用发票仅针对对公开具；2.增值税专用发票必须开具产品明细，其他票据的产品明细可选填日用品、化妆品、保健品统称；3.增值税专用发票开具时请上传对方公司营业执照、税务登记证及开户行许可证电子版；4.不可直接体现在发票中的产品为：罗麦π化负离子健康机、罗麦健康活氧解毒机、罗麦π石链(长)、罗麦π石链、罗麦π水宝、杯芯（8个/盒）、罗麦居家套装锅具（汤锅、炒锅）、罗麦熣燦套锅（砂光）、罗麦熣燦套锅（镜光），如会员订购此类产品，可将其开具为其他产品。</label>
							</td>
						</tr>
						<tr id="xf-23">
							<td id="xf-23-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" colspan="4">
								<label style="display:block;text-align:center;margin-bottom:0px;">上传附件</label>
							</td>
						</tr>
						<tr id="xf-24">
							<td id="xf-24-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" colspan="4">
		                        <div class="col-md-8">
		                            <%@include file="/common/_uploadFile.jsp"%>
		                            <span style="color:gray;"> 请添加小于200M的附件 </span>
		                        </div>
	                    	</td>
                    	</tr>
						<tr id="xf-25">
							<td id="xf-25-0" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left">
		                        <div class="xf-from">
		                        	<label style="display:block;text-align:center;margin-bottom:0px;">历史附件：</label>
		                        </div>
	                    	</td>
							<td id="xf-25-1" class="xf-cell xf-cell-right xf-cell-bottom xf-cell-top xf-cell-left" colspan="3">
		                        <!-- <div class="xf-from">
		                        	<input type="text" id="history" style="width:100%" readonly>
		                        </div> -->
		                        <div class="col-md-8">
                            		<%@include file="/common/show_edit_file.jsp" %>
                        		</div>
	                    	</td>
                    	</tr>
					</tbody>
				</table>
				<table id="myTable" width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="table table-border">
				  <thead>
				    <tr>
					  <th>环节</th>
					  <th>操作人</th>
					  <th>时间</th>
					  <th>结果</th>
					  <th>审核时长</th>
					</tr>
				  </thead>
				  <tbody>
					  <c:forEach var="item" items="${logHumanTaskDtos}">
					  <c:if test="${not empty item.completeTime}">
				    <tr>
					  <td>${item.name}</td>
					  <td><tags:user userId="${item.assignee}"/></td>
					  <td><fmt:formatDate value="${item.completeTime}" type="both"/></td>
					  <td>${item.action}</td>
					  <td>${item.auditDuration}</td>
					</tr>
					<c:if test="${item.action != '提交' && item.action != '重新申请'}">
						<tr style="border-top:0px hidden;">
							<td>批示内容</td>
							<td colspan="4"><pre>${item.comment}</pre></td>
						</tr>
					</c:if>
					  </c:if>
					  </c:forEach>
				  </tbody>
				</table>
			</div>
		</div>
		<br>
    </section>
	<!-- end of main -->
  </div>
  <br/><br/><br/><br/>
  <div class="navbar navbar-default navbar-fixed-bottom">
    <div class="container-fluid">
      <div class="text-center" style="padding-top:8px;">
	    <div class="text-center" style="padding-top:8px;">
			<!-- <button id="saveDraft" class="btn btn-default" type="button" onclick="taskOperation.saveDraft()">保存草稿</button> -->
			<button id="adjustment" class="btn btn-default" type="button" onclick="completeTask(3)">调整申请</button>
			<button id="revoke" class="btn btn-default" type="button" onclick="completeTask(4)">撤销申请</button>
			<button id="endProcess" type="button" class="btn btn-default" onclick="confirmOperation()">撤销申请</button>
			<button type="button" class="btn btn-default" onclick="javascript:history.back();">返回</button>
			
		</div>
	
	  </div>
    </div>
  </div>
</form>
</body>

</html>
