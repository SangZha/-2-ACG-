<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Home</title>
<link rel="stylesheet" href="css/Home.css">
    <style>
        .menu_li{
            display:none
        }
        .plate_row{
            cursor:pointer;
        }
        #login,#register{
            cursor:pointer;
        }
    </style>
</head>
<!-- 可修改的：判断用户是否登录未登录不加载一些标签（消息，头像hover时出现的东西）-->
<body>
  <div class="wrapper"> <!-- pixiv 57758984  -->
    <div class="bg" >  
      
    </div>
    <div class="main">
      <div class="mask">
        <div class="mask_bg"></div>
        <div class="mask_rsp"></div>
      </div>
      <div class="header">
        <div class="userbox">
          <ul class="menu">
            <li class="menu_li" runat="server" id="message">
 				<a href="Message.aspx" class="li_links">消息</a>
                <div class="dyn_list" id="message_dyn" >
                  <div class="triangle" id="message_tri"></div>
                  <div id="my_message"> 
                        <ul>
                          <li>
                            <a href="Love.aspx">
                              <span class="inner_title">对我点赞</span>
                            </a>
                          </li>
                          <li>
                            <a href="Message.aspx">
                              <span class="inner_title">回复我的</span>
                            </a>
                          </li>
                          <li>
                            <a href="">
                              <span class="inner_title">好友私信</span>
                            </a>
                          </li>
                          <li>
                            <a href="Notice.aspx">
                              <span class="inner_title">系统通知</span>
                            </a>
                          </li>
                        </ul>
                      </div> 
                </div>
            </li>
            <li class="menu_li" runat="server" id="history">
                <a href="History.aspx" class="li_links">历史</a>
                <div class="dyn_list" id="history_dyn">
                  <div class="triangle" id="history_tri"></div>
                  <div id="my_history">
                    <ul>
                      <li>
                                   占位 <!--连接数据库历史记录 自动创建li-->
                      </li>
                      <li>
                      </li>
                    </ul>
                    <a href="History.aspx" id="read_history">查看历史记录</a>
                  </div>
                </div>          
            </li>            
            <li class="menu_li" runat="server" id="profile">
              <a href="Space.aspx">个人中心</a>
            </li>
            <li class="menu_li" runat="server" id="exit" >
              <a href="Login_exit.aspx">退出登录</a>
            </li>
            <li class="menu_li" runat="server" id="display">
            </li>   <!-- 连接个人中心和头像数据库 -->
            <li id="log_reg" runat="server">
              <span id="login">登录</span><!--
           --><i id="line"></i><!--
           --><span id="register">注册</span>
            </li>
          </ul>
        </div>
      </div>
      <div class="contain">
        <div id="contain">
          <div class="title">
            <span class="title" > ❤ HAHAHAHAHA HAHA ❤ </span>
            <hr class="title_hr">
          </div>
          <div class="row_first">
            <div class="plate_row" id="news">
              <div class="plate_icon"></div>
              <img src="img/News.png" alt="">
              <div class="news_title">
                <span class="span_en">NEWS</span>
                <span class="span_ch">最新文章</span>
              </div>
            </div>
            <div class="plate_row" id="anime">
              <div class="plate_icon"></div>
              <img src="img/Game.png" alt="">
              <div class="news_title">
                <span class="span_en">Game</span>
                <span class="span_ch">游戏</span>              
              </div>
            </div>
            <div class="plate_row" id="comic">         
              <div class="plate_icon"></div>
              <img src="img/Novel.png" alt="">
              <div class="news_title">
                <span class="span_en">Novel</span>
                <span class="span_ch">轻小说</span>              
              </div>
            </div>
          </div>
          <div class="row_last">  
            <div class="plate_row" id="game">
              <div class="plate_icon"></div>
              <img src="img/Anime.png" alt="">
              <div class="news_title">
                <span class="span_en">Anime</span>
                <span class="span_ch">动漫</span>              
              </div>
            </div>
            <div class="plate_row" id="lightnovel">              
              <div class="plate_icon"></div>
              <img src="img/Music.png" alt="">
              <div class="news_title">
                <span class="span_en">Music</span>
                <span class="span_ch">音乐</span>              
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div> 
  
<script type="text/javascript" src="javascript/jquery-3.1.1.js"></script>
    <script>
        $(function () {
            $("#news").click(function () { window.location.href = "News.aspx" });
            $("#login").click(function () { window.location.href = "Login.aspx" });
            $("#register").click(function () { window.location.href = "Register.aspx" });
        });
    </script>
</body>
</html>

