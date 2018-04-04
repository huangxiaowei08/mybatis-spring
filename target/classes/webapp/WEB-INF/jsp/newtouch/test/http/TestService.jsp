<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.error {
	background: #FBE3E4;
	color: #D12F19;
	border-color: #FBC2C4;
}

.success {
	background: green;
	color: white;
	border-color: #FBC2C4;
}
</style>
</head>
<body>
  <form id="form1" class="form-horizontal" style="margin-top: 12px;">
    <div class="form-group">
      <div class="row">
        <label for="path" class="col-sm-2 control-label">
          <span class="not-null">*</span>请求路径
        </label>
        <div class="col-sm-7 has-feedback">
          <input type="text" class="form-control" id="requestPath" name="requestPath" placeholder="请求路径">
        </div>
        <button type="button" class="btn btn-primary" onclick="doRequest(this)">提 交</button>
      </div>
    </div>

    <div class="form-group">
      <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-4">
          <textarea class="form-control" rows="25" id="request_json" name="request_json" placeholder="请求JSON"></textarea>
        </div>
        <div class="col-md-4">
          <textarea class="form-control" rows="25" id="return_json" name="return_json" placeholder="返回JSON" readonly="readonly"></textarea>
        </div>
        <div class="col-md-2"></div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-4">
          <pre id="request_json_results" style="display: none;"></pre>
        </div>
        <div class="col-md-4">
          <pre id="return_json_results" style="display: none;"></pre>
        </div>
        <div class="col-md-2"></div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-4">
          <button type="button" name="validate" id="validate" class="btn btn-primary" onclick="validateJson('request_json')">格式化</button>
        </div>
        <div class="col-md-4">
        </div>
        <div class="col-md-2"></div>
      </div>
    </div>
  </form>
</body>
<script type="text/javascript">
	<jsp:include page="./js/inone.js" />
	function doRequest(btn) {
		var requestPath = _nsObject().find("#requestPath").val();
		if (!validateJson('request_json')) {
			return;
		}
		var request_json = _nsObject().find("#request_json").val();
		var jsonData = str2json(request_json);
		jsonData.rqstType = "AJAX";
		$.ajax({
			type : "POST",
			url : requestPath,
			data : jsonData,
			dataType : "json",
			success : function(data) {
				if (data.flag == "success") {// 保存成功
					_nsObject().find("#return_json").val(JSON.stringify(data));
					validateJson('return_json');
					return;
				}
				alertMsg4Modal(data, _nsObject());// 提示失效信息
				_nsObject().find("#return_json").val(JSON.stringify(data));
				validateJson('return_json');
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				updateTips("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = "
						+ errorThrown);
				btn.disabled = false;
			}
		});
	}
</script>
</html>