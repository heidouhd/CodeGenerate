#set ($cdoLoginer = $baseController.getLoginer($request))
#set ($lBorrowerId=$request.getParameter("lBorrowerId"))
#set ($lDebtCaseId=$request.getParameter("lDebtCaseId"))
#set ($chooseTimeCx=$request.getParameter("dtLoanDate"))
#set ($strSource=$request.getParameter("strSource"))
#set ($strBorrowerName=$request.getParameter("strBorrowerName"))
#set ($strBorrowerPhone=$request.getParameter("strBorrowerPhone"))
#set ($strBorrowerCardNo=$request.getParameter("strBorrowerCardNo"))
#set ($lFianceV2=$request.getParameter("lFianceV2"))
#set ($lMobileTerminal=$request.getParameter("lMobileTerminal"))
#set ($strBatchCode=$request.getParameter("strBatchCode"))
#set ($repaymentMode=$request.getParameter("repaymentMode"))
#set ($lOverdueAmount=$request.getParameter("lOverdueAmount"))
#set ($${table.name?substring(2)?cap_first}=$${table.name?substring(2)?cap_first}Controller.view${table.name?substring(2)?cap_first}($request))
#set ($lId=$request.getParameter("lId"))
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>编辑${table.remark}</title>
    <meta name="description" content="编辑${table.remark}">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <script type="text/javascript" src="http://static.dafy.com/upload/swfobject.js"></script>
    <script type="text/javascript" src="http://static.dafy.com/upload/FileUpload.js"></script>
    <link rel="stylesheet" href="../../assets/css/amazeui.min.css"/>
    <link rel="stylesheet" href="../../assets/css/admin.css">
    <link rel="stylesheet" href="http://static.dafy.com/jstab/jquery-ui.css" />
    <link rel="stylesheet" href="http://static.dafy.com/jstab/jqgrid/jqgrid.css" />
    <link rel="stylesheet" href="../../js/layui/css/layui.css">

    <script type="text/javascript" src="../../assets/js/jquery.min.js"></script>
    <script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../../assets/js/bootstrap.min.js"></script>
    <script src="../../js/foundation-datepicker.js"></script>
    <script src="../../js/locales/foundation-datepicker.zh-CN.js"></script>
    <link href="../../css/foundation-datepicker.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../assets/css/bootstrap.css">
    <script type="text/javascript" src="../../assets/js/bootstrap-multiselect.js"></script>
    <link rel="stylesheet" href="../../assets/css/bootstrap-multiselect.css" type="text/css"/>
    <style>
        a:link,a,span,i,td,th{
            text-decoration: none;
            text-indent: 0;
        }
        td,th{
            text-align: center;
        }
        .serchIterm{
            margin-right: 5%;
            width: 300px;
        }
    </style>
</head>

<body style="background-color:#f1f2f7">
<div class="panel panel-default" style="text-indent:1em;margin:15px">
    <div style="margin-top: 10px">
        当前位置：
        <span class="layui-breadcrumb">
			  <a href="">编辑${table.remark}</a>
			</span>
    </div>
    <hr/>
    <input type="hidden" value="$lId" id="lId">
    <div  id="container" class="form-body" style="margin:15px; display:flex">
        <ul style="list-style-type:none;width: 47%">
            <#list table.columns as column>
                <li style="display:flex; margin-bottom:10px">
                    <label for="inputEmail3" class="text-left col-sm-8">&nbsp;&nbsp;${column.remark}</label>
                    <input type="text" class="form-control" id="${column.name}" value="$${table.name?substring(table_pre)?cap_first}.getStringValue('${column.name}')" >
                </li>
            </#list>
        </ul>

    </div>

    <div  id="container2" class="form-body" style="margin:15px; display:flex">
        <div>
            <div class="layui-form-item" style="text-indent: 0;margin: 0;margin-left: 20px">
                <label class="layui-form-label" style="padding-left:9%"><div id="cusFile"></div></label>
            </div>
            <div class="layui-form-item" style="text-indent: 0;margin: 0">
                <label for="inputEmail3" class="layui-form-label">
                    <button class="layui-btn" type="button" onclick="doEdit()"
                            style="margin-top:10px;margin-bottom:10px">
                        <i class="fa fa-check"></i> 保存
                    </button>
                </label>
            </div>

        </div>

    </div>
</div>
</body>
<script>
    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        var beforemonth = "";
        if (month == 1) {
            beforemonth = "12";
        } else {
            beforemonth = month - 1;
        }
        if (beforemonth >= 1 && beforemonth <= 9) {
            beforemonth = "0" + beforemonth;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = date.getFullYear() + seperator1 + beforemonth
            + seperator1 + strDate;
        return currentdate;
    }

    function getFirstAndLastMonthDay(year, month) {
        var date = new Date();
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var lastdate = year + '-' + month + '-' + strDate;//获取当月最后一天日期
        //给文本控件赋值。同下
        return lastdate;
    }

    var now = new Date();
    var nowYear = now.getFullYear();
    var nowMonth = now.getMonth() + 1;
    //18点为催收计划执行时间
    $(function() {
        $('#dtArrivalTime').fdatepicker({
            format : 'yyyy-mm-dd'
        });
        $('#chooseTimeCx').fdatepicker({
            format : 'yyyy-mm-dd',
            startDate : getNowFormatDate(),
            endDate : getFirstAndLastMonthDay(nowYear, nowMonth)
        });
    });
</script>
<script src="../../assets/js/amazeui.min.js"></script>
<script type="text/javascript" src="../../cdojs/CDO.js"></script>
<script type="text/javascript" src="../../cdojs/HttpClient.js"></script>
<script type="text/javascript" src="../../cdojs/Utility.js"></script>
<script type="text/javascript" src="../../js/layui/layui.all.js"></script>
<script type="text/javascript" src="update${table.name?substring(2)?cap_first}.js"></script>
</html>
