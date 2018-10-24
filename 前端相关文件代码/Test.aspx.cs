using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;  //ajax可以调用后台函数
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;  //stringbuilder

public partial class Test : System.Web.UI.Page
{
    //***************好多地方要给已有的数组啊啥的 运行时先清零，不然老有些奇奇怪怪的错误 （是因为static的原因？） ******************
    //***************还没找为什么题目会重复的问题出现在哪个环节，（应该不出在数据库语句） ******************
    //***************用户登录无法进入该页面（要不要这样做呢？） ******************

    protected static StringBuilder Subject_AllHtml = new StringBuilder();  //存放动态生成的Html的代码
    public static string Subject_FirstChose;       //存放用户选择的第一个题目类型
    public static string Subject_LastChose;        //存放用户选择的第二个题目类型
    static string SubjectTitle;           //存放题目的名字
    static string SubjectSolutionA;       //存放题目的A答案
    static string SubjectSolutionB;       //存放题目的B答案
    static string SubjectSolutionC;       //存放题目的C答案
    static string SubjectSolutionD;       //存放题目的D答案
    static string SubjectNo;              //存放题目类型为第几个
    static List<string> TrueSolution = new List<string>();         //存放动态生成的题目的正确答案 （暂时没用上）
    static List<string> Subject_UserChose = new List<string>();    //存放用户选择的题目类型(Subject_FirstChose和Subject_LastChose)
    static int j = 0;                     //存放当前为第几道题
    public static string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        string current_time = DateTime.Now.ToLongDateString().ToString();
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
 //获取当前用户的信息
        SqlCommand Cmaccount = new SqlCommand("SELECT UserName FROM Users WHERE UserAccount='" + Session["username"] + "'", Cn);
        SqlDataReader Draccount = Cmaccount.ExecuteReader();
        Draccount.Read();
            string users_name = Draccount.GetString(Draccount.GetOrdinal("UserName"));
        Draccount.Close();
            display_name.InnerText = users_name;  //后台调整前台用户的名字
            test_name.InnerText = users_name;
            test_time.InnerText = current_time;
            test_subject.InnerText = Subject_FirstChose + "、" + Subject_LastChose;
        }
    }

    [WebMethod]                        //Ajax调用后台函数所必须的解释
    public static String SayHello(string str1, string str2)
    {
        Subject_FirstChose = Test.Check_Subject(str1);          //将Ajax传过来的题目类型解析 (game -> 游戏，anime -> 动漫)
        Subject_LastChose = Test.Check_Subject(str2);
        Subject_UserChose.Clear();
        Subject_UserChose.Add(Subject_FirstChose);              //将用户选择的答案推入数组
        Subject_UserChose.Add(Subject_LastChose);

        if (Subject_FirstChose == "false" || Subject_LastChose == "false")          //没什么用的错误判定
        {
            Subject_FirstChose = "很抱歉出现错误，请勿修改Html调戏后台菌哦";
            return Subject_FirstChose.ToString(); ;
        }
        else
        {
            j = 0;                         // 初始化 j(题目号) (之前碰到第二次点开网页题号接着走的问题)
            Subject_AllHtml.Length = 0;    // 初始化 清空Subject_AllHtml   （理由同上）
 
            CreateBlock(Subject_UserChose, Subject_AllHtml);        //运行函数开始创建Html （将需要创建的模块名字 和 StringBuilder传过去）

            Subject_AllHtml.ToString();        //将StringBuilder转化为String (不转化Ajax接到的就是[object Object])  -> (不明白理由，但是没有大碍)
            return Subject_AllHtml.ToString(); //返回需要动态生成的Html 给Ajax
        }
    }

//函数创建题目的模块（eg:动漫题模块 或 游戏题模块）
    public static void CreateBlock (List<string> str,StringBuilder strbud)
    {
        for (int i = 0; i <= 1; i++)       //循环创建所有模块
        {
            switch (i)                     //判断第几次循环 （将数字转化为汉字）
            {
                case 0:
                    SubjectNo = "一";
                    break;
                case 1:
                    SubjectNo = "二";
                    break;
                case 2:
                    SubjectNo = "三";
                    break;
            }

            strbud.Append("<div class=\"subject_block\">\r\n");
            strbud.Append("<div class=\"block_title\">\r\n");
            strbud.Append("<span class=\"block_output\">" + str[i] + "</span>\r\n");
            strbud.Append("<span class=\"block_input\">（" + SubjectNo + "）</span>\r\n");
            strbud.Append("</div>\r\n");
            strbud.Append("<div class=\"block_subject\">\r\n");
            GetSubjectId(str[i]);
            CreateSubject(str[i],strbud);
            strbud.Append("</div>\r\n");
            strbud.Append("</div>\r\n");
        }
    }

