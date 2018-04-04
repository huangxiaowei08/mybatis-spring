<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>布局</title>
</head>
<body>
  <div class="bs-docs-section">
    <h1 id="queryPage" class="page-header">查询页面</h1>
    <p>
      查询页面分为了
      <code>导航条</code>
      、
      <code>提示信息区</code>
      、
      <code>查询条件区</code>
      、
      <code>查询结果区</code>
      、
      <code>温馨提示区</code>
      、
      <code>查询条件暂存区</code>
      几个功能块，每个块对应的含义和代码如下。
    </p>


    <h2 id="navigationbar" class="page-header">导航条</h2>
    <p>用于显示当前页面所处的位置，以及上级菜单。</p>
    <p>目前无法点击导航条回退，后续会加入点击导航条回退到对应页面的功能。</p>
    <div class="bs-example">
      <!-- 导航条  -->
      <ol class="breadcrumb">
        <li><a href="#">首页</a></li>
        <li><a href="#">权限管理</a></li>
        <li class="active">用户查询</li>
        <span class="pull-right"> <a data-toggle="collapse" href="#goUserQueryClps"> 收缩</a>
        </span>
      </ol>
      <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a href="#html" role="tab" data-toggle="tab">HTML</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active">
          <script class="brush: html; highlight:7" type="syntaxhighlighter">
            <![CDATA[
<!-- 导航条  -->
<ol class="breadcrumb">
  <li><a href="#">首页</a></li>
  <li><a href="#">权限管理</a></li>
  <li class="active">用户查询</li>
  <span class="pull-right"> 
    <a data-toggle="collapse" href="#goUserQueryClps">收缩</a>
  </span>
</ol>
            ]]></script>
        </div>
      </div>
      <div class="bs-callout bs-callout-warning">
        <p>
          第7行中的
          <code>href</code>
          标签的值，需要与
          <code>操作区</code>
          中
          <code>DIV</code>
          的
          <code>id</code>
          值相同，才能够收缩对应的面板。
        </p>
      </div>
    </div>

    <h2 id="message" class="page-header">提示信息区</h2>
    <p>用于显示服务器端返回的提示信息。</p>
    <p>执行完成服务器请求后，提示信息由公用JS自动填充，只需将提示信息区域标识出来，不需要再另外写额外的代码。</p>
    <p>目前提示信息使用的是模态框的方式，暂时没有向提示信息区中写内容，但在开发过程中仍需要加入此部分代码，为后续扩展使用。</p>
    <div class="bs-example">
      <!-- 提示信息区  -->
      <div id="message"></div>
      <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a href="#html" role="tab" data-toggle="tab">HTML</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active">
          <script class="brush: html" type="syntaxhighlighter">
            <![CDATA[
<!-- 提示信息区  -->
<div id="message"></div>
            ]]></script>
        </div>
      </div>
    </div>
    <h2 id="querycondition" class="page-header">查询条件区</h2>
    <p>查询条件一般为3列n行的布局方式。</p>
    <div class="bs-example">
      <!-- 操作区  -->
      <div id="goUserQueryClps" class="panel-collapse collapse in">
        <form id="form1" class="form-horizontal">
          <div class="row">
            <div class="col-md-4">
              <div class="form-group">
                <label for="user_no" class="col-md-5 control-label">登录帐号</label>
                <div class="col-xs-12 col-md-7">
                  <input type="text" class="form-control" id="user_no" name="user_no" placeholder="登录帐号" />
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group">
                <label for="user_name" class="col-md-5 control-label">用户名称</label>
                <div class="col-xs-12 col-md-7">
                  <input type="text" class="form-control" id="user_name" name="user_name" placeholder="用户名称" />
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="form-group">
                <label for="state" class="col-md-5 control-label">状态</label>
                <div class="col-xs-12 col-md-7">
                  <select class="form-control" id="state" name="state">
                    <option value=""></option>
                    <option value="1">有效</option>
                    <option value="0">无效</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="row text-center">
            <button name="doUserQuery.do" type="button" class="btn btn-primary btn-sm" data-ns="goUserQuery">查询</button>
            <button type="button" data-ns="goUserQuery" class="btn btn-link">
              <span class="fa fa-rotate-left"></span>
            </button>
          </div>
        </form>
      </div>
      <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a href="#html" role="tab" data-toggle="tab">HTML</a></li>
        <li><a href="#queryconditioncontroller" role="tab" data-toggle="tab">Controller</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active" id="html">
          <script class="brush: html;highlight:[1,2]" type="syntaxhighlighter">
