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
    <li class="active">系统启动执行查询</li>
    <span class="pull-right"> <a data-toggle="collapse" data-toggle="collapse" href="#doInformationQuery"> 查询条件</a>
    </span>
  </ol>
  <!-- 提示信息区  -->
  <div id="message"></div>
  <!-- 操作区  -->
  <div id="doInformationQuery" class="panel-collapse collapse in">
    <form id="form1" class="form-horizontal">
      <div class="row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="startcode" class="col-md-3 control-label">启动编码</label>
            <div class="col-xs-12 col-md-8">
              <input type="text" class="form-control" id="startup_no" name="startup_no" placeholder="启动编码" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="classdescript" class="col-md-3 control-label">类说明</label>
            <div class="col-xs-12 col-md-8">
              <input type="text" class="form-control" id="class_memo" name="class_memo" placeholder="类说明" />
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="form-group">
            <label for="classname" class="col-md-3 control-label">类名</label>
            <div class="col-xs-12 col-md-9">
              <input type="text" class="form-control" id="class_name" name="class_name" placeholder="类名" />
            </div>
          </div>
        </div>
        <div class="row text-center">
          <span>
            <button name="doSysStartQuery.do" onclick="query(this)" type="button" class="btn btn-primary btn-sm">查询</button>
          </span> <span>
            <button type="button" onclick="resetForm(this)" class="btn btn-link btn-sm">重置</button>
          </span>
        </div>
      </div>
      <br>
    </form>
  </div>
  <br>
  <!-- --------------------------------------------------------------------查询结果展示-------------------------------------------------------------------------------- -->
  <button name="goSysStartConfigAdd.do" type="button" class="btn btn-primary btn-sm" data-ns="resl" onclick="addInit(this)">
    <span class="fa fa-plus fa-lg"></span> <font>新增</font>
  </button>
  <button name="doSysStartConfigDel.do" onclick="rowSubmit(this)" type="button" class="btn btn-link btn-sm">
    <span class="fa fa-times fa-lg"></span> <font>删除</font>
  </button>
  <div>
    <table id="grid" class="table table-striped table-bordered table-hover table-condensed dataTable">
      <thead>
        <tr>
          <th axis="checkbox" class="td_center"><input onclick="checkAll(this)" type="checkbox" name="box" /></th>
          <th abbr="rn" class="td_center visible-lg">序号</th>
          <th abbr="startup_no" data-len="10">启动编码</th>
          <th abbr="class_memo">类说明</th>
          <th abbr="class_name">类名</th>
          <th class="td_center" axis="button">
            <button name="goModifySysConfig.do" onclick="" type="button" class="btn btn-link btn-sm" style="display: none">修改</button> <span>&nbsp;</span>
            <span>&nbsp;</span>操作
          </th>
          <th abbr="serno" axis="hidden" class="hidden" />
          <th abbr="startup_no" axis="hidden" class="hidden" />
        </tr>
      </thead>
    </table>
  </div>
  <!-- 查询条件暂存区 -->
  <div id="queryTerms" class="hidden"></div>
  <script type="text/javascript">
   $(function(){
     goBackQuery($("#doInformationQuery button[name='doSysStartQuery.do']")[0], ${json});
     fillPage(${json});
  }); 
</script>
</body>
</html>