//数组 将传过来的题目名字通过数据库搜索五道题，将题目的ID存入该数组
    public static List<string> GetSubjectId(string str)
    {
        List<string> SubjectId = new List<string>();           //************* static的原因 加上List<string>添加的原理   清空很重要！！！！！！！否则重复*************
        SubjectId.Clear(); 
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
            //随机抽取获得的数据库数据的方式
        SqlCommand CmSubjectFirstId = new SqlCommand("SELECT TOP 5 SubjectId FROM TestSubjects WHERE SubjectType='" + str + "' order  by  newid()  ", Cn);
        SqlDataReader DrSubjectFirstId = CmSubjectFirstId.ExecuteReader();
        while (DrSubjectFirstId.Read())
        {
            SubjectId.Add(DrSubjectFirstId["SubjectId"].ToString());
        }
        Cn.Close();
        return SubjectId;
    }

//函数 利用循环 运行函数添加Html内容 创建某题目模块下题目的内容（题目名字 题目答案）
    public static void CreateSubject(string str,StringBuilder strbud)
    {
        for (int i = 0; i <= 4; i++)
        {
            j += 1;
            strbud.Append("<li class=\"TESTLI\">\r\n");
            strbud.Append("<div class=\"subject_title\">\r\n");
            strbud.Append("<span class=\"subject_no\">" + j + "、</span>\r\n");
            CreateSubjectHtml(GetSubjectId(str)[i],strbud);
        }
    }

//函数 接收传过来的随机抽取的题目Id 和 Html标签的容器StringBuilder 通过Id运行数据库搜索题目相关信息，创建Html打入StringBuilder
    public static void CreateSubjectHtml (string str,StringBuilder strbud)
    {
        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
        SqlCommand CmSubjectInfo = new SqlCommand("SELECT SubjectTitle,SubjectSolutionA,SubjectSolutionB,SubjectSolutionC,SubjectSolutionD,SubjectSolutionTrue FROM TestSubjects WHERE SubjectId = '" + str + "'", Cn);
        SqlDataReader DrSubjectInfo = CmSubjectInfo.ExecuteReader();
        DrSubjectInfo.Read();
        SubjectTitle = DrSubjectInfo["SubjectTitle"].ToString();
        SubjectSolutionA = DrSubjectInfo["SubjectSolutionA"].ToString();
        SubjectSolutionB = DrSubjectInfo["SubjectSolutionB"].ToString();
        SubjectSolutionC = DrSubjectInfo["SubjectSolutionC"].ToString();
        SubjectSolutionD = DrSubjectInfo["SubjectSolutionD"].ToString();
        TrueSolution.Add(DrSubjectInfo["SubjectSolutionTrue"].ToString());
        DrSubjectInfo.Close();

        strbud.Append("<div class=\"subject_info\" data-id=" + str + ">" + SubjectTitle + "</div>\r\n");
        strbud.Append("</div>\r\n");
        strbud.Append("<div class=\"subject_solution\">\r\n");
        strbud.Append("<ul class=\"SOLUTIONUL\">\r\n");
        strbud.Append("<li class=\"SOLUTIONLI\" >\r\n");
        strbud.Append("<span class=\"solution_N\">A.</span>\r\n");
        strbud.Append("<div class=\"solution_N\">" + SubjectSolutionA + "</div>\r\n");
        strbud.Append("</li>\r\n");
        strbud.Append("<li class=\"SOLUTIONLI\">\r\n");
        strbud.Append("<span class=\"solution_N\">B.</span>\r\n");
        strbud.Append("<div class=\"solution_N\">" + SubjectSolutionB + "</div>\r\n");
        strbud.Append("</li>\r\n");
        strbud.Append("<li class=\"SOLUTIONLI\">\r\n");
        strbud.Append("<span class=\"solution_N\">C.</span>\r\n");
        strbud.Append("<div class=\"solution_N\">" + SubjectSolutionC + "</div>\r\n");
        strbud.Append("</li>\r\n");
        strbud.Append("<li class=\"SOLUTIONLI\">\r\n");
        strbud.Append("<span class=\"solution_N\">D.</span>\r\n");
        strbud.Append("<div class=\"solution_N\">" + SubjectSolutionD + "</div>\r\n");
        strbud.Append("</li>\r\n");
        strbud.Append("</ul>\r\n");
        strbud.Append("</div>\r\n");
        strbud.Append("</li>\r\n");
        Cn.Close();
    }

//函数 解析前台传过来的用户所选择的题目
    public static string Check_Subject(string str)
    {
        if (str.Contains("game"))
        {
            return str = "游戏";
        }
        else if (str.Contains("anime"))
        {
            return str = "动漫";
        }
        else if (str.Contains("lightnovel"))
        {
            return str = "轻小说";
        }
        else if (str.Contains("cold"))
        {
            return str = "冷知识";
        }
        else {
            str = "false";
            return str;
        }
    }
}