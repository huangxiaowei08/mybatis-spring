/**
 * 公用树组件
 */

(function($) {
	var menuCache = function(action) {
		var treeMenuCache = {};
		return function(node_type, treeNode) {
			if (treeMenuCache[node_type] != undefined)
				return treeMenuCache[node_type];
			if (!treeNode)
				treeNode = {};
			var jsonData = str2json('{"node_type":"' + node_type + '","rqstType":"AJAX"}');
			$.ajax({
				type : "POST",
				url : "tree/doTreeMenuQuery.do",
				data : jsonData,
				dataType : "json",
				async : false,
				success : function(data) {
					if (data.flag == "success") {// 保存成功
						var menus = new Array();
						$.each(data.data, function(i, v) {
							var menu = {};
							menu.treeNode = treeNode;
							menu.text = v.menu_name;
							menu.action = function() {
								var _treeNode = {};
								$.extend(true, _treeNode, menu.treeNode);
								delete _treeNode.getNextNode;
								delete _treeNode.getParentNode;
								delete _treeNode.children;
								delete _treeNode.getPreNode;
								delete _treeNode.mdf_date;
								delete _treeNode.mdf_user;
								delete _treeNode.crt_date;
								delete _treeNode.crt_user;
								delete _treeNode.patch_memo;
								delete _treeNode.data_flag;
								// 新增节点页面，显示属性名称时需要使用
								_treeNode.menu_info = {
									"menu_name" : v.menu_name,
									"node_type" : v.node_type
								};
								action(v.request_mapping, _treeNode);
							};
							menus.push(menu);
						});
						treeMenuCache[node_type] = menus;
						return;
					}
					alertMsg4Modal(data, ns);// 提示失效信息
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					updateTips("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = "
							+ errorThrown);
				}
			});
			return treeMenuCache[node_type];
		}
	};
	var defSetting = {
		view : {
			dblClickExpand : false
		},
		data : {
			key : {
				name : "node_name",
				title : "node_name"
			},
			showTitle : true,
			simpleData : {
				enable : true,
				idKey : "node_no",
				pIdKey : "up_node",
				nodeType : "node_type",
				rootPId : null
			}
		}
	};
	// 树节点
	var initTree = function(zSetting, data) {
		var obj = $(this);
		var zTreeObj;
		var ns = _nsObject();// 缓存当前页面对象
		/**
		 * 删除选中节点
		 */
		var delSelectNodes = function(action, treeNode, zTreeObj) {
			treeNode.funcID = action;
			treeNode.rqstType = "AJAX";
			$.ajax({
				type : "POST",
				url : action,
				data : treeNode,
				dataType : "json",
				success : function(data) {
					if (data.flag == "success") {// 保存成功
						alertMsg4Modal(data, _nsObject());// 提示成功信息
						var nodes = zTreeObj.getSelectedNodes();
						for (var i = 0, l = nodes.length; i < l; i++) {
							// 删除选中的节点
							zTreeObj.removeNode(nodes[i]);
						}
						_nsObject().find("#console").empty();// 清空当前操作区
						return;
					}
					alertMsg4Modal(data, _nsObject());// 提示失效信息
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					updateTips("status = " + XMLHttpRequest.status + " | readyState = " + XMLHttpRequest.readyState + " | textStatus = " + textStatus + " | errorThrown = "
							+ errorThrown);
				}
			});
		}
		var initConsole = function(action, treeNode) {
			ns.find("#console").empty();// 清空当前操作区
			if (action == '' || action == undefined)
				return;
			if (!treeNode)
				treeNode = {};
			treeNode.funcID = action;
			delete treeNode.rqstType;
			if (action.indexOf("doDel") >= 0) {
				// 执行删除操作
				delSelectNodes(action, treeNode, zTreeObj);
			} else {
				// 执行删除以外的其他操作
				var page = $("<div id='" + action.substring(0, action.length - 3) + "'></div>");
				page.load(action, treeNode, function() {
					ns.find("div[id='console']").append(page);
				});
			}
		};
		var _menuCache = menuCache(initConsole);
		// 所有右键回调都使用这个
		var defInitMenu = {
			callback : {
				beforeRightClick : function(treeId, treeNode) {
					if (!treeNode)
						return;
					zTreeObj.selectNode(treeNode, false);
					ns.find("ul[id^='dropdown-']").remove();
					var menu = _menuCache(treeNode[setting.data.simpleData.nodeType], treeNode);
					if (menu != null && menu != undefined && menu.length > 0) {
						$.each(menu, function(i, k) {
							menu[i].treeNode = treeNode;
						});
						context.attach("#" + treeNode.tId + " a", menu, ns);
					}
				}
			}
		};
		var setting = {};
		$.extend(true, setting, defSetting, zSetting, defInitMenu);
		var parentid = obj.attr("id") + "_parent";
		var objParent = obj.parent();
		objParent.attr("id", parentid);
		objParent.mousedown(function(event, a) {
			if (event.which == 1 || a == 'left')
				return;
			if (event.which == 3 || a == 'right')
				context.attach("#" + parentid, _menuCache(obj.attr("data-nodeType"), {
					"node_type" : obj.attr("data-nodeType")
				}), ns);// 空白处右键
		});
		zTreeObj = $.fn.zTree.init(obj, setting, data);
		var reloadNode = function(reloadUrl) {
			if (!reloadUrl)
				throw new Error("重新加载路径不能为空！");
			// 找到当前选择的节点
			var nodes = zTreeObj.getSelectedNodes();
			if (!nodes)
				return;
			if (nodes.length <= 0)
				return;
			if (!nodes[0])
				return;
			setTimeout("", 500);
			var selectNode = nodes[0];
			// 找到当前选择的节点
			var node_no = selectNode[setting.data.simpleData.idKey];
			if (!node_no)// 当前节点不存在，则取上级节点
				node_no = selectNode[setting.data.simpleData.pIdKey];
			// 执行初始化节点方法
			selectNode.funcID = reloadUrl;// 需要修改
			selectNode.rqstType = "AJAX";
			// 自动展开上级节点
			$.ajax({
				type : "POST",
				url : reloadUrl,
				data : selectNode,
				dataType : "json",
				success : function(data) {
					if (data.data == undefined)
						return;
					var nextNode = "nextNode";
					// 取目前已经有的下级，拼接成字符串
					if (selectNode.children != undefined) {
						var valNextNode = function(childrenNode) {
							$.each(childrenNode, function(i, v) {
								nextNode += v[setting.data.simpleData.idKey] + "#";
								if (v.isParent)
									valNextNode(v.children);
							});
						}
						valNextNode(selectNode.children);
					}
					var newNodes = new Array();
					// 判断新的下级里，如果包含已有下级，则不放进去
					$.each(data.data, function(i, v) {
						if (nextNode.indexOf(v[setting.data.simpleData.idKey]) < 0) {
							newNodes.push(v);
						}
					});
					if (newNodes.length > 0)
						zTreeObj.addNodes(selectNode, newNodes, false);
				}
			});
		}
		var deleteNode = function() {
			zTreeObj.removeNode(zTreeObj.getSelectedNodes());
		}
		return {
			tree : zTreeObj,
			reloadNode : reloadNode,
			deleteNode : deleteNode
		};
	};
	$.fn.nTree = initTree;
})(jQuery);
