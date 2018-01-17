<?xml version="1.0" encoding="UTF-8"?>
<NodeList xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="D:\workspace\Account\FBPDesign\XML\NodeList.xsd">
	 <Node Id="OfflineLendBusiness">
		<HttpServiceClient URL="http://workbench.xcddc.xcdbjmc.service/handleTrans.cdo" Encoding="utf-8" />
		<ToDoFilter Default="true" />
		<TransFilter Default="true">
		<#list tables as table>
			<Action ServiceName="${table.name?substring(table_pre)?cap_first}Service" Enabled="true" />
		</#list>
		</TransFilter>
		<EventFilter Default="true" />
	</Node> 
</NodeList>
