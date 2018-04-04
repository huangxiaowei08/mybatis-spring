/**
 * 查询
 * 
 * @param btn
 */
function query(btn) {
	query4Id(btn, "grid", "form1");
}

function query4Id(btn, grid_id, form_id) {
	var _btn = $(btn);
	var ns = _nsObject(_btn);
	ns.find("div[id='queryTerms']").last().empty();// 调用此方法均为通过查询按钮调用，则清空此区域
	fillGrid(btn, grid_id, form_id);// 初始化查询结果
}

function addInit(btn) {
	addInit4Id(btn, "form1");
}
/**
 * 跳转添加/修改页面
 * 
 * @param btn
 */
function addInit4Id(btn, form_id) {
	var _this = $(btn);
	_this[0].disabled = true;
	var ns = _nsObject(_this);
	var url = _this.attr("name");
	var fv = valForm("queryTerms", ns); // 取查询条件隐藏域的值，用于返回时回显
	var data = valForm(form_id, ns); // 取查询条件中的值，用于后台业务逻辑使用
	data = joinJson(data, valTRHide(btn)); // 取当前按钮所在行的值，修改时使用
	ns.load(url, str2json('{' + joinStr(data, '"queryTerms":{' + fv + '}') + '}'), function() {
		$("div[class='modal-backdrop fade in']").remove();
	});
}
/**
 * 修改时取修改按钮那行的隐藏值
 * 
 * @param btn
 *            修改按钮
 * @returns {String} 修改按钮那行对应的值
 */
function valTRHide(btn) {
	var _btn = $(btn);
	var tr = _btn.parentsUntil("table", "tr");
	if (!tr.is("tr"))
		return ""; // 如果不是在查询结果的行里面，则不取值
	var _v = "", json = "";
	tr.find("[type='hidden']").each(function(i, v) {
		_v = $(v);
		if (_v[0] == undefined)
			return;
		json = joinJson(json, '"' + _v.attr("id") + '":"' + _v.val() + '"');
	});
	return json
}

/**
 * 添加方法
 * 
 * @param btn
 */
function add(btn) {
	add4Id(btn, "form1");
}

function mdf(btn) {
	add4Id(btn, "form1", true);
}

function add4Id(btn, form_id, isMdf) {
	var _this = $(btn);
	btn.disabled = true;
	var ns = _nsObject(_this);
	var url = _this.attr("name");
	var f = ns.find("form[id='" + form_id + "']");
	if (!_this.attr("data-notchk") && f && !f.valid()) { // 触发jquery.validate校验
		callback(btn, "", "data-cbchkfail"); // 校验失败后回调
		btn.disabled = false;
		return;
	}
	if (!customCheck(_this, form_id)) {
		callback(btn, "", "data-cbchkfail"); // 校验失败后回调
		btn.disabled = false;
		return;
	}
	var data = valForm(form_id, ns); // 取表单中值
	var _data = valTable(ns);// 如果有tab页，取tab页中的信息
	_data = joinJson(_data, callbackArg(btn));// 参数回调方法，用于附加其他参数
	var jsonData = str2json('{' + joinStr(data, _data, '"rqstType":"AJAX"') + "}");
	$.ajax({
		type : "POST",
		url : url,
		data : jsonData,
		dataType : "json",
		// contentType : 'application/json',
		success : function(data) {
			if (data.flag == "success") {// 保存成功
				if (!isMdf)
					resetForm(btn, form_id);// 重置表单(位置不能变，否则回调函数中重新赋值会有问题)
				callbackSuc(btn, data);// 调用成功回调函数
				alertMsg4Modal(data, ns);// 提示成功信息
				_this[0].disabled = false;
				return;
			}
			callbackFail(btn, data);// 保存失败，调用失败回调函数
			alertMsg4Modal(data, ns);// 提示失效信息
			btn.disabled = false;
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			updateTips("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = " + errorThrown);
			btn.disabled = false;
		}
	});
}

function customCheck(_btn, form_id) {
	var cbCheck = _btn.attr("data-cbchk");
	if (cbCheck == undefined || cbCheck == "")
		return true;
	var param = new Array();
	param.push(_btn[0]);
	param.push(form_id);
	var _fnList = cbCheck.split(",");
	var flag = true;
	$.each(_fnList, function(i, fn) {
		if (!doCallback(eval(fn), param)) {
			flag = false;
		}
	});
	return flag;
}

/**
 * 返回查询页面
 * 
 * @param btn
 */
