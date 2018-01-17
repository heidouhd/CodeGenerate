package ${servicePackage}.controller;

import com.cdoframework.cdolib.base.Return;
import com.cdoframework.cdolib.data.cdo.CDO;
import com.dafy.dcs.web.BusinessService;
import com.dafy.dflib.web.Utility;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

/**
 * 中间人管理
 * @author liup
 */
public class ${table.name?substring(table_pre)?cap_first}Controller {

    /**
     * 获取列表
     * @param req
     * @return
     */
    public CDO query${table.name?substring(table_pre)?cap_first}List(HttpServletRequest req){
        BigDecimal b2=new BigDecimal("100");
        Object strPageIndex = req.getParameter("pageindex");
        if (strPageIndex == null || "".equals(strPageIndex)) {
            strPageIndex = req.getAttribute("strPageIndex");
        }
        String strPageSize = req.getParameter("strPageSize");
        if(strPageIndex==null || "".equals(strPageIndex)){
            strPageIndex = "0";
        }
        if(strPageSize==null || "".equals(strPageSize)){
            strPageSize = "10";
        }

        CDO cdoRequest=CDO.newRequest("${table.name?substring(table_pre)?cap_first}Service","query${table.name?substring(table_pre)?cap_first}List");

        Integer nPageIndex = Integer.parseInt(strPageIndex.toString());
        Integer nPageSize = Integer.parseInt(strPageSize);
        cdoRequest.setIntegerValue("nStartIndex", nPageIndex * nPageSize);
        cdoRequest.setIntegerValue("nPageSize", nPageSize);

        CDO cdoResponse=new CDO();
        Return ret= BusinessService.getInstance().handleTrans(cdoRequest,cdoResponse);
        if(ret==null){
            return cdoResponse;
        }
        if(ret.getCode()!=0){
            return cdoResponse;
        }
        int nCount = cdoResponse.getIntegerValue("nTotalCount");
        cdoResponse.setIntegerValue("nPageCount", Utility.getPageCount(nCount, nPageSize));
        return cdoResponse;
    }

    /**
     * 根据id获取信息
     * @param req
     * @return
     */
    public CDO view${table.name?substring(table_pre)?cap_first}(HttpServletRequest req){
        CDO cdoRequest=CDO.newRequest("${table.name?substring(table_pre)?cap_first}Service","view${table.name?substring(table_pre)?cap_first}");
        String lId = req.getParameter("lId");
        cdoRequest.setStringValue("lId",lId);
        CDO cdoResponse=new CDO();
        Return ret= BusinessService.getInstance().handleTrans(cdoRequest,cdoResponse);
        return cdoResponse.getCDOValue("cdoRecord");
    }

}
