package core.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

public class Config {

    public static Map<String, String> map = new HashMap<>();

    public static String CDO_ROOTPATH;
    public static String CDO_SERVICEPACKAGE;
    public static String CDO_SERVICEPACKAGEPATH;
    public static String CDO_CONFIGPATH;
    public static String JDBC_USERNAME;
    public static String JDBC_PASSWORD;
    public static String JDBC_DATABASE;
    public static String JDBC_URL;
    public static String CDO_RELATIVEPATH;
    public static Integer CDO_TABLE_PRE = 0;
    public static Boolean CDO_TABLE_NONAME_ISCREATEALL = true;
    public static String[] CDO_TABLE_NAMES ;


    static {
        Properties prop = new Properties();
        try {
            //读取属性文件config.properties
            String path = System.getProperty("user.dir");
            InputStream in = new BufferedInputStream(new FileInputStream(path + "\\src\\main\\resources\\config.properties"));
            prop.load(in);     ///加载属性列表
            Iterator<String> it = prop.stringPropertyNames().iterator();
            while (it.hasNext()) {
                String key = it.next();
                map.put(key, prop.getProperty(key));
            }
            CDO_ROOTPATH = map.get("cdo.rootPath");
            CDO_SERVICEPACKAGE = map.get("cdo.servicePackage");
            CDO_SERVICEPACKAGEPATH = map.get("cdo.servicePackagePath");
            if (CDO_SERVICEPACKAGEPATH == null) {
                CDO_SERVICEPACKAGEPATH = CDO_SERVICEPACKAGE.replace(".", "/");
            }
            CDO_CONFIGPATH = map.get("cdo.configPath");
            JDBC_USERNAME = map.get("jdbc.username");
            JDBC_PASSWORD = map.get("jdbc.password");
            JDBC_DATABASE = map.get("jdbc.database");
            JDBC_URL = map.get("jdbc.url");
            CDO_RELATIVEPATH = map.get("cdo.relativePath");
            if (map.get("cdo.table.pre") != null) {
                CDO_TABLE_PRE = Integer.parseInt(map.get("cdo.table.pre"));
            }

            if(map.get("cdo.table.noname.isCreateAll") != null){
                CDO_TABLE_NONAME_ISCREATEALL = Boolean.parseBoolean(map.get("cdo.table.noname.isCreateAll"));
            }
            String names = map.get("cdo.table.name");
            if( names!= null){
                CDO_TABLE_NAMES = names.split(",");
            }
            in.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
