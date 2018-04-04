<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>常量生成</title>
</head>
<body>
  <!-- 提示信息区  -->
  <div id="message"></div>
  <!-- 操作区  -->
  <form id="form1" class="form-horizontal">
    <div class="form-group">
      <label for="package" class="col-sm-2 control-label"><span class="not-null">*</span>包路径</label>
      <div class="col-sm-10 has-feedback">
        <input type="text" class="form-control" id="package" name="package" placeholder="包路径" aria-describedby="package_help" />
        <span id="package_help" class="help-block">例如：com.newtouch。</span>
      </div>
    </div>
    <div class="form-group">
      <label for="class_name" class="col-sm-2 control-label"><span class="not-null">*</span>类名</label>
      <div class="col-sm-10 has-feedback">
        <input type="text" class="form-control" id="class_name" name="class_name" placeholder="类名" />
      </div>
    </div>
    <div class="form-group">
      <label for="file_path" class="col-sm-2 control-label"><span class="not-null">*</span>文件路径</label>
      <div class="col-sm-10 has-feedback">
        <input type="text" class="form-control" id="file_path" name="file_path" placeholder="文件路径" aria-describedby="file_path_help" />
        <span id="file_path_help" class="help-block">项目的根路径，路径中文件夹以/分隔，文件路径和包路径一起组成类文件的存储目录。</span>
      </div>
    </div>
    <div class="row text-center">
      <button type="button" name="doSysConst.do" onclick="add(this)" class="btn btn-primary btn-sm">
        <span class="fa fa-save fa-lg"></span>
        <font>保存</font>
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
  <script type="text/javascript">
  $(function(){
    fillPage(${json}, "goSysEnumQuery");
  });
  </script>
</body>
</html>