<![CDATA[
<div id="goUserQueryClps" class="panel-collapse collapse in">
  <form id="form1" class="form-horizontal">
    <div class="row">
      <div class="col-md-4">
        <div class="form-group">
          <label for="user_no" class="col-md-5 control-label">登录帐号</label>
          <div class="col-xs-12 col-md-7">
            <input type="text" class="form-control" id="user_no" name="user_no" placeholder="登录帐号" />
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="form-group">
          <label for="user_name" class="col-md-5 control-label">用户名称</label>
          <div class="col-xs-12 col-md-7">
            <input type="text" class="form-control" id="user_name" name="user_name" placeholder="用户名称" />
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="form-group">
          <label for="state" class="col-md-5 control-label">状态</label>
          <div class="col-xs-12 col-md-7">
            <select class="form-control" id="state" name="state">
              <option value=""></option>
              <option value="1">有效</option>
              <option value="0">无效</option>
            </select>
          </div>
        </div>
      </div>
    </div>
    <div class="row text-center">
      <button name="doUserQuery.do" onclick="query(this)" type="button" class="btn btn-primary btn-sm" data-ns="goUserQuery">查询</button>
      <button type="button" data-ns="goUserQuery" onclick="resetForm(this)" class="btn btn-link">
        <span class="fa fa-rotate-left"></span>
      </button>
    </div>
  </form>
</div>]]>
          </script>
        </div>
        <div class="tab-pane" id="queryconditioncontroller">
          <script class="brush: java;highlight:1" type="syntaxhighlighter">
          <![CDATA[
@RequestMapping("/goUserQuery.do")
public ModelAndView goUserQuery(HttpServletRequest request,
		HttpServletResponse response) {
	return returnPage(response, new ReturnMsg(),
			"newtouch/core/security/user/UserQuery");
}
            ]]></script>
        </div>
      </div>
      <div class="bs-callout bs-callout-warning">
        <p>
          第1行中的
          <code>id</code>
          值，需要与
          <code>导航条</code>
          中第7行的
          <code>href</code>
          值相同，才能够收缩此面板。并且此id值在页面范围内不能重复。
        </p>
        <p>
          查询条件录入框必须包含在
          <code>form</code>
          表单表，并且表单
          <code>id</code>
          必须为
          <code>form1</code>
          ，见代码第2行。
        </p>
        <p>
          按钮
          <code>data-ns</code>
          属性值需要与进入此页面的url相同，否则提交表单时取值会出错，属性详细介绍参见表单一节中按钮元素的介绍。
        </p>
      </div>
    </div>
    <h2 id="QueryResults" class="page-header">查询结果</h2>
    <div class="bs-example">
      <button name="goUserAdd.do" data-ns="goUserQuery" type="button" class="btn btn-primary btn-sm">
        <span class="fa fa-plus fa-lg"></span> <font>用户</font>
      </button>
      <button name="doUserDel.do" data-ns="goUserQuery" type="button" class="btn btn-link btn-sm">
        <span class="fa fa-times fa-lg"></span> <font>用户</font>
      </button>
      <div class="table-responsive">
        <table id="grid" class="table table-striped table-bordered table-hover table-condensed dataTable">
          <thead>
            <tr>
              <th axis="button" class="td_center">
                <button name="goUserMdf.do" type="button" class="btn btn-link btn-sm" style="display: none">
                  <span class="fa fa-pencil fa-lg"></span>
                </button>
              </th>
              <th axis="checkbox" class="td_center"><input onclick="checkAll(this)" type="checkbox" name="box" /></th>
              <th abbr="rn" class="td_center visible-lg">#</th>
              <th abbr="user_no">登录帐号</th>
              <th abbr="employee_no">员工工号</th>
              <th abbr="user_name">用户姓名</th>
              <th abbr="oper_auth" class="visible-lg">数据权限</th>
              <th abbr="oper_role" class="visible-lg">用户角色</th>
              <th abbr="state" class="visible-lg">用户状态</th>
              <th abbr="user_no" axis="hidden" class="hidden" />
            </tr>
          </thead>
        </table>
      </div>
      <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a role="tab" data-toggle="tab">HTML</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active">
          <script class="brush: html;" type="syntaxhighlighter">
          <![CDATA[
<button name="goUserAdd.do" onclick="addInit(this)" data-ns="goUserQuery" type="button" class="btn btn-primary btn-sm">
  <span class="fa fa-plus fa-lg"></span> <font>用户</font>
</button>
<button name="doUserDel.do" onclick="rowSubmit(this)" data-ns="goUserQuery" type="button" class="btn btn-link btn-sm">
  <span class="fa fa-times fa-lg"></span> <font>用户</font>
</button>
<div class="table-responsive">
  <table id="grid" class="table table-striped table-bordered table-hover table-condensed dataTable">
    <thead>
      <tr>
        <th axis="button" class="td_center">
          <button name="goUserMdf.do" type="button" class="btn btn-link btn-sm" style="display: none">
            <span class="fa fa-pencil fa-lg"></span>
          </button>
        </th>
        <th axis="checkbox" class="td_center"><input onclick="checkAll(this)" type="checkbox" name="box" /></th>
        <th abbr="rn" class="td_center visible-lg">#</th>
        <th abbr="user_no">登录帐号</th>
        <th abbr="employee_no">员工工号</th>
        <th abbr="user_name">用户姓名</th>
        <th abbr="oper_auth" class="visible-lg">数据权限</th>
        <th abbr="oper_role" class="visible-lg">用户角色</th>
        <th abbr="state" class="visible-lg">用户状态</th>
        <th abbr="user_no" axis="hidden" class="hidden" />
      </tr>
    </thead>
  </table>
</div>
            ]]></script>
        </div>
      </div>
      <div class="bs-callout bs-callout-warning">
        <p>
          查询结果通过
          <code>th</code>
          标签中的
          <code>abbr</code>
          属性进行匹配，若返回数据中不包含对应的值，则会报错。
        </p>
      </div>
    </div>

    <h2 id="reminder" class="page-header">温馨提示区</h2>
    <p>显示此页面的一些帮助和提示信息</p>
    <div class="bs-example">
      <!-- 温馨提示区  -->
      <div class="page-header">
        <h5>
          <small>温馨提示</small>
        </h5>
      </div>
      <div class="row">
        <ol>
          <li>分页会重新查询服务器，在点分页前修改了查询条件，会按新的查询条件查询。</li>
        </ol>
      </div>
      <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a role="tab" data-toggle="tab">HTML</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active">
          <script class="brush: html;" type="syntaxhighlighter">
          <![CDATA[
<div class="page-header">
  <h5><small>温馨提示</small></h5>
</div>
<div class="row">
  <ol>
    <li>分页会重新查询服务器，在点分页前修改了查询条件，会按新的查询条件查询。</li>
  </ol>
</div>
            ]]></script>
        </div>
      </div>
    </div>
    <h2 id="queryconditioncache" class="page-header">查询条件暂存区</h2>
    <p>点击查询按钮后会将查询条件缓存到此区域内，供分页按钮以及进入下一页面时使用。</p>
    <div class="bs-example">
      <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a role="tab" data-toggle="tab">HTML</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active">
          <script class="brush: html;" type="syntaxhighlighter">
          <![CDATA[
<!-- 查询条件暂存区 -->
<div id="queryTerms" class="hidden"></div>
            ]]></script>
        </div>
      </div>
    </div>
    <h2 id="queryloadjs" class="page-header">页面加载JS</h2>
    <p>需要在页面最下方加入以下代码，用于返回时写值。</p>
    <div class="bs-example">
      <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a role="tab" data-toggle="tab">Javascrpit</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane active">
          <pre class="brush: js; html-script: true">