function goBack(btn) {
	var _this = $(btn);
	var ns = _nsObject(_this);
	_this[0].disabled = true;
	var url = _this.attr('name');
	var json = valForm("queryTerms", ns);// 取前查询页面的查询条件
	var jsonForm = str2json("{queryTerms:{" + json + "}}");
	ns.load(url, jsonForm, function() {
		$("div[class='modal-backdrop fade in']").remove();
	});
}
/**
 * 查询页面回写增加/修改页面返回时数据
 * 
 * @param btn
 * @param data
 */
function goBackQuery(btn, data) {
	var _btn = $(btn);
	var ns = _nsObject(_btn);
	if (data["queryTerms"] == undefined) // 没有查询条件，表示未点击查询到新页面，则不需要回写
		return;
	fillQueryTerms(data, ns)// 回写查询条件
	ns.find("div[id='queryTerms']").last().append("<input id='gobackflag' type='hidden'>");// 加入是返回页面回来的标志
	fillGrid(btn, "grid", "form1");// 重新刷新查询结果
}

/**
 * 重置表单
 * 
 * @param btn
 */
function resetForm(btn) {
	resetForm4Id(btn, "form1")
}

/**
 * 重置表单
 * 
 * @param btn
 *            按钮
 * @param formid
 *            表单
 */
function resetForm4Id(btn, formid) {
	var _btn = $(btn);
	var ns = _nsObject(_btn);
	var _form = ns.find("[id='" + formid + "']");
	if (_form[0] == undefined)
		_form = ns.find("form").first();
	_form.find(":input").each(function(k, v) {
		var _v = $(v);
		var parent = _v.parent();
		parent.removeClass("has-error").removeClass("has-success");// 将提示信息去除
		parent.find("span[class^='glyphicon']").remove();// 将提示信息的错号/对号去除
		if (_v.attr("data-notrst")) // 如果标识为不需要重置，则返回
			return;
		switch (v.type) {
		case 'submit':
			break;
		case 'button':
			break;
		case 'select-multiple':
			_v.find("option:selected").prop("selected", false);
			if (_v.attr("data-rstrm") === "true") {
				_v.find("option").remove();
			}
			break;
		case 'select-one':
			_v.find("option:first").prop("selected", true);
			break;
		case 'checkbox':
			_v.prop("checked", false);
			break;
		case 'radio':
			_v.prop("checked", false);
			break;
		default:
			_v.val("");
			break;
		}
	});
	if (_form.find("div[class*='has-feedback']").size() > 0) {
		var valid = _form.validate();
		if (valid != undefined)
			valid.resetForm();// 重置校验信息
	}
}

/**
 * 勾选复选框后提交信息
 * 
 * @param btn
 */
function rowSubmit(btn) {
	rowSubmit4id(btn, "grid", "form1");
}
/**
 * 勾选复选框后提交信息
 * 
 * @param btn
 * @param gridid
 * @param formid
 */
function rowSubmit4id(btn, gridid, formid) {
	var _btn = $(btn);
	var ns = _nsObject(_btn);
	// 创建执行成功后的回调函数
	var querybtn = ns.find("[id='" + formid + "'] button[onclick^='query']");// 查找查询按钮
	console.log(querybtn);
	var array;
	if (querybtn[0] != undefined) {// 会存在没有
		array = new Array();
		array.push("fillGrid");// 回调刷新查询结果函数
		array.push(querybtn[0]);// 查询按钮
		array.push(gridid);// 查询结果写值区域
		array.push(formid);// 查询条件取值表单
	}
	rowSubmit4Public(btn, gridid, formid, array);
}

/**
 * 勾选复选框后提交信息公用方法
 * 
 * @param btn
 * @param gridid
 * @param formid
 * @param callback
 * @param async
 *            是否异步，默认为是异步<br>
 *            一般情况下均为异步，但addRow方法调用时需要修改为同步，否则隐藏模态框后会出现黑色遮罩
 */
