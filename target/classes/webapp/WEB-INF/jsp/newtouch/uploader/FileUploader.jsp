<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.newtouch.util.string.StrUtil"%>
<%@page import="com.newtouch.util.json.JsonUtil"%>
<%@page import="java.util.Map"%>
<%@page import="com.newtouch.util.uuid.UniqueSeq"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "";
	Map<String, Object> map = JsonUtil.json2Map((String) request.getAttribute("json"));
	String ext_mimeTypes = StrUtil.trimStr(((Map<String, Object>) map.get("defmap")).get("ext_mimeTypes"));
	String ext_title = StrUtil.trimStr(((Map<String, Object>) map.get("defmap")).get("ext_title"));
	String ext_extensions = StrUtil.trimStr(((Map<String, Object>) map.get("defmap")).get("ext_extensions"));
	String goBackService = StrUtil.trimStr(((Map<String, Object>) map.get("defmap")).get("goBackService"));
	String multiple = StrUtil.trimStr(((Map<String, Object>) map.get("defmap")).get("multiple"));
    if(StrUtil.isNull(multiple))
    	multiple = "false";
    String fileNumLimit = StrUtil.trimStr(((Map<String, Object>) map.get("defmap")).get("fileNumLimit"));
    if(StrUtil.isNull(fileNumLimit))
      fileNumLimit = "1";
	String varName = "a_" + UniqueSeq.shortUUID();
	String picker = UniqueSeq.shortUUID();
%>
<script type="text/javascript" src="<%=path%>/compent/webuploader/0.1.5/webuploader.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
  <div id="<%=varName%>">
    <!--用来存放文件信息-->
    <div id="thelist" class="uploader-list"></div>
    <div class="btns">
      <div id="<%=picker%>" class="pull-left">
        <button type="button" class="btn btn-primary btn-sm btn-hit">
          <span class="fa fa-plus fa-lg"></span>文件
        </button>
      </div>
      <div class="pull-left" style="padding-right: 15px;">
        <button id="ctlBtn" class="btn btn-default" onclick="<%=varName%>uploadFile(this)">
          <span class="glyphicon glyphicon-cloud-upload"></span><font>上传文件</font>
        </button>
      </div>
      <div id="downloadBtn" class="pull-left" style="padding-right: 15px;">
        <button class="btn btn-default btn-xs" style="margin-top: 12px;" onclick="<%=varName%>downloadFile(this)">
          <span class="glyphicon glyphicon-cloud-download"></span>模板下载
        </button>
      </div>
      <div class="pull-left">
        <button type="button" name="<%=goBackService %>" onclick="addInit4Id(this, 'uploadFormData')" class="btn btn-link">
          <span class="fa fa-reply"></span>
        </button>
      </div>
    </div>
    <form id="downloadFileForm" method="post" target="_blank">
      <div id="uploadFormData" class="hidden">
        <input type="hidden" id="uploadService" name="uploadService" />
        <input type="hidden" id="downloadService" name="downloadService" />
        <input type="hidden" id="fileType" name="fileType" />
        <input type="hidden" id="goBackService" name="goBackService" />
      </div>
    </form>
  </div>
</body>
<script type="text/javascript">
var <%=varName%>_state = 'pending',<%=varName%>;
$(function(){
	<%=varName%>fillMoreElmt(${json});
	<%=varName%> = WebUploader.create({
		swf : "<%=path%>/compent/webuploader/0.1.5/Uploader.swf", // swf文件路径
		server : 'doFileUploader.do', // 文件接收服务端。
		pick : {
			id : '#<%=picker%>',
			multiple : <%=multiple%>
		},
		fileNumLimit : <%=fileNumLimit%>,//默认一个文件
		resize : false, // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
		accept : {
			title : '<%=ext_title%>',
			extensions : '<%=ext_extensions%>',
			mimeTypes : '<%=ext_mimeTypes%>'
		}
	});
	if(_nsObject().find("#downloadService").val() == "")
		_nsObject().find("#downloadBtn").hide();
});
//当有文件被添加进队列的时候执行
<%=varName%>.on('fileQueued', function(file){
	var $fileList = _nsObject().find("#thelist");
	$fileList.append('<div id="' + file.id + '" class="panel panel-default"><div class="panel-body box-zero"><div class="row"><div class="col-sm-12"><div class="pull-right">'
			+ '<button type="button" class="close" aria-label="Close" onclick="<%=varName%>removeFile(this)"><span aria-hidden="true">&times;</span></button></div><h4>' + file.name
			+ '<small id="progress">等待上传...</small></h4></div></div></div></div>');
});

