<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>表单</title>
</head>
<body>
  <h1 id="ui_form" class="page-header">表单</h1>
  <p>表单使用了Bootstrap的样式，此处只列出了常用表单组件，更多详细说明请查看 <a href="http://v3.bootcss.com/css/#forms" target="_blank">Bootstrap官网</a> 针对表单的介绍。
  </p>
  <h2 id="ui_from_input" class="page-header">文本框</h2>
  <div class="bs-example">
    <div class="form-horizontal">
      <div class="row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="ui_input_text" class="col-md-5 control-label"><span class="not-null">*</span>文本框一</label>
            <div class="col-xs-12 col-md-7">
              <input type="text" class="form-control" id="ui_input_text" name="ui_input_text" placeholder="文本框一" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <ul class="nav nav-tabs" role="tablist">
      <li class="active">
        <a role="tab" data-toggle="tab">HTML</a>
      </li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active">
        <script class="brush: html;" type="syntaxhighlighter">
          <![CDATA[
<div class="form-group">
  <label for="ui_input_text" class="col-md-5 control-label"><span class="not-null">*</span>文本框一</label>
  <div class="col-xs-12 col-md-7">
    <input type="text" class="form-control" id="ui_input_text" name="ui_input_text" placeholder="文本框一" />
  </div>
</div>
            ]]></script>
      </div>
    </div>
    <div class="bs-callout bs-callout-warning">
      <p>文本框元素必须包含在 <code>form-horizontal</code> 样式下。
      </p>
    </div>
  </div>
  <h2 id="ui_from_date" class="page-header">日期</h2>
  <p>日期分为单个日期录入框和日期段两种形式，日期调用 <code>My97DatePicker</code> 插件，更多详细信息可以访问 <a href="http://www.my97.net/dp/demo/index.htm" target="_blank">My97日期控件 官方网站</a> 。
  </p>
  <h2>单个日期录入</h2>
  <div class="bs-example">
    <div class="form-horizontal">
      <div class="row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="ui_input_date" class="col-md-5 control-label"><span class="not-null">*</span>日期框一</label>
            <div class="col-xs-12 col-md-7">
              <input type="text" class="Wdate form-control" onfocus="WdatePicker()" id="ui_input_date" name="ui_input_date" placeholder="日期框一" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <ul class="nav nav-tabs" role="tablist">
      <li class="active">
        <a role="tab" data-toggle="tab">HTML</a>
      </li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active">
        <script class="brush: html;" type="syntaxhighlighter">
          <![CDATA[
<div class="form-group">
  <label for="ui_input_date" class="col-md-5 control-label"><span class="not-null">*</span>日期框一</label>
  <div class="col-xs-12 col-md-7">
    <input type="text" class="Wdate form-control" onfocus="WdatePicker()" id="ui_input_date" name="ui_input_date" placeholder="日期框一" />
  </div>
</div>
            ]]></script>
      </div>
    </div>
  </div>
  <h2>日期区间录入</h2>
  <div class="bs-example">
    <div class="form-horizontal">
      <div class="row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="ui_input_date_str" class="col-md-5 control-label">日期区间</label>
            <div class="col-md-8 hidden-md hidden-lg"></div>
            <div class="col-xs-5 col-md-3 pd-zero">
              <input type="text" class="Wdate form-control pd-zero" onfocus="WdatePicker()" id="ui_input_date_str" name="ui_input_date_str" placeholder="开始时间" />
            </div>
            <div class="col-xs-2 col-md-1 pd-zero text-center">
              <label for="ui_input_date_end" class="control-label">到</label>
            </div>
            <div class="col-xs-5 col-md-3 pd-zero">
              <input type="text" class="Wdate form-control pd-zero" onfocus="WdatePicker()" id="ui_input_date_end" name="ui_input_date_end" placeholder="结束时间">
            </div>
          </div>
        </div>
      </div>
    </div>
    <ul class="nav nav-tabs" role="tablist">
      <li class="active">
        <a role="tab" data-toggle="tab">HTML</a>
      </li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active">
        <script class="brush: html;" type="syntaxhighlighter">
          <![CDATA[
<div class="form-group">
  <label for="str_date" class="col-md-5 control-label">日期区间</label>
  <div class="col-md-8 hidden-md hidden-lg" ></div>
  <div class="col-xs-5 col-md-3 pd-zero">
    <input type="text" class="Wdate form-control pd-zero" onfocus="WdatePicker()" id="str_date" name="str_date" placeholder="开始时间" />
  </div>
  <div class="col-xs-2 col-md-1 pd-zero text-center">
    <label for="end_date" class="control-label">到</label>
  </div>
  <div class="col-xs-5 col-md-3 pd-zero">
    <input type="text" class="Wdate form-control pd-zero" onfocus="WdatePicker()" id="end_date" name="end_date" placeholder="结束时间">
  </div>
</div>
            ]]></script>
      </div>
    </div>
  </div>
  <h2 id="ui_from_select" class="page-header">下拉列表</h2>
  <p>下拉列表使用 <code>n:select</code> 标签进行显示。
  </p>
  <div class="bs-example">
    <div class="form-horizontal">
      <div class="row">
        <div class="col-md-4">
          <div class="form-group">
            <label for="ui_input_select" class="col-md-5 control-label">下拉列表</label>
            <div class="col-xs-12 col-md-7">
              <n:select id="datatype_no" up_no="con_flag" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <ul class="nav nav-tabs" role="tablist">
      <li class="active">
        <a href="#需要修改" role="tab" data-toggle="tab">HTML</a>
      </li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane active" id="需要修改">
        <script class="brush: html; highlight:4" type="syntaxhighlighter">
          <![CDATA[
<div class="form-group">
  <label for="ui_input_select" class="col-md-5 control-label">下拉列表</label>
  <div class="col-xs-12 col-md-7">
    &ltn:select id="datatype_no" up_no="con_flag" />
  </div>
</div>
            ]]></script>
      </div>
    </div>
    <div class="bs-callout bs-callout-warning">
      <p>n:select标签有以下属性可以使用：</p>
      <p><code>id</code> <code>必填</code>：设置当前下拉列表的id；在向服务器端传传时会传递此值。</p>
      <p><code>up_no</code> <code>必填</code>：设置列表内容上级的值；默认使用<code>sys_enum</code>表中<code>up_enum</code>字段的值。未设置<code>service</code>、<code>custom_no</code>值时可以使用sys_enum表中up_enum字段的值，否则不能使用。</p>
      <p><code>value</code> <code>非必填</code>：设置默认选中的值；此值维护之后，下拉列表中有与此值相同的值，则会被设置为默认选中。</p>
      <p><code>clazz</code> <code>非必填</code>：设置下拉列表的样式，对应select标签的class属性；默认为<code>form-control</code>。</p>
      <p><code>style</code> <code>非必填</code>：设置下拉列表的样式，对应select标签的style属性。</p>
      <p><code>disabled</code> <code>非必填</code>：设置是否有效。</p>
      <p><code>readonly</code> <code>非必填</code>：设置是否只读。</p>
      <p><code>notrst</code> <code>非必填</code>：设置重置时是否清空值，默认（未设置）为重置清空值；此值为空（未设置）表示重置清空值；此值不为空（值为true）表示重置不清空值。</p>
      <p><code>onchange</code> <code>非必填</code>：设置onchange事件。</p>
      <p><code>onblur</code> <code>非必填</code>：设置onblur事件。</p>
      <p><code>blankline</code> <code>非必填</code>：设置是否插入空白行，默认（未设置）为插入空白行；此值为空（未设置）表示插入空白行；此值不为空（值为false）表示不插入空白行。</p>
      <p><code>service</code> <code>非必填</code>：设置后台查询时需要调用的service；默认为<code>CustomSelect</code>，指向CustomSelectServiceImp类。可以新增类来处理个性化的下拉列表。</p>
      <p><code>custom_no</code> <code>非必填</code>：设置当前下拉列表映射的表；默认为<code>enum</code>；此值与<code>sys_select_custom</code>表内<code>custom_no</code>字段的值对应，填写的值必须在此表中有配置；sys_select_custom用于影射下拉列表，可以配置除sys_enum表外其他表的信息做为下拉列表使用。</p>
      <p><code>other</code> <code>非必填</code>：设置需要向后台传递的值；对应<code>sys_select_custom</code>表内<code>mapping_rule</code>字段，通过json字符串向后台传值。</p>
      <p><code>cache</code> <code>非必填</code>：设置是否缓存下拉列表，默认（未设置）为缓存下拉列表；此值为空（未设置）表示缓存下拉列表；此值不为空（值为false）表示不缓存下拉列表。缓存：下拉列表只在第一次使用时查询一次，后续均使用已查询的结果。不缓存：每次加载下拉列表都查询下拉列表中的值。</p>
    </div>
  </div>
</body>
</html>