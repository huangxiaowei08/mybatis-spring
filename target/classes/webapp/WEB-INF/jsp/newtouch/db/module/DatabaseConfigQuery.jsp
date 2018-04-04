<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/jspTag" prefix="n"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据库配置查询</title>
</head>
<body>
  <ol class="breadcrumb">
    <li><a href="#">首页</a></li>
    <li><a href="#">设计器</a></li>
    <li class="active">数据库配置查询</li>
    <span class="pull-right"> <a data-toggle="collapse" data-toggle="collapse" href="dodataBaseQuery"> 查询条件</a>
    </span>
  </ol>
  <!-- 提示信息区  -->
  <div id="message"></div>
  <!-- 操作区  -->
  <div id="dodataBaseQuery" class="panel-collapse collapse in">
    <form id="form1" class="form-horizontal">
      <div class="row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="datacode" class="col-md-3 control-label">数据库编码</label>
            <div class="col-xs-12 col-md-8">
              <input type="text" class="form-control" id="database_no" name="database_no" placeholder="数据库编码" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="dataname" class="col-md-3 control-label">数据库名称</label>
            <div class="col-xs-12 col-md-8">
              <input type="text" class="form-control" id="database_name" name="database_name" placeholder="数据库名称" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="ui_input_select" class="col-md-3 control-label">数据库类型</label>
            <div class="col-xs-12 col-md-9">
              <n:select id="database_type" up_no="database_type" value="database_type" />
            </div>
          </div>
        </div>
      </div>
      <br>
      <div class="row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="conn_type" class="col-md-3 control-label">连接方式</label>
            <div class="col-xs-12 col-md-8">
              <n:select id="connect_type" up_no="connect_type" value="connect_type" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="question_title" class="col-md-3 control-label">用户名</label>
            <div class="col-xs-12 col-md-8">
              <input type="text" class="form-control" id="db_user" name="db_user" placeholder="数据库用户名" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="datadriver" class="col-md-3 control-label">数据库驱动</label>
            <div class="col-xs-12 col-md-8">
              <input type="text" class="form-control" id="driver_class" name="driver_class" placeholder="数据库驱动" />
            </div>
          </div>
        </div>
        <div class="row text-center">
          <span>
            <button name="dodataBaseQuery.do" onclick="query(this)" type="button" class="btn btn-primary btn-sm">查询</button>
          </span> <span>
            <button type="button" onclick="resetForm(this)" class="btn btn-link btn-sm">重置</button>
          </span>
        </div>
      </div>
    </form>
  </div>

  <br>
  <!-- --------------------------------------------------------------------查询结果展示-------------------------------------------------------------------------------- -->
  <button name="godataConfigAdd.do" type="button" class="btn btn-primary btn-sm" data-ns="resl" onclick="addInit(this)">
    <span class="fa fa-plus fa-lg"></span> <font>新增</font>
  </button>
  <button name="dodataConfigDel.do" onclick="rowSubmit(this)" type="button" class="btn btn-link btn-sm">
    <span class="fa fa-times fa-lg"></span> <font>删除</font>
  </button>
  <div>
    <table id="grid" class="table table-striped table-bordered table-hover table-condensed dataTable">
      <thead>
        <tr>
          <th axis="checkbox" class="td_center"><input onclick="checkAll(this)" type="checkbox" name="box" /></th>
          <th abbr="rn" class="td_center visible-lg">序号</th>
          <th abbr="database_no" data-len="10">数据库编码</th>
          <th abbr="database_name">数据库名称</th>
          <th abbr="database_type_name">数据库类型</th>
          <th abbr="connect_type_name">连接方式</th>
          <th abbr="driver_class">数据库驱动</th>
          <th abbr="url">数据库地址</th>
          <th abbr="db_user">数据库用户名</th>
          <th class="td_center" axis="button">
            <button name="goModifydataconfig.do" onclick="" type="button" class="btn btn-link btn-sm" style="display: none">修改</button> <span>&nbsp;</span>
            <span>&nbsp;</span>操作
          </th>
          <th abbr="serno" axis="hidden" class="hidden" />
          <th abbr="database_no" axis="hidden" class="hidden" />
        </tr>
      </thead>
    </table>
  </div>
  <!-- 查询条件暂存区 -->
  <div id="queryTerms" class="hidden"></div>
  <script type="text/javascript">
  $(function(){
     goBackQuery($("#dodataBaseQuery button[name='dodataBaseQuery.do']")[0], ${json});
     fillPage(${json});
  });
</script>
</body>
</html>