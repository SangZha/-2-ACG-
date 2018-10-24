using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class News : System.Web.UI.Page
{
    protected StringBuilder str = new StringBuilder();    //stringbuilder 需要 system.text
                                                          //前台使用<% str %>即可添加到指定位置（记住protected）
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
    int idMax;  //最新文章ID
    string titleArticle; //文章标题
    string contentArticleFake; //文章内容未转码 （&lt;&gt;）
    string contentArticle; //文章内容
    string writerArticle; //文章发布者
    string timeArticle; //文章发布时间
    string users_name;//登录用户名字
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            login.Style["display"] = "none";
            register.Style["display"] = "none";
            message.Style["display"] = "inline-block";
            history.Style["display"] = "inline-block";
            profile.Style["display"] = "inline-block";
            display.Style["display"] = "inline-block";
            post.Style["display"] = "inline-block";
        }

        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();

        SqlCommand Cmaccount = new SqlCommand("SELECT UserName FROM Users WHERE UserAccount='" + Session["username"] + "'", Cn);
        SqlDataReader Draccount = Cmaccount.ExecuteReader();
        if (Draccount.Read()) {
            users_name = Draccount.GetString(Draccount.GetOrdinal("UserName"));
        }
        Draccount.Close();
        display_name.InnerText = users_name;

        SqlCommand CmIdMax = new SqlCommand("select ArticleId From Articles where ArticleId = (select MAX(ArticleId) from Articles)", Cn);
//这里用MAX返回的是一个值不知道该用什么语句取这个值   绕个弯仍然使用SqlDataReader
        SqlDataReader DrIdMax = CmIdMax.ExecuteReader();
        DrIdMax.Read();
        string tempId = DrIdMax["ArticleId"].ToString();
            idMax = Convert.ToInt32(tempId);
        DrIdMax.Close();
        //Response.Write("<script>alert('"+idMax+"');</script>"); 
        Cn.Close();

        Create_Article();
    }
    public void Create_Article()
    {
        for (int i = idMax;i > 0; i--)
        {
            Create_Html(i);
        }
    }
   
    public void Create_Html(int id)
    {
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
        //读取文章的各个信息
        SqlCommand CmArticles = new SqlCommand("SELECT ArticleTitle,ArticleContent,ArticleWriter,ArticleTime FROM Articles WHERE ArticleId = '"+ id +"'", Cn);
        SqlDataReader DrArticles = CmArticles.ExecuteReader();
        DrArticles.Read();
        titleArticle = DrArticles["ArticleTitle"].ToString();
        contentArticleFake = DrArticles["ArticleContent"].ToString();
        writerArticle = DrArticles["ArticleWriter"].ToString();
        timeArticle = DrArticles["ArticleTime"].ToString();
        DrArticles.Close();
        contentArticleFake = Simplify_Content(contentArticleFake);   //运行函数截取文章
        tempContent.InnerHtml = contentArticleFake;
        contentArticle = tempContent.InnerText;
        Cn.Close();

        str.Append("<article id=\"post-"+ id +"\">\r\n");
        str.Append("<header class=\"articles_entire_header\">\r\n");
        str.Append("<div class=\"articles_entire_avatar\">\r\n");
        str.Append("<a href=\"\" class=\"avatar_links\">\r\n");
        str.Append("<img src=\"img/header_head.jpg\" alt=\"\" class=\"avatar_img\">\r\n");
        str.Append("</a>\r\n");
        str.Append("</div>\r\n");
        str.Append("<div class=\"articles_entire_decription\">\r\n");
        str.Append("<h1 class=\"articles_entire_titles\">\r\n");
        str.Append("<a href=\"Article.aspx?id=" + id + "\" class=\"articlestitle\">" + titleArticle + "</a>\r\n");
        str.Append("</h1>\r\n");
        str.Append("<div class=\"articles_entire_ups\">\r\n");
        str.Append("<span class=\"articles_entire_upsby\">由</span>\r\n");
        str.Append("<span class=\"articles_entire_upsname\">\r\n");
        str.Append("<a href=\"\" class=\"upname\">" + writerArticle + "</a>\r\n");
        str.Append("</span>\r\n");
        str.Append("<span class=\"articles_entire_upsby\">发表</span>\r\n");
        str.Append("</div>\r\n");
        str.Append("</div>\r\n");
        str.Append("</header>\r\n");
        str.Append("<div class=\"articles_entire_content\">\r\n");
        str.Append("" + contentArticle + "\r\n");
        str.Append("</div>\r\n");
        str.Append("<footer class=\"articles_entire_footer\">\r\n");
        str.Append("<time class=\"articles_entire_time\" datetime=\"\">" + timeArticle + "</time>\r\n");
        str.Append("</footer>\r\n");
        str.Append("</article>\r\n");
    }

    public string Simplify_Content(string str)
    {
        int h = 0;  //记录<hr>前面字符串的位置
        int p = 0;  //记录前三段最后一个字符的位置（这里是搜索第四个&lt;p）
        //循环三次找到第四个"&lt;p"(<p)的字符位置
        for (int i = 0; i < 3; i++){    
            p = str.IndexOf("&lt;p", p + 1);
        }
        //这里当上方文章段数小于循环次数，不同循环次数的循环语句可能会导致 s=0 不知道原因，因此加个p=0的判断
        if (p == -1 | p== 0)       //i<3  只有两段的文章s=0  而i<4  只有两段文章s!=0 会掉入下面的if
        {
            return str;
        }
        else
        {
            h = str.IndexOf("&lt;hr");
            if (h < p  )//同上方循环次数不同时会掉入这个if
            {
                if (h == -1) { return str; }    //因此还需要进行判断
                else { return str.Substring(0, h); }
            }
            else
            {//Response.Write("<script>alert("+h+");</script>");
                return str.Substring(0, p);
            }
        }
    }
}