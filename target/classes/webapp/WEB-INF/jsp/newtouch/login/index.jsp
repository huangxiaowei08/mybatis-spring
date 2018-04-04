<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@taglib uri="/jspTag" prefix="n"%>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 让IE不使用兼容模式 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 让国产浏览器使用高速模式 -->
<meta name="renderer" content="webkit">
<title>人保寿一站式移动平台</title>

<%
	String path = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/bootstrap/css/bootstrap.css" />

<link rel="stylesheet" type="text/css" href="<%=path%>/compent/ztree/zTreeStyle.css" type="text/css">

<link rel="stylesheet" type="text/css" href="<%=path%>/compent/datatables/css/dataTables.bootstrap.css" />
<%-- <link rel="stylesheet" type="text/css" href="<%=path%>/compent/datatables/css/dataTables.bootstrap-theme.css" /> --%>
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/bootstrap-table/css/bootstrap-table.css" />

<link rel="stylesheet" type="text/css" href="<%=path%>/compent/menu/css/com.newtouch.menu.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/datepicker/skin/WdatePicker.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/fontawesome/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/bootstrap/css/other.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/webuploader/0.1.5/webuploader.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/context/context.standalone.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/context/context.bootstrap.css" />
<style type="text/css">
body {
	padding-top: 70px;
}
</style>
<body>
  <div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="sr-only"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
        </button>
        <div class="navbar-brand dropdown">
          <a href="#" id="menu-toggler" class="dropdown-toggle" data-toggle="dropdown"> PICC <b class="caret"></b>
          </a>
        </div>
        <!-- ↓↓↓变小时显示↓↓↓ -->
        <div class="navbar-brand visible-xs pull-right">
          <li class="dropdown" style="list-style-type: none; font-size: 14px"><a href="#" class="dropdown-toggle"
            data-toggle="dropdown" style="color: #777"> 消息 <b class="caret"></b>
          </a>
            <ul class="dropdown-menu">
              <li><a href="#" onclick="createTable('查询页面', 'goQueryPage.do')">查询页面</a></li>
              <li><a href="#" onclick="createTable('用户管理', 'goUserMgmtQueryPage.do')">用户管理</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
              <li class="divider"></li>
              <li><a href="#">One more separated link</a></li>
            </ul></li>
        </div>
        <!-- ↑↑↑变小时显示↑↑↑ -->
      </div>
      <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav" id="index_Tab_List">
          <li class="active"><a href="#home" data-toggle='tab'>首页</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li class="dropdown visible-sm visible-md visible-lg"><a href="#" class="dropdown-toggle" data-toggle="dropdown"> 消息 <b
              class="caret"></b>
          </a>
            <ul class="dropdown-menu">
              <li><a href="#" onclick="createTable('查询页面', 'goQueryPage.do')">查询页面</a></li>
              <li><a href="#" onclick="createTable('用户管理', 'goUserMgmtQueryPage.do')">用户管理</a></li>
              <li><a href="#">Something else here</a></li>
              <li class="divider"></li>
              <li><a href="#">Separated link</a></li>
              <li class="divider"></li>
              <li><a href="#">One more separated link</a></li>
            </ul></li>
          <li><a href="#">退出</a></li>
        </ul>
      </div>
    </div>
  </div>
  <div id="sidebar_p" style="width: 500px; height: 600px; position: fixed; z-index: 99999999; display: none">
    <div style="width: 43px; z-index: 9999">
      <div class="sidebar menu-min" id="sidebar">
        <div class="sidebar-shortcuts" id="sidebar-shortcuts">
          <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
            <button class="btn btn-success">
              <i class="fa fa-signal"></i>
            </button>
            <button class="btn btn-info">
              <i class="fa fa-pencil"></i>
            </button>
            <button class="btn btn-warning">
              <i class="fa fa-group"></i>
            </button>
            <button class="btn btn-danger">
              <i class="fa fa-cogs"></i>
            </button>
          </div>

          <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
            <span class="btn btn-success"></span> <span class="btn btn-info"></span> <span class="btn btn-warning"></span> <span
              class="btn btn-danger"></span>
          </div>
        </div>
        <!-- #sidebar-shortcuts -->
        <ul class="nav nav-list">
          <%
          	String file = application.getRealPath("/") + "/WEB-INF/jsp/newtouch/login/";
          	File file1 = new File(file);
          	String[] fileNames = file1.list();
          	File[] fileObjects = file1.listFiles();
          	for (int i = 0; i < fileObjects.length; i++) {
          		if (!fileObjects[i].isDirectory() && !"index.jsp".equals(fileNames[i])) {
          %>
          <jsp:include page="<%=fileNames[i]%>" />
          <%
          	}
          	}
          %>
          <li><a href="#" class="dropdown-toggle"> <i class="fa fa-list"></i> <span class="menu-text"> 表格 </span> <b
              class="arrow fa fa-angle-down"></b>
          </a>
            <ul class="submenu">
              <li><a href="#" onclick="createTable('文件上传', 'goFileUploader.do')"> <i class="fa-angle-double-right fa"></i> 文件上传
              </a></li>
              <li><a href="#" onclick="createTable('文件上传Demo', 'goFileUploaderDemo.do')"> <i class="fa-angle-double-right fa"></i>
                  其他页面调用
              </a></li>
            </ul></li>
        </ul>
        <!-- /.nav-list -->
        <div class="sidebar-collapse" id="sidebar-collapse" onclick="sidebar_collapsed()" style="z-index: 9999">
          <i class="fa-angle-double-right fa" data-icon1="fa-angle-double-left fa" data-icon2="fa-angle-double-right fa"></i>
        </div>
      </div>
    </div>
    <div id="sidebar_hidden" style="width: 500px; height: 600px; position: fixed; display: none">&nbsp</div>
  </div>

  <div class="container-fluid">
    <div class="tab-content" id="index_Content_List">
      <div class="tab-pane active" id="home">home</div>
    </div>
  </div>
</body>
<script type="text/javascript" src="<%=path%>/compent/jquery/jquery-1.10.2.min.js"></script>


<script type="text/javascript" src="<%=path%>/compent/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="<%=path%>/compent/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="<%=path%>/compent/ztree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="<%=path%>/compent/ztree/jquery.ztree.exedit-3.5.js"></script>

<script type="text/javascript" src="<%=path%>/compent/datatables/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="<%=path%>/compent/datatables/js/dataTables.bootstrap.js"></script>
<script type="text/javascript" src="<%=path%>/compent/bootstrap-table/js/bootstrap-table.js"></script>

<script type="text/javascript" src="<%=path%>/compent/core/com.newtouch.core.js"></script>
<script type="text/javascript" src="<%=path%>/compent/core/com.newtouch.util.js"></script>
<script type="text/javascript" src="<%=path%>/compent/ajax/com.newtouch.ajax.js"></script>
<script type="text/javascript" src="<%=path%>/compent/msg/com.newtouch.message.js"></script>
<script type="text/javascript" src="<%=path%>/compent/grid/com.newtouch.grid.js"></script>
<script type="text/javascript" src="<%=path%>/compent/menu/js/com.newtouch.menu.js"></script>
<script type="text/javascript" src="<%=path%>/compent/core/com.newtouch.tree.js"></script>

<script type="text/javascript" src="<%=path%>/compent/validation/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/compent/validation/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=path%>/compent/validation/localization/messages_zh.js"></script>

<script type="text/javascript" src="<%=path%>/compent/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/compent/spin/spin.js"></script>
<script type="text/javascript" src="<%=path%>/compent/context/context.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
</html>