using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.IO;

public partial class Article : System.Web.UI.Page
{
    protected StringBuilder str = new StringBuilder();  //存放从数据库读取的评论
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
    string ReplyContent;  //评论内容
    string CurrentTime; //评论时间
    string ReplyId;  //评论ID
    string UserId;  //评论者ID
    string UserName; //评论者名字;
    string UserAccount; //评论者账号;
    string ReplyToContent;  //回复评论内容
    string AnsCurrentTime; //回复评论时间
    string ReplyToId;  //回复评论ID
    string UserToId;  //回复评论者ID
    string UserToName; //回复评论者名字;
    string UserToAccount; //回复评论者账号;
    int ListCount;  //评论数量
    int ListToCount;  //楼中楼数量
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.QueryString["id"];  //暂时用这个来读取url辨认是哪篇文章
        //Response.Write("<script>alert('"+id+"');</script>");
        if (Session["username"] != null)
        {
            login_li.Style["display"] = "none";
            register_li.Style["display"] = "none";
            message.Style["display"] = "inline-block";
            history.Style["display"] = "inline-block";
            profile.Style["display"] = "inline-block";
            display.Style["display"] = "inline-block";
            post.Style["display"] = "inline-block";
        }
        SqlConnection Cn = new SqlConnection(constr);
            Cn.Open();
        

        SqlCommand CmGet = new SqlCommand("SELECT ArticleTitle,ArticleContent,ArticleWriter,ArticleTime FROM Articles WHERE ArticleId='" + id + "'", Cn);
        SqlDataReader DrGet = CmGet.ExecuteReader();
        if (DrGet.Read())
        {
            string article_title = DrGet["ArticleTitle"].ToString();
            string article_content = DrGet["ArticleContent"].ToString();
            string article_writer = DrGet["ArticleWriter"].ToString();
            string article_time = DrGet["ArticleTime"].ToString();
            DrGet.Close();
            content_title.InnerText = article_title;
            temp.InnerHtml = article_content;
            content_detail.InnerHtml = temp.InnerText;
            meta_up.InnerText = article_writer;
            meta_time.InnerText = article_time;
            //这里有个问题，通过将文章 原封不动带Html标签放入数据库后（应该是使用较多的方法）
            //数据库本身会将< >等转义， 这样造成读取时需要进行反转义
            //目前有个问题   读取按网上所说直接InnerHtml即可，该方法可以进行反转义，但读出的数据仍带Html标签（如："<p>测试<p>"）
            //               即InnerHtml并没有原封不动的呈现文本编辑器输入的内容
            //目前俩办法  一是编写代码先将  文章文本读出用 Replace一种种反转义
            //            二是现在使用的  编写后发现若使用两次InnerHtml即可实现原本意图，但这样会导致需要读取两次文本还要赋值一次
            //想办法找个对用户加载网页来说友好的

            //仍然不知道time标签中datetime怎么更好的赋值 （便于搜索引擎搜索）
        }
        DrGet.Close();
        Cn.Close();