function rowSubmit4Public(btn, gridid, formid, callback, async) {
	var _btn = $(btn);
	var ns = _nsObject(_btn);
	var str = "";
	if (gridid != "" && gridid != undefined) {// 如果gridid值传入了，则取gridid中的值，同时会触发选择一条记录的校验
		str = boxCheck(_btn, ns, gridid);
		if (!str)
			return;
	}
	var url = btn.name;// 取调用的controlle
	var data = valForm(formid, ns);// 取表单中值供后台使用
	data = joinJson(data, callbackArg(btn));// 加入取值回调函数中的值
	var jsonData = str2json('{' + joinStr(data, '"checkbox":[' + str + ']', '"rqstType":"AJAX"') + '}');
	if (async != false)
		async = true;
	var flag = false;
	$.ajax({
		async : async,
		type : "POST",
		url : url,
		data : jsonData,
		dataType : "json",
		success : function(data) {
			if (data.flag == "success" || data.flag == "warn") {
				if (callback != null && callback != undefined && callback[1] != null && callback[1] != undefined) {
					// 销毁datatable
					$(callback[1]).mousedown();
				}
				callbackSuc(btn, data);// 成功后调用成功回调函数
				if (callback != undefined) {// 有回调方法时才执行回调
					var fn = callback[0];// 准备调用外层传入回调函数
					callback.shift();
					ns.find("div[id='queryTerms']").last().append("<input id='gobackflag' type='hidden'>");// 设置标志，标识为分页查询，而非新查询
					callback.push(data);// 将返回结果放进去，供被回调函数使用
					doCallback(eval(fn), callback);// 调用外层传入的回调函数
				}
				alertMsg4Modal(data, ns);// 提示信息
				_btn[0].disabled = false;
				flag = true;
				return;
			}
			callbackFail(btn, data);// 失败回调函数
			alertMsg4Modal(data, ns);// 失败提示信息
			_btn[0].disabled = false;
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			updateTips("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = " + errorThrown);
		}
	});
	return flag;
}

function boxCheck(_btn, ns, gridid) {
	var table = ns.find("table[id='" + gridid + "']");// 取提交请求的查询结果
	if (table[0] == undefined)
		return true;// 没有查询结果，就不用判断是否需要清空，直接返回
	var index = table.find("thead tr th :checkbox").first().parent().prevAll().length + 1;// 查找复选框在第几列，用于判断是否有勾选
	var boxlist = table.find("tbody tr td:nth-child(" + index + ")").find(":checked");// 选择复选框对应列所有已经勾选了的值
	if (boxlist == undefined || boxlist.length < 1) {// 如果勾选的数据小于1，则进行提示
		var data = {
			flag : "warn",
			msg : [ {
				"" : "请至少选择一条记录"
			} ]
		};
		alertMsg4Modal(data, ns);
		return false;
	}
	var cfmd = _btn.attr("data-cfmd");
	if (cfmd == undefined || cfmd == true)
		if (!window.confirm('请您确认操作！'))
			return false;// 选择的是否，则直接退出
	var p, str = "";
	boxlist.each(function(i, val) {// 把每个checkbox以及checkbox所在行里的隐藏列的值全取出来
		p = $(val).parent().parent();// 得取被勾选框的行对象
		str = joinJson(str, "{");
		var subStr = "";
		p.find(":input").each(function(ii, value) {// 取行里的每一个隐藏元素
			if (value.type == "button")
				return;
			subStr = joinJson(subStr, valInput($(value), true));
		});
		str += subStr + "}";
	});
	return str;
}
function showModal(btn) {
	showModal4Id(btn, "form1");
}

/**
 * 显示添加一行的模态框
 * 
 * @param btn
 */
function showModal4Id(btn, formid) {
	btn.disabled = true;
	var _btn = $(btn);
	var ns = _nsObject(_btn);
	var url = _btn.attr("name");
	var modal = $("<div/>");
	ns.prepend(modal);
	var _data = callbackArg(btn);// 参数回调方法，用于附加其他参数
	var data = valForm(formid, ns); // 取查询条件中的值，用于后台业务逻辑使用
	modal.load(url, str2json("{" + joinStr(data, _data) + "}"), function() {
		var _modal = modal.find("div[class^='modal'][role='dialog']").first();
		// $("#" + ns).prepend(_modal);
		_modal.modal({
			show : 'true'
		});
		_modal.on('hidden.bs.modal', function(e) {
			modal.remove();
			$("div[class='modal-backdrop in']").remove();
			$("div[class='modal-backdrop fade in']").remove();
		});
		callbackSuc(btn, data);// 调用成功回调函数
		btn.disabled = false;
	});

}

/**
 * 将模态框内查询结果中的值，添加到页面上 <br>
 * 添加记录后保存数据库及回写页面
 * 
 * @param btn
 */
function addRow4Query(btn) {
	var _btn = $(btn);
	// 创建执行成功后的回调函数
	var array = new Array();
	array.push("fillDiv");// 回调刷新查询结果函数
	array.push(_btn.attr("data-parent-grid"));// 保存成功后回写的区域
	array.push(_btn.attr("data-parent-ns"));// 回写的命名空间
	// 当前按钮,当前查询的表格,前一页面的表单,回调函数(ns也需要是前一页面的，不能是当前页面的)
	var flag = rowSubmit4Public(btn, _btn.attr("data-grid"), "", array, false);
	if (flag)
		$("div[class='modal in']").modal('hide');
}

