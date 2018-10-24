using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;

public partial class Head : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            login_li.Style["display"] = "none";
            register_li.Style["display"] = "none";
            message.Style["display"] = "inline-block";
            history.Style["display"] = "inline-block";
            profile.Style["display"] = "inline-block";
            display.Style["display"] = "inline-block";
            post.Style["display"] = "inline-block";

            SqlConnection Cn = new SqlConnection(constr);
            Cn.Open();

            SqlCommand Cmaccount = new SqlCommand("SELECT UserName FROM Users WHERE UserAccount='" + Session["username"] + "'", Cn);
            SqlDataReader Draccount = Cmaccount.ExecuteReader();
            Draccount.Read();
            string users_name = Draccount.GetString(Draccount.GetOrdinal("UserName"));
            Draccount.Close();
            display_name.InnerText = users_name;
            user_name.InnerText = users_name;

            SqlCommand Cmsign = new SqlCommand("SELECT * FROM Users WHERE UserAccount='" + Session["username"] + "'", Cn);
            SqlDataReader Drsign = Cmsign.ExecuteReader();
            if (Drsign.Read())
            {
                string users_sign = Drsign["UserSign"].ToString();
                Drsign.Close();
                user_sign.InnerText = users_sign;
            }

            StreamReader sr = new StreamReader("C:\\SchoolProject\\UserHead\\"+ Session["username"]+".txt", Encoding.Default);
            string headbase = sr.ReadToEnd();
            user_head.Src = headbase;
            display_head.Src = headbase;

            Cn.Close();
         }
        else
        {
            Response.Redirect("Login_not.aspx", true);
        }
    }

    protected void upload_head_Click(object sender, EventArgs e)
    {
        string temp = tempBase.Value;
        Write(temp);
        //SqlConnection Cnbase = new SqlConnection(constr);
        //Cnbase.Open();
        //if (Session["username"] != null)
        //{
        //    SqlCommand Cmbase = new SqlCommand("UPDATE Users SET UserHead = '" + temp + "' WHERE UserAccount='" + Session["username"] + "'", Cnbase);
        //    int i = Cmbase.ExecuteNonQuery();
        //    Response.Write("<script>alert('修改成功');</script>");
        //}
        //else
        //{
        //    Response.Redirect("Login_not.aspx", true);
        //}
        //Cnbase.Close();
    }

//Base64明显缺点，图片过大的话不建议使用，这里用了Base64存不进数据库只能放入txt中   暂不作修改

    public void Write(string ib)
    {
        FileStream fs = new FileStream("C:\\SchoolProject\\UserHead\\"+ Session["username"]+".txt", FileMode.Create);
        //获得字节数组
        byte[] data = System.Text.Encoding.Default.GetBytes(ib);
        //开始写入
        fs.Write(data, 0, data.Length);
        //清空缓冲区、关闭流
        fs.Flush();
        fs.Close();
    }
}