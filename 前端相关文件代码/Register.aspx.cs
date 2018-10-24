using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Register : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void register_button_Click(object sender, EventArgs e)
    {

        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();

        SqlCommand Cmname = new SqlCommand("SELECT * FROM Users WHERE UserName='" + name.Text + "'", Cn);
        SqlDataReader Drname = Cmname.ExecuteReader();
        if (Drname.Read())//如果存在相同昵称
        {
            name_same.Style["display"] = "block";
            Drname.Close();
        }
        else if (name.Text==""){
            name_none.Style["display"] = "block";
        }
        else
        {
            Drname.Close();
       
            SqlCommand Cmaccount = new SqlCommand("SELECT * FROM Users WHERE UserAccount='" + account.Text + "'", Cn);
            SqlDataReader Draccount = Cmaccount.ExecuteReader(); 
            if (Draccount.Read())
            {
                account_same.Style["display"] = "block";
                Draccount.Close();
            }
            else if (account.Text==""){
                account_none.Style["display"] = "block";
            }
            else 
            {
                Drname.Close();
                Draccount.Close();
                SqlCommand CmInsert = new SqlCommand("INSERT INTO Users (UserName,UserAccount,UserPassword) VALUES ('" + name.Text + "','" + account.Text + "','" + password.Text + "')", Cn);
                int i = CmInsert.ExecuteNonQuery();
                //message.InnerHtml = "注册成功";
                Response.Write("<script>alert('注册成功');window.window.location.href='Login.aspx';</script>");
            }
            Cn.Close();
       }
    }
}