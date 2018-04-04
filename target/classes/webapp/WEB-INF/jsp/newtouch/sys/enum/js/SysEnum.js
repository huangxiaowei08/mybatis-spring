var ly4RNkiD_chkenable = _nsObject().find("#tree_enum_config").attr("data-chkenable");
if (ly4RNkiD_chkenable == undefined) {
	ly4RNkiD_chkenable = false;
}
var zTree_enum;
var setting_enum = {
	view : {
		dblClickExpand : false
	},
	callback : {
		beforeRightClick : function(treeId, treeNode) {
			if (!treeNode)
				return;
			console.log("test=" + treeNode);
			zTree_enum.selectNode(treeNode, false);
			_nsObject().find("ul[id^=]").remove();
			context.attach("#" + treeNode.tId + " a", [ {
				text : '增加字典',
				action : function() {
					initConsole_enum("goSysSubEnumAdd.do", treeNode);
				}
			}, {
				text : '修改字典',
				href : '#',
				action : function() {
					initConsole_enum("goSysEnumMdf.do", treeNode);
				}
			} ]);
		}
	},
	data : {
		key : {
			name : "enum_name"
		},
		simpleData : {
			enable : true,
			idKey : "enum_no",
			pIdKey : "up_enum",
			rootPId : null
		}
	},
	check : {
		enable : ly4RNkiD_chkenable
	}
};

function checkTreeNode_De3CcxY8(treeId, treeNode) {
	var treeObj = $.fn.zTree.getZTreeObj(treeId);
	if (treeNode.parentTId == null) {// 如果没有父节点，则取消所有节点的选择
		treeObj.checkAllNodes(false);
		return true;
	}
	// 如果有父节点，则判断当前已勾选的节点是否为相同父节点，如果不是，就取消所有选择，如果是，则不处理
	var nodes = treeObj.getCheckedNodes(true);
	for (var i = 0; i < nodes.length; i++) {
		if (nodes[i].parentTId != treeNode.parentTId && nodes[i].tId != treeNode.parentTId) {
			treeObj.checkAllNodes(false);
			return true;
		}
	}

	return true;
}

// 初始化右侧菜单录入区域
function initConsole_enum(action, treeNode) {
	_nsObject().find("#console").empty();// 清空当前操作区
	if (action == '' || action == undefined)
		return;
	var enum_no = "";
	var up_enum_name = "";
	if (treeNode != undefined && treeNode != null) {
		enum_no = treeNode.enum_no;
		up_enum_name = treeNode.enum_name;
	}
	var jsonData = str2json("{funcID:'" + action + "',enum_no:'" + enum_no + "',up_enum_name:'" + up_enum_name + "',up_enum:'" + enum_no + "'}");
	_nsObject().find("div[id='console']").load(action, jsonData, null);
}

function initTree_enum() {
	var jsonData = str2json("{funcID:'goSysEnumQuery.do',rqstType:'AJAX'}");
	setTimeout('', 5000);
	$.ajax({
		type : "POST",
		url : "goSysEnumQuery.do",
		data : jsonData,
		dataType : "json",
		success : function(data) {
			if (data.data == undefined)
				return;
			ly4RNkiD_chkenable = _nsObject().find("#tree_enum_config").attr("data-chkenable");
			if (ly4RNkiD_chkenable == undefined) {
				ly4RNkiD_chkenable = false;
			}
			setting_enum.check.enable = ly4RNkiD_chkenable;
			zTree_enum = $.fn.zTree.init(_nsObject().find("#tree_enum_config"), setting_enum, data.data);
		}
	});

}