&lt;script type="text/javascript">
  $(function(){
     goBackQuery(&#36("#goUserQuery button[name='doUserQuery.do']")[0], &#36{json});
  });
&lt;/script>
        </pre>
        </div>
      </div>
      <div class="bs-callout bs-callout-warning">
        <p>
          <code>goBackQuery</code>
          函数的第一个入参为
          <code>查询按钮</code>
          对象，第二个入参为服务器端的
          <code>返回值</code>
          。
        </p>
        <p>
          取查询按钮时必须加入
          <code>命名空间</code>
          的限制，防止出现重名按钮，导入出错。
        </p>
      </div>
    </div>
  </div>
  <h2 id="queryfullexam" class="page-header">完整示例</h2>
  <div class="bs-example">
    <!-- 导航条  -->
    <ol class="breadcrumb">
      <li class="active">首页</li>
      <li class="active">权限管理</li>
      <li><a href="#">用户查询</a></li>
      <span class="pull-right"> <a data-toggle="collapse" href="#goUserQueryClps">收缩</a>
      </span>
    </ol>
    <!-- 提示信息区  -->
    <div id="message"></div>
    <div id="goUserQueryClps" class="panel-collapse collapse in">
      <form id="form1" class="form-horizontal">
        <div class="row">
          <div class="col-md-4">
            <div class="form-group">
              <label for="user_no" class="col-md-5 control-label">登录帐号</label>
              <div class="col-xs-12 col-md-7">
                <input type="text" class="form-control" id="user_no" name="user_no" placeholder="登录帐号" />
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <label for="user_name" class="col-md-5 control-label">用户名称</label>
              <div class="col-xs-12 col-md-7">
                <input type="text" class="form-control" id="user_name" name="user_name" placeholder="用户名称" />
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <label for="state" class="col-md-5 control-label">状态</label>
              <div class="col-xs-12 col-md-7">
                <select class="form-control" id="state" name="state">
                  <option value=""></option>
                  <option value="1">有效</option>
                  <option value="0">无效</option>
                </select>
              </div>
            </div>
          </div>
        </div>
        <div class="row text-center">
          <button name="doUserQuery.do" type="button" class="btn btn-primary btn-sm" data-ns="goUserQuery">查询</button>
          <button type="button" data-ns="goUserQuery" class="btn btn-link">
            <span class="fa fa-rotate-left"></span>
          </button>
        </div>
      </form>
    </div>
    <button name="goUserAdd.do" data-ns="goUserQuery" type="button" class="btn btn-primary btn-sm">
      <span class="fa fa-plus fa-lg"></span> <font>用户</font>
    </button>
    <button name="doUserDel.do" data-ns="goUserQuery" type="button" class="btn btn-link btn-sm">
      <span class="fa fa-times fa-lg"></span> <font>用户</font>
    </button>
    <div class="table-responsive">
      <table id="grid" class="table table-striped table-bordered table-hover table-condensed dataTable">
        <thead>
          <tr>
            <th axis="button" class="td_center">
              <button name="goUserMdf.do" type="button" class="btn btn-link btn-sm" style="display: none">
                <span class="fa fa-pencil fa-lg"></span>
              </button>
            </th>
            <th axis="checkbox" class="td_center"><input onclick="checkAll(this)" type="checkbox" name="box" /></th>
            <th abbr="rn" class="td_center visible-lg">#</th>
            <th abbr="user_no">登录帐号</th>
            <th abbr="employee_no">员工工号</th>
            <th abbr="user_name">用户姓名</th>
            <th abbr="oper_auth" class="visible-lg">数据权限</th>
            <th abbr="oper_role" class="visible-lg">用户角色</th>
            <th abbr="state" class="visible-lg">用户状态</th>
            <th abbr="user_no" axis="hidden" class="hidden" />
          </tr>
        </thead>
      </table>
    </div>
    <div class="page-header">
      <h5>
        <small>温馨提示</small>
      </h5>
    </div>
    <div class="row">
      <ol>
        <li>分页会重新查询服务器，在点分页前修改了查询条件，会按新的查询条件查询。</li>
      </ol>
    </div>
    <!-- 查询条件暂存区 -->
    <div id="queryTerms" class="hidden"></div>
    <ul class="nav nav-tabs" role="tablist">
      <li class="active"><a href="#html" role="tab" data-toggle="tab">HTML</a></li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active">
        <pre class="brush: js; html-script: true">
&lt;!-- 导航条  -->
&lt;ol class="breadcrumb">
  &lt;li class="active">首页&lt;/li>
  &lt;li class="active">权限管理&lt;/li>
  &lt;li>&lt;a href="#">用户查询&lt;/a>&lt;/li>
  &lt;span class="pull-right"> 
    &lt;a data-toggle="collapse" href="#goUserQueryClps">收缩&lt;/a>
  &lt;/span>
&lt;/ol>
&lt;!-- 提示信息区  -->
&lt;div id="message">&lt;/div>
&lt;!-- 查询条件区  -->
&lt;div id="goUserQueryClps" class="panel-collapse collapse in">
  &lt;form id="form1" class="form-horizontal">
    &lt;div class="row">
      &lt;div class="col-md-4">
        &lt;div class="form-group">
          &lt;label for="user_no" class="col-md-5 control-label">登录帐号&lt;/label>
          &lt;div class="col-xs-12 col-md-7">
            &lt;input type="text" class="form-control" id="user_no" name="user_no" placeholder="登录帐号" />
          &lt;/div>
        &lt;/div>
      &lt;/div>
      &lt;div class="col-md-4">
        &lt;div class="form-group">
          &lt;label for="user_name" class="col-md-5 control-label">用户名称&lt;/label>
          &lt;div class="col-xs-12 col-md-7">
            &lt;input type="text" class="form-control" id="user_name" name="user_name" placeholder="用户名称" />
          &lt;/div>
        &lt;/div>
      &lt;/div>
      &lt;div class="col-md-4">
        &lt;div class="form-group">
          &lt;label for="state" class="col-md-5 control-label">状态&lt;/label>
          &lt;div class="col-xs-12 col-md-7">
            &lt;select class="form-control" id="state" name="state">
              &lt;option value="">&lt;/option>
              &lt;option value="1">有效&lt;/option>
              &lt;option value="0">无效&lt;/option>
            &lt;/select>
          &lt;/div>
        &lt;/div>
      &lt;/div>
    &lt;/div>
    &lt;div class="row text-center">
      &lt;button name="doUserQuery.do" onclick="query(this)" type="button" class="btn btn-primary btn-sm" data-ns="goUserQuery">查询&lt;/button>
      &lt;button type="button" data-ns="goUserQuery" onclick="resetForm(this)" class="btn btn-link">
        &lt;span class="fa fa-rotate-left">&lt;/span>
      &lt;/button>
    &lt;/div>
  &lt;/form>
&lt;/div>
&lt;!-- 查询结果区  -->
&lt;button name="goUserAdd.do" onclick="addInit(this)" data-ns="goUserQuery" type="button" class="btn btn-primary btn-sm">
  &lt;span class="fa fa-plus fa-lg">&lt;/span> &lt;font>用户&lt;/font>
&lt;/button>
&lt;button name="doUserDel.do" onclick="rowSubmit(this)" data-ns="goUserQuery" type="button" class="btn btn-link btn-sm">
  &lt;span class="fa fa-times fa-lg">&lt;/span> &lt;font>用户&lt;/font>
&lt;/button>
&lt;div class="table-responsive">
  &lt;table id="grid" class="table table-striped table-bordered table-hover table-condensed dataTable">
    &lt;thead>
      &lt;tr>
        &lt;th axis="button" class="td_center">
          &lt;button name="goUserMdf.do" type="button" class="btn btn-link btn-sm" style="display: none">
            &lt;span class="fa fa-pencil fa-lg">&lt;/span>
          &lt;/button>
        &lt;/th>
        &lt;th axis="checkbox" class="td_center">&lt;input onclick="checkAll(this)" type="checkbox" name="box" />&lt;/th>
        &lt;th abbr="rn" class="td_center visible-lg">#&lt;/th>
        &lt;th abbr="user_no">登录帐号&lt;/th>
        &lt;th abbr="employee_no">员工工号&lt;/th>
        &lt;th abbr="user_name">用户姓名&lt;/th>
        &lt;th abbr="oper_auth" class="visible-lg">数据权限&lt;/th>
        &lt;th abbr="oper_role" class="visible-lg">用户角色&lt;/th>
        &lt;th abbr="state" class="visible-lg">用户状态&lt;/th>
        &lt;th abbr="user_no" axis="hidden" class="hidden" />
      &lt;/tr>
    &lt;/thead>
  &lt;/table>
&lt;/div>
&lt;div class="page-header">
  &lt;h5>&lt;small>温馨提示&lt;/small>&lt;/h5>
&lt;/div>
&lt;div class="row">
  &lt;ol>
    &lt;li>分页会重新查询服务器，在点分页前修改了查询条件，会按新的查询条件查询。&lt;/li>
  &lt;/ol>
&lt;/div>
&lt;!-- 查询条件暂存区 -->
&lt;div id="queryTerms" class="hidden">&lt;/div>
&lt;script type="text/javascript">
  $(function(){
     goBackQuery(&#36("#goUserQuery button[name='doUserQuery.do']")[0], &#36{json});
  });
&lt;/script>
         </pre>
      </div>
    </div>
  </div>
</body>
</html>