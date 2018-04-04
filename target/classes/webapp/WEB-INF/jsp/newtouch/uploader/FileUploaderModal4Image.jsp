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
<style type="text/css">
#uploader-demo .thumbnail {
    width: 110px;
    height: 110px;
}
#uploader-demo .thumbnail img {
    width: 100%;
}
.uploader-list {
    width: 100%;
    overflow: hidden;
}
.file-item {
    float: left;
    position: relative;
    margin: 0 20px 20px 0;
    padding: 4px;
}
.file-item .error {
    position: absolute;
    top: 4px;
    left: 4px;
    right: 4px;
    background: red;
    color: white;
    text-align: center;
    height: 20px;
    font-size: 14px;
    line-height: 23px;
}
.file-item .info {
    position: absolute;
    left: 4px;
    bottom: 4px;
    right: 4px;
    height: 20px;
    line-height: 20px;
    text-indent: 5px;
    background: rgba(0, 0, 0, 0.6);
    color: white;
    overflow: hidden;
    white-space: nowrap;
    text-overflow : ellipsis;
    font-size: 12px;
    z-index: 10;
}
.upload-state-done:after {
    content:"\f00c";
    font-family: FontAwesome;
    font-style: normal;
    font-weight: normal;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    font-size: 32px;
    position: absolute;
    bottom: 0;
    right: 4px;
    color: #4cae4c;
    z-index: 99;
}
.file-item .progress {
    position: absolute;
    right: 4px;
    bottom: 4px;
    height: 3px;
    left: 4px;
    height: 4px;
    overflow: hidden;
    z-index: 15;
    margin:0;
    padding: 0;
    border-radius: 0;
    background: transparent;
}
.file-item .progress span {
    display: block;
    overflow: hidden;
    width: 0;
    height: 100%;
    -webit-transition: width 200ms linear;
    -moz-transition: width 200ms linear;
    -o-transition: width 200ms linear;
    -ms-transition: width 200ms linear;
    transition: width 200ms linear;
    -webkit-animation: progressmove 2s linear infinite;
    -moz-animation: progressmove 2s linear infinite;
    -o-animation: progressmove 2s linear infinite;
    -ms-animation: progressmove 2s linear infinite;
    animation: progressmove 2s linear infinite;
    -webkit-transform: translateZ(0);
}

.remove-img {
  position: absolute;
  right: 4px;
  top: 1px;
  background-color: #FFF;
}
</style>
</head>
<body>
  <div id="fileUploaderModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="fileUploaderModalTitle" data-backdrop="static">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h4 class="modal-title" id="fileUploaderModalTitle">文件上传</h4>
        </div>
        <div class="modal-body" id="<%=varName%>">
          <div class="row" style="padding-right: 15px; padding-left: 15px;">
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
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        </div>
      </div>
    </div>
  </div>
</body>
<script type="text/javascript">
var <%=varName%>_state = 'pending',<%=varName%>;
$(function(){
	<%=varName%>fillMoreElmt(${json});
	if(_nsObject().find("#downloadService").val() == "")
		_nsObject().find("#downloadBtn").hide();
	_nsObject().find('#fileUploaderModal').on('shown.bs.modal', function (e) {
		<%=varName%> = WebUploader.create({
			swf : "<%=path%>/compent/webuploader/0.1.5/Uploader.swf", // swf文件路径
			server : 'doFileUploader.do', // 文件接收服务端。
			pick : {
				id : '#<%=picker%>',
				multiple : <%=multiple%>//默认不开启多文件选择
			},
			fileNumLimit : <%=fileNumLimit%>,//默认一个文件
			resize : false, // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
			accept : {
				title : 'Image',
				extensions : 'png,gif,jpg,jpeg,bmp,tiff',
				mimeTypes : 'image/*'
			}
		});
		//当有文件被添加进队列的时候执行
		<%=varName%>.on('fileQueued', function(file){
			var $fileList = _nsObject().find("#thelist"),
				ratio = window.devicePixelRatio || 1,
	        	// 缩略图大小
	        	thumbnailWidth = 100 * ratio,
	        	thumbnailHeight = 100 * ratio;

			var $li = $('<div id="' + file.id + '" class="file-item thumbnail"><div class="remove-img">'
					+'<button type="button" class="close" aria-label="Close" '
					+'onclick="<%=varName%>removeFile(this,\''+file.id+'\')">'
					+'<span aria-hidden="true">&times;</span></button></div><img><div class="info">' + file.name + '</div></div>'),
	            $img = $li.find('img');
	        $fileList.append( $li );
	        // 创建缩略图
	        <%=varName%>.makeThumb( file, function( error, src ) {
	            if ( error ) {
	                $img.replaceWith('<span>不能预览</span>');
	                return;
	            }
	            $img.attr( 'src', src );
	        }, thumbnailWidth, thumbnailHeight );
		});

		//文件上传过程中创建进度条实时显示
		<%=varName%>.on('uploadProgress', function(file, percentage) {
			var $fileList = _nsObject().find("#thelist");
			var $li = $( '#'+file.id ), $percent = $li.find('.progress span');
			// 避免重复创建
        	if ( !$percent.length )
            	$percent = $('<p class="progress"><span></span></p>').appendTo( $li ).find('span');
        	$percent.css( 'width', percentage * 100 + '%' );
		});
		//成功之后显示成功信息
		<%=varName%>.on('uploadSuccess', function(file, data) {
			var $fileList = _nsObject().find("#thelist");
			var $file = $fileList.find('#'+file.id);
			var progress = $fileList.find("div[id='" + file.id + "']").find("#progress");
			progress.empty();
			if (data.flag == "success") {// 保存成功
				$file.addClass('upload-state-done');
				// 成功回调
				if(data.defmap != undefined && data.defmap.cbsuc){
					var btn = $("<button data-cbsuc='"+data.defmap.cbsuc+"'/>");
					callbackSuc(btn, data);
				}
			} else {
				alertMsg4Modal(data, _nsObject());// 提示失效信息
	        	var $error = $file.find('div.error');
	        	// 避免重复创建
	        	if ( !$error.length )
	            	$error = $('<div class="error"></div>').appendTo($file);
	        	$error.text('上传失败');
	        	
				// 失败回调
				if(data.defmap != undefined && data.defmap.cbfail){
					var btn = $("<button data-cbfail='"+data.defmap.cbfail+"'/>");
					callbackFail(btn, data);
				}
			}
			_nsObject().find("#ctlBtn").find("font").text('上传文件');
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
	})
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

function <%=varName%>removeFile(btn, fileid) {
	<%=varName%>.removeFile(fileid, true);
	$(btn).parent().parent().remove();
}

function <%=varName%>fillMoreElmt(data) {
	var $upForm = _nsObject().find("#<%=varName%> #uploadFormData");
	$.each(data.defmap, function(k, v) {
		var $k = $upForm.find("#" + k);
		if ($k[0] == undefined){
			$upForm.append("<input type='hidden' id='" + k + "' name='" + k + "' value='" + v + "'>");
			return;
		}
		$k.val(v);
	});
}
</script>
</html>