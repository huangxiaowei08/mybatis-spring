function cancelActiveTab() {
	var aActLi = $("#index_Tab_List li[class='active']"); // 当前活动li标签
	var aActDiv = $("#index_Content_List div[class='tab-pane active']").first(); // 当前活动div标签
	if (aActLi[0] != undefined) // 存在活动li标签则取消
		aActLi.removeAttr("class");
	if (aActDiv[0] != undefined) // 存在活动div标签则取消
		aActDiv.attr("class", "tab-pane");
}

function createActiveTab(id, name, url) {
	// 判断数量，确定是否能够新加，以及新的位置，暂不实现
	// 创建新标签
	var tabList = $("#index_Tab_List");
	tabList
			.append("<li class='active'><a href='#"
					+ id
					+ "' data-toggle='tab'>"
					+ name
					+ "</a><div style='position:absolute;top:15.5px;right:0px;' class='pull-right'><b class='close' onclick='removeTable(\""
					+ id + "\")'>&times;</b></div></li>");
	var contentList = $("#index_Content_List");
	contentList.append("<div class='tab-pane active' id='" + id + "'></div>");
	loadTabContent(contentList, id, url);
}

function loadTabContent(list, id, url) {
	list.find("div[id='" + id + "']").load(url + "?funcName=" + url);
}

function removeTable(id) {
	var li = $("#index_Tab_List a[href='#" + id + "']").parent();
	var div = $("#index_Content_List div[id='" + id + "']");
	if (li.attr("class") == "active") {
		li.prev().attr("class", "active");
		div.prev().attr("class", "tab-pane active");
	}
	li.remove();
	div.remove();
}

function createTable(title, url) {
	var id = url.substring(0, url.length - 3).replace(/\//g,"");
	var aA = $("#index_Tab_List a[href='#" + id + "']"); // 当前要生效的a标签
	var aDiv = $("#index_Content_List div[id='" + id + "']"); // 当前要生效的DIV标签
	if (aA[0] != undefined) { // 表示已存在，则直接显示
		var parentLi = aA.parent();
		if (parentLi.attr("class") == "active") // 当前要生效的已是活动标签，则不继续
			return;
		cancelActiveTab();// 取消当前生效的tab
		parentLi.attr("class", "active"); // 将当前设置成活动标签
		if (aDiv[0] != undefined)
			aDiv.attr("class", "tab-pane active");
		return;
	}
	cancelActiveTab();// 取消当前生效的tab
	createActiveTab(id, title, url);
	if (!$("#sidebar").hasClass("menu-min"))
		$("#sidebar").addClass("menu-min");
	sidebar_hidden();
}

function sidebar_collapsed() {
	var c = $("#sidebar").hasClass("menu-min");
	var e = $("#sidebar");
	var d = $("#sidebar-collapse").find("i");
	var b = d.attr("data-icon1");
	var a = d.attr("data-icon2");
	if (!c) {
		e.attr("class", e.attr("class") + " menu-min");
		d.attr("class", a);
	} else {
		e.attr("class", e.attr("class").replace(" menu-min", ""));
		d.attr("class", b);
	}
}

function sidebar_hidden(){
	if($("#sidebar").css("display")=="none"){
		$("#sidebar").css("display","block");
		$("#sidebar_p").css("display","block");
		$("#sidebar_hidden").css("display","block");
	}else{
		$("#sidebar").css("display","none");
		$("#sidebar_p").css("display","none");
		$("#sidebar_hidden").css("display","none");
	}
}

$(function (){
	$(".nav-list").on("click", function(h){
		var g = $(h.target).closest("a");
		if (!g || g.length == 0) {
			return
		}
		var c = $("#sidebar").hasClass("menu-min");
		if (!g.hasClass("dropdown-toggle")) {
			return
		}
		var f = g.next().get(0);
		if (!$(f).is(":visible")) {
			var d = $(f.parentNode).closest("ul");
			if (c && d.hasClass("nav-list")) {
				return
			}
			d.find("> .open > .submenu").each(function() {
				if (this != f && !$(this.parentNode).hasClass("active")) {
					$(this).slideUp(200).parent().removeClass("open");
				}
			});
		} else {}
		if (c && $(f.parentNode.parentNode).hasClass("nav-list")) {
			return false;
		}
		$(f).slideToggle(200).parent().toggleClass("open");
		return false;
	});
	$("#menu-toggler").on("click", function() {
		sidebar_hidden();
	});
	$("#sidebar_hidden").on("click", function() {
		sidebar_hidden();
	});
});
