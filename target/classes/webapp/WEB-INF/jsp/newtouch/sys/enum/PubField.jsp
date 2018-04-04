<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
  <div class="form-group">
    <label for="enum_no" class="col-sm-2 control-label">
      <span class="not-null">*</span>字典编码
    </label>
    <div class="col-sm-10 has-feedback">
      <input type="text" class="form-control" id="enum_no" name="enum_no" placeholder="字典编码">
    </div>
  </div>
  <div class="form-group">
    <label for="enum_name" class="col-sm-2 control-label">
      <span class="not-null">*</span>字典名称
    </label>
    <div class="col-sm-10 has-feedback">
      <input type="text" class="form-control" id="enum_name" name="enum_name" placeholder="字典名称">
    </div>
  </div>
  <div class="form-group">
    <label for="enum_code" class="col-sm-2 control-label">
      <span class="not-null">*</span>字典值
    </label>
    <div class="col-sm-10 has-feedback">
      <input type="text" class="form-control" id="enum_code" name="enum_code" placeholder="字典值">
    </div>
  </div>
  <div class="form-group">
    <label for="enum_order" class="col-sm-2 control-label">
      <span class="not-null">*</span>显示顺序
    </label>
    <div class="col-sm-10 has-feedback">
      <input type="text" class="form-control" id="enum_order" name="enum_order" placeholder="显示顺序">
    </div>
  </div>
  <div class="form-group">
    <label for="enum_type" class="col-sm-2 control-label">
      <span class="not-null">*</span>部门类型
    </label>
    <div class="col-sm-10">
      <select class="form-control" id="enum_type" name="enum_type">
        <option value="00">公用</option>
      </select>
    </div>
  </div>
  <div class="form-group">
    <label for="memo" class="col-sm-2 control-label"> 备注</label>
    <div class="col-sm-10 has-feedback">
      <textarea rows="4" cols="100%" class="form-control" id="memo" name="memo" placeholder="备注"></textarea>
    </div>
  </div>
</body>
<script type="text/javascript">
	$(function() {
		_nsObject().find("#ekKROwCi form[id='form1']").validate({
			rules : {
				enum_no : {
					required : true,
					rangelength : [ 1, 32 ]
				},
				enum_name : {
					required : true,
					rangelength : [ 1, 64 ]
				},
				enum_code : {
					required : true,
					rangelength : [ 1, 32 ]
				},
				enum_order : {
					required : true,
					digits : true,
					min : 0
				}
			}
		});
	});
</script>
</html>