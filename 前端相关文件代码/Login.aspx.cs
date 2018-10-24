using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Login : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            Response.Redirect("Login_done.aspx", true);
        }
    }
  
    protected void login_button_Click(object sender, EventArgs e)
    {
        if (account.Text != null && password.Text != null)
        {
            SqlConnection Cn = new SqlConnection(constr);
            Cn.Open();
            SqlCommand Cm = new SqlCommand("SELECT * FROM Users WHERE UserAccount='" + account.Text + "' AND UserPassword ='" + password.Text + "'", Cn);
            SqlDataReader Dr = Cm.ExecuteReader();
            if (Dr.Read())//用户名和密码是否正确
            {
                Session["username"] = account.Text;
                Session["password"] = password.Text;
                Dr.Close();
                Response.Write("<script>window.window.location.href='Home.aspx'</script>");
            }
            else 
            {
                Dr.Close();
                SqlCommand Cmaccount = new SqlCommand("SELECT * FROM Users WHERE UserAccount='" + account.Text + "'", Cn);
                SqlDataReader Draccount = Cmaccount.ExecuteReader();
                if(Draccount.Read())
                {
                    password_wrong.Style["display"] = "block";
                    Draccount.Close();
                }
                else
                {
                    account_wrong.Style["display"] = "block";
                    Draccount.Close();
                }
            }
            
            Cn.Close();
        }
        else
        {
            account_none.Style["display"] = "block";
            password_none.Style["display"] = "block";
        }
    }
}
