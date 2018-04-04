<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>枚举值添加</title>
</head>
<body>
  <div id="ekKROwCi">
    <!-- 提示信息区  -->
    <div id="message"></div>
    <!-- 操作区  -->
    <form id="form1" class="form-horizontal">
      <!--新增父节点和子节点是一样的，所以引用一个公用的 -->
      <jsp:include page="PubField.jsp" />
      <jsp:include page="PubButton.jsp" />

    </form>
    <!-- 温馨提示区  -->
    <div class="page-header">
      <h5>
        <small>温馨提示</small>
      </h5>
    </div>
    <div class="row">
      <ol>
        <li>字典编码：生成常量时使用，永远不会发生变化，终生唯一。</li>
        <li>字典值：具体功能使用时，存储到数据库中的值。</li>
      </ol>
    </div>
    <div id="queryTerms" class="hidden"></div>
  </div>
  <script type="text/javascript">
  $(function(){
    fillPage(${json}, "goSysEnumQuery");
  });
  </script>
</body>
</html>