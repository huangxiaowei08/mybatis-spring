<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/jspTag" prefix="n"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
$(function(){
    fillPage(${json});
 });
$("#sysconfig form[id='form1']").validate({
    rules: {
    	startup_no:{required: true},
    	class_name:{required: true},
    	class_memo:{required: true},
    	display_order:{required: true,number:true}
    }
});
</script>
</head>
<body>
  <!-- 提示信息区  -->
  <div id="message"></div>
  <!-- 导航条  -->
  <ol class="breadcrumb">
    <li><a href="#">首页</a></li>
    <li><a href="#">系统启动管理</a></li>
    <li class="active">系统启动新增</li>
  </ol>
  <div id="sysconfig" class="panel-collapse collapse in">
  <form id="form1" class="form-horizontal" >
      <div class="form-group">
        <label for="exam_paper_name" class="col-sm-2 control-label"><span class="not-null">*</span>类名</label>
        <div class="col-sm-8 has-feedback">
          <input type="text" class="form-control" id="class_name" name="class_name" placeholder="类名">
        </div>
      </div>                    
      <div class="form-group">
        <label for="ui_input_select" class="col-sm-2 control-label"><span class="not-null">*</span>类说明</label>
        <div class="col-sm-8 has-feedback">
          <input type="text" class="form-control" id="class_memo" name="class_memo" placeholder="类说明">
        </div>
      </div>
       <div class="form-group">
        <label for="ui_input_select" class="col-sm-2 control-label"><span class="not-null">*</span>显示顺序</label>
        <div class="col-sm-8 has-feedback">
          <input type="text" class="form-control" id="display_order" name="display_order" placeholder="显示顺序">
        </div>
      </div>
      <div class="row text-center">
        <button type="button" name="sysStartconfigAdd.do" onclick="add(this)" class="btn btn-primary btn-sm">
          <span class="fa fa-save fa-lg"></span> <font>保存</font>
        </button>
        <button type="button" data-ns="goexamQuery" onclick="resetForm(this),reSetcontent()" class="btn btn-link">
          <span class="fa fa-rotate-left"></span>
        </button>
        <button type="button" name="doSysStartQuery.do" onclick="goBack(this)" class="btn btn-link">
          <span class="fa fa-reply"></span>
        </button>
      </div>
  </form>
   </div>
   <div id="queryTerms" class="hidden"></div>
</body>
</html>