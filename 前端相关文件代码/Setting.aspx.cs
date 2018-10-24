using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class Setting : System.Web.UI.Page
{
    string temp;
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
       // Response.Write("<script>alert("+Session["username"]+");</script>");
        if (Session["username"] != null)
        {
            string user_account = Session["username"].ToString();
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
        text_name.Text = users_name;

        SqlCommand Cmsign = new SqlCommand("SELECT * FROM Users WHERE UserAccount='" + Session["username"] + "'", Cn);
        SqlDataReader Drsign = Cmsign.ExecuteReader();
            if (Drsign.Read())
            {
                string users_sign = Drsign["UserSign"].ToString();
                Drsign.Close();
                user_sign.InnerText = users_sign;
                text_sign.InnerText = users_sign;
            }
        
        SqlCommand Cmsex = new SqlCommand("SELECT UserSex FROM Users WHERE UserAccount='" + user_account + "'", Cn);
        SqlDataReader Drsex = Cmsex.ExecuteReader();
            if (Drsex.Read())
            {
                string users_sex = Drsex["UserSex"].ToString();
                if(users_sex == "男")
                {
                    radio_boy.Checked = true;
                }
                else if (users_sex == "女")
                {
                    radio_boy.Checked = true;
                }
                else if(users_sex == "保密")
                {
                    radio_boy.Checked = true;
                }
                Drsex.Close();
            }

         SqlCommand Cmbirth = new SqlCommand("SELECT UserBirth FROM Users WHERE UserAccount='" + user_account + "'", Cn);
         SqlDataReader Drbirth = Cmbirth.ExecuteReader();
            if(Drbirth.Read())
            {
                string users_birth = Drbirth["UserBirth"].ToString();
                Drbirth.Close();
                calendar.Text = users_birth;
            }

         SqlCommand Cmprovince = new SqlCommand("SELECT UserProvince FROM Users WHERE UserAccount='" + user_account + "'", Cn);
         SqlDataReader Drprovince = Cmprovince.ExecuteReader();
            if (Drprovince.Read())
            {
                string users_province = Drprovince["UserProvince"].ToString();
                Drprovince.Close();
                location_province.InnerText = users_province;
            }

        SqlCommand Cmcity = new SqlCommand("SELECT UserCity FROM Users WHERE UserAccount='" + user_account + "'", Cn);
        SqlDataReader Drcity = Cmcity.ExecuteReader();
            if (Drcity.Read())
            {
                string users_city = Drcity["UserCity"].ToString();
                Drcity.Close();
                location_city.InnerText = users_city;
            }

            SqlCommand Cmlove = new SqlCommand("SELECT UserLove FROM Users WHERE UserAccount='" + user_account + "'", Cn);
         SqlDataReader Drlove = Cmlove.ExecuteReader();
            if(Drlove.Read())
            {
                string users_love = Drlove["UserLove"].ToString();
                switch(users_love)
                {
                    case "0":
                        inner_info_orientation.SelectedValue = "0";
                        break;
                    case "1":
                        inner_info_orientation.SelectedValue = "1";
                        break;
                    case "2":
                        inner_info_orientation.SelectedValue = "2";
                        break;
                    case "3":
                        inner_info_orientation.SelectedValue = "3";
                        break;
                    case "4":
                        inner_info_orientation.SelectedValue = "4";
                        break;
                }
                Drlove.Close();
            }

         SqlCommand CmQQ = new SqlCommand("SELECT UserQQ,UserWechat FROM Users WHERE UserAccount='" + user_account + "'", Cn);
         SqlDataReader DrQQ = CmQQ.ExecuteReader();
            if (DrQQ.Read())
            {
                string users_qq = DrQQ["UserQQ"].ToString();
                text_qq.Text = users_qq;
                string users_wechat = DrQQ["UserWechat"].ToString();
                text_wechat.Text = users_wechat;
                DrQQ.Close();
            }
                Cn.Close();
        }
    }

    protected void button_submit_Click(object sender, EventArgs e)
    {
        if (radio_boy.Checked){
            temp = "男";
            } 
        else if (radio_girl.Checked){
            temp = "女";
            }
        else if (radio_secret.Checked){
            temp = "保密";
        }


        SqlConnection Cn2 = new SqlConnection(constr);  //判断昵称是否数据库中有相同
        Cn2.Open();
        SqlCommand Cmname_confirm = new SqlCommand("SELECT * FROM Users WHERE UserName='" + text_name + "'", Cn2);
        SqlDataReader Drcname_confirm = Cmname_confirm.ExecuteReader();
        if (Drcname_confirm.Read())
        {
            name_same.Style["display"] = "inline-block";
            Drcname_confirm.Close();
        }
        else  //没有则将表单中的数据更新到数据库
        {
            Drcname_confirm.Close();
            SqlCommand CmUpdate = new SqlCommand("UPDATE Users SET UserName='" + text_name.Text + "', UserSign='" + text_sign.InnerText + "', UserSex='" + temp + "', UserBirth='" + calendar.Text + "', UserLove='" + inner_info_orientation.SelectedValue + "', UserQQ='" + text_qq.Text + "', UserWechat='" + text_wechat.Text + "' WHERE UserAccount='" + Session["username"] + "'", Cn2);
            int i = CmUpdate.ExecuteNonQuery();
            Response.Write("<script>alert('修改成功');window.window.location.href='Setting.aspx';</script>");
        }
        Cn2.Close();
    }
}