        ListCount = GetRepliesId(id).Count();
        CreateReply(ListCount,id);
    }
    //循环创建标签的函数 ，根据List函数完成目标创建评论区
    public void CreateReply(int r_max, string a_id)  //r_max List函数最大值 ，a_id当前文章ID
    {
        for (int i = r_max - 1; i >= 0; i--)
        {
            CreateReplyHtml(GetRepliesId(a_id)[i]);
        }
    }

    //声明一个List函数 装ReplyId
    public List<string> GetRepliesId(string r_id)  
    {
        List<string> RepliesId = new List<string>();   //初始化List
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
        SqlCommand CmRepliesId = new SqlCommand("SELECT ReplyId FROM Replies WHERE ArticleId = '" + r_id + "' AND ReplyToId = 0", Cn);    //加个ReplyToId = 0 的条件，把回复评论的数据剔除
        SqlDataReader DrRepliesId = CmRepliesId.ExecuteReader();
        while (DrRepliesId.Read())   //DataReader 中的 Read() 会从第一行读取数据库获取的值，读一行少一行，所以循环赋值直至所有的读完
        {
            RepliesId.Add(DrRepliesId["ReplyId"].ToString());
        }
        DrRepliesId.Close();
        Cn.Close();
        return RepliesId;
    }

    //用来创建评论区Html标签
    public void CreateReplyHtml(string r_id)  //r_id 当前所要创建的评论ID
    {
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
        //读取评论相关内容
        SqlCommand CmReply = new SqlCommand("SELECT ReplyId,ReplyContent,ReplyTime,UserId FROM Replies WHERE ReplyId='" + r_id + "'", Cn);
        SqlDataReader DrReply = CmReply.ExecuteReader();
        DrReply.Read();
        ReplyContent = DrReply["ReplyContent"].ToString();  //评论内容
        CurrentTime = DrReply["ReplyTime"].ToString();      //评论时间
        ReplyId = DrReply["ReplyId"].ToString();            //评论ID
        UserId = DrReply["UserId"].ToString();              //评论者ID
        DrReply.Close();
        
        //运行函数获取当前评论的ID，建立回复当前ID的评论的数组ID
        GetRepliesToId(r_id);        
        ListToCount = GetRepliesToId(r_id).Count();

        //读取评论者相关信息
        SqlCommand CmUser = new SqlCommand("SELECT UserName,UserAccount FROM Users WHERE UserId = '" + UserId + "'", Cn);
        SqlDataReader DrUser = CmUser.ExecuteReader();
        DrUser.Read();
        UserName = DrUser["UserName"].ToString();
        UserAccount = DrUser["UserAccount"].ToString();
        DrUser.Close();

        //文件流，读取头像的base4存放txt (需要 System.IO)
        StreamReader sr = new StreamReader("E:\\Visual Stadio 2015\\网站\\SchoolProject\\UserHead\\" + UserAccount + ".txt", Encoding.Default);
        string headbase = sr.ReadToEnd();
        Cn.Close();

        str.Append("<div class=\"article_reply_list\" data-id=" + r_id + ">\r\n");
        str.Append("<div class=\"reply_list_head\">\r\n");
        str.Append("<a href=\"\" target=\"_blank\">\r\n");
        str.Append("<img src=" + headbase + " class=\"reply_user_head\"/>\r\n");
        str.Append("</a>\r\n");
        str.Append("</div>\r\n");
        str.Append("<div class=\"reply_list_main\">\r\n");
        str.Append("<div class=\"reply_user_name\" data-uid=" + UserId + ">\r\n");
        str.Append("<a href=\"\" runat=\"server\">" + UserName + "</a>\r\n");
        str.Append("</div>\r\n");
        str.Append("<p>" + ReplyContent + "</p>\r\n");
        str.Append("<div class=\"reply_list_meta\">\r\n");
        str.Append("<span class=\"floor\">#" + ListCount-- + "</span>\r\n");
        str.Append("<span class=\"time\" runat=\"server\">" + CurrentTime + "</span>\r\n");
        str.Append("</div>\r\n");
        str.Append("<div class=\"reply_list_box\">\r\n");
        str.Append("<div class=\"reply_button\">回复</div>\r\n");
        str.Append("</div>\r\n");
        str.Append("<div class=\"reply_list_answer\">\r\n");
        //判断当前评论ID在数据库中是否被其他评论使用
        if (ListToCount > 0)
        {
            CreateReplyTo(ListToCount,r_id);
        }
        str.Append("</div>\r\n");
        str.Append("</div>\r\n");
        str.Append("</div>\r\n");
    }

    //循环创建标签的函数 ，根据List函数完成目标创建楼中楼
    public void CreateReplyTo(int rt_max,string rt_id)
    {
        for (int i = rt_max - 1; i >= 0; i--)
        {
            CreateReplyToHtml(GetRepliesToId(rt_id)[i]);
        }
    }

    //声明一个List函数 装ReplyId 但是是楼中楼
    public List<string> GetRepliesToId(string rt_id)
    {
        List<string> RepliesToId = new List<string>();
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
        SqlCommand CmRepliesToId = new SqlCommand("SELECT ReplyId FROM Replies WHERE ReplyToId = '" + rt_id + "'", Cn);
        SqlDataReader DrRepliesToId = CmRepliesToId.ExecuteReader();
        while (DrRepliesToId.Read())
        {
            RepliesToId.Add(DrRepliesToId["ReplyId"].ToString());
        }
        DrRepliesToId.Close();
        Cn.Close();
        return RepliesToId;
    }
    
    //用来创建回复评论区域的Html
    public void CreateReplyToHtml(string rt_id)
    {
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
        //读取回复评论相关内容
        SqlCommand CmReplyTo = new SqlCommand("SELECT ReplyId, ReplyContent, ReplyTime, UserId FROM Replies WHERE ReplyId = '" + rt_id + "'", Cn);
        SqlDataReader DrReplyTo = CmReplyTo.ExecuteReader();
        DrReplyTo.Read();
        ReplyToContent = DrReplyTo["ReplyContent"].ToString();  //回复评论内容
        AnsCurrentTime = DrReplyTo["ReplyTime"].ToString();      //回复评论时间
        ReplyToId = DrReplyTo["ReplyId"].ToString();            //回复评论ID
        UserToId = DrReplyTo["UserId"].ToString();              //回复评论者ID    
        DrReplyTo.Close();

        //读取回复评论者相关信息
        SqlCommand CmUserTo = new SqlCommand("SELECT UserName,UserAccount FROM Users WHERE UserId = '" + UserToId + "'", Cn);
        SqlDataReader DrUserTo = CmUserTo.ExecuteReader();
        DrUserTo.Read();
        UserToName = DrUserTo["UserName"].ToString();
        UserToAccount = DrUserTo["UserAccount"].ToString();
        DrUserTo.Close();

        //文件流，读取头像的base4存放txt (需要 System.IO)
        StreamReader sr = new StreamReader("E:\\Visual Stadio 2015\\网站\\SchoolProject\\UserHead\\" + UserToAccount + ".txt", Encoding.Default);
        string headbase = sr.ReadToEnd();
        Cn.Close();

        str.Append("<div class=\"list_answer_box\" data-id=" + rt_id + ">\r\n");
              str.Append("<div class=\"list_answer_head\">\r\n");                
                str.Append("<a href = \"\" target=\"_blank\">\r\n");                    
                  str.Append("<img src =" + headbase + " class=\"reply_answer_head\">\r\n");                        
                str.Append("</a>\r\n");                    
              str.Append("</div>\r\n");                
              str.Append("<div class=\"list_answer_main\">\r\n");                
                str.Append("<div class=\"list_answer_name\" data-uid=" + UserToId + ">\r\n");
                  str.Append("<a class=\"reply_answer_name\">" + UserToName + "</a>\r\n");                        
                  str.Append("<i></i>\r\n");                        
                str.Append("</div>\r\n");
                str.Append("<div class=\"list_answer_content\">\r\n");
                  str.Append("<span>" + ReplyToContent + "</span>\r\n");
                str.Append("</div>\r\n");
                str.Append("<div class=\"list_answer_meta\">\r\n");
                  str.Append("<span class=\"time\">" + AnsCurrentTime + "</span>\r\n");
                  str.Append("<div class=\"answer_button\">回复</div>\r\n");
                str.Append("</div>\r\n");
              str.Append("</div>\r\n");
            str.Append("</div>\r\n");
    }

}