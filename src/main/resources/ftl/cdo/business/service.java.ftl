package ${servicePackage}.plugin;

import com.cdoframework.cdolib.base.Return;
import com.cdoframework.cdolib.data.cdo.CDO;
import com.cdoframework.cdolib.servicebus.TransService;
import org.apache.log4j.Logger;

public class ${table.name?substring(table_pre)?cap_first}Service  extends TransService {
	Logger log=Logger.getLogger(this.getClass());
	public Return handleTrans(CDO cdoRequest,CDO cdoResponse){
		
		if(!cdoRequest.exists("strTransName")){
			return new Return(-1,"请求信息错误，缺少必要参数：strTransName");
		}
		String strTransName=cdoRequest.getStringValue("strTransName");
		log.info("[ContactService]:strTransName is <"+strTransName+">.");
		Return ret=null;
		if(strTransName.equals("add${table.name?substring(table_pre)?cap_first}")){
			ret = this.add${table.name?substring(table_pre)?cap_first}(cdoRequest, cdoResponse);
		}else if(strTransName.equals("update${table.name?substring(table_pre)?cap_first}")){
			ret = this.update${table.name?substring(table_pre)?cap_first}(cdoRequest, cdoResponse);
		}else if(strTransName.equals("query${table.name?substring(table_pre)?cap_first}List")){
			ret=this.query${table.name?substring(table_pre)?cap_first}(cdoRequest, cdoResponse);
		}
		return ret;
	}
	/**
	 * 添加${table.remark}
	 * @param cdoRequest
	 * @param cdoResponse
	 * @return
	 */
	public Return add${table.name?substring(table_pre)?cap_first}(CDO cdoRequest,CDO cdoResponse){
		Return ret = this.servicePlugin.handleDataTrans(cdoRequest, cdoResponse);
		return ret;
	}
	/**
	 * 修改${table.remark}
	 * @param cdoRequest
	 * @param cdoResponse
	 * @return
	 */
	public Return update${table.name?substring(table_pre)?cap_first}(CDO cdoRequest,CDO cdoResponse){
		Return ret = this.servicePlugin.handleDataTrans(cdoRequest, cdoResponse);
		return ret;
	}
	
	/**
	 * 查询${table.remark}
	 * @param cdoRequest
	 * @param cdoResponse
	 * @return
	 */
	public Return query${table.name?substring(table_pre)?cap_first}List(CDO cdoRequest,CDO cdoResponse){
		Return ret = this.servicePlugin.handleDataTrans(cdoRequest, cdoResponse);
		return ret;
	}
}
