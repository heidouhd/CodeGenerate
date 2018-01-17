<?xml version="1.0" encoding="UTF-8"?>
<ServicePlugin xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xsi:noNamespaceSchemaLocation="http://www.cdoframework.com:9000/xsd/ServiceBus.xsd">

<#list tables as table>
    <ServiceConfig Name="${table.name?substring(table_pre)?cap_first}Service">
        <DataService Resource="${servicePackagePath}/plugin/${table.name?substring(table_pre)?cap_first}Service.xml" Encoding="utf-8"/>
        <TransService ClassPath="${servicePackage}.${table.name?substring(table_pre)?cap_first}Service"/>
    </ServiceConfig>
</#list>

</ServicePlugin>
