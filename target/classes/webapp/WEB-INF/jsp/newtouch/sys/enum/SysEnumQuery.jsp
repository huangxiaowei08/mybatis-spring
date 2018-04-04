<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>枚举值添加</title>
</head>
<body>
  <div class="row">
    <div id="tree" class="col-md-3">
      <div id="tree_opt_area_lh7z1feN" style="height: 600px; overflow: auto;">
        <ul id="tree_enum_config" class="ztree min_height panel panel-default"></ul>
      </div>
    </div>
    <div id="console" class="col-md-9"></div>
  </div>
  <div class="row">
    <form id="form2">
      <div id="tree" class="col-md-3">
        <button type="button" name="doInitEnumData.do" onclick="add4Id(this, 'form2')" class="btn btn-primary btn-sm">
          <font>初始化枚举数据</font>
        </button>
      </div>
    </form>

  </div>
</body>
<script type="text/javascript">
<jsp:include page="./js/SysEnum.js" />
$(function() {
	context.init({preventDoubleContext: false});
	context.settings({
		compress : true
	});
	context.attach("#tree_opt_area_lh7z1feN", [ {
		text : '增加字典',
		action : function() {
			zTree_enum.cancelSelectedNode();
			initConsole_enum("goSysEnumAdd.do");
		}
	}]);
	zTree_enum = $.fn.zTree.init(_nsObject().find("#tree_enum_config"), setting_enum, ${json}.data);
});
</script>
</html>