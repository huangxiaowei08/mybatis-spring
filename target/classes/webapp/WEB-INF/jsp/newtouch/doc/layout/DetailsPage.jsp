<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>明细页面</title>
</head>
<body>
  <h1 class="page-header" id="DetailsPage">明细页面</h1>
  <p>
    明细页面分为了
    <code>导航条</code>
    、
    <code>提示信息区</code>
    、
    <code>操作区</code>
    、
    <code>温馨提示区</code>
    、
    <code>查询条件暂存区</code>
    几个功能块，每个块对应的含义和代码如下。
  </p>
  <h2 id="Detailsnavigationbar" class="page-header">导航条</h2>
  <p>
    与查询页面导航条相同，<a href="#navigationbar">点击查看</a>查询页面导航条。
  </p>
  <h2 id="Detailsmessage" class="page-header">提示信息区</h2>
  <p>
    与查询页面提示信息区相同，<a href="#message">点击查看</a>查询页面提示信息区。
  </p>
  <h2 id="DetailsColumns" class="page-header">
    操作区<small>多列多行</small>
  </h2>
  <p>对于录入项非常多的内容建议使用多列多行的形式进行操作。</p>
  <div class="bs-example">
    <form id="form1" class="form-horizontal">
      <div class="row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="input1" class="col-md-5 control-label"><span class="not-null">*</span>录入项一</label>
            <div class="col-xs-12 col-md-7">
              <input type="text" class="form-control" id="input1" name="input1" placeholder="录入项一" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="input2" class="col-md-5 control-label"><span class="not-null">*</span>录入项二</label>
            <div class="col-xs-12 col-md-7">
              <input type="text" class="form-control" id="input2" name="input2" placeholder="录入项二" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="input3" class="col-md-5 control-label">录入项三</label>
            <div class="col-xs-12 col-md-7">
              <input type="text" class="form-control" id="input3" name="input3" placeholder="录入项三" />
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="input4" class="col-md-5 control-label">录入项四</label>
            <div class="col-xs-12 col-md-7">
              <input type="text" class="form-control" id="input4" name="input4" placeholder="录入项四" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="input5" class="col-md-5 control-label">录入项五</label>
            <div class="col-xs-12 col-md-7">
              <input type="text" class="form-control" id="input5" name="input5" placeholder="录入项五" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="input6" class="col-md-5 control-label">录入项六</label>
            <div class="col-xs-12 col-md-7">
              <input type="text" class="form-control" id="input6" name="input6" placeholder="录入项六" />
            </div>
          </div>
        </div>
      </div>
      <div class="row text-center">
        <button type="button" name="doUserAdd.do" data-ns="goUserQuery" class="btn btn-primary btn-sm">
          <span class="fa fa-save fa-lg"></span> <font>基本信息</font>
        </button>
        <button type="button" data-ns="goUserQuery" class="btn btn-link">
          <span class="fa fa-rotate-left"></span>
        </button>
        <button type="button" name="goUserQuery.do" data-ns="goUserQuery" class="btn btn-link">
          <span class="fa fa-reply"></span>
        </button>
      </div>
    </form>
    <ul class="nav nav-tabs" role="tablist">
      <li class="active"><a role="tab" data-toggle="tab">HTML</a></li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active" id="">
        <script class="brush: html;" type="syntaxhighlighter">
          <![CDATA[
<form id="form1" class="form-horizontal">
  <!-- 第一行 -->
  <div class="row">
    <div class="col-md-4">
      <div class="form-group">
        <label for="input1" class="col-md-5 control-label"><span class="not-null">*</span>录入项一</label>
        <div class="col-xs-12 col-md-7">
          <input type="text" class="form-control" id="input1" name="input1" placeholder="录入项一" />
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="form-group">
        <label for="input2" class="col-md-5 control-label"><span class="not-null">*</span>录入项二</label>
        <div class="col-xs-12 col-md-7">
          <input type="text" class="form-control" id="input2" name="input2" placeholder="录入项二" />
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="form-group">
        <label for="input3" class="col-md-5 control-label">录入项三</label>
        <div class="col-xs-12 col-md-7">
          <input type="text" class="form-control" id="input3" name="input3" placeholder="录入项三" />
        </div>
      </div>
    </div>
  </div>
  <!-- 第二行 -->
  <div class="row">
    <div class="col-md-4">
      <div class="form-group">
        <label for="input4" class="col-md-5 control-label">录入项四</label>
        <div class="col-xs-12 col-md-7">
          <input type="text" class="form-control" id="input4" name="input4" placeholder="录入项四" />
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="form-group">
        <label for="input5" class="col-md-5 control-label">录入项五</label>
        <div class="col-xs-12 col-md-7">
          <input type="text" class="form-control" id="input5" name="input5" placeholder="录入项五" />
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="form-group">
        <label for="input6" class="col-md-5 control-label">录入项六</label>
        <div class="col-xs-12 col-md-7">
          <input type="text" class="form-control" id="input6" name="input6" placeholder="录入项六" />
        </div>
      </div>
    </div>
  </div>
  <div class="row text-center">
    <button type="button" name="doUserAdd.do" data-ns="goUserQuery" onclick="add(this)" class="btn btn-primary btn-sm">
      <span class="fa fa-save fa-lg"></span> <font>基本信息</font>
    </button>
    <button type="button" data-ns="goUserQuery" onclick="resetForm(this)" class="btn btn-link">
      <span class="fa fa-rotate-left"></span>
    </button>
    <button type="button" name="goUserQuery.do" data-ns="goUserQuery" onclick="goBack(this)" class="btn btn-link">
      <span class="fa fa-reply"></span>
    </button>
  </div>
            ]]></script>
      </div>
    </div>
    <div class="bs-callout bs-callout-warning">
      <p></p>
    </div>
  </div>
  <h2 id="DetailsColumn" class="page-header">
    操作区<small>一列多行</small>
  </h2>
  <p>对于录入项较少的内容，可以使用一列多行的形式进行维护。</p>
  <div class="bs-example">
    <form id="form1" class="form-horizontal">
      <div class="form-group">
        <label for="dept_no" class="col-sm-2 control-label">所属机构</label>
        <div class="col-sm-10 has-feedback">
          <input type="text" class="form-control" id="dept_no" placeholder="所属机构">
        </div>
      </div>
      <div class="form-group">
        <label for="user_no" class="col-sm-2 control-label"><span class="not-null">*</span>登录帐号</label>
        <div class="col-sm-10 has-feedback">
          <input type="text" class="form-control" id="user_no" name="user_no" placeholder="登录帐号"> <span class="help-block">6~18个字符，可使用字母、数字、下划线，需以字母开头</span>
        </div>
      </div>
      <div class="form-group">
        <label for="user_name" class="col-sm-2 control-label"><span class="not-null">*</span>姓名</label>
        <div class="col-sm-10 has-feedback">
          <input type="text" class="form-control" id="user_name" name="user_name" placeholder="姓名">
        </div>
      </div>
      <div class="form-group">
        <label for="employee_no" class="col-sm-2 control-label"><span class="not-null">*</span>工号</label>
        <div class="col-sm-10 has-feedback">
          <input type="text" class="form-control" id="employee_no" name="employee_no" placeholder="工号">
        </div>
      </div>
      <div class="form-group">
        <label for="user_pwd" class="col-sm-2 control-label"><span class="not-null">*</span>密码</label>
        <div class="col-sm-10 has-feedback">
          <input type="password" class="form-control" id="user_pwd" name="user_pwd" placeholder="密码">
        </div>
      </div>
      <div class="form-group">
        <label for="user_pwd_confirm" class="col-sm-2 control-label"><span class="not-null">*</span>确认密码</label>
        <div class="col-sm-10 has-feedback">
          <input type="password" class="form-control" id="user_pwd_confirm" name="user_pwd_confirm" placeholder="确认密码">
        </div>
      </div>
      <div class="row text-center">
        <button type="button" name="doUserAdd.do" data-ns="goUserQuery" class="btn btn-primary btn-sm">
          <span class="fa fa-save fa-lg"></span> <font>保存</font>
        </button>
        <button type="button" data-ns="goUserQuery" class="btn btn-link">
          <span class="fa fa-rotate-left"></span>
        </button>
        <button type="button" name="goUserQuery.do" data-ns="goUserQuery" class="btn btn-link">
          <span class="fa fa-reply"></span>
        </button>
      </div>
    </form>
    <ul class="nav nav-tabs" role="tablist">
      <li class="active"><a role="tab" data-toggle="tab">HTML</a></li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active">
        <script class="brush: html;" type="syntaxhighlighter">
          <![CDATA[
<form id="form1" class="form-horizontal">
  <div class="form-group">
    <label for="dept_no" class="col-sm-2 control-label">所属机构</label>
    <div class="col-sm-10 has-feedback">
      <input type="text" class="form-control" id="dept_no" placeholder="所属机构">
    </div>
  </div>
  <div class="form-group">
    <label for="user_no" class="col-sm-2 control-label"><span class="not-null">*</span>登录帐号</label>
    <div class="col-sm-10 has-feedback">
      <input type="text" class="form-control" id="user_no" name="user_no" placeholder="登录帐号"> 
      <span class="help-block">6~18个字符，可使用字母、数字、下划线，需以字母开头</span>
    </div>
  </div>
  <div class="form-group">
    <label for="user_name" class="col-sm-2 control-label"><span class="not-null">*</span>姓名</label>
    <div class="col-sm-10 has-feedback">
      <input type="text" class="form-control" id="user_name" name="user_name" placeholder="姓名">
    </div>
  </div>
  <div class="form-group">
    <label for="employee_no" class="col-sm-2 control-label"><span class="not-null">*</span>工号</label>
    <div class="col-sm-10 has-feedback">
      <input type="text" class="form-control" id="employee_no" name="employee_no" placeholder="工号">
    </div>
  </div>
  <div class="form-group">
    <label for="user_pwd" class="col-sm-2 control-label"><span class="not-null">*</span>密码</label>
    <div class="col-sm-10 has-feedback">
      <input type="password" class="form-control" id="user_pwd" name="user_pwd" placeholder="密码">
    </div>
  </div>
  <div class="form-group">
    <label for="user_pwd_confirm" class="col-sm-2 control-label"><span class="not-null">*</span>确认密码</label>
    <div class="col-sm-10 has-feedback">
      <input type="password" class="form-control" id="user_pwd_confirm" name="user_pwd_confirm" placeholder="确认密码">
    </div>
  </div>
  <div class="row text-center">
    <button type="button" name="doUserAdd.do" data-ns="goUserQuery" onclick="add(this)" class="btn btn-primary btn-sm">
      <span class="fa fa-save fa-lg"></span> <font>保存</font>
    </button>
    <button type="button" data-ns="goUserQuery" onclick="resetForm(this)" class="btn btn-link">
      <span class="fa fa-rotate-left"></span>
    </button>
    <button type="button" name="goUserQuery.do" data-ns="goUserQuery" onclick="goBack(this)" class="btn btn-link">
      <span class="fa fa-reply"></span>
    </button>
  </div>
</form>
            ]]></script>
      </div>
    </div>
    <div class="bs-callout bs-callout-warning">
      <p>警告</p>
    </div>
  </div>
  <h2 id="Detailsreminder" class="page-header">温馨提示区</h2>
  <p>
    与查询页面温馨提示区相同，<a href="#reminder">点击查看</a>查询页面温馨提示区。
  </p>
  <h2 id="Detailsqueryconditioncache" class="page-header">查询条件暂存区</h2>
  <p>
    与查询页面查询条件暂存区相同，<a href="#queryconditioncache">点击查看</a>查询页面查询条件暂存区。
  </p>
  <h2 id="Detailsqueryloadjs" class="page-header">页面加载JS</h2>
  <p>
    页面加载的JS分为
    <code>填充页面属性</code>
    和
    <code>设置元素校验规则</code>
    两部分。设置元素校验校验规则使用的是
    <code>jquery.validate.js</code>
    插件，具体使用方法详件组件一节。
  </p>
  <div class="bs-example">

    <ul class="nav nav-tabs" role="tablist">
      <li class="active"><a role="tab" data-toggle="tab">HTML</a></li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active" id="需要修改">
        <pre class="brush: js; html-script: true">
&lt;script type="text/javascript">
  $(function(){
    // 填充页面属性
    fillPage(&#36{json}, "goUserQuery");
    // 设置元素校验规则
    $("#goUserQuery form[id='form1']").validate({
      rules: {
        user_no: {required: true, minlength: 2},
        user_name: "required",
        employee_no: "required",
        user_pwd: "required",
        user_pwd_confirm:{required: true, equalTo:"#user_pwd"}
      }
    });
  });
&lt;/script>
        </pre>
      </div>
    </div>
  </div>
</body>
</html>