<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/jspTag" prefix="n"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div id="form1" class="form-horizontal">
    <div class="form-group">
      <label for="uploadService" class="col-sm-2 control-label">
        <span class="not-null">*</span>文件上传处理类
      </label>
      <div class="col-sm-10 has-feedback">
        <input type="text" class="form-control" id="uploadService" name="uploadService" value="FileUploaderImp.saveFile">
        <span id="helpBlock" class="help-block">必传，否则会报空指针异常。传类名.方法名，方法入参必须为Map</span>
      </div>
    </div>

    <div class="form-group">
      <label for="downloadService" class="col-sm-2 control-label">
        <span class="not-null">*</span>模板下载处理类
      </label>
      <div class="col-sm-10 has-feedback">
        <input type="text" class="form-control" id="downloadService" name="downloadService" value="BonusCaculateServiceImp.export2excel">
        <span id="helpBlock" class="help-block">可选，有值会显示模板下载按钮，无值则不显示模板下载按钮.</span>
      </div>
    </div>
    <div class="form-group">
      <label for="cbsuc" class="col-sm-2 control-label">
        <span class="not-null">*</span>成功后回调函数
      </label>
      <div class="col-sm-10 has-feedback">
        <input type="text" class="form-control" id="cbsuc" name="cbsuc" value="alertsuc">
        <span id="helpBlock" class="help-block">可选，上传成功后会回调此js函数，入参为btn和data.</span>
      </div>
    </div>
    <div class="form-group">
      <label for="cbfail" class="col-sm-2 control-label">
        <span class="not-null">*</span>失败后回调函数
      </label>
      <div class="col-sm-10 has-feedback">
        <input type="text" class="form-control" id="cbfail" name="cbfail" value="alertfail">
        <span id="helpBlock" class="help-block">可选，上传失败后会回调此js函数，入参为btn和data.</span>
      </div>
    </div>

    <div class="form-group">
      <label for="goBackService" class="col-sm-2 control-label">
        <span class="not-null">*</span>返回方法
      </label>
      <div class="col-sm-10 has-feedback">
        <input type="text" class="form-control" id="goBackService" name="goBackService" value="goFileUploaderDemo.do">
        <span id="helpBlock" class="help-block">可选，使用进入新页面方式时需要传此值，供返回前一页面调用.</span>
      </div>
    </div>

    <div class="form-group">
      <label for="testselect" class="col-sm-2 control-label">
        <span class="not-null">*</span>失败后回调函数
      </label>
      <div class="col-sm-10 has-feedback">
        <n:select id="test" up_no="test" onchange="nLevelLinkage(this, true)" />
      </div>
    </div>
    <button name="goFileUploader.do" onclick="addInit(this)" type="button" class="btn btn-primary btn-sm">
      <span class="fa fa-plus fa-lg"></span> <font>导入(新页面)</font>
    </button>
    <button name="goFileUploaderModal.do" onclick="showModal(this)" type="button" class="btn btn-primary btn-sm">
      <span class="fa fa-plus fa-lg"></span> <font>导入(模态框)</font>
    </button>
    <button name="goFileUploaderModal4Image.do" onclick="showModal(this)" type="button" class="btn btn-primary btn-sm">
      <span class="fa fa-plus fa-lg"></span> <font>选择图片(模态框)</font>
    </button>
  </div>
</body>
<script type="text/javascript">
	function alertsuc(btn, data) {
		alert("alertsuc");
	}

	function alertfail(btn, data) {
		alert("alertfail");
	}
</script>

</html>