(function( factory ) {
	if ( typeof define === "function" && define.amd ) {
		define( ["jquery", "../jquery.validate"], factory );
	} else {
		factory( jQuery );
	}
}(function( $ ) {

/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: ZH (Chinese, 中文 (Zhōngwén), 汉语, 漢語)
 */
$.extend($.validator.messages, {
	required: "不能为空",
	remote: "填写有误，请重新重写",
	email: "请填写有效的电子邮件",
	url: "请填写有效的网址",
	date: "请填写有效的日期",
	dateISO: "请填写有效的日期 (YYYY-MM-DD)",
	number: "请填写正确的数字",
	digits: "只可输入数字",
	creditcard: "请填写有效的信用卡号码",
	equalTo: "两次填写不相同",
	extension: "请填写有效的后缀",
	maxlength: $.validator.format("最多 {0} 个字"),
	minlength: $.validator.format("最少 {0} 个字"),
	rangelength: $.validator.format("长度应为 {0} ~ {1} 个字符"),
	range: $.validator.format("请填写 {0} 至 {1} 之间的数值"),
	max: $.validator.format("请填写不大于 {0} 的数值"),
	min: $.validator.format("请填写不小于 {0} 的数值")
});

}));