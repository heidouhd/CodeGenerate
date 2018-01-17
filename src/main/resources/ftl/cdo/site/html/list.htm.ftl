#set($strPageIndex = $request.getParameter("pageindex"))
$request.setAttribute("strPageIndex",$strPageIndex)
#set ($strNameCx = $request.getParameter("strBorrowerName"))
#set ($strBorrowerPhoneCx = $request.getParameter("strBorrowerPhone"))
#set ($strSourceCx = $request.getParameter("strSource"))
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>中间人列表</title>
    <meta name="description" content="中间人列表">
    <meta name="keywords" content="index">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="stylesheet" href="../../assets/css/bootstrap.css">
    <link rel="stylesheet" href="../../js/layui/css/layui.css">
    <script type="text/javascript" src="../../assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="../../assets/js/bootstrap.min.js"></script>
    <style>
        a:link,a,span,i,td{
            text-decoration: none;
            text-indent: 0;
        }
        td{
            text-align: center;
        }
    </style>
</head>

<body>
<div>
    <button class="layui-btn layui-btn-primary" type="button" id="aDomAddDistribute" >
        <i class="fa fa-check"></i><a href="add${table.name?substring(table_pre)?cap_first}.htm.ftl">添加${table.remark}</a>
    </button>
</div>
<div >
    <table id="empDataTable" border="0" cellspacing="0" cellpadding="0" class="table table-striped table-bordered layui-table">
        <tr>
            <#list table.columns as column>
                <td class="grid-title grid-no" style="padding-left: 4px; padding-right: 12px; text-align: left;">${column.remark}</td>
            </#list>
            <td class="grid-title grid-no">操作</td>
        </tr>
        #set ($cdosCaseList=$${table.name?substring(table_pre)?cap_first}Controller.query${table.name?substring(table_pre)?cap_first}List($request))
        #if($cdosCaseList.exists("cdosListRecord"))
        #set($cdosCaseLists=$cdosCaseList.getCDOArrayValue("cdosListRecord"))
        #foreach($cdoCase in $cdosCaseLists)
        <tr>
            <#list table.columns as column>
                <td style="padding-left: 4px; padding-right: 12px; text-align: left;">$cdoCase.getLongValue("${column.name}")</td>
            </#list>
            <td>
                <a class="layui-btn layui-btn-primary layui-btn-mini" onclick="viewInfo($cdoCase.getLongValue('lId'))" href="#" >查看</a>
                <a class="layui-btn layui-btn-primary layui-btn-mini" onclick="editInfo($cdoCase.getLongValue('lId'))" href="#" >修改</a>
            </td>
        </tr>

        #end
        #end
        #set($nPageCount =$cdosCaseList.getIntegerValue("nPageCount"))
        #set($nRecordCount= $cdosCaseList.getIntegerValue("nTotalCount"))
    </table>
    <div style="height: 55px">
        <div colspan="18" id="demo7" class="grid-title last-right" pageCount=$nRecordCount style="position:absolute; left: 15%;"></div>
    </div>
</div>
</body>
<script type="text/javascript" src="../../cdojs/CDO.js"></script>
<script type="text/javascript" src="../../cdojs/HttpClient.js"></script>
<script type="text/javascript" src="../../cdojs/Utility.js"></script>
<script type="text/javascript" src="../../js/layui/layui.all.js"></script>
<script type="text/javascript" src="${table.name?substring(table_pre)?cap_first}List.js"></script>
<script>
    //layui  分页渲染及复选radio等事件监听
    var pageCount = $("#demo7").attr("pageCount");
    var laypage = layui.laypage,forms = layui.form;
    layui.use(['form', 'laypage'], function(){
        laypage.render({
            elem: 'demo7'
            ,count: pageCount
            ,curr: (getQueryString("pageindex")*1+1)
            ,limits: [10, 20, 30, 40, 50]
            ,limit: getQueryString("strPageSize")
            ,layout: ['count', 'prev', 'page', 'next', 'limit', 'skip']
            ,jump: function(obj,first){
                if(!first)window.location.href = "${table.name?substring(table_pre)?cap_first}List.htm?pageindex="+(obj.curr-1)+"&strPageSize="+obj.limit;
            }
        });
    });
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)
            return decodeURI(r[2]);
        return null;
    }
</script>
</html>
