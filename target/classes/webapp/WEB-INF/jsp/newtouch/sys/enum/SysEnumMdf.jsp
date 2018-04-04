<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改字典</title>
</head>
<body>
  <div id="ekKROwCi">
    <!-- 提示信息区  -->
    <div id="message"></div>
    <!-- 操作区  -->
    <form id="form1" class="form-horizontal">
      <div class="form-group">
        <label for="up_enum_name" class="col-sm-2 control-label">
          <span class="not-null">*</span>上级名称
        </label>
        <div class="col-sm-10 has-feedback">
          <input type="text" class="form-control" id="up_enum_name" name="up_enum_name" disabled="disabled" data-notrst="true" />
          <input type="hidden" id="up_enum" name="up_enum" data-notrst="true" />
        </div>
      </div>
      <!--新增父节点和子节点是一样的，所以引用一个公用的 -->
      <jsp:include page="PubField.jsp" />
      <div class="row text-center">
        <button type="button" name="doSysEnumMdf.do" onclick="mdf(this)" data-ns="ekKROwCi" data-cbsuc="initTree_enum"
          class="btn btn-primary btn-sm">
          <span class="fa fa-save fa-lg"></span> <font>保存</font>
        </button>
        <button type="button" name="doSysEnumDel.do" onclick="add(this)" data-ns="ekKROwCi" data-notchk="true"
          data-cbsuc="initTree_enum,initConsole_enum" class="btn btn-link">
          <span class="fa fa-rotate-left"></span><font>删除</font>
        </button>
        <button type="button" onclick="resetForm(this)" class="btn btn-link">
          <span class="fa fa-rotate-left"></span>
        </button>
      </div>
    </form>
    <!-- 温馨提示区  -->
    <div class="page-header">
      <h5>
        <small>温馨提示</small>
      </h5>
    </div>
    <div class="row">
      <ol>
        <li>字典编码：生成常量时使用，永远不会发生变化，终生唯一。</li>
        <li>字典值：具体功能使用时，存储到数据库中的值。</li>
      </ol>
    </div>
    <div id="queryTerms" class="hidden"></div>
  </div>
  <script type="text/javascript">
  $(function(){
	_nsObject().find("#ekKROwCi #enum_no").prop("disabled", true);
    fillPage(${json}, "ekKROwCi");
  });
  </script>
</body>