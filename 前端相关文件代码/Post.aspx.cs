using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Post : System.Web.UI.Page
{
    string title;  //文章标题 （隐藏）
    string content;   //读取文章内容
    string writer;  //Session作者
    string time;    //读取电脑时间（需要修改）
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null){
            Response.Write("<script language=javascript>window.window.location.href='Login.aspx';</script>");
        }
        else { 
        SqlConnection Cn1 = new SqlConnection(constr);
        Cn1.Open();
        SqlCommand CmName = new SqlCommand("SELECT UserName FROM Users WHERE UserAccount='" + Session["username"] + "'", Cn1);
        SqlDataReader DrName = CmName.ExecuteReader();
            DrName.Read();
            writer = DrName.GetString(DrName.GetOrdinal("UserName"));
            DrName.Close();
        Cn1.Close();       
        }
    }

    protected void article_submit_Click(object sender, EventArgs e)
    {
        title = hidden.Value;
        content = editor_content.InnerHtml;
        time = DateTime.Now.ToLongDateString().ToString();  //yyyy年m月d日

        SqlConnection Cn2 = new SqlConnection(constr);
        Cn2.Open();
        SqlCommand CmInsert = new SqlCommand("INSERT INTO Articles (ArticleTitle,ArticleContent,ArticleWriter,ArticleTime) VALUES ('" + title + "','" + content + "','" + writer +"','" + time + "')", Cn2);
        int i = CmInsert.ExecuteNonQuery();

        Response.Write("<script>alert('发布成功');window.window.location.href='News.aspx'</script>");
        Cn2.Close();
    }
}