/**
 * 将模态框中查询结果中的值，添加到页面上 <br>
 * 添加记录后只保存在页面上，不调用后台
 * 
 * @param btn
 */
function addRow2Cache4Query(btn) {
	var _btn = $(btn);
	_btn[0].disabled = true;
	var ns = _nsObject(_btn);
	var parentGrid = _btn.attr("data-parent-grid"), parentNS = _btn.attr("data-parent-ns"), data = "";
	// 取本页面的数据
	var grid_id = _btn.attr("data-grid");
	if (grid_id != "" && grid_id != undefined) {
		// 从选择的行中取值
		var str = boxCheck(_btn, ns, grid_id);
		if (!str)
			return;
		data = str2json("[" + str + "]");

	} else {
		if (!customCheck(_btn, _btn.attr("data-form"))) {
			_btn[0].disabled = false;
			return;
		}
		data = callbackArg(btn);// 参数回调方法，用于附加其他参数
		if (data == "")
			data = "[{" + valForm(_btn.attr("data-form"), ns) + "}]";// 从表单中取值，供显示
		data = str2json(data);
	}
	var url = btn.name;// 取调用的controlle
	// 取前一页面查询结果的数据
	var _pns = _nsObject($("<button data-ns='" + parentNS + "'/>"));
	var gridData = valTableData(parentGrid, _pns);
	var jsonData = str2json(gridData);
	$.each(data, function(i, v) {
		if (jsonData == undefined || jsonData == null) {
			v["rn"] = i + 1;
			return;
		} else {
			v["rn"] = jsonData.length + 1;
			jsonData.push(v);
		}
	});
	if (jsonData == undefined || jsonData == null)
		jsonData = data;
	// 显示数据
	fillDiv(_btn.attr("data-parent-grid"), _pns, jsonData);
	$("div[class='modal in']").modal('hide');
	callbackSuc(btn, null);
	_btn[0].disabled = false;
}

/**
 * 将当前页面中的值添加到指定的grid上 <br>
 * 添加记录后只保存在页面上，不调用后台
 * 
 * @param btn
 */
function addRow(btn) {
	var _btn = $(btn);
	_btn[0].disabled = true;
	if (!customCheck(_btn, _btn.attr("data-form"))) {
		_btn[0].disabled = false;
		return;
	}
	var data = callbackArg(btn);// 参数回调方法，用于附加其他参数
	if (data == "")
		data = "[{" + valForm(_btn.attr("data-form"), _nsObject(_btn)) + "}]";// 从表单中取值，供显示
	data = str2json(data);
	var url = btn.name;// 取调用的controlle
	// 取本页面的数据
	var grid_id = _btn.attr("data-grid");
	var parent_ns = _nsObject($("<button data-ns='" + _btn.attr("data-parent-ns") + "'/>"));
	var jsonData, gridData = valTableData(grid_id, parent_ns);
	if (gridData != "")
		jsonData = str2json(gridData);
	$.each(data, function(i, v) {
		if (jsonData == undefined || jsonData == null) {
			v["rn"] = i + 1;
			return;
		} else {
			v["rn"] = jsonData.length + 1;
			jsonData.push(v);
		}
	});
	if (jsonData == undefined || jsonData == null)
		jsonData = data;
	// 显示数据
	fillDiv(grid_id, parent_ns, jsonData);
	callbackSuc(btn, null);
	_btn[0].disabled = false;
}

function delRow2Cache(btn) {
	var _btn = $(btn);
	_btn.parentsUntil("table", "tr").remove();
	var ns = _nsObject(_btn);
	var grid_id = _btn.attr("data-grid");
	var gridData = valTableData(grid_id, ns);
	if (gridData == "")
		return;
	var gridData = str2json(gridData);
	var data = new Array();
	$.each(gridData, function(i, v) {
		v["rn"] = i + 1;
		data.push(v);
	});
	// 显示数据
	fillDiv(grid_id, ns, data);
}
/**
 * 删除一行记录
 * 
 * @param btn
 */
