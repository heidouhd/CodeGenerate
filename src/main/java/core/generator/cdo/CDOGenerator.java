package core.generator.cdo;

import core.database.Column;
import core.database.Table;
import core.file.java.Class;
import core.file.java.Field;
import core.file.java.Interface;
import core.generator.dao.DaoGenerator;
import core.generator.dao.DaoImplGenerator;
import core.generator.dao.POGenerator;
import core.resolver.TypeResolver;
import core.util.FileUtils;
import core.util.FreeMarkerUtils;
import core.util.PathUtils;
import core.util.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * Hibernate持久层代码生成器.
 *
 * @author liup
 */
public class CDOGenerator {
    /**
     * 表格集合
     */
    private List<Table> tables;

    /**
     * <strong>Description:</strong>
     * <pre>
     * 构造实例化生成器.
     * </pre>
     *
     * @param tables 表格集合
     */
    public CDOGenerator(List<Table> tables) {
        // 赋值
        this.tables = tables;
    }

    /**
     * <strong>Description:</strong>
     * <pre>
     * 生成代码.
     * </pre>
     */
    public void generate(String fileName,String relativePath,Map<String, Object> map) throws Exception {
        // 遍历表格集合
        for (Table table : tables) {
            map.put("table",table);
            generateXML(fileName,relativePath,map);

        }
    }

    private void generateXML(String fileName,String relativePath,Map<String, Object> map) throws Exception {
        FreeMarkerUtils.generateFile(fileName,relativePath,map);
    }

    /**
     * <strong>Description:</strong>
     * <pre>
     * 生成代码.
     * </pre>
     */
    public void generateConfig(String fileName,String relativePath,Map<String, Object> map) throws Exception {
        // 遍历表格集合
            map.put("tables",tables);
            generateConfigXML(fileName,relativePath,map);
    }

    private void generateConfigXML(String fileName,String relativePath,Map<String, Object> map) throws Exception {
        FreeMarkerUtils.generateConfigFile(fileName,relativePath,map);
    }


}