/*
* 功能说明：
* WebInfo类：
*   属性：服务器的域名,ip地址,域名标题,服务器名,服务器版本,以及服务器所使用的语言
*   方法：
*       打印信息toString()
*       校验完整性checkComplete()
* */

public class WebInfo {
    public String domain = "";
    public String ip = "";
    public String title="";
    public String http_server = "";
    public String http_server_version = "";
    public String language = "";
    public String set_Cookie = "";
    public String X_Powered_By = "";
    //服务器加密的状态
    public Boolean isServerCrypto = false;
    public String charset = "";

    public WebInfo(){}

    public String toString(){
        String str = "";
        str = str + this.domain + "\t";
        str = str + this.ip + "\t";
        str = str + this.title + "\t";
        str = str + this.http_server + "\t";
        str = str + this.http_server_version + "\t";
        str = str + this.language + "\t";
        return str;
    }

    public boolean checkComplete() {
        return this.title != null && this.title.length() > 0 && this.http_server != null && this.http_server.length() > 0 && this.language != null && this.language.length() > 0;
    }
}
