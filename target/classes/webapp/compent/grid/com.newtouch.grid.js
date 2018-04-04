function fillGrid(btn, grid_id, from_id) {
  // var start = new Date();
  var _btn = $(btn);
  _btn[0].disabled = true;
  var url = _btn.attr("name");
  var ns = _nsObject(_btn);
  var table = ns.find("table[id='" + grid_id + "']");
  table.find("tbody").empty();
  var col = [];
  var title = [];
  var _rnNo = findTH(grid_id, ns, title, col);
  var func = table.attr("data-cbsuc");
  var index = table.find("thead tr th :checkbox").first().parent().prevAll().length + 1;
  // 从前一页面返回，则取上一次查询的值赋当前页面显示记录数
  var displayLength = ns.find("#queryTerms #row4Page").val();
  if (displayLength == undefined || displayLength == "")
    displayLength = 10;
  var tab = table.DataTable({
    "processing": "true",
    "serverSide": "true",
    "aLengthMenu": [10, 30, 50, 100],
    "iDisplayLength": displayLength,
    "order": [_rnNo, 'asc'],
    "ajax": function (page, _callback, settings) {
      var order = page.columns[page.order[0].column].data + " " + page.order[0].dir;
      var row4Page = page.length;
      var nowPage = page.start / row4Page + 1;
      // 在一个页面有多个查询时，会就存在多个queryTerms，只能取命名空间内最后一个，否则会取错。
      var _qt = ns.find("div[id='queryTerms']").last();
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
        var _page = 'order:"' + order + '",nowPage:"' + nowPage + '",row4Page:"' + row4Page + '"';
        if (json != "" && json != undefined)
          json = json + "," + _page;
      }
      json += ',queryTerms:{' + json + '}';
      json += ',funcID:"' + url + '",rqstType:"AJAX"';
      $.ajax({
        "url": url,
        "async": "false",
        "dataType": "json",
        "type": "POST",
        "data": str2json("{" + json + "}"),
        success: function (data) {
          if (data.flag != "success") {
            callbackFail(btn, data);
            alertMsg4Modal(data, ns);
            _btn[0].disabled = false;
            return;
          }
          settings.json = data;
          callbackSuc(btn, data);
          _callback(data);
          _btn[0].disabled = false;
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
          _btn[0].disabled = false;
        }
      });
    },
    "columns": title,
    "columnDefs": col,
    "drawCallback": function (settings) {
      var json = settings.json;
      if (json == undefined)
        return;
      var qt = ns.find("div[id='queryTerms']").last();
      var flag = qt.find("input[id='gobackflag']");
      qt.empty();
      var _from = ns.find("[id='" + from_id + "']");
      $.each(json.queryTerms, function (i, v) {
        qt.append("<input id='" + i + "' name='" + i + "' value='" + v + "' type='hidden' data-notrepl='true'/>");
        _from.find("[id='" + i + "']").val(v);
      });
      var json = "";
      if (flag[0] != undefined) { // 返回到查询页面的
        var nowPage = qt.find("input[id='nowPage']").val();
        if (nowPage == 1)
          return;
        var ul = ns.find("ul[class='pagination']");
        ul.find("li[class='paginate_button active']").toggleClass("active");
        ul.find("li:contains(" + nowPage + ")").each(function (i, v) {
          var _v = $(v);
          if (_v.find("a").text() != nowPage)
            return true;
          _v.toggleClass("active");
          return false;
        });
      }
      // 取消全选按钮
      var checkbox = table.find("tbody tr td:nth-child(" + index + ") :checkbox").first();
      ifCheckAll(checkbox[0]);
      // $(".DTFC_ScrollWrapper").css("height", "100%");
      // var end = new Date();
      // $("small").prepend("本次查询用时" + ((end.getTime() - start.getTime())
      // /
      // 1000.00) + "秒,");
    }, "createdRow": function (row, data, dataIndex) {
      if (func == null || func == undefined || func == "")
        return
      var param = new Array();
      param.push(row);
      param.push(data);
      param.push(dataIndex);
      doCallback(eval(func), param);
    },
    "oLanguage": {
      "sEmptyTable": "",
      "sLengthMenu": " _MENU_ ",
      "sSearch": "",
      "sZeroRecords": "未检索到数据.",
      "sInfo": "共[_TOTAL_]条记录,当前显示[_START_ - _END_]条.",
      "sInfoEmpty": "共[0]条记录.",
      "sInfoFiltered": "在[_MAX_]条记录中筛选."
    }
  });
  _btn.one("mousedown", function () {
    tab.destroy();
  });
}

