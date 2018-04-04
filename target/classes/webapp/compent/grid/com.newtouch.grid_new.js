function fillGrid(btn, grid_id, from_id) {
	var _btn = $(btn);
	_btn[0].disabled = true;
	var url = _btn.attr("name");
	var ns = _ns(_btn);
	var url = _btn.attr("name");
	var table = _btn.parents("div[class='tab-pane active']").last().find("table[id='" + grid_id + "']");
	var _columns = findTH(table, ns);
	var _qt = $("#" + ns).find("div[id='queryTerms']").last();
	var flag = _qt.find("input[id='gobackflag']");
	var json = "";
	if (flag[0] != undefined) { // 返回到查询页面的
		json = valForm("queryTerms", ns);
	} else { // 点击查询或分页
		// 去除缓存的分页信息
		_qt.find("input[id='order']").attr("name", "");
		_qt.find("input[id='nowPage']").attr("name", "");
		_qt.find("input[id='row4Page']").attr("name", "");
		json = valForm("queryTerms", ns);
		if (json == "" || json == undefined) { // 为空表示点击的是查询，不是分页按钮
			json = valForm(from_id, ns);
			json = joinJson(json, callbackArg(btn));
		}
		// var _page = 'order:"' + order + '",nowPage:"' + nowPage +
		// '",row4Page:"' + row4Page + '"';
		// if (json != "" && json != undefined)
		// json = json + "," + _page;
	}
	json += ',queryTerms:{' + json + '}';
	json += ',funcID:"' + url + '",rqstType:"AJAX"';
	$.ajax({
		"url" : url,
		"dataType" : "json",
		"type" : "POST",
		"data" : str2json("{" + json + "}"),
		success : function(data) {
			
			table.bootstrapTable({
				method : 'post',
				data : data.data,
				cache : false,
				striped : true,
				pagination : true,
				pageSize : 10,
				pageList : [ 10, 25, 50, 100, 200 ],
				showColumns : true,
				showToggle : true,
				minimumCountColumns : 2,
				clickToSelect : true,
				columns : _columns,
				pagination : true,
				totalRows : data.recordsTotal,
				sidePagination : "server"
			});
			if (data.flag != "success") {
				callbackFail(btn, data);
				alertMsg4Modal(data, ns);
				_btn[0].disabled = false;
				return;
			}
			callbackSuc(btn, data);
			_btn[0].disabled = false;
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			_btn[0].disabled = false;
		}
	});
}

function findTH(table, ns) {
	// 取表头，并判断是否显示选择框
	var trList = table.find("thead tr").last();
	var axis = "";
	var columns = [];
	$.each(trList.find("th"), function(i, v) {
		var aCol = {};
		var _v = $(v);
		aCol.field = _v.attr("abbr");
		aCol.title = _v.text();
		aCol["class"] = _v.attr("class");
		aCol.align = "left";
		aCol.halign = "left";
		aCol.valign = "middle";
		aCol.sortable = _v.attr("data-sortable") != undefined ? _v.attr("data-sortable") : "false";
		if (_v.attr("abbr") == "rn") {
			aCol.sortable = false;
			columns[i] = aCol;
			return;
		}
		axis = _v.attr("axis") != undefined ? _v.attr("axis").toLowerCase() : "";
		switch (axis) {
		case '':
			columns[i] = aCol;
			return;
		case 'checkbox':
			aCol.checkbox = "true";
			aCol.sortable = false;
			columns[i] = aCol;
			return;
		case 'button':
			var bl = [];
			_v.find("button").each(function(bi, bv) {
				var _bv = $(bv).clone();
				_bv.attr("onclick", "addInit(this)");
				_bv.attr("data-ns", ns);
				_bv.removeAttr("style");
				_bv.show();
				bl.push(_bv.outerHTML());
			});
			aCol.sortable = false;
			aCol.switchable = false;
			aCol.formatter = function(value, row, index) {
				return bl.join("");
			}
			columns[i] = aCol;
			return;
		case 'btn-group':
			_colConfig.orderable = false;
			var btnGrp = _v.find("div[class='btn-group']");
			btnGrp.find("button").removeAttr("style");
			aCol.sortable = false;
			aCol.switchable = false;
			aCol.formatter = function(value, row, index) {
				return btnGrp.outerHTML();
			}
			columns[i] = aCol;
			return;
		case 'select':// 直接显示select
			_colConfig.orderable = false;
			_v.find("select").each(function(si, sv) {
				var _sv = $(sv);
				_sv.removeAttr("style");
				_sv.show();
				aCol.sortable = false;
				aCol.formatter = function(value, row, index) {
					_sv.children("option").each(function() {
						if ($(this).val() == value)
							$(this).attr("selected", "true");
					});
					return _sv.outerHTML();
				};
				columns[i] = aCol;
			});
			return;
		case 'date':
			var len = _v.attr("data-len");
			aCol.formatter = function(value, row, index) {
				return value.substring(0, len);
			};
			columns[i] = aCol;
			return;
		case 'custom': // 自定义函数
			var func = _v.attr("data-cbsuc");
			aCol.formatter = function(value, row, index) {
				var param = new Array();
				param.push(value); // 当前单元格的值
				param.push(row);
				param.push(index); // 当前单元格所属行的值
				return doCallback(eval(func), param);
			};
			columns[i] = aCol;
			return;
		case 'hidden':
			aCol.formatter = function(value, row, index) {
				return "<input type='hidden' id='" + _v.attr("abbr") + "' name='" + _v.attr("abbr") + "' value='" + value + "'/>";
			};
			aCol["class"] = "hidden";
			aCol.switchable = false;
			columns[i] = aCol;
			return;
		case 'elps':
			var len = _v.attr("data-len");
			aCol.formatter = function(value, row, index) {
				if (!(value.length > len))
					return value;
				var a = $("<a href='#' data-toggle='tooltip' title='" + value + "'>" + value.substring(0, len) + "...</a>");
				a.tooltip();
				return a.outerHTML();
			};
			columns[i] = aCol;
			return;
		case 'href':
			aCol.formatter = function(value, row, index) {
				return "<a href='#' name='" + _v.attr("data-href") + "' onclick='addInit(this)'>" + value + "</a>";
			};
			columns[i] = aCol;
			return;
		default:
			columns[i] = aCol;
		}
	});
	return columns;
}

function checkAll(btn) {
	var _btn = $(btn);
	var checked = false;
	if (_btn.prop("checked"))
		checked = true;
	var td = _btn.parent()
	var table = td.parent().parent().parent();
	table.find("tbody tr td:nth-child(" + (td.prevAll().length + 1) + ") :checkbox").prop("checked", checked);
}

function ifCheckAll(btn) {
	var _btn = $(btn);
	var td = _btn.parent()
	var index = td.prevAll().length + 1;
	var table = td.parent().parent().parent();
	var checked = table.find("tbody tr td:nth-child(" + index + ") :not(:checked)").length == 0;
	table.find("thead tr th:nth-child(" + index + ") :checkbox").attr("checked", checked);
}
