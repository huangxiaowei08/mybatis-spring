/**
 * 替换空格、斜杠、单引号、双引号
 * 
 * @param str
 *            被替换字符串
 * @returns 替换完成字符串
 */
function trimStr(str) {
	if (str == null || str == undefined)
		return "";
	str = str.replace(/\\/g, "\\\\");// 替换\为空
	str = str.replace(/\"/g, "\\\"");// 替换双引号为空，json全用双引号包裹，所以单引号不需要替换
	// str = str.replace(/\'/g, "");// 替换单引号为空
	return $.trim(str);
}

/**
 * 替换换行、回车符号
 * 
 * @param str
 *            被替换字符串
 * @returns 替换完成字符串
 */
function trimRN(str) {
	if (str == null || str == undefined)
		return "";
	return str.replace(/\r/ig, "").replace(/\n/ig, "").replace(/\t/ig, "");
}

/**
 * 将json字符串转换为josn对象
 * 
 * @param strJson
 *            json字符串
 * @returns json对象
 */
function str2json(strJson) {
	console.log(strJson);
	try {
		return JSON.parse(strJson);
	} catch (e) {
		try {
			return (new Function("return " + strJson))();
		} catch (e) {
			try {
				var j = "(" + strJson + ")"; // 用括号将json字符串括起来
				return eval(j); // 返回json对象
			} catch (e) {
				updateTips("转换录入信息出错，请升级浏览器\n" + strJson);
			}
		}
	}
}

function joinStr() {
	var s = "";
	var len = arguments.length - 1;
	for (var i = 0; i <= len; i++) {
		if (arguments[i] != "" && i != len)
			s += arguments[i] + ",";
		if (arguments[i] != "" && i == len)
			s += arguments[i];
	}
	return s;
}

function joinJson(json, value) {
	if (value == "" || value == undefined || value == null)
		return json;
	if (json != "")
		json += ",";
	return json + value;
}

function callbackArg(btn) {
	var argfn = $(btn).attr("data-cbarg");
	if (argfn == "" || argfn == null)
		return "";
	var param = new Array();
	param.push(btn);
	var funcArray = argfn.split(",");
	var json = "";
	$.each(funcArray, function(i, func) {
		json = joinJson(json, doCallback(eval(func), param));
	});
	return json;
}

function callbackSuc(btn, data) {
	callback(btn, data, "data-cbsuc");
}

function callbackFail(btn, data) {
	callback(btn, data, "data-cbfail");
}

function callback(btn, data, type) {
	var argfn = $(btn).attr(type);
	if (argfn == "" || argfn == null)
		return "";
	var param = new Array();
	param.push(btn);
	if (data != undefined && data != "" && data != null)
		param.push(data);
	var _fnList = argfn.split(",");
	$.each(_fnList, function(i, fn) {
		doCallback(eval(fn), param);
	});
}

function doCallback(fn, args) {
	return fn.apply(this, args);
}
/**
 * 多级联动
 * 
 * @param select
 *            下拉列表对象
 * @param submitLast
 *            true：只提交最后一个select<br>
 *            false：(默认)提交所有select
 */
function nLevelLinkage(select, submitLast) {
	var _this = $(select);
	// 删除同级之后的元素
	if (_this.parent().attr("class") == "col-sm-3 pd-zero-left") {
		_this.parent().nextAll().remove();
		_this.attr("id", _this.attr("name"));// 将自己id和name赋成一样
	}
	var nextSelectId = _this.find("option[value='" + _this.val() + "']").attr("id");
	var nextSelect = _this.clone();
	nextSelect.empty();
	var data = '"up_no":"' + nextSelectId + '"';
	$.each(select.attributes, function(k, v) {
		data = joinJson(data, '"' + v.name + '":"' + v.value + '"');
	});
	var jsonData = str2json('{' + joinStr(data, '"funcID":"doNLevelLinkage.do"', '"rqstType":"AJAX"') + "}");
	$.ajax({
		type : "POST",
		url : "doNLevelLinkage.do",
		data : jsonData,
		dataType : "json",
		success : function(data) {
			if (data.flag != "success") {// 未成功，则提示
				alertMsg4Modal(data, _nsObject());
				return;
			}
			if (!data.data || data.data.length < 1) // 没有数据则退出
				return;
			if (_this.parent().attr("class") != "col-sm-3 pd-zero-left") {
				var div = $("<div class='col-sm-3 pd-zero-left'></div>");
				_this.parent().append(div);
				div.append(_this);
			}
			nextSelect.append("<option value=''></option>");
			$.each(data.data, function(k, v) {
				nextSelect.append("<option id='" + v.option_id + "' value='" + v.option_code + "'>" + v.option_name + "</option>");
			});
			_this.parent().parent().append(nextSelect);// 找上级
			if (submitLast) {// 不为空表示只取最后一个属性的id，需要把这个放到最后
				nextSelect.attr("id", _this.attr("name"));
				nextSelect.attr("name", _this.attr("name"));
				_this.removeAttr("id");
			} else {
				nextSelect.attr("id", nextSelectId);
				nextSelect.attr("name", nextSelectId);
			}
			_this.parent().parent().append($("<div class='col-sm-3 pd-zero-left'></div>").append(nextSelect));
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			updateTips("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = " + errorThrown);
		}
	});
}

function linkage(select, target) {
	if ($.type(target) === "string")
		target = _nsObject.fina("#" + target);
	target.empty();
	var data = '"up_no":"' + $(select).val() + '"';
	var jsonData = str2json('{' + joinStr(data, '"funcID":"doNLevelLinkage.do"', '"rqstType":"AJAX"') + "}");
	$.ajax({
		type : "POST",
		url : "doNLevelLinkage.do",
		data : jsonData,
		dataType : "json",
		success : function(data) {
			if (data.flag != "success") {// 未成功，则提示
				alertMsg4Modal(data, _nsObject());
				return;
			}
			if (!data.data || data.data.length < 1) // 没有数据则退出
				return;
			target.append("<option value=''></option>");
			$.each(data.data, function(k, v) {
				target.append("<option id='" + v.option_id + "' value='" + v.option_code + "'>" + v.option_name + "</option>");
			});
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			updateTips("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = " + errorThrown);
		}
	});
}

jQuery.fn.outerHTML = function(s) {
	return (s) ? this.before(s).remove() : jQuery("<p>").append(this.eq(0).clone()).html();
};

/**
 * 问卷问题添加，左右多选框操作样式
 */
function moveSelectOption(left, rigth) {
	$(left).find("option:selected").clone().appendTo($(rigth));
	$(left).find("option:selected").remove();
}

function moveAllOption(left, rigth) {
	$(left).find("option").clone().appendTo($(rigth));
	$(left).find("option").remove();
}