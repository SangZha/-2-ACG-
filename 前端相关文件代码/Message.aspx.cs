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

//动态生成方法： 由于该界面不需要用户互动，直接往前台放 StringBuilder变量生成动态页面

public partial class Message : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
        String UserOwnName;        //存取用户自己的名字
        String UserOwnId;          //存取用户自己的Id
        String UserOwnHead;        //存取用户自己的头像地址
        String UserOtherId;        //存取回复者的Id
        String UserOtherName;      //存取回复者的名字
        String UserOtherAccount;   //存取回复者的账号(搜索头像地址用)
        String UserOtherHead;      //存取回复者的头像地址
        String ReplyId;            //存取回复评论的ID
        String ReplyToCotent;      //存取回复评论的内容
        String ReplyToTime;        //存取回复评论时间
        String ReplyArticleId;     //存取评论所在的文章ID
        String ReplyToId;          //存取用户被他人回复的评论ID
        String ReplyOwnContent;    //存取用户被他人回复的评论内容
        int ReplyLength;           //存取数据库搜索出用户被回复的评论的ID数组长度
        protected StringBuilder ReplyHtml = new StringBuilder();
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
        
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
//数据库操作：通过Session读取当前用户的姓名和ID
        SqlCommand Cmaccount = new SqlCommand("SELECT UserName,UserId,UserHead FROM Users WHERE UserAccount='" + Session["username"] + "'", Cn);
        SqlDataReader Draccount = Cmaccount.ExecuteReader();
        Draccount.Read();
            UserOwnName = Draccount.GetString(Draccount.GetOrdinal("UserName"));         //这个方法是获得序列，把序列转化为字符串，不是很懂区别（不是差不多吗？）
            UserOwnId = Draccount["UserId"].ToString();
        Draccount.Close();
        Cn.Close();
            display_name.InnerText = UserOwnName;

            ReplyLength = GetRepliesId(UserOwnId).Count() ;  //获取ID数组的长度
            ForToCreate(ReplyLength, UserOwnId);             //运行循环创建被回复信息的函数
        }
    }

//函数：循环创建Html
    public void ForToCreate(int ReplyLength, string UserOwnId)
    {
        for (int i = ReplyLength - 1; i >= 0; i--)
        {
            GetReplyInfo(GetRepliesId(UserOwnId)[i]);
        }
    }

//数组函数： 搜索当前用户所有被回复过的评论的ID
    public List<string> GetRepliesId(string UserOwnId)
    {
        List<string> RepliesId = new List<string>();
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
        SqlCommand CmRepliesId = new SqlCommand("SELECT ReplyId FROM Replies WHERE ToUserId = '" + UserOwnId + "'", Cn);
        SqlDataReader DrRepliesId = CmRepliesId.ExecuteReader();
        while (DrRepliesId.Read())
        {
            RepliesId.Add(DrRepliesId["ReplyId"].ToString());
        }
        DrRepliesId.Close();
        Cn.Close();
        return RepliesId;
    }

//函数：数据库操作获取每条被回复评论的 回复评论ID、回复评论内容、回复评论时间、回复者姓名、回复者头像地址、被回复评论ID、被回复评论内容 ，并运行StringBuilder赋值语句
    public void GetReplyInfo(string ReplyId)
    {   
            SqlConnection Cn = new SqlConnection(constr);
            Cn.Open();
            SqlCommand CmGetOtherReply = new SqlCommand("SELECT ReplyContent,ReplyTime,ArticleId,ReplyToId FROM Replies WHERE ReplyId = '" + ReplyId + "'", Cn);
            SqlDataReader DrGetOtherReply = CmGetOtherReply.ExecuteReader();
            DrGetOtherReply.Read();
                ReplyToCotent = DrGetOtherReply["ReplyContent"].ToString();
                ReplyToTime = DrGetOtherReply["ReplyTime"].ToString();
                ReplyArticleId = DrGetOtherReply["ArticleId"].ToString();
                ReplyToId = DrGetOtherReply["ReplyToId"].ToString();
            DrGetOtherReply.Close();

            SqlCommand CmGetOwnReply = new SqlCommand("SELECT ReplyContent,UserId FROM Replies WHERE ReplyId = '" + ReplyToId + "'", Cn);
            SqlDataReader DrGetOwnReply = CmGetOwnReply.ExecuteReader();
            DrGetOwnReply.Read();
                ReplyOwnContent = DrGetOwnReply["ReplyContent"].ToString();
                UserOtherId = DrGetOwnReply["UserId"].ToString();
            DrGetOwnReply.Close();

            SqlCommand CmGetOtherInfo = new SqlCommand("SELECT UserName,UserAccount FROM Users WHERE UserId = '" + UserOtherId + "'", Cn);
            SqlDataReader DrGetOtherInfo = CmGetOtherInfo.ExecuteReader();
            DrGetOtherInfo.Read();
                UserOtherName = DrGetOtherInfo["UserName"].ToString();
                UserOtherAccount = DrGetOtherInfo["UserAccount"].ToString();
            DrGetOtherInfo.Close();

            StreamReader sr = new StreamReader("E:\\Visual Stadio 2015\\网站\\SchoolProject\\UserHead\\" + UserOtherAccount + ".txt", Encoding.Default);
            UserOtherHead = sr.ReadToEnd();

        CreateReplyHtml(ReplyId, ReplyToCotent, ReplyToTime, ReplyArticleId, ReplyToId, ReplyOwnContent, UserOtherName, UserOtherHead);
    }

 //函数：接收上一函数传送过来的相关信息，将信息打入Html中，赋值给StringBuilder
    public void CreateReplyHtml(string ReplyId, string ReplyToCotent, string ReplyToTime,string ReplyArticleId, string ReplyToId, string ReplyOwnContent, string UserOtherName, string UserOtherHead)
    {
        ReplyHtml.Append("<li class=\"message_main_list\" data-rid=" + ReplyId + ">\r\n");
            ReplyHtml.Append("<div class=\"main_list_left\">\r\n");
                ReplyHtml.Append("<a href = \"\" class=\"main_list_head\">\r\n");
                    ReplyHtml.Append("<img src =" + UserOtherHead + " alt=" + UserOtherName + ">\r\n");
                ReplyHtml.Append("</a>\r\n");
            ReplyHtml.Append("</div>\r\n");
            ReplyHtml.Append("<div class=\"main_list_right\">\r\n");
                ReplyHtml.Append("<a href =\"\" class=\"main_list_username\">" + UserOtherName + "</a>\r\n");
                ReplyHtml.Append("<span class=\"main_list_time\">" + ReplyToTime + "</span>\r\n");
                ReplyHtml.Append("<div class=\"main_list_reply\">" + ReplyToCotent + "</div>\r\n");
                ReplyHtml.Append("<div class=\"main_list_source\" data-oid=" + ReplyToId + ">\r\n");
                    ReplyHtml.Append("<a href = \"Article.aspx?id=" + ReplyArticleId + "\"  class=\"list_source_title\">" + ReplyOwnContent + "</a> \r\n");
                ReplyHtml.Append("</div>\r\n");
            ReplyHtml.Append("</div>\r\n");
        ReplyHtml.Append("</li>\r\n");
    }
}