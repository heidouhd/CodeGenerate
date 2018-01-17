var httpClient=new HttpClient("handleTrans.cdo");
var encrypt = "isEncrypt";

var ATTCHMENT_ARRAY = new Array();
var isInitDone = false;


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
    forms.on('checkbox(checkAll)', function(data){
        if(data.elem.checked){
            $("input[name='checkboxt']").each(function(){this.checked=true;$(this).siblings("div").addClass("layui-form-checked")});
        }else{
            $("input[name='checkboxt']").each(function(){this.checked=false;$(this).siblings("div").removeClass("layui-form-checked")});
        }
        chooseCalculated();
    });
    forms.on('checkbox(checkEvery)', function(data){
        chooseCalculated();
    });
});
function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null)
        return decodeURI(r[2]);
    return null;
}

function viewInfo(id){
    if(id == null || id == ''){
        return;
    }
    console.log(id);
    var url = "view${table.name?substring(table_pre)?cap_first}.htm?lId=" + id;
    window.location.href = url;

}

function editInfo(id){
    if(id == null || id == ''){
        return;
    }
    console.log(id);
    var url = "update${table.name?substring(table_pre)?cap_first}.htm?lId=" + id;
    window.location.href = url;

}