function delRow(btn) {
	var _this = $(btn);
	btn.disabled = true;
	var ns = _nsObject(_this);
	var url = _this.attr("name");
	var _data = valTRHide(btn);
	_data = joinJson(_data, callbackArg(btn));// 参数回调方法，用于附加其他参数
	var jsonData = str2json('{' + joinStr(_data, '"rqstType":"AJAX"') + "}");
	$.ajax({
		type : "POST",
		url : url,
		data : jsonData,
		dataType : "json",
		success : function(data) {
			if (data.flag == "success") {// 保存成功
				delRow2Cache(btn);// 刷新页面
				callbackSuc(btn, data);// 调用成功回调函数
				alertMsg4Modal(data, ns);// 提示成功信息
				_this[0].disabled = false;
				return;
			}
			callbackFail(btn, data);// 保存失败，调用失败回调函数
			alertMsg4Modal(data, ns);// 提示失效信息
			btn.disabled = false;
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			updateTips("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = " + errorThrown);
			btn.disabled = false;
		}
	});
}
function fillPage4Ajax(link, data, ns) {
	// 发送ajax请求，data为要传送的数据
	var sendDate = {
		"rqstType" : "AJAX"
	};
	$.extend(sendDate, data);
	$.ajax({
		type : "POST",
		url : link,
		data : sendDate,
		dataType : "json",
		// contentType : 'application/json',
		success : function(_returnData) {
			// 成功之后，调用fillPage方法回写页面
			fillPage(_returnData, ns);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			updateTips("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = " + errorThrown);
			btn.disabled = false;
		}
	});
}

/**
 * 进入修改/新增页面时为页面赋值
 * 
 * @param data
 * @param ns
 */
function fillPage(data, ns) {
	console.dir(data);
	if (typeof data == "undefined" || data == null || data == undefined)
		return;// 没有数据则返回不赋值
	if (!(ns instanceof jQuery)) {
		if (ns != "" && ns != undefined) {
			ns = _nsObject($("<button data-ns='" + ns + "'/>"));
		} else {
			ns = _nsObject();
		}
	}
	if (data.flag == "fail") {
		alertMsg4Modal(data, ns);// 失败，则提示信息
		return;
	}
	if (data["defmap"] != undefined) {// 有需要回写的数据，则回写
		$.each(data["defmap"], function(k, d) {
			fillValue(k, d, ns);// 回写值
		});
	}
	fillQueryTerms(data, ns);// 回写前一页查询条件
}

/**
 * 回写查询条件<br>
 * 回写的查询条件在分页和跳转新页面时会使用到<br>
 * 点击查询按钮时会清空<br>
 * 回写查询结果完成后会清空，重新将新的查询条件及分页信息写入
 * 
 * @param data
 * @param ns
 */
function fillQueryTerms(data, ns) {
	if (data["queryTerms"] == undefined || data["queryTerms"] == "")
		return;
	var qt = ns.find("div[id='queryTerms']").last();
	qt.empty();
	$.each(data["queryTerms"], function(i, v) {
		qt.append("<input id='" + i + "' name='" + i + "' value='" + v + "' type='hidden'>");
	});
}

/**
 * 填充每一个元素
 * 
 * @param key
 * @param data
 * @param ns
 */
function fillValue(key, data, ns) {
	var elmt = findElmt(key, data, ns, "id");// 先用id取值
	if (elmt[0] == undefined) {// 使用id没有查找到对象
		elmt = findElmt(key, data, ns, "name");// 使用name再查找一次，raido会使用name写值
		if (elmt[0] == undefined) // 使用name在页面上未查找到返回对象，则返回
			return;
	}

	if (elmt[0].type != undefined) {// 对象有类型表示是input/select等元素，直接回写
		fillElmt(elmt, data);
		return;
	} else if (elmt.parent().is("tr")) {
		elmt.html(data);
		return;
	} else {
		fillDiv(key, ns, data); // 对象无类型，则表示是table，需要写单元格
	}
}

function findElmt(key, data, ns, attr) {
	var elmt = ns.find("[" + attr + "='" + key + "']");// 第一次先取所有值，因为会涉及到grid，grid可能不在form内，所以不能只限制form内的值
	if (elmt.length > 1) // 如果存在多个值，就从form里取值，因为grid内的值有单独的方法进行写值
		elmt = ns.find("form [" + attr + "='" + key + "'][value='" + data + "']");
	if (elmt.length > 1)
		throw new Error("[" + attr + "='" + key + "']的元素存在[" + elmt.length + "]，请检查代码");
	return elmt;
}

/**
 * 回写普通元素
 * 
 * @param elmt
 * @param data
 */
