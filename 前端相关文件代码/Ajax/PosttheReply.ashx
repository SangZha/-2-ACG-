<%@ WebHandler Language="C#" Class="PosttheReply" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Configuration;

//ashx调用session
//放俩命名空间 System.Web , System.Web.SessionState 然后接口增加自　IRequiresSessionState

public class PosttheReply : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string UserAccount = context.Session["username"].ToString(); //存放Session，方便对应数据库表
        string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString; //定义数据库连接
        string NewReplyTo = context.Request.Form["NewReplyId"]; //获取Ajax传来的非回复他人评论记号
        string ReplyContent = context.Request.Form["ReplyContent"]; //获取Ajax传来的评论区内容
        string ArticleId = context.Request.Form["ArticleId"]; //获取Ajax传来的文章ID
        string ReplyToId = context.Request.Form["ReplyToId"]; //获取Ajax传来的被回复评论ID
        string ReplyToUserId = context.Request.Form["ReplyToUserId"]; //获取Ajax传来的被回复评论 评论者ID
        string CurrentTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");            //获取时间 yyyy-MM-dd HH:mm:ss
        string UserId; //存放用户ID (后面连接数据获取)
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();

        SqlCommand CmAccount = new SqlCommand("SELECT UserId FROM Users WHERE UserAccount='" + UserAccount + "'", Cn);
        SqlDataReader DrAccount = CmAccount.ExecuteReader();
        DrAccount.Read();
        UserId = DrAccount["UserId"].ToString();  //获取用户ID(接上数据库获取)
        DrAccount.Close();
  //判断记号，如果为0说明是对文章评论 否则是回复他人，赋个1，证明未读消息
        if(NewReplyTo != "0")
        {
                NewReplyTo = "1";
        }

        SqlCommand CmInsert = new SqlCommand("INSERT INTO Replies(ReplyContent,ReplyTime,ArticleId,UserId,ReplyToId,ToUserId,NewReplyTo) VALUES ('" + ReplyContent + "','" + CurrentTime + "','" + ArticleId + "','" + UserId + "','" + ReplyToId + "','" + ReplyToUserId + "','" + NewReplyTo + "')", Cn);
        int i = CmInsert.ExecuteNonQuery();
        Cn.Close();

        //string OriPass = context.Request.Form["ReplyContent"];   //原始密码(Get传参对应QueryString)
        context.Response.Write(ReplyToId);   //返回信息
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}