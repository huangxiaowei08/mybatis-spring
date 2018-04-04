<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/jspTag" prefix="n"%>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 让IE不使用兼容模式 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 让国产浏览器使用高速模式 -->
<meta name="renderer" content="webkit">
<title>开发手册</title>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "";
%>
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/bootstrap/css/bootstrap.css" />

<link rel="stylesheet" type="text/css" href="<%=path%>/compent/ztree/zTreeStyle.css" type="text/css">

<link rel="stylesheet" type="text/css" href="<%=path%>/compent/datatables/css/dataTables.bootstrap.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/datatables/css/dataTables.bootstrap-theme.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/bootstrap-table/css/bootstrap-table.css" />

<link rel="stylesheet" type="text/css" href="<%=path%>/compent/menu/css/com.newtouch.menu.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/datepicker/skin/WdatePicker.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/fontawesome/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/bootstrap/css/other.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/bootstrap/css/doc.min.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/compent/syntaxhighlighter/css/shCoreDefault.css" />

</head>
<body>
  <div class="container bs-docs-container">
    <div class="row">
      <div class="col-md-2" role="complementary">
        <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm">
        <ul id="affix" class="nav bs-docs-sidenav">
          <li><a href="#queryPage">查询页面</a>
            <ul class="nav">
              <li><a href="#navigationbar">导航条</a></li>
              <li><a href="#message">提示信息区</a></li>
              <li><a href="#querycondition">查询条件区</a></li>
              <li><a href="#QueryResults">查询结果区</a></li>
              <li><a href="#reminder">温馨提示区</a></li>
              <li><a href="#queryconditioncache">查询条件暂存区</a></li>
              <li><a href="#queryloadjs">页面加载JS</a></li>
              <li><a href="#queryfullexam">完整示例</a></li>
              
            </ul></li>
          <li><a href="#DetailsPage">明细页面</a>
            <ul class="nav">
              <li><a href="#Detailsnavigationbar">导航条</a></li>
              <li><a href="#Detailsmessage">提示信息区</a></li>
              <li><a href="#DetailsColumns">操作区(多列多行)</a></li>
              <li><a href="#DetailsColumn">操作区(一列多行)</a></li>
              <li><a href="#Detailsreminder">温馨提示区</a></li>
              <li><a href="#Detailsqueryconditioncache">查询条件暂存区</a></li>
              <li><a href="#Detailsqueryloadjs">页面加载JS</a></li>
            </ul></li>
          <li><a href="#ui_form">表单</a>
            <ul class="nav">
              <li><a href="#ui_from_input">文本框</a></li>
              <li><a href="#ui_from_date">日期</a></li>
              <li><a href="#ui_from_select">下拉列表</a></li>
              <li><a href="#ui_from_button">按钮</a></li>
              <li><a href="#ui_from_validate">验证</a></li>
            </ul></li>
          <li><a href="#ui_table">表格</a>
            <ul class="nav">
              <li><a href="#ui_tab_text">文本</a></li>
              <li><a href="#ui_tab_checkbox">复选框</a></li>
              <li><a href="#ui_tab_button">按钮</a></li>
              <li><a href="#ui_tab_but_grp">按钮组</a></li>
              <li><a href="#ui_tab_select">下拉列表</a></li>
              <li><a href="#ui_tab_date">日期格式化</a></li>
              <li><a href="#ui_tab_custom">自定义函数</a></li>
              <li><a href="#ui_tab_hidden">隐藏域</a></li>
              <li><a href="#ui_tab_elps">省略</a></li>
              <li><a href="#ui_tab_href">超连接</a></li>
            </ul></li>
          <li><a href="#js-overview1">概览</a>
            <ul class="nav">
              <li class="active"><a href="#js-individual-compiled">单个还是全部引入</a></li>
              <li><a href="#js-data-attrs">data 属性</a></li>
              <li><a href="#js-programmatic-api">编程方式的 API</a></li>
              <li><a href="#js-noconflict">避免命名空间冲突</a></li>
              <li><a href="#js-events">事件</a></li>
              <li><a href="#js-disabled">浏览器的 JavaScript 被禁用的情况</a></li>
              <li><a href="#callout-third-party-libs">第三方工具库</a></li>
            </ul></li>
        </ul>
        </nav>
      </div>
      <div class="col-md-10" role="main">
        <!-- 布局 -->
        <%@ include file="/WEB-INF/jsp/newtouch/doc/layout/QueryPage.jsp"%>
        <%@ include file="/WEB-INF/jsp/newtouch/doc/layout/DetailsPage.jsp"%>
        <%@ include file="/WEB-INF/jsp/newtouch/doc/ui/Form.jsp"%>
      </div>
    </div>

  </div>

</body>
<script type="text/javascript" src="<%=path%>/compent/jquery/jquery-1.11.3.min.js"></script>

<script type="text/javascript" src="<%=path%>/compent/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path%>/compent/bootstrap/js/doc.min.js"></script>

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

<script type="text/javascript" src="<%=path%>/compent/validation/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/compent/validation/localization/messages_zh.js"></script>

<script type="text/javascript" src="<%=path%>/compent/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=path%>/compent/spin/spin.js"></script>

<script type="text/javascript" src="<%=path%>/compent/syntaxhighlighter/js/shCore.js"></script>
<script type="text/javascript" src="<%=path%>/compent/syntaxhighlighter/js/shBrushJScript.js"></script>
<script type="text/javascript" src="<%=path%>/compent/syntaxhighlighter/js/shBrushJava.js"></script>
<script type="text/javascript" src="<%=path%>/compent/syntaxhighlighter/js/shBrushCss.js"></script>
<script type="text/javascript" src="<%=path%>/compent/syntaxhighlighter/js/shBrushXml.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript">
	$(function() {
		$("#affix").affix({
			offset : {
				top : 50
			}
		});
		SyntaxHighlighter.config.bloggerMode = true;
		SyntaxHighlighter.defaults['toolbar'] = false;
		//SyntaxHighlighter.defaults['collapse'] = true;
		SyntaxHighlighter.all();
	});
</script>
</html>