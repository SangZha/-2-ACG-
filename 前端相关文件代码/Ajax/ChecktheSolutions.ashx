<%@ WebHandler Language="C#" Class="ChecktheSolutions" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public class ChecktheSolutions : IHttpHandler,IRequiresSessionState{
    StringBuilder TestResultStr = new StringBuilder();
    string constr = ConfigurationManager.ConnectionStrings["SchoolProjectConnectionString"].ConnectionString;
    string SubjectWrongTitle;           //存放题目的名字
    string SubjectWrongSolutionA;       //存放题目的A答案
    string SubjectWrongSolutionB;       //存放题目的B答案
    string SubjectWrongSolutionC;       //存放题目的C答案
    string SubjectWrongSolutionD;       //存放题目的D答案

    string SolutionChoseA;string SolutionChoseB;string SolutionChoseC;string SolutionChoseD;       //放class:solution_chose，在后台就将用户选择了答案加上class效果
    string SolutionTrueA;string SolutionTrueB;string SolutionTrueC;string SolutionTrueD;          //同上原因 但是是给 正确的答案 换颜色   
                                                                                                  //这么麻烦都是因为你只知道如何返回一个数给Ajax的原因！！！！ ***************************
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        //ashx接受ajax传过来的数组直接用一个变量接的话会直接变成  第一个数组,第二个数组,第三个数组..........

        int TempNumber = 0;
        int UserPoint = 100;

        String UserSolution = context.Request.Form["Array_Solutions"];       //存放传过来的答案
        String SolutionId = context.Request.Form["Array_SolutionsId"];     //存放传过来的题目ID
                                                                           //未将对象引用设置到对象的实例 -> 变量没有值 
        String[] UserSolutionArray = UserSolution.Split(',');              //将传递过来的题目答案分解成数组
        String[] UserSolutionIdArray = SolutionId.Split(',');              //将传递过来的题目ID分解成数组 

        List<string> TrueSolutionArray = new List<string>();          //存放正确的答案

        List<string> WrongSolutionArray = new List<string>();         //存放回答错误的题目的答案
        List<string> WrongSolutionIdArray = new List<string>();       //存放回答错误的题目的ID

        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
        foreach (string SubjectId in UserSolutionIdArray)          //foreach循环， 1、接收前台传过来的动态生成的题目的ID搜索其答案存入 TrueSolutionArray
                                                                   //              2、记录用户分数
                                                                   //              3、核对用户答案，将错误答案和ID分别放入对应数组
        {
            SqlCommand CmSubjectId = new SqlCommand("SELECT SubjectSolutionTrue FROM TestSubjects WHERE SubjectId = '" + SubjectId + "'", Cn);
            SqlDataReader DrSubjectId = CmSubjectId.ExecuteReader();
            DrSubjectId.Read();
            TrueSolutionArray.Add(DrSubjectId["SubjectSolutionTrue"].ToString());
            if (TrueSolutionArray[TempNumber] != UserSolutionArray[TempNumber])
            {
                UserPoint = UserPoint - 4;
                WrongSolutionIdArray.Add(SubjectId.ToString());
                WrongSolutionArray.Add(UserSolutionArray[TempNumber].ToString());
            }
            TempNumber++;
            DrSubjectId.Close();
        }
        Cn.Close();

        CreateResult(UserPoint,WrongSolutionIdArray,WrongSolutionArray,TrueSolutionArray);      //用户提交试卷后，该函数创建结果（分别传入：分数、错误题目ID、错误题目答案、题目正确答案）

        context.Response.Write(TestResultStr.ToString());           //这串代码即会将括号内的内容传递给 Ajax :Success(data)中

    }

    //函数 用来创建用户回答错误的问题的相关提示（标题，分数）（后期需要修改，太不美观） ***********************************
    public void CreateResult(int point,List<string> idArray,List<string> wrongSolutionArray,List<string> trueSolutionArray)
    {
        if (idArray.Count == 0)
        {
            TestResultStr.Append("<div class=\"userinfo_userpoint\" data-id=" + point + "></div>\r\n");
            TestResultStr.Append("<div class=\"subject_block\">\r\n");
            TestResultStr.Append("<div class=\"block_allchecked\">\r\n");
            TestResultStr.Append("<h1 class=\"block_output\">很棒唉！你全部做对了哦</h1>\r\n");
            TestResultStr.Append("</div>\r\n");
        }
        else {
            TestResultStr.Append("<div class=\"userinfo_userpoint\" data-id=" + point + "></div>\r\n");
            TestResultStr.Append("<div class=\"subject_block\">\r\n");
            TestResultStr.Append("<div class=\"block_title\">\r\n");
            TestResultStr.Append("<span class=\"block_output\">这些题目您做错了嗷：</span>\r\n");
            TestResultStr.Append("</div>\r\n");
            TestResultStr.Append("<div class=\"block_subject\">\r\n");
            CreateWrongSubject(idArray,wrongSolutionArray,trueSolutionArray);     //在这里运行CreateWrongSubject函数，创建回答错误的题
            TestResultStr.Append("</div>\r\n");
        }
    }

    //函数  用来创建用户所做错的相应的题目
    public void CreateWrongSubject(List<string> idArray,List<string> wrongSolutionArray,List<string> trueSolutionArray)
    {
        int tempNumber = 0;       //由于foreach语句，加个变量记录循环次数

        SqlConnection Cn = new SqlConnection(constr);
        Cn.Open();
        foreach(string id in idArray)
        {
            tempNumber++;
            SqlCommand CmSubject = new SqlCommand("SELECT SubjectTitle,SubjectSolutionA,SubjectSolutionB,SubjectSolutionC,SubjectSolutionD FROM TestSubjects WHERE SubjectId = '" + id + "'", Cn);
            SqlDataReader DrSubject = CmSubject.ExecuteReader();
            DrSubject.Read();
            SubjectWrongTitle = DrSubject["SubjectTitle"].ToString();       //读取错误答案题目
            SubjectWrongSolutionA = DrSubject["SubjectSolutionA"].ToString();    //读取错误题目的答案A
            SubjectWrongSolutionB = DrSubject["SubjectSolutionB"].ToString();    //读取错误题目的答案B
            SubjectWrongSolutionC = DrSubject["SubjectSolutionC"].ToString();    //读取错误题目的答案C
            SubjectWrongSolutionD = DrSubject["SubjectSolutionD"].ToString();    //读取错误题目的答案D
            DrSubject.Close();

            ChoseCheck(wrongSolutionArray[tempNumber-1]);   //运行函数判断哪个是用户选错的答案，给那个赋值  达成给相应答案加class的目的
            TrueCheck(trueSolutionArray[tempNumber - 1]);   //运行函数判断哪个正确的答案  ，给那个赋值  达成给相应答案加class的目的

            //SolutionChoseA/B/C/D -> solution_chose（即前台效果:勾）    
            //SolutionTrueA/B/C/D -> solution_N_Wrong （即前台效果：正确答案颜色变粉）
            //感觉这个记录用户错误和正确答案的方法会浪费很多运行（判断语句，清空变量等）  所以学好怎么返回数组给Ajax！！！*****************************************************
            TestResultStr.Append("<li class=\"TESTLI\">\r\n");
            TestResultStr.Append("<div class=\"subject_title\">\r\n");
            TestResultStr.Append("<span class=\"subject_no\">" + tempNumber + "、</span>\r\n");
            TestResultStr.Append("<div class=\"subject_info\" data-id=" + id + ">" + SubjectWrongTitle + "</div>\r\n");
            TestResultStr.Append("</div>\r\n");
            TestResultStr.Append("<div class=\"subject_solution\">\r\n");
            TestResultStr.Append("<ul class=\"SOLUTIONUL\">\r\n");
            TestResultStr.Append("<li class=\"SOLUTIONLI " + SolutionChoseA + "\">\r\n");
            TestResultStr.Append("<span class=\"solution_N " + SolutionTrueA + "\">A.</span>\r\n");
            TestResultStr.Append("<div class=\"solution_N " + SolutionTrueA + "\">" + SubjectWrongSolutionA + "</div>\r\n");
            TestResultStr.Append("</li>\r\n");
            TestResultStr.Append("<li class=\"SOLUTIONLI " + SolutionChoseB + "\">\r\n");
            TestResultStr.Append("<span class=\"solution_N " + SolutionTrueB + "\">B.</span>\r\n");
            TestResultStr.Append("<div class=\"solution_N " + SolutionTrueB + "\">" + SubjectWrongSolutionB + "</div>\r\n");
            TestResultStr.Append("</li>\r\n");
            TestResultStr.Append("<li class=\"SOLUTIONLI " + SolutionChoseC + "\">\r\n");
            TestResultStr.Append("<span class=\"solution_N " + SolutionTrueC + "\">C.</span>\r\n");
            TestResultStr.Append("<div class=\"solution_N " + SolutionTrueC + "\">" + SubjectWrongSolutionC + "</div>\r\n");
            TestResultStr.Append("</li>\r\n");
            TestResultStr.Append("<li class=\"SOLUTIONLI " + SolutionChoseD + "\">\r\n");
            TestResultStr.Append("<span class=\"solution_N " + SolutionTrueD + "\">D.</span>\r\n");
            TestResultStr.Append("<div class=\"solution_N " + SolutionTrueD + "\">" + SubjectWrongSolutionD + "</div>\r\n");
            TestResultStr.Append("</li>\r\n");
            TestResultStr.Append("</ul>\r\n");
            TestResultStr.Append("</div>\r\n");
            TestResultStr.Append("</li>\r\n");

            SolutionChoseA = "";SolutionChoseB = "" ;SolutionChoseC = "";SolutionChoseD = "";   //清空变量，让下次循环不会照成错误
            SolutionTrueA = "";SolutionTrueB = "" ;SolutionTrueC = "";SolutionTrueD = "";       //同上
        }
        Cn.Close();
    }

    //下面俩函数，根据当前题目的正确答案和用户错误答案，给这个题目 正确答案加class 用户错误答案加class
    public void ChoseCheck(string Solution)
    {
        switch (Solution)
        {
            case "A":
                SolutionChoseA = "solution_chose";
                break;
            case "B":
                SolutionChoseB = "solution_chose";
                break;
            case "C":
                SolutionChoseC = "solution_chose";
                break;
            case "D":
                SolutionChoseD = "solution_chose";
                break;
        }
    }
    public void TrueCheck(string Solution)
    {
        switch (Solution)
        {
            case "A":
                SolutionTrueA = "solution_N_Wrong";
                break;
            case "B":
                SolutionTrueB = "solution_N_Wrong";
                break;
            case "C":
                SolutionTrueC = "solution_N_Wrong";
                break;
            case "D":
                SolutionTrueD = "solution_N_Wrong";
                break;
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}