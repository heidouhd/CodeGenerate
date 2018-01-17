<?xml version="1.0" encoding="UTF-8"?>
<DataService xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:noNamespaceSchemaLocation="http://www.cdoframework.com:9000/xsd/DataService.xsd">

    <!--分页查询-->
    <SQLTrans TransFlag="0" TransName="query${table.name?substring(table_pre)?cap_first}List" DataGroupId="read_xcd_dc_boss">
        <SelectRecordSet OutputId="{cdosListRecord}" RecordCountId="{nRecordCount}">
            <OutputSQL>
                select * from ${table.name} where 1=1
            </OutputSQL>
            <#list table.columns as column>
<SQLIf Type="${column.strType}" Operator="EXIST" Value1="{${column.name}}">
    <SQLThen>
        <OutputSQL>
		            and ${column.name}={${column.name}}
        </OutputSQL>
    </SQLThen>
</SQLIf>
            </#list>

            <SQLIf Value1="{nStartIndex}" Type="Integer" Operator="EXIST">
                <SQLThen>
                    <OutputSQL><![CDATA[ ORDER BY lId  LIMIT {nPageSize|10} OFFSET {nStartIndex|0} ]]></OutputSQL>
                </SQLThen>
            </SQLIf>
        </SelectRecordSet>
        <SelectField OutputId="{nTotalCount}">
            <OutputSQL>
                select count(1) from ${table.name}
            </OutputSQL>
        </SelectField>
        <OnException>
            <Return Code="-1" Text="数据库操作异常" Info="${table.name?substring(table_pre)?cap_first}Service.query${table.name?substring(table_pre)?cap_first}List.Error"/>
        </OnException>
        <Return Code="0" Text="查询成功！" Info="${table.name?substring(table_pre)?cap_first}Service.query${table.name?substring(table_pre)?cap_first}List.OK">
            <ReturnItem FieldId="{cdosListRecord}" ValueId="{cdosListRecord}"/>
            <ReturnItem ValueId="{nRecordCount}" FieldId="{nRecordCount}"/>
            <ReturnItem ValueId="{nTotalCount}" FieldId="{nTotalCount}"/>
        </Return>
    </SQLTrans>

    <!--增加数据-->
    <SQLTrans TransFlag="1" TransName="add${table.name?substring(table_pre)?cap_first}" DataGroupId="write_xcd_dc_boss">
        <!-- 查询出该 lBorrowerId的明细 数据-->
        <Insert>
            <OutputSQL>
                INSERT INTO ${table.name} (
                <#list table.columns as column>
            <#if column_index==0>
                ${column.name}
            <#else>
		            ,${column.name}
            </#if>
                </#list>
                VALUES (
                <#list table.columns as column>
                    <#if column_index==0>
                        {${column.name}}
                    <#else>
		            ,{${column.name}}
                    </#if>
                </#list>
                );
            </OutputSQL>
        </Insert>

        <OnException>
            <Return Code="-1" Text="插入数据失败" Info="${table.name?substring(table_pre)?cap_first}Service.add${table.name?substring(table_pre)?cap_first}.Error"></Return>
        </OnException>
        <Return Code="0" Text="插入数据成功" Info="${table.name?substring(table_pre)?cap_first}Service.add${table.name?substring(table_pre)?cap_first}.OK">

        </Return>
    </SQLTrans>

    <!--查看数据-->
    <SQLTrans TransFlag="0" TransName="view${table.name?substring(table_pre)?cap_first}" DataGroupId="read_xcd_dc_boss">
        <SelectRecord OutputId="{cdoRecord}" RecordCountId="{nRecordCount}">
            <OutputSQL>
                select * from ${table.name} where lId = {lId}
            </OutputSQL>
        </SelectRecord>
        <OnException>
            <Return Code="-1" Text="数据库操作异常" Info="${table.name?substring(table_pre)?cap_first}Service.view${table.name?substring(table_pre)?cap_first}.Error"/>
        </OnException>
        <Return Code="0" Text="查询成功！" Info="${table.name?substring(table_pre)?cap_first}Service.view${table.name?substring(table_pre)?cap_first}.OK">
            <ReturnItem FieldId="{cdoRecord}" ValueId="{cdoRecord}"/>
        </Return>
    </SQLTrans>

    <!--更新查询-->
    <SQLTrans TransFlag="1" TransName="update${table.name?substring(table_pre)?cap_first}" DataGroupId="write_xcd_dc_boss">
        <Update>
            <OutputSQL>
                UPDATE ${table.name}
                SET
                `dtUpdateTime` = now()
            </OutputSQL>
            <#list table.columns as column>
                <SQLIf Type="${column.strType}" Operator="EXIST" Value1="{${column.name}}">
                    <SQLThen>
                        <OutputSQL>,${column.name} = {${column.name}}</OutputSQL>
                    </SQLThen>
                </SQLIf>
            </#list>
            <OutputSQL>
                WHERE
                `lId` = {lId};
            </OutputSQL>
        </Update>
        <OnException>
            <Return Code="-1" Text="数据库操作异常" Info="${table.name?substring(table_pre)?cap_first}Service.update${table.name?substring(table_pre)?cap_first}.Error"></Return>
        </OnException>
        <Return Code="0" Text="修改成功" Info="D${table.name?substring(table_pre)?cap_first}Service.update${table.name?substring(table_pre)?cap_first}.OK">
        </Return>
    </SQLTrans>
</DataService>