function fillElmt(elmt, data) {
	if (elmt.parent().is("td")) // 表示此对象在表格中，则不进行赋值，表格中对象用grid进行赋值
		return;
	switch (elmt[0].type) {
	case "radio":
	case "checkbox":
		if (data instanceof Object) {// 可能用于一组有多个选项时使用
			for ( var dKey in data) {
				for ( var ddkey in data[dKey]) {
					elmt.find("[name='" + ddkey + "']").prop("checked", "true");
				}
			}
			return;
		}
		elmt.prop("checked", "true");// 为明细页面只有一个复选框时进行赋值使用
		break;
	case "select-multiple":
	case "select-one":
		switch ($.type(data)) {// 下拉列表分两种情况回写
		case "array":// 返回值是数组，则把下拉列表清空后，将数组的值写到下拉列表中
			elmt.empty();
			elmt.append("<option value=''></option>");
			$.each(data, function(sKey, sVal) {
				var aValue = "";
				if (sVal["selected"] != undefined)
					aValue = "selected = 'selected'";
				elmt.append("<option value='" + sVal["code"] + "' " + aValue + ">" + sVal["name"] + "</option>");
			});
			break;
		case "string":
			elmt.find("option[value='" + data + "']").prop("selected", "true");
			break;
		default:// 否则直接给下拉列表赋值
			for ( var dKey in data) {
				for ( var ddkey in data[dKey]) {
					elmt.find("option[value='" + ddkey + "']").prop("selected", "true");
				}
			}
			break;
		}
		break;
	default:
		elmt.val(data);// 非单选/复选/下拉列表则直接赋值
	}
}
/**
 * 写grid
 * 
 * @param grid_id
 *            回写查询结果区域
 * @param ns
 *            命名空间
 * @param data
 *            必须放在最后，供回调函数使用
 */
function fillDiv(grid_id, ns, data) {
	var table = ns.find("table[id='" + grid_id + "']");
	if (table[0] == undefined) // 表格不存在，则直接返回
		return;
	// 不管返回结果是否有值，先清空表格
	table.find("tbody").remove();// 取消全选按钮
	table.find("thead input:checked").prop("checked", false);// 取消全选按钮
	if ($.fn.dataTable.isDataTable("#" + ns.attr("id") + " table[id='" + grid_id + "']"))
		table.DataTable().destroy();// 如果已经存在，则先清空
	if (data["data"] != undefined) // 返回的是json.data中的值
		data = data["data"];
	if (data == undefined)
		return;
	if (data[0] == undefined) // 没有任何数据
		return;
	var title = [];
	var col = [];
	var _rnNo = findTH(grid_id, ns, title, col);// 查找表头，初始化需要的信息
	var func = table.attr("data-cbsuc");
	// TODO 此处与jquery1.11.3不兼容，需要修改。
	table.dataTable({
		"dom" : "",
		"bPaginate" : false, // 关闭翻页功能
		"columns" : title,
		"columnDefs" : col,
		"order" : [ _rnNo, 'asc' ],
		"data" : data,
		"createdRow" : function(row, data, dataIndex) {
			if (func == null || func == undefined || func == "")
				return;
			var param = new Array();
			param.push(row);
			param.push(data);
			param.push(dataIndex);
			doCallback(eval(func), param);
		}
	}); // datatables回写数据
}

/**
 * 取表单中的值
 * 
 * @param formid
 *            表单编码
 */
var _iList = "";
function valForm(formid, ns) {
	if (formid == "" || formid == null || formid == undefined)
		return "";
	var fields = ns.find("[id='" + formid + "']").last().find(":input");// 取出最后一个表单中所有可录入元素，取后一个表单是为了防止取返回查询结果区域时存在的问题
	var parent = "", json = "";
	_iList = ",";
	fields.each(function(i, value) {// 循环每个元素取值
		var _value = $(value);
		parent = _value.parent();
		if (parent.is("td") || parent.is("th"))
			return;// 不取查询结果中的值，查询结果中的值有单独取值方法
		json = joinJson(json, valInput(_value));
	});
	return json;
}
/**
 * 
 * @param _value
 *            需要被取值的对象
 * @param notChkRep
 *            不校验是否重复
 * @returns {String}
 */
