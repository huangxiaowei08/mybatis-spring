//弹出提示信息
function alertMsg4Modal(data, ns, backdrop) {
	unLoading();
	var modal = $("div[class^='modal in'][role='dialog']"); // 当前有模态框
	if (modal[0] != undefined) {
		modalFadeIn(modal, data);
		return;
	}
	var normalMmsg = $('<div class="modal" id="modal-msg" tabindex="-1" role="dialog" aria-labelledby="msg-titls" aria-hidden="true"><div class="modal-dialog"><div class="modal-content"><div id="msg-header" class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title" id="msg-titls"></h4></div><div class="modal-body" id="msg-body"></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">关闭</button></div></div></div></div>');
	if (!(data && data.msg && data.flag))
		return;
	var msg = "<ul>";
	$.each(data.msg, function(i, value) {
		$.each(value, function(msgKey, msgInfo) {
			if (msgKey != "")
				msgKey += ":";
			msg += "<h5>" + msgKey + msgInfo + " </h5>";
		});
	});
	msg += "</ul>";
	var msg_titls = normalMmsg.find("[id='msg-titls']");
	// var msg_header = normalMmsg.find("[id='msg-header']");
	if (data.flag == 'success') {
		msg_titls.text("成功");
		// msg_header.attr("class", "modal-header btn-success");
	}
	if (data.flag == 'warn') {
		msg_titls.text("警告");
		// msg_header.attr("class", "modal-header btn-warning");
	}
	if (data.flag == 'fail') {
		msg_titls.text("失败");
		// msg_header.attr("class", "modal-header btn-danger");
	}
	var msgBody = normalMmsg.find("[id='msg-body']");
	msgBody.empty();
	msgBody.append(msg);
	if (data.dtildMsg) {
		var fstMsg = "";
		var dtMsg = "";
		var dtildMsg = $('<div class="panel-group" id="msg-dtild"><div><div><a data-toggle="collapse" data-toggle="collapse" data-parent="#msg-dtild" href="#msg-dtild-collapse">点击查看详细</a></div><div id="msg-dtild-collapse" class="panel-collapse collapse"><div class="panel-body" id="msg-dtild-body"/></div></div></div>');
		var fst = true;
		$.each(data.dtildMsg, function(key, value) {
			$.each(value, function(msgKey, msgInfo) {
				if (msgKey != "")
					msgKey += ":";
				if (fst) {
					fstMsg += "<pre><p class='text-danger'>" + msgKey + msgInfo + "</p></pre>";
					fst = false;
				} else {
					dtMsg += "<p>" + msgKey + msgInfo + "</p>";
				}
			});
		});
		dtildMsg.find("[id='msg-dtild-body']").append(fstMsg + "<pre>" + dtMsg + "</pre>");
		msgBody.append(dtildMsg);
	}
	var _div = ns.find("div[id='modal-msg']");
	if (_div[0] == undefined) {
		ns.prepend(normalMmsg);
	} else {
		_div.remove();
		ns.prepend(normalMmsg);
	}
	var options = "show:'true'";
	if (data.flag != 'success' && (backdrop == undefined || backdrop == ""))
		options += ",backdrop:'static'";
	ns.find("div[id='modal-msg']").modal(str2json("{" + options + "}"));
	ns.find("div[id='modal-msg']").on('hidden.bs.modal', function(e) {
		ns.find("div[id='modal-msg']").remove();
		$("div[class='modal-backdrop fade in']").remove();
		$("div[class='modal-backdrop in']").remove();

	});
	return true;
}

function modalFadeIn(modal, data) {
	var alertClass = "alert alert-success";
	if (data.flag == 'warn')
		alertClass = "alert alert-warning";
	if (data.flag == 'fail')
		alertClass = "alert alert-danger";
	var msgArray = modal.find("div[id='_ModalInAlertMsg']");
	if (msgArray != undefined)
		msgArray.remove();
	if (data && data.msg && data.flag) {
		var msgHtml = "";
		$.each(data.msg, function(i, value) {
			$.each(value, function(msgKey, msgInfo) {
				msgHtml += '<div id="_ModalInAlertMsg" class="alert ' + alertClass + ' alert-dismissible" role="alert">';
				msgHtml += '<button type="button" class="close" data-dismiss="alert">';
				msgHtml += '<span aria-hidden="true">&times;</span><span class="sr-only">关闭</span>';
				msgHtml += '</button>';
				if (msgKey != "")
					msgKey += ":";
				msgHtml += msgKey + msgInfo;
				msgHtml += '</div>';
			});
		});
		var msg = $(msgHtml);
		modal.find("div[class='modal-body']").prepend(msg);
		setTimeout(function() {
			msg.remove();
		}, 4000);
	}
}

/**
 * 更新提示信息
 * 
 * @param t
 *            提示信息
 */
function updateTips(t) {
	var checkuiMsg = $("#checkui-msg");
	if (checkuiMsg[0] == undefined) {
		var _body = $("div[class='tab-pane active']").last();
		_body
				.append('<div class="modal" id="checkui-msg" tabindex="-1" role="dialog" aria-labelledby="msg-titls" aria-hidden="true"><div class="modal-dialog"><div class="modal-content"><div id="msg-header" class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button><h4 class="modal-title" id="checkui-titls"></h4></div><div class="modal-body" id="checkui-body"></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div></div></div></div>');
		checkuiMsg = $("#checkui-msg");
	}
	var checkui_titls = checkuiMsg.find("[id='checkui-titls']");
	checkui_titls.text("失败");
	var checkuiBody = checkuiMsg.find("[id='checkui-body']");
	if (checkuiBody.outerHTML().indexOf(t) < 0)
		checkuiMsg.find("[id='checkui-body']").append("<h5>" + t + "</h5>");
	checkuiMsg.modal({
		show : 'true'
	});
	checkuiMsg.on('hidden.bs.modal', function(e) {
		$("#checkui-msg").remove();
		$("div[class='modal-backdrop fade in']").remove();
		$("div[class='modal-backdrop in']").remove();
	});
}