<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/jspTag" prefix="n"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
$(function(){
    fillPage(${json});
 });
$("#goExam form[id='form1']").validate({
    rules: {
    	/* database_no:{required: true}, */
    	database_name:{required: true},
    	database_type:{required: true},
    	connect_type:{required: true},
    	driver_class:{required: true},
    	url:{required: true},
    	db_user:{required: true},
    	db_pwd:{required: true}
    }
});

//填充页面   要填充的id/(下拉框类型)/html元素id
function autoF(aid, t, vid) {
	 if (t == "MYSQL") {
		 $("#" + aid).append('<label for=\"exam_paper_name\" class=\"col-sm-2 control-label\"><span class=\"not-null\">*</span>数据库驱动</label><div class=\"col-sm-8 has-feedback\"><select name=\"driver_class\" id=\"driver_class\" class=\"form-control\"><option value=\"com.mysql.jdbc.Driver\">com.mysql.jdbc.Driver</option></select></div>')
	} else if (t == "ORACLE") {
		$("#" + aid).append('<label for=\"exam_paper_name\" class=\"col-sm-2 control-label\"><span class=\"not-null\">*</span>数据库驱动</label><div class=\"col-sm-8 has-feedback\"><select name=\"driver_class\" id=\"driver_class\" class=\"form-control\"><option value=\"oracle.jdbc.driver.OracleDriver\">oracle.jdbc.driver.OracleDriver</option></select></div>')
	}
}

function configProType(t, aid, qz) {
	$("#" + aid).hide();//隐藏
	$("#" + aid).html("");//清空
	if (t == "ORACLE") {
		qz="ORACLE";
		$("#" + aid).show();
		autoF(aid, t, qz);
	} else if (t == "MYSQL") {
		qz="MYSQL";
		$("#" + aid).show();
		autoF(aid, t, qz);
	} 
}
</script>
<body>
  <!-- 提示信息区  -->
  <div id="message"></div>
  <!-- 导航条  -->
  <ol class="breadcrumb">
    <li><a href="#">首页</a></li>
    <li><a href="#">数据库配置管理</a></li>
    <li class="active">数据库配置新增</li>
  </ol>
  <div id="goExam" class="panel-collapse collapse in">
    <form id="form1" class="form-horizontal">
      <%-- <div class="form-group">
        <label for="exam_paper_name" class="col-sm-2 control-label"><span class="not-null">*</span>数据库编码</label>
        <div class="col-sm-8 has-feedback">
            <input type="text" class="form-control" id="database_no" value="${database_no}" name="database_no" placeholder="数据库编码">
        </div>
      </div> --%>
      <div class="form-group">
        <label for="exam_paper_name" class="col-sm-2 control-label">
          <span class="not-null">*</span>数据库名称
        </label>
        <div class="col-sm-8 has-feedback">
          <input type="text" class="form-control" id="database_name" name="database_name" placeholder="数据库名称">
        </div>
      </div>
      <div class="form-group">
        <label for="ui_input_select" class="col-sm-2 control-label">
          <span class="not-null">*</span>数据库类型
        </label>
        <div class="col-sm-8 has-feedback">
          <select name="database_type" id="database_type" class="form-control" onchange="configProType(this.value,'driver_class','')">
            <option value=''></option>
            <option value='MYSQL'>MYSQL</option>
            <option value='ORACLE'>ORACLE</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <label for="ui_input_select" class="col-sm-2 control-label">
          <span class="not-null">*</span>连接方式
        </label>
        <div class="col-sm-8 has-feedback">
          <n:select id="connect_type" up_no="connect_type" value="connect_type" />
        </div>
      </div>
      <div class="form-group">
        <label for="exam_paper_name" class="col-sm-2 control-label">
          <span class="not-null">*</span>数据库地址
        </label>
        <div class="col-sm-8 has-feedback">
          <input type="text" class="form-control" id="url" name="url" value="${url}" placeholder="数据库地址">
        </div>
      </div>
      <div class="form-group">
        <label for="exam_paper_name" class="col-sm-2 control-label">
          <span class="not-null">*</span>数据库用户名
        </label>
        <div class="col-sm-8 has-feedback">
          <input type="text" class="form-control" id="db_user" name="db_user" placeholder="数据库用户名">
        </div>
      </div>
      <div class="form-group">
        <label for="exam_paper_name" class="col-sm-2 control-label">
          <span class="not-null">*</span>数据库密码
        </label>
        <div class="col-sm-8 has-feedback">
          <input type="text" class="form-control" id="db_pwd" name="db_pwd" placeholder="数据库密码">
        </div>
      </div>
      <div class="form-group" id="driver_class">
        <%--  <label for="exam_paper_name" class="col-sm-2 control-label"><span class="not-null">*</span>数据库驱动</label>
        <div class="col-sm-8 has-feedback">
          <input type="text" class="form-control" id="driver_class" value="${driver_class}" name="driver_class" placeholder="数据库驱动">
        </div> --%>
      </div>
      <div class="row text-center">
        <button type="button" name="dataconfigAdd.do" onclick="add(this)" class="btn btn-primary btn-sm">
          <span class="fa fa-save fa-lg"></span> <font>保存</font>
        </button>
        <button type="button" data-ns="goexamQuery" onclick="resetForm(this),reSetcontent()" class="btn btn-link">
          <span class="fa fa-rotate-left"></span>
        </button>
        <button type="button" name="dodataBaseQuery.do" onclick="goBack(this)" class="btn btn-link">
          <span class="fa fa-reply"></span>
        </button>
      </div>
    </form>
  </div>
  <div id="queryTerms" class="hidden"></div>
</body>
</html>