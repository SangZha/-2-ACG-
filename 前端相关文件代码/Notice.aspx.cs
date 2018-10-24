using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Notice : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
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
        Draccount.Read();
        string users_name = Draccount.GetString(Draccount.GetOrdinal("UserName"));
        Draccount.Close();
        display_name.InnerText = users_name;
    }
}