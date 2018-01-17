var httpClient=new HttpClient("handleTrans.cdo");



function doEdit(){

<#list table.columns as column>
    var ${column.name}=$.trim($("#${column.name}").val());//${column.remark}
</#list>

<#list table.columns as column>
    if(${column.name}==""||${column.name}==null||${column.name}==undefined){
        alert("${column.remark}不能为空");
        return;
    }
</#list>

    var cdoRequest=new CDO();
    cdoRequest.setStringValue("strServiceName","${table.name?substring(table_pre)?cap_first}Service");
    cdoRequest.setStringValue("strTransName","update${table.name?substring(table_pre)?cap_first}");

    <#list table.columns as column>
        if(${column.name}!=""&&${column.name}!=null&&${column.name}!=undefined){
                cdoRequest.setStringValue("${column.name}",${column.name});
            }
    </#list>

    var cdoResponse=new CDO();
    var ret=httpClient.handleTrans(cdoRequest,cdoResponse);
    if(ret.getCode()==0)
    {
        alert("更新成功");
        window.location.href="${table.name?substring(table_pre)?cap_first}List.htm";
    }
    else
    {
        alert("更新失败："+ret.strText);
    }
}




