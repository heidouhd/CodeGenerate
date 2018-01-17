package core;

import core.database.DatabaseReader;
import core.database.Table;
import core.generator.cdo.CDOGenerator;
import core.util.Config;

import java.io.File;
import java.util.*;

/**
 * 入口类.
 *
 * @author liup
 */
public class Main {

    private static Map<String, String> configMap = new HashMap<>();

    /**
     * <strong>Description:</strong>
     * <pre>
     * 入口函数
     * </pre>
     *
     * @param args 参数
     */
    public static void main(String[] args) throws Exception {
        Config config = new Config();
        // 生成代码
        generate(Config.JDBC_DATABASE, Config.JDBC_USERNAME, Config.JDBC_PASSWORD);
    }

    /**
     * <strong>Description:</strong>
     * <pre>
     * 根据数据库信息生成代码.
     * </pre>
     *
     * @param database 数据库
     * @param username 账户名
     * @param password 密码
     */
    private static void generate(String database, String username, String password) throws Exception {
        List<String> list = new ArrayList<>();
        if(Config.CDO_TABLE_NAMES != null){
            for(String name : Config.CDO_TABLE_NAMES){
                list.add(name.toLowerCase());
            }
        }

        // 读取数据库表格
        List<Table> tables = new DatabaseReader(username, password, database).readTables(list);
        //生成service.java
        String filePath = Config.CDO_ROOTPATH;
        File file = new File(filePath);
        // get the folder list
        createFile(file, tables);
    }

    public static void createFile(File file, List<Table> tables) throws Exception {
        File[] array = file.listFiles();

        for (int i = 0; i < array.length; i++) {
            String[] configPaths = Config.CDO_CONFIGPATH.split(",");
            if (array[i].isFile()) {
                if (array[i].getName().length() > 4) {
                    String fileName = array[i].getName().substring(0, array[i].getName().length() - 4);
                    String filePath = array[i].getPath();
                    String templatePath = filePath.substring(0, filePath.lastIndexOf("\\"));
                    String relativePath = Config.CDO_RELATIVEPATH+filePath.substring(Config.CDO_ROOTPATH.length(),templatePath.length())+"\\";
                    String servicePackage = Config.CDO_SERVICEPACKAGE;
                    String servicePackagePath = Config.CDO_SERVICEPACKAGEPATH;
                    Map<String, Object> map = new HashMap<>();
                    map.put("servicePackage", servicePackage);
                    map.put("servicePackagePath", servicePackagePath);
                    map.put("templatePath", templatePath);
                    map.put("table_pre",Config.CDO_TABLE_PRE);
                    Boolean flag = true;

                    for (String configPath : configPaths) {
                        if (array[i].getPath().contains(configPath)) {
                            flag = false;
                            if(configMap.get(filePath)==null){
                                map.put("tables",tables);
                                configMap.put(filePath,fileName);
                                new CDOGenerator(tables).generateConfig(fileName, relativePath, map);
                                break;
                            }else {
                                break;
                            }

                        }
                    }
                    if(flag){
                        new CDOGenerator(tables).generate(fileName, relativePath, map);
                    }

                }
            } else {
                createFile(array[i], tables);
            }
        }
    }
}