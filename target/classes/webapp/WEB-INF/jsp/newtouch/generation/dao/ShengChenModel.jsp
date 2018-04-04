<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="body">
  <h1>生成Model</h1>
  <div id="index_Content_List">
    <div class="tab-pane active">
      <div class="form-horizontal">
        <form id="form1" action="" method="post" class="well">
          <div class="form-group">
            <label for="table_schema" class="col-sm-2 control-label">数据库</label>
            <div class="col-sm-10">
              <input id="table_schema" name="table_schema" class="form-control" value="picc_db_98" data-rule-required="true"
                data-notrst="true" />
            </div>
          </div>
          <div class="form-group">
            <label for="source_folder" class="col-sm-2 control-label">项目根目录</label>
            <div class="col-sm-10">
              <input id="source_folder" name="source_folder" class="form-control" data-rule-required="true" data-notrst="true" />
            </div>
          </div>

          <div class="form-group">
            <label for="baseClm" class="col-sm-2 control-label">基本列</label>
            <div class="col-sm-10">
              <select id="baseClm" name="baseClm" class="form-control">
                <option value="serno,crt_date,mdf_date,crt_user,mdf_user,data_flag">serno,crt_date,mdf_date,crt_user,mdf_user,data_flag</option>
              </select> <span>顺序必须为“序号、创建日期、修改日期、创建操作员、修改操作员、数据有效标志”</span>
            </div>
          </div>
          <div class="form-group">
            <label for="dbSourceType" class="col-sm-2 control-label">数据源</label>
            <div class="col-sm-10">
              <input id="dbSourceType" class="form-control" name="dbSourceType" value="dataSource" />
            </div>
          </div>
          <div class="form-group">
            <label for="package_no" class="col-sm-2 control-label">包路径</label>
            <div class="col-sm-10">
              <select id="daoDir" name="daoDir" class="form-control">
                <option value="com.newtouch.sys.model">系统表</option>
                <option value="com.newtouch.design.model">设计器</option>
                <option value="com.newtouch.login.controller">登录</option>
                <option value="com.picc.interfaces">核心接口</option>
                <option value="com.picc.policy.model">移动出单</option>
                <option value="com.newtouch.product.model">产品配置</option>
                <option value="com.newtouch.db.model">分库</option>
                <option value="com.newtouch.security.model">权限</option>
                <option value="com.newtouch.disclose.model">告知</option>
                <option value="com.newtouch.fna.model">fna</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="package_no" class="col-sm-2 control-label">生成表</label>
            <div class="col-sm-10">
              <select id="tables" name="tables" class="form-control">
                <option
                  value="sys_data_change_track,sys_enum,sys_error_code,sys_opt_log,sys_select_custom,sys_uniquetable,sys_file_repostry,sys_startup_run">系统表</option>
                <option
                  value="dsn_attribute_option,dsn_attribute,dsn_biz_attribute_option,dsn_biz_attribute_rules,dsn_biz_attribute,dsn_dynamic_data,dsn_dynamic_describe,dsn_structure,sys_tree_menu">设计器</option>
                <option value="rms_user,rms_messages,rms_password_error,rms_login_log">登录</option>
                <option value="t_log_msg">核心接口</option>
                <option value="crm_customer_natural">客户自然信息表</option>
                <option value="push_messages,push_message_detail">消息提醒</option>
                <option value="cms_information_group,cms_information,cms_information_annex,sys_file_repostry">资讯组信息</option>
                <option value="pol_policy_party">核保信息表</option>
                <option
                  value="sip_attribute_option,sip_attribute,sip_biz_attribute_option,sip_biz_attribute_rules,sip_biz_attribute,sip_dynamic_data,sip_dynamic_describe,sip_product_risks,sip_product_structure,sip_products,sip_risk_relation,sip_risk_rule_trigge,sip_risk_rules,sip_risks">产品配置</option>
                <option value="ws_organ_dept">核保职业信息表</option>
                <option value="db_database,db_sharding">分库</option>
                <option
                  value="rms_grant_roles,rms_login_log,rms_menu,rms_messages,rms_password_error,rms_password_hist,rms_resources,rms_resources_auth,rms_resources_data,rms_roles,rms_search_history,rms_user,rms_user_natural,rms_user_roles,rms_user_settings">权限</option>
                <option
                  value="tr_exam_paper,tr_exam_paper_ans_result,tr_exam_paper_answer,tr_exam_paper_group,tr_exam_paper_qu_setting,tr_exam_paper_qu_show,tr_exam_paper_question,tr_question_blank_option,tr_question_blanks,tr_question_option,tr_questions">告知</option>
                <option value="pol_info_maintain">维护</option>
                <option value="fna_recommend_product,fna_product_type">子女教育</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="use_ftl" class="col-sm-2 control-label">使用模板</label>
            <div class="col-sm-10">
              <select id="use_ftl" name="use_ftl" class="form-control">
                <option value="AbsModelSample.ftl">java jpa</option>
                <option value="AbsDaoSample.ftl">java</option>
                <option value="IOSDaoSample.h.ftl">ios.h</option>
                <option value="IOSDaoSample.m.ftl">ios.m</option>
                <option value="AndroidDaoSample.ftl">android</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
              <button type="button" onclick="add(this)" data-ns="index_Content_List" name="dodaopage.controller"
                class="btn btn-default btn-xs">保存</button>
            </div>
          </div>
          <input type="hidden" id="__SubmitJsonStr" />
        </form>
      </div>
    </div>
  </div>
  <button type="button" onclick="eeee()" name="dodaopage.controller" class="btn btn-default btn-xs">test</button>

</body>
<script type="text/javascript">
	function eeee() {
		alert(eval("(4<2 && 5>8) || (2<3 && 4!=5)"));
	}
</script>
</html>