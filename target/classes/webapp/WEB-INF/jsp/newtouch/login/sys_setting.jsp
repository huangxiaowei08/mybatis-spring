<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
  <li>
    <a href="#" class="dropdown-toggle"> <i class="fa fa-desktop"></i> <span class="menu-text"> 基础功能 </span> <b
      class="arrow fa fa-angle-down"></b>
    </a>
    <ul class="submenu">
      <li>
        <a href="#" onclick="createTable('字典维护', 'goSysEnumQuery.do')"> <i class="fa-angle-double-right fa"></i> 字典维护
        </a>
      </li>
      <li>
        <a href="#" onclick="createTable('常量生成', 'goSysConst.do')"> <i class="fa-angle-double-right fa"></i> 常量生成
        </a>
      </li>
      <li>
        <a href="#" onclick="createTable('数据库配置', 'dataconfigQuery.do')"> <i class="fa-angle-double-right fa"></i> 数据库配置
        </a>
      </li>
      <li>
        <a href="#" onclick="createTable('启动设置', 'goStartSysTask.do')"> <i class="fa-angle-double-right fa"></i> 启动设置
        </a>
      </li>
      <li>
        <a href="#" onclick="createTable('接口测试', 'goTestService.do')"> <i class="fa-angle-double-right fa"></i> 接口测试
        </a>
      </li>
      <li>
        <a href="#" onclick="createTable('生成Model', 'goModelPage.controller')"> <i class="fa-angle-double-right fa"></i> 生成Model
        </a>
      </li>
    </ul>
  </li>




</body>
</html>