function findTH(grid_id, ns, title, col) {
  // 取表头，并判断是否显示选择框
  var trList = ns.find("table[id=" + grid_id + "] thead tr").last();
  var axis = "";
  var _rnNo = 0;
  $.each(trList.find("th"), function (i, v) {
    var _v = $(v);
    title.push({
      "data": _v.attr("abbr")
    });
    var className = _v.attr("class");
    var _colConfig = {
      "className": className,
      "aTargets": [i]
    };
    if (_v.attr("abbr") == "rn") {
      _rnNo = i;
      _colConfig.orderable = false;
      col.push(_colConfig);
      return;
    }
    axis = _v.attr("axis") != undefined ? _v.attr("axis").toLowerCase() : "";
    if (_v.attr("data-order") == "false")
      _colConfig.orderable = false;// 设置哪些列不排序
    switch (axis) {
      case '':
        col.push(_colConfig);
        break;
      case 'checkbox':
        _colConfig.orderable = false;
        var _c = _v.find("[type='checkbox']").clone();
        var showBox = _v.attr("data-showbox");
        var id = _v.attr("abbr");
        var onclick = _c.attr("onclick");
        if (onclick == undefined)
          onclick = "";
        if (onclick == "checkAll(this)" || onclick.indexOf("check4ID") >= 0)
          _c.removeAttr("onclick");
        _c.attr("onclick", "ifCheckAll(this)");
        _c.show();
        if (showBox != undefined && showBox == "false")
          _c.hide();
        if (_c.attr("id") == undefined)
          id = "checkbox";
        _c.attr("id", id);
        _c.attr("class", "checkbox");
        _colConfig.mRender = function (cell, type, row) {
          var checked = false;
          if (cell != undefined && (cell.toLowerCase() === "true" || cell === "Y"))
            checked = true;
          _c.prop("checked", checked);
          _c.attr("checked", checked);
          _c.val(cell);
          _c.attr("value", cell);
          _c.attr("name", id + "_" + row["rn"]);
          return _c.outerHTML();
        };
        col.push(_colConfig);
        break;
      case 'button':
        _colConfig.orderable = false;
        var bl = [];
        _v.find("button").each(function (bi, bv) {
          var _bv = $(bv).clone();
          if (_bv.attr("onclick") == undefined || _bv.attr("onclick") == "")
            _bv.attr("onclick", "addInit(this)");
          if (_bv.attr("data-ns") == undefined || _bv.attr("data-ns") == "")
            _bv.attr("data-ns", ns.attr("id"));
          _bv.removeAttr("style");
          _bv.show();
          bl.push(_bv.outerHTML());
        });
        _colConfig.mRender = function (cell, type, row) {
          return bl.join("");
        };
        col.push(_colConfig);
        break;
      case 'btn-group':
        _colConfig.orderable = false;
        var btnGrp = _v.find("div[class*='btn-group']").clone();
        btnGrp.find(":button").removeAttr("style");
        btnGrp.removeAttr("style");
        btnGrp.find("a").each(function (i, a) {
          var $a = $(a);
          if ($a.attr("onclick") == undefined || $a.attr("onclick") == "")
            $a.attr("onclick", "addInit(this)");
          var href = $a.attr("href");
          $a.attr("name", href);
          $a.attr("href", "#");
        });
        _colConfig.mRender = function (cell, type, row) {
          return btnGrp.outerHTML();
        };
        col.push(_colConfig);
        break;
      case 'select':// 直接显示select
        _colConfig.orderable = false;
        _v.find("select").each(function (si, sv) {
          var _sv = $(sv).clone();
          _sv.removeAttr("style");
          _sv.show();
          _colConfig.mRender = function (cell, type, row) {
            _sv.children("option").each(function () {
              if ($(this).val() == cell)
                $(this).attr("selected", "true");
              else
                $(this).removeAttr("selected");
            });
            return _sv.outerHTML();
          };
          col.push(_colConfig);
        });
        break;
      case 'date': // 自定义函数
        var len = _v.attr("data-len");
        _colConfig.mRender = function (cell, type, row) {
          _sv.children("option").each(function () {
            if (cell == "" || cell == undefined || cell == null)
              return "";
            return cell.substring(0, len);
          });
          return _sv.outerHTML();
        };
        col.push(_colConfig);
        break;
      case 'custom': // 自定义函数
        var func = _v.attr("data-cbsuc");
        _colConfig.mRender = function (cell, type, row) {
          var param = new Array();
          param.push(cell); // 当前单元格的值
          param.push(type);
          param.push(row); // 当前单元格所属行的值
          param.push(_v); // tr表头
          return doCallback(eval(func), param);
        };
        col.push(_colConfig);
        break;
      case 'hidden': // 自定义函数
        _colConfig.mRender = function (cell, type, row) {
          return "<input type='hidden' id='" + _v.attr("abbr") + "' name='" + _v.attr("abbr") + "' value='"
            + cell + "'/>";
        };
        _colConfig.createdCell = function (td, cellData, rowData, row, col) {
          $(td).attr("class", "hidden");
        };
        col.push(_colConfig);
        break;
      case 'elps':
        var len = _v.attr("data-len");
        _colConfig.mRender = function (cell, type, row) {
          if (!(cell.length > len))
            return cell;
          return "<a href='#' data-toggle='tooltip' title='" + cell + "'>" + cell.substring(0, len) + "...</a>";
        };
        _colConfig.createdCell = function (td, cellData, rowData, row, col) {
          $(td).find("a").tooltip();
        };
        col.push(_colConfig);
        break;
      case 'popover':
        var len = _v.attr("data-len");
        _colConfig.mRender = function (cell, type, row) {
          if (!(cell.length > len))
            return cell;
          return "<a href='#' data-toggle='popover' data-trigger='focus' title='弹出框' data-content='" + cell + "'>" + cell.substring(0, len) + "...</a>";
        };
        _colConfig.createdCell = function (td, cellData, rowData, row, col) {
          $(td).find("a").popover();
        };
        col.push(_colConfig);
        break;
      case 'href':
        _colConfig.mRender = function (cell, type, row) {
          return "<a href='#' name='" + _v.attr("data-href") + "' onclick='addInit(this)' data-ns='" + ns.attr("id") + "'>"
            + cell + "</a>";
        };
        col.push(_colConfig);
        break;
      case 'href_blank':
        _colConfig.mRender = function (cell, type, row) {
          return "<a href='#' name='" + _v.attr("data-href") + "' onclick='hrefBlank(this)' data-ns='" + ns.attr("id") + "' target='_blank'>"
            + cell + "</a>";
        };
        col.push(_colConfig);
        break;
      default:
        if (className == null || className == "")
          break;
        col.push(_colConfig);
    }
  });
  return _rnNo;
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

function hrefBlank(btn) {
  var _this = $(btn);
  _this[0].disabled = true;
  var ns = _nsObject(_this);
  var url = _this.attr("name");
  var data = valForm("form1", ns); // 取查询条件中的值，用于后台业务逻辑使用
  data = joinJson(data, valTRHide(btn)); // 取当前按钮所在行的值，修改时使用
  // _this.attr("href", "goHrefBlank.do?funcID=" + url + "&data="+data);
  // _this.click();
  window.open("goHrefBlank.do?funcID=" + url + "&data=" + data);
}