function valInput(_value, notChkRep) {
	if (!notChkRep)
		chkRep = false;
	if (_value[0].name == null || _value[0].name == "")
		return "";// name为空则不取值
	var ipt_id = _value.attr("id");
	if (ipt_id == undefined || ipt_id == "")
		return "";
	if (!notChkRep && _iList.indexOf("," + ipt_id + ",") > 0)
		return;
	_iList += ipt_id + ","; // 取过值的字段都放到这里，防止取重复
	var json = "";
	switch (_value[0].type) {
	case 'submit':
		break;
	case 'button':
		break;
	case 'select-multiple':// 多选下拉
		_value.find("option").each(function(si, sv) {
			var _sv = $(sv);
			if (!_value.attr("data-all") && !_sv.prop("selected"))
				return;
			if (json != "")
				json += ",";
			json += '{"' + ipt_id + '":"' + _sv.val() + '","' + ipt_id + '_name":"' + _sv.html() + '"}';
		});
		if (json != "")
			json = '"' + ipt_id + '":[' + json + ']';
		break;

	case 'checkbox':// 复选框id相同表示为一组，提交到一个list中，data-all表示需要将未选中的也提交，否则只提交已选中的
		if (_value.parent().is("td")) {// 上级是td，表示在查询结果中。查询结果中不需要取所有的值，只需要取当前值就可以了
			ipt_id = ipt_id.split("#")[0];// 当checkbox出现在table中时，为了各行之前的lable标签的for属性不相互影响，需要加入#号区分，所以取值时需要只取#号之前的
			var bList = _value.parent().parent().find(":checkbox[id^='" + ipt_id + "']");// 同id复选框，不能跨两个上级
			if (bList.size() > 1) {// 有多个复选框时，使用list提交
				var checkBox = "";
				var _true = "";
				var _false = "";
				bList.each(function(bi, bv) {
					var _bv = $(bv);
					if (_bv.prop("checked"))
						json = joinJson(json, '{"' + ipt_id + '":"' + _bv.val() + '", "checked":"true"}');
					else if (_value.attr("data-all")) // 为提交所有数据时，才提交未选中的数据
						json = joinJson(json, '{"' + ipt_id + '":"' + _bv.val() + '", "checked":"false"}');
				});
				if (json != "")
					json = '"' + ipt_id + '":[' + json + ']';
				break;
			}
		}
		// 只有一个复选框时
		if (_value.prop("checked"))
			json = joinJson(json, '"' + ipt_id + '":"' + _value.val() + '"');
		else
			json = joinJson(json, '"' + ipt_id + '":""');// 未选中时传空
		break;
	case 'radio':
		var _value = _value.parent().parent().find(":radio[id='" + ipt_id + "']:checked");
		if (_value.prop("checked")) {
			var radioName = _value.attr("name").split("#")[0];// 当radio出现在table中时，为了各行之前不相互影响，需要加入#号区分，所以取值时需要只取#号之前的
			json = '"' + radioName + '":"' + _value.val() + '"';// id相同会影响后面的值取数，所以使用name传值
		}
		break;
	case 'textarea':
		var str = trimStr(_value.val());// 替换前后空格，替换\ " '
		if (_value.attr("data-notrepl"))
			str = _value.val();
		json = '"' + ipt_id + '":"' + trimRN(str) + '"';// 去除换行
		break;
	default:
		var str = trimStr(_value.val());
		if (_value.attr("data-notrepl"))
			str = _value.val();
		json = '"' + ipt_id + '":"' + str + '"';
		break;
	}
	return json;
}

/**
 * 取查询结果中的值
 * 
 * @param ns
 * @returns {String}
 */
function valTable(ns) {
	var json = "";
	var tJson = "";
	// 循环表单中所有查询结果
	ns.find("form table").each(function(i, v) {
		var _v = $(v);
		var id = _v.attr("id");
		if (id == "" || "tableid" == id)
			return;
		if (_v.parents("table")[0] != undefined)
			return;
		// 通过表名获取该表中所有的信息项
		tJson = valTableData(_v, ns);
		if (tJson != "")
			json = joinJson(json, '"' + id + '":' + tJson);
	});
	return json;
}

// 返回表格中所有的数据的json数据，已备传至后台
function valTableData(table_id, ns) {
	var table, trd = "[";
	if (table_id instanceof jQuery) {
		table = table_id;
	} else {
		table = ns.find("table[id='" + table_id + "']");
	}
	var thArr = table.find("thead th");
	var th = "";
	if (table.attr("id") == undefined || table.attr("id") == "")
		return "";
	var onlyInput = table.attr("data-input");
	table.find(">tbody>tr").each(function(i, v) {
		var tr = "";
		_iList = ",";
		// 取每行的值
		$(v).find(">td").each(function(di, dv) {
			var _dv = $(dv);
			var _inputArr = _dv.find(":input");
			if (_inputArr.length > 0) {// 如果有input则取input中的值
				_inputArr.each(function(ii, iv) {
					tr = joinJson(tr, valInput($(iv)));
				});
				return;
			}
			if (onlyInput)
				return;
			// 如果没有 input则直接取td中的文字
			th = $(thArr[di]);
			tr = joinJson(tr, '"' + th.attr("abbr") + '":"' + trimRN(_dv.html()) + '"');
		});
		if (tr.length > 1) {
			tr = "{" + tr + "}";
			trd += tr + ",";
		}
	});
	if (trd.length > 1)
		trd = trd.substring(0, trd.length - 1) + "]";
	if (trd == "[")
		return "";
	return trd;
}