//文件上传过程中创建进度条实时显示
<%=varName%>.on('uploadProgress', function(file, percentage) {
	var $fileList = _nsObject().find("#thelist");
	var progress = $fileList.find("div[id='" + file.id + "']").find("#progress");
	if (progress.find("div[class='progress']")[0] == undefined) {
		progress.empty();
		progress.append('<div class="progress"><div class="progress-bar progress-bar-info progress-bar-striped active" '
				+ 'aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;" role="progressbar"></div></div>');
	}
	var $percent = progress.find("div[role='progressbar']");
	$percent.attr("style", "width:" + ((percentage * 100) - 1) + "%");
});
//成功之后显示成功信息
<%=varName%>.on('uploadSuccess', function(file, data) {
	var $fileList = _nsObject().find("#thelist");
	var progress = $fileList.find("div[id='" + file.id + "']").find("#progress");
	progress.empty();
	if (data.flag == "success") {// 保存成功
		progress.append('<div class="progress"><div class="progress-bar progress-bar-success progress-bar-striped active" '
				+ 'aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;" role="progressbar"></div></div>');
		progress.fadeOut("slow", function() {
			progress.empty();
			progress.append("<span class='glyphicon glyphicon-ok-circle' aria-hidden='true' style='color:#5cb85c'>上传成功!</span>");
			progress.fadeIn();
		});
		// 成功回调
		if(data.defmap != undefined && data.defmap.cbsuc){
			var btn = $("<button data-cbsuc='"+data.defmap.cbsuc+"'/>");
			callbackSuc(btn, data);
		}
	} else {
		alertMsg4Modal(data, _nsObject());// 提示失效信息
		progress.append('<div class="progress"><div class="progress-bar progress-bar-danger progress-bar-striped active" '
				+ 'aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;" role="progressbar"></div></div>');
		progress.fadeOut("slow", function() {
			progress.empty();
			progress.append("<span class='glyphicon glyphicon-remove' aria-hidden='true' style='color:#d9534f'>上传失败!</span>");
			progress.fadeIn();
		});
		// 失败回调
		if(data.defmap != undefined && data.defmap.cbfail){
			var btn = $("<button data-cbfail='"+data.defmap.cbfail+"'/>");
			callbackFail(btn, data);
		}
	}
});
<%=varName%>.on('all', function(type) {
	if (type === 'startUpload') {
		<%=varName%>_state = 'uploading';
	} else if (type === 'stopUpload') {
		<%=varName%>_state = 'paused';
	} else if (type === 'uploadFinished') {
		<%=varName%>_state = 'done';
	}

	if (<%=varName%>_state === 'uploading') {
		_nsObject().find("#ctlBtn").find("font").text('暂停上传');
	} else {
		_nsObject().find("#ctlBtn").find("font").text('上传文件');
	}
});

//点击按钮开始上传，再次点击暂停
function <%=varName%>uploadFile(btn) {
	var _btn = $(btn);
	var _ns = _nsObject(_btn);
	var jsonData = str2json("{" + joinStr(valForm("uploadFormData", _ns), '"funcID":"doFileUploader.do"', '"rqstType":"AJAX"') + "}");
	<%=varName%>.option('formData', jsonData);
	if (<%=varName%>_state === 'uploading') {
		<%=varName%>.stop();
	} else {
		<%=varName%>.upload();
	}
}

function <%=varName%>downloadFile(btn) {
	var _btn = $(btn);
	var _ns = _nsObject(_btn);
	var jsonData = str2json("{" + joinStr(valForm("uploadFormData", _ns), '"funcID":"downloadExcel.do"', '"rqstType":"AJAX"') + "}");
	var _form1 = _ns.find("form[id='downloadFileForm']")[0];
	_form1.target = "_blank";
	_form1.action = "downloadExcel.do?funcID='downloadExcel.do'&rqstType='AJAX'";
	_form1.submit();
}

function <%=varName%>removeFile(btn) {
	var file = $(btn).parents("div[class='panel panel-default']");
	<%=varName%>.removeFile(file.attr("id"), true);
	$(btn).parents("div[class='panel panel-default']").remove();
}

function <%=varName%>fillMoreElmt(data) {
	var $upForm = _nsObject().find("#<%=varName%> #uploadFormData");
	$.each(data.defmap, function(k, v) {
		var $upForm = _nsObject().find("#uploadFormData");
		$.each(data.defmap, function(k, v) {
			var $k = $upForm.find("#" + k);
			if ($k[0] == undefined){
				$upForm.append("<input type='hidden' id='" + k + "' name='" + k + "' value='" + v + "'>");
				return;
			}
			$k.val(v);
		});
	});
}
</script>
</html>