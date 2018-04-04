/**
 * 触发ajax调用，使用动态传值的方式
 * 
 * @param className
 *            类名（必填）
 * @param methodName
 *            方法名（必填）
 * @param _this
 *            触发ajax的对象（必填）
 */
function callAjax(className, methodName, _this) {
	// 传输数据
	var btn = $(_this);
	var ns = _nsObject(btn);
	var dataXml = joinData(className, methodName, ns, btn);
	if (dataXml == null || dataXml == '') {
		return;
	}
	// 生成URL
	$.ajax({
		type : "POST",
		url : "callAjax.do",
		data : str2json(dataXml),
		dataType : "json",
		success : function(data) {
			if (data.flag != undefined) {
				alertMsg4Modal(data);
				return;
			}
			if (data.data == undefined)
				return;
			var scope = ns;
			$.each(data.data, function(key, value) {
				if (value["ajaxscope"] == "table")
					scope = btn.parent().parent();
				input(key, value, scope);
				focus(key, value, scope);
				alertInfo(key, value);
				style(key, value, scope);
				readonly(key, value, scope);
				disabled(key, value, scope);
				edit(key, value, scope);
				select(key, value, scope);
				grid(key, value, ns);
			});
			callbackSuc(btn, data);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = " + errorThrown);
		}
	});
}

function input(aKey, value, scope) {
	// alert(key);
	if (aKey != "input")
		return;
	$.each(value, function(key, value) {
		// alert("input | "+key+" | "+value);
		scope.find(":input[id='" + key + "']").val(value);
	});
}

function focus(aKey, value, scope) {
	if (aKey != "focus")
		return;
	var input;
	$.each(value, function(key, value) {
		// alert("focus | "+key+" | "+value);
		input = scope.find(":input[id='" + key + "']");
		if (value != "none")
			input.val(value);
		input.focus();
	});
}

function alertInfo(key, value) {
	if (key != "alert")
		return;
	// alertMsg4Modal(data);
	// alert("alertInfo");
	$.each(value, function(key, value) {
		updateTips(value);
	});
}

function style(aKey, value, scope) {
	if (aKey != "style")
		return;
	$.each(value, function(key, value) {
		// alert("style | "+key+" | "+value);
		scope.find(":input[id='" + key + "']").css("color", value);
	});
}

function msg(aKey, value, scope) {
	if (aKey != "msg")
		return;
	$.each(value, function(key, value) {
		// alert("msg | "+key+" | "+value);
		scope.find(":input[id='" + key + "']").val(value);
	});
}

function disabled(aKey, value, scope) {
	if (aKey != "disabled")
		return;
	var input;
	$.each(value, function(key, value) {
		// alert("disabled | "+key+" | "+value);
		input = scope.find(":input[id='" + key + "']");
		if (value != "none")
			input.val(value);
		input.attr("disabled", "disabled");
	});
}

function edit(aKey, value, scope) {
	if (aKey != "edit")
		return;
	// alert("edit.type" + key);
	var input;
	$.each(value, function(key, value) {
		// alert("edit | "+key+" | "+value);
		input = scope.find(":input[id='" + key + "']");
		if (value != "none")
			input.val(value);
		input.removeAttr("readonly");
		input.removeAttr("disabled");
	});
}

function readonly(aKey, value, scope) {
	if (aKey != "readonly")
		return;
	var input;
	$.each(value, function(key, value) {
		// alert("readonly | "+key+" | "+value);
		input = scope.find(":input[id='" + key + "']");
		if (value != "none")
			input.val(value);
		input.attr("readonly", "readonly");
	});
}

function select(aKey, value, scope) {
	if (aKey != "select")
		return;
	$.each(value, function(key, value) {
		// alert("readonly | "+key+" | "+value);
		addSelectOption(key, value, scope);
	});
}

function grid(key, value, ns) {
	if (key != "grid")
		return;
	var titleArr = new Array();
	var tdArr = new Array();
	var obj = null, axis = "", tr = "", trSize = null, table = null, tbody = null;
	$.each(value, function(gridId, value) {
		// alert("readonly | "+key+" | "+value);
		trSize = findTH(titleArr, tdArr, gridId, ns);
		table = $("#" + ns + " table[id='" + gridId + "']");
		if (table.find("tbody").length <= 0)
			table.append("<tbody/>");
		tbody = table.find("tbody");
		tbody.empty();
		$.each(value, function(aKey, aValue) {
			obj = null;
			tr = $("<tr/>");
			axis = "";
			for (var i = 0; i < titleArr.length; i++) { // 写每行数据中的每个单元格
				obj = tdArr[i].clone();
				axis = obj.attr("axis") != undefined ? obj.attr("axis").toLowerCase() : "";
				if (axis == "checkbox")
					obj.attr("data-showbox", "true");
				createTD(titleArr, tr, aValue, axis, obj, ns, i, trSize);
			}
			tbody.append(tr);
		});
	});
}

// 拼接上传值的JSON串
function joinData(className, methodName, ns, btn) {
	var _form = "form1";
	if (btn.attr("data-form"))
		_form = btn.attr("data-form");
	var formValue = valForm(_form, ns);
	var subJson = valTable(ns);
	var otherArg = callbackArg(btn);// 参数回调方法，用于附加其他参数
	var json = '"classname":"' + className + '","method":"' + methodName + '","_this":"' + btn.val() + '",rqstType:"AJAX"';
	json = joinStr(formValue, subJson, otherArg, json);
	return "{" + json + "}";
}

// 对下拉列表写值
function addSelectOption(aKey, value, scope) {
	if (scope.is("tr") || scope.is("td")) {
		addSelectOptionTd(aKey, value, scope);
		return;
	}
	// alert("select | " + key + " | " + value);
	// 得到界面元素中下拉列表
	var slctArg = scope.find(":input[id='" + aKey + "']");
	// alert(slctArg);
	// 界面元素不存在则返回
	if (slctArg[0] == undefined) {
		return;
	}
	// 先清空下拉列表
	slctArg.find("option").remove();
	// 没有有data-blankline属性，或者有属性，值为true时拼接空白行
	if (!slctArg.attr("data-blankline") || slctArg.attr("data-blankline") == "true")
		slctArg.append("<option value=''></option>");
	$.each(value, function(sKey, sVal) {
		var selected = "";
		if (sVal["selected"] != undefined)
			selected = "selected = 'selected'";
		slctArg.append("<option value='" + sVal["code"] + "' " + selected + ">" + sVal["name"] + "</option>");
	});
}

// 对下拉列表写值
function addSelectOptionTd(aKey, value, scope) {
	// alert("select | " + key + " | " + value);
	// 得到界面元素中下拉列表
	var slctArg = scope.find(":input[id='" + aKey + "']");
	var td = slctArg.parent();
	slctArg.remove();
	// alert(slctArg);
	// 界面元素不存在则返回
	if (slctArg[0] == undefined) {
		return;
	}
	// 先清空下拉列表
	slctArg.find("option").remove();
	console.log(slctArg.attr("data-blankline"));
	// 没有有data-blankline属性，或者有属性，值为true时拼接空白行
	if (!slctArg.attr("data-blankline") || slctArg.attr("data-blankline") == "true")
		slctArg.append("<option value=''></option>");
	$.each(value, function(sKey, sVal) {
		var selected = "";
		if (sVal["selected"] != undefined)
			selected = "selected = 'selected'";
		slctArg.append("<option value='" + sVal["code"] + "' " + selected + ">" + sVal["name"] + "</option>");
	});
	td.append(slctArg);
}