function valTree(treeId) {
	var ztree = $.fn.zTree.getZTreeObj(treeId);// 得到树对象
	var nodes = ztree.getCheckedNodes(true);// 取到当前所有勾选的树
	var treeArray = "", treeObj = "";
	for (var i = 0; i < nodes.length; i++) {
		var isDisplay = false;
		// 下级被选择的节点不为1个 或者 下级不为半选状态 则显示，否则不显示。
		if (ztree.getNodesByFilter(filter, false, nodes[i], nodes[i].data_auth_no).length >= 1 || !nodes[i].isParent)
			isDisplay = true;
		treeObj = "{data_auth_no:'" + nodes[i].data_auth_no + "',data_auth_child:'false',is_half_check:'";
		treeObj += nodes[i].getCheckStatus().half ? 'false' : '';
		treeObj += "',is_display:'" + isDisplay + "'}";
		treeArray = joinJson(treeArray, treeObj);
	}
	treeArray = treeId + ":[" + treeArray + "]";
	return treeArray;
}

function filter(node, invokeParam) {
	if (node.parent_data_auth == invokeParam && node.checked)
		return true;
	return false;
}
/**
 * 取命名空间
 * 
 * @param btn
 * @returns
 */
function _ns(btn) {
	var namespace = btn.attr("data-ns");
	if (namespace == null || namespace == undefined)
		namespace = btn.parents("#index_Content_List>div[class='tab-pane active']").last().attr("id");
	if (namespace != null && namespace != undefined)
		return namespace;
	return "body";
}

function _nsObject(btn) {
	var page = $("#index_Content_List>div[class='tab-pane active']").last();
	var namespace = "";
	if (btn == null || btn == undefined)
		return page;
	namespace = btn.attr("data-ns");
	if (namespace != "" && namespace != null && namespace != undefined) {
		var ns = page.find("#" + namespace);
		if (ns[0] != undefined)
			return ns
	}
	return page;
}

/**
 * 初始化标签页
 */
jQuery.fn.extend({
	tabs : function() {
		var ns, data_ns = $(this).attr("data-ns");
		if (data_ns != "")
			ns = _nsObject($("<button data-ns='" + data_ns + "'/>"));
		else
			ns = _nsObject();
		var li_array = $(this).find("li");
		var data = valForm("form1", ns);
		data = joinJson(data, valTable(ns));
		if (data != null && data != undefined && data != "")
			data += ",";
		var fv = valForm("queryTerms", ns);// 前一页查询条件
		loadTab(li_array.toArray(), data, fv, ns);// 递归调用load方法，从第一个标签页开始，逐个加载标签
	}
});
/**
 * 递归加载标签页<br>
 * 解决load是异步加载，导致的前一标签页依赖后一标签页所造成的问题
 * 
 * @param li_array
 * @param data
 * @param fv
 * @param ns
 */
function loadTab(li_array, data, fv, ns) {
	var li = li_array.shift();
	if (li == undefined) {
		return;
	}
	var link = $(li).find("a").attr("href");
	if (link != "" && link != undefined)
		link = link.substring(1, link.length);
	var jsonData = str2json('{' + data + '"queryTerms":{' + fv + '}}');
	ns.find("div[id='" + link + "']").load(link + ".do", jsonData, function() {
		loadTab(li_array, data, fv, ns);
	});
}

function loading() {
	var page = _nsObject();
	var top = page.height() / 2;
	var loading = $("<div id='loadingModal' class='modal fade bs-example-modal-sm' tabindex='-1' data-backdrop='static' data-keyboard='false' role='dialog' aria-hidden='true'>"
			+ "<div style='margin-top:" + top + "px' class='modal-dialog modal-sm'><div class='modal-content'><img src='loading.gif'/>数据加载中...</div></div></div>");
	loading.modal('show');
	loading.on('hide.bs.modal', function(e) {
		$("#loadingModal").remove();
		$("div[class='modal-backdrop fade in']").remove();
	}).on('show.bs.modal', function(e) {
		$("div[class='modal-backdrop fade in']").remove();
	});

	page.append(loading);
}
function unLoading() {
	var loading = _nsObject().find("#loadingModal");
	if (loading[0] == undefined)
		return;
	loading.modal('hide');
}
