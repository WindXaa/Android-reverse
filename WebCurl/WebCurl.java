import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class WebCurl {

    /*
     * 函数说明：
     *   getTitle(String webcontent):
     *   输入参数：web页面信息html
     *   返回结果：标题
     * */

    public static String getTitle(String webContent){
        Pattern pattern = Pattern.compile("<title>.*?</title>",Pattern.CASE_INSENSITIVE|Pattern.DOTALL);
        Matcher ma =pattern.matcher(webContent);
        while (ma.find()){
            //System.out.println(ma.group());
            return outTag(ma.group());
        }
        return null;
    }


    //去除标题中的一些无关信息
    public static String outTag(String s)
    {
        String title = s.replaceAll("<.*?>", "");
        title=replaceBlank(title);
        title = title.replace("首页", "");
        title = title.replace("-", "");
        title = title.replace("主页", "");
        title = title.replace("官网", "");
        title = title.replace("欢迎进入", "");
        title = title.replace("欢迎访问", "");
        title = title.replace("登录入口", "");
        return title;
    }

    //除去标题字符串中的\t制表符 \n回车 \r换行符
    public static String replaceBlank(String str) {
        String dest = "";
        if (str!=null) {
            Pattern p = Pattern.compile("\\s*|\t|\r|\n");
            Matcher m = p.matcher(str);
            dest = m.replaceAll("");
        }
        return dest;
    }

    /*
    * 功能说明：
    * 输入参数：域名
    * 返回参数：IP地址
    * */
    public void getIpName(WebInfo wi,String damin){
        try{
            InetAddress inetAddress = InetAddress.getByName(damin);
            String host_damin =inetAddress.getHostAddress();
            wi.domain = damin;
            wi.ip = host_damin;
            System.out.println(wi.ip);
        }catch (Exception exception){

        }
    }

    /*
    * 功能说明
    * Curl指令的java代码
    * 输入函数：curl指令
    * 返回参数：curl指令的返回值
    * 例子：curl [option] [url]
    * curl url  //获取url的html
    * curl -A "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.0)" url  //使用指定的浏览器去访问
    * curl -I url  //返回header信息
    * */
    public static String execCurl(String[] cmds,String chartname) {
        ProcessBuilder process = new ProcessBuilder(cmds);
        Process p;
        try {
            p = process.start();
            BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream(),chartname));
            StringBuilder builder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                builder.append(line);
                builder.append(System.getProperty("line.separator"));
            }
            return builder.toString();

        } catch (IOException e) {
            System.out.print("error");
            e.printStackTrace();
        }
        return null;
    }


    //使用curl获取服务器信息，输入url
    public static void getServerInfo(WebInfo wi,String domain) throws IOException {
        String charset = "utf-8";
        charset = getCharset(domain);
        //System.out.println("charset:"+charset);
        if(!matcherChar(charset,"gb")){
            charset = "utf-8";
        }
        //-L 跟随跳转 -i 打印详细信息
        String[] cmds = {"curl","-A","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36","-L","-i",domain};
        String result_html = execCurl(cmds,charset);
        //获取的header和html信息
        //System.out.println(result_html);
        if(!result_html.isEmpty()){
            wi.title = getTitle(result_html);
        }else{
            System.out.println("无法获取域名的html");
        }
        strName(wi,result_html);
        LanguageCheck(wi);
        NormalLanguageTest(wi);
        ExceptionCheck(wi);
       // CheckStatus(wi);

    }



    /*
    * 获取url的编码格式：
    *(1)从返回的响应头中匹配获取："charset"
    *(2)从主体中匹配获取:"charset"
    * */
    public static String getCharset(String link)  {
        String charset = "utf-8";

        HttpURLConnection conn = null;

        try {
            URL url = new URL(link);

            conn = (HttpURLConnection)url.openConnection();

            conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36");

            conn.connect();
            System.setProperty("sun.net.client.defaultConnectTimeout","30000");
            System.setProperty("sun.net.client.defaultReadTimeout", "30000");

                String contentType = conn.getContentType();

                //在header里面找charset

                charset = findCharset(contentType);
                //System.out.println("header:"+charset);

                //如果没找到的话，则一行一行的读入页面的html代码，从html代码中寻找

                if(charset.isEmpty()){
                    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));

                    String line = reader.readLine();

                    while(line != null) {
                        if(line.contains("Content-Type")) {
                            // result = findCharset(line);
                            Pattern p = Pattern.compile("content=\"text/html;\\s*charset=([^>]*)\"");
                            Matcher m = p.matcher(line);
                            if (m.find()) {
                                charset = m.group(1);
                                System.out.println("html:"+charset);
                            }
                            break;

                        }

                        line = reader.readLine();

                    }
                    reader.close();

                }




        } catch (Exception e) {
// TODO Auto-generated catch block
            //这里可以打印响应不了的域名错误信息
            //e.printStackTrace();

        }
        finally {
            conn.disconnect();

        }

        return charset;

    }




    public static String findCharset(String line){
        String charset = "";
        if(line.contains("charset")){
            String[] arr=line.split("=",2);
            for(String str:arr){
                if(!str.equals("charset")){
                    charset = str;
                }
            }
            return charset;
        }else {
            return "";
        }

    }





    //用于检测服务器语言的指纹信息,输入参数：webInfo对象
    public static void LanguageCheck(WebInfo wi) {
        if(wi.set_Cookie.contains("PHPSSIONID")&&wi.language.isEmpty()){
            wi.language = "PHP";
        }
        if(wi.set_Cookie.contains("JSESSIONID")&&wi.language.isEmpty()){
            wi.language = "JAVA";
        }
        if(wi.X_Powered_By.contains("ASP.NET")||wi.set_Cookie.contains("ASPSESS")||wi.set_Cookie.contains("ASP.NET")&&wi.language.isEmpty()){
            wi.language = "ASP.NET";
            if(wi.http_server.isEmpty()){
                wi.http_server = "IIS";
            }
        }
        if(wi.X_Powered_By.contains("JBoss")&&wi.language.isEmpty()){
            wi.language = "JAVA";
            if(wi.http_server.isEmpty()){
                wi.http_server = "JBOSS";
            }
        }
        if(wi.X_Powered_By.contains("Servlet")&&wi.language.isEmpty()){
            wi.language = "JAVA";
            if(wi.http_server.isEmpty()){
                wi.http_server = "SERVLET";
            }
        }
        if(wi.X_Powered_By.contains("Next.js")&&wi.language.isEmpty()){
            wi.language = "NODEJS";
        }
        if(wi.X_Powered_By.contains("Express")&&wi.language.isEmpty()){
            wi.language = "NODEJS";
        }
        if(wi.X_Powered_By.contains("Dragonfly CMS")&&wi.language.isEmpty()){
            wi.language = "PHP";
        }
        if(wi.X_Powered_By.contains("PHP")&&wi.language.isEmpty()){
            wi.language = "PHP";
        }
        if(wi.X_Powered_By.startsWith("JSF")&&wi.language.isEmpty()){
            wi.language = "JAVA";
            if(wi.http_server.isEmpty()){
                wi.http_server = "SERVLET";
            }
        }
        if(wi.X_Powered_By.startsWith("WP")&&wi.language.isEmpty()){
            wi.language = "PHP";
        }
        if(wi.X_Powered_By.startsWith("enduro")&&wi.language.isEmpty()){
            wi.language = "NODEJS";
        }

    }

    /*
    * 服务器版本语言检测，如果语言指纹信息仍然检测不到，针对加密服务器，采用一般检测方式，误差率较高
    * */
    public static void NormalLanguageTest(WebInfo wi){
        if(!wi.http_server.isEmpty()){
            if (wi.http_server.contains("IIS") && wi.language.isEmpty()) {
                wi.language = "ASP.NET";
            }
            if (wi.http_server.contains("Tomcat")||wi.http_server.contains("Resin")|| wi.http_server.contains("JBoss")&& wi.language.isEmpty()) {
                wi.language = "Java";
            }
            if (wi.http_server.contains("Nginx") && wi.language.isEmpty()) {
                wi.language = "Python";
            }
            if (wi.http_server.contains("Apache")&&wi.language.isEmpty()) {
                wi.language = "PHP";
            }
            if (wi.http_server.contains("VWebServer")||wi.http_server.contains("Enterprise")&&wi.language.isEmpty()) {
                wi.language = "JAVA";
            }
            if (wi.http_server.contains("nginx")&&wi.language.isEmpty()) {
                wi.language = "C";
            }
            if (wi.http_server.contains("Oracle-HTTP-Server")&&wi.language.isEmpty()){
                wi.language = "Java|C|Perl|PHP";
            }
            if (wi.http_server.contains("openresty")&&wi.language.isEmpty()){
                wi.language = "Lua|C";
            }
            if (wi.http_server.contains("GWS")&&wi.language.isEmpty()){
                wi.language = "C++";
            }

        }
    }




    /*
    * 匹配包头信息和服务器html信息，获取服务器名和服务器版本
    * */
    public static void strName(WebInfo wi,String strcontent) throws IOException {
        if(!strcontent.isEmpty()){
            BufferedReader br =new BufferedReader(new InputStreamReader(new ByteArrayInputStream(strcontent.getBytes(Charset.forName("utf-8")))));
            String line;
            String[] items;
            StringBuffer strbuf = new StringBuffer();
            while ((line = br.readLine())!=null){
                String reg = "Server:\\s(\\D*)(\\s|\\/|\\*)(.*)";
                String reg1 = "Server:\\s(\\D*)";
                String[] result =RegCheck(line,reg);
                if(result.length>0){
                    //System.out.println("result.length:"+result.length);
                    wi.http_server = result[1];
                    wi.http_server_version = result[3];
                    if(wi.http_server==null){
                        wi.http_server="";
                    }
                    if(wi.http_server.contains("*")){
                        wi.http_server = "";
                        wi.isServerCrypto = true;
                    }
                }
                if(line.contains("Set-Cookie")){
                    String[] arr=line.split(":",2);
                    for(String str:arr){
                        if(!str.equals("Set-Cookie")){
                            wi.set_Cookie = str;
                        }
                    }
                }
                if(line.contains("X-Powered-By")){
                    String[] arr=line.split(":",2);
                    for(String str:arr){
                        if(!str.equals("X-Powered-By")){
                            wi.X_Powered_By= str;
                        }
                    }
                }
//                //检测主体中的服务器版本信息
                if (matcherChar(line, "Apache")&&wi.http_server.isEmpty()){
                    wi.http_server = "Apache";
                }
                if (matcherChar(line, "Nginx")&&wi.http_server.isEmpty()){
                    wi.http_server = "Nginx";
                }
                if (matcherChar(line, "Lighttpd ")&&wi.http_server.isEmpty()){
                    wi.http_server = "Lighttpd";
                }
                if (matcherChar(line, "IIS ")&&wi.http_server.isEmpty()){
                    wi.http_server = "IIS ";
                }
                if (matcherChar(line, "WebSphere")&&wi.http_server.isEmpty()){
                    wi.http_server = "WebSphere";
                }
                if (matcherChar(line, "Weblogic")&&wi.http_server.isEmpty()){
                    wi.http_server = "WebSphere";
                }
                if (matcherChar(line, "Boa")&&wi.http_server.isEmpty()){
                    wi.http_server = "Boa";
                }
                if (matcherChar(line, "Jigsaw")&&wi.http_server.isEmpty()){
                    wi.http_server = "Jigsaw";
                }
            }
            if(wi.http_server.isEmpty()){
                marcherServer(wi,strcontent);
            }
            br.close();
        }
    }

    //匹配字符串，不区分大小写，参数：源字符串，匹配的字符串
    public static Boolean matcherChar(String strName,String matChar){
        Pattern pattern =Pattern.compile(matChar, Pattern.CASE_INSENSITIVE);
        Matcher matcher=pattern.matcher(strName);
        return matcher.find();
    }



    /*  处理加密服务器，无法获得版本
     *  匹配服务器顺序,根据主流服务器的响应头顺序来识别
     *  例如：Apache 顺序：Http->Date->Server
     */
    public static void marcherServer(WebInfo wi,String strcontent) throws IOException {
        if(!strcontent.isEmpty()) {
            BufferedReader br = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(strcontent.getBytes(Charset.forName("utf-8")))));
            String line;
            int i=0;
            StringBuffer strbuf = new StringBuffer();
            while ((line = br.readLine()) != null) {
                i=i+1;
                if(line.contains("HTTP")&&i==1){
                   // i=2;
                }
                if(line.contains("Date")&&i==2){
                    wi.http_server="Apache";
                    break;
                }
                if(line.contains("Server")&&i==2){
                    //i=3;
                }
                if(line.contains("Expires")&&i==3){
                    wi.http_server="IIS";
                    break;
                }
                if(line.contains("Data")&&i==3){
                    //i=4;
                }
                if(line.contains("Content-Type")&&i==4){
                    wi.http_server="Enterprise ";
                    break;
                }
                if(line.contains("Content-length")&&i==4){
                    wi.http_server="SunONE";
                    break;
                }
                if(i==5){
                    break;
                }
            }
        }
    }
    /*
    * 正则表达式匹配：输入字符串、正则表达式
    * 例如：reg3 = "Server:\\s(\\D*)(\\s|\/)(.*)";
    * 返回匹配的结果数组
    * */
    public static String[] RegCheck(String str,String reg){
        String[] result=new String[4];
        String[] resultnew = {};
        Pattern p = Pattern.compile(reg);
        Matcher m = p.matcher(str);
        if (m.matches()) {
            for(int i=0;i<=m.groupCount();i++){
                result[i]=m.group(i);
                //System.out.println("result[i]:"+result[i]);
                //System.out.println("m.group(i):"+m.group(i));
            }
            return result;
        }else {
            return resultnew;
        }
    }

    public static void  ExceptionCheck(WebInfo wi){
        if(wi.title == null){
            wi.title ="";
        }
        if(wi.http_server == null){
            wi.title ="";
        }
        if(wi.language == null){
            wi.title ="";
        }
        if(wi.http_server == null){
            wi.title ="";
        }

    }

    //检查扫描信息的状态
    public static void CheckStatus(WebInfo wi){
        if(wi.title.isEmpty()&&wi.http_server.isEmpty()&&wi.language.isEmpty()&&wi.http_server_version.isEmpty()){
            System.out.println("站点无法访问，请检查站点信息！");
        }else if(!wi.title.isEmpty()&&!wi.http_server.isEmpty()&&!wi.language.isEmpty()&&!wi.http_server_version.isEmpty()){
            System.out.println("扫描完成,所有信息扫描完成");
        }else{
            if(wi.title.isEmpty()){
                wi.title = "标题防护，无法获取";
            }
            if(wi.http_server.isEmpty()){
                wi.http_server = "服务器防护，无法获取";
            }
            if (wi.language.isEmpty()){
                wi.language="服务器语言防护，无法获取";
            }
            if(wi.http_server_version.isEmpty()){
                wi.http_server_version="服务器版本防护，无法获取";
            }
        }
    }


    public static void main(String[] args) throws IOException {
        WebInfo wi = new WebInfo();
        getServerInfo(wi,"网址");
        System.out.println("title:"+wi.title+"\nhttp_server:"+wi.http_server+"\nlanguage:"+wi.language+"\nhttp_server_version:"+wi.http_server_version+"\nisServerCrypto："+wi.isServerCrypto);
        System.out.println("---------------------");


    }



}

