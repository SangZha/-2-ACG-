<%@ Page Language="C#" AutoEventWireup="true" CodeFile="News.aspx.cs" Inherits="News" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>News</title>
<script type="text/javascript" src="javascript/jquery-3.1.1.js"></script>
<script type="text/javascript" src="javascript/backto_navigation.js"></script>
<link rel="stylesheet" href="css/font-awesome.min.css"/>
<link rel="stylesheet" href="css/header_black.css"/>
<link rel="stylesheet" href="css/mainpage_hover.css"/>
<link rel="stylesheet" href="css/navigation_black.css"/>
<link rel="stylesheet" href="css/News.css"/>

</head>

<body>
<!-- 尝试一种新的背景，但是达不到想要的四周迸发渐变融入背景色的效果，所以用了能想到的办法-->
<!-- 子元素的margin-top会影响父元素 可给父元素一个overflow-hidden-->
<!-- 制作中遇到 投稿(id=post)这一地方的设计会影响布局导致下滑 原因是未设置父容器li的高度 导致超出时li被自适应
             结论：父容器在一般情况下会自适应子容器的大小，导致某种设计（故意让子容器超出）影响布局
                   可以给父容器设定宽高或子容易绝对定位等使子容器脱出这个布局中-->
    <div class="header">
          <div class="header_mask">
            <div class="header_rsp">
            </div>
            <div class="header_container">
              <div class="homepage">
                <ul>
                  <li class="header_li" id="news">
                    <a href="News.aspx" class="li_links">  
                        最新文章  
                    </a>
                  </li>
                  <li class="header_li" id="game">
                    <a href="Game.aspx" class="li_links">
                        游戏
                    </a> 
                  </li>     
                  <li class="header_li" id="novel">
                    <a href="Novel.aspx" class="li_links">
                        轻小说
                    </a>        
                  </li>
                  <li class="header_li" id="anime">
                    <a href="Anime.aspx" class="li_links">
                        动漫
                    </a>        
                  </li>
                  <li class="header_li" id="music">
                    <a href="Music.aspx" class="li_links">
                        音乐
                    </a>
                  </li>        
                </ul>
              </div>
               <div class="userbox">
                <ul >
                  <li class="header_user" runat="server" id="message">
                    <a href="Message.aspx" class="li_links">消息</a>
                    <div class="dyn_list" id="message_dyn">
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
                  <li class="header_user" runat="server"  id="history">
                    <a href="History.aspx" class="li_links">历史</a>
                    <div class="dyn_list" id="history_dyn" >
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
                  <li class="header_user" runat="server" id="profile">
                     <a href="Space.aspx">个人中心</a>
                  </li>
                   <li class="header_user" runat="server" id="display">
                      <div class="dyn_list" id="display_dyn" >
                          <div id="my_display">
                              <p runat="server" id="display_name">北大西洋扇贝</p>
                              <div class="display_menu">
                                  <ul id="display_ul">
                                      <li><a href="Test.aspx" class="display_a user_test">问卷答题</a></li>
                                      <li><a href="Friend.aspx" class="display_a user_friend">我的好友</a></li>
                                      <li><a href="Setting.aspx" class="display_a user_setting">修改资料</a></li>
                                  </ul>
                              </div>
                              <div runat="server" id="exit" ><a href="Login_exit.aspx">退出登录</a></div>
                          </div>
                       </div>
                       <img id="display_head" runat="server" src="img/header_head.jpg"/>
                  </li>   <!-- 连接个人中心和头像数据库 -->
                  <li class="header_user" runat="server" id="post">
                        <a href="Post.aspx" id="user_post">投稿</a>
                  </li>
                  <li class="header_user" runat="server" id="login" style="display:inline-block">
                      <a href="Login.aspx" id="user_login">登录</a>
                      <i id="line"></i>
                  </li>
                  <li class="header_user" runat="server" id="register" style="display:inline-block">
                      <a href="Register.aspx" id="user_register">注册</a>
                  </li>
                </ul>
                </div>  
                </div>
              </div>
        </div>
    <div class="navigation" style="display:none">
            <div class="navigation_style" id="navigation_back_top">
                <a>
                	<img src="img/navigation_top.png" alt=""/>
                </a>            
            </div>
    </div>
    <div class="mainpage_bg">
        <div class="mainpage_content">
            <div class="mainpage_wrapper">
                <div class="mainpage_wrapper_title">
                	<h1 id="wrapper_title">大三项目★（暂定）</h1>
                    <h3 id="wrapper_description">同性恋交友平台（大雾）</h3>
                </div>
                <div class="mainpage_wrapper_logion">
                	<p>哈啊哈哈哈哈哈哈哈哈哈哈哈啊啊哦。《老子》</p>
                </div>
                <div class="mainpage_wrapper_navigation">
                    <div class="wrapper_navigation_div">   
                    	<div class="wrapper_navigation_title">
                        	<a href="News.aspx" class="wrapper_navigation_a">
                            	<img src="img/mainpage_news.png" alt="">
                            </a>
                            <div class="wrapper_navigation_description">
                            	<span class="navigation_description_title">最新文章</span>
                                <span class="navigation_description_content">这里有近期的新文章哦</span>
                            </div>
                        </div>
                    </div> 
                    <div class="wrapper_navigation_div">
                        <div class="wrapper_navigation_title">
                        	<a href="" class="wrapper_navigation_a">
                            	<img src="img/mainpage_game.png" alt="">
                            </a>
                            <div class="wrapper_navigation_description">
                            	<span class="navigation_description_title">游&nbsp;&nbsp;戏</span>
                                <span class="navigation_description_content">再玩一个小时我就睡觉</span>
                            </div>
                        </div>
                    </div> 
                    <div class="wrapper_navigation_div">
                        <div class="wrapper_navigation_title">
                        	<a href="" class="wrapper_navigation_a">
								<img src="img/mainpage_anime.png" alt="">                           
                            </a>
                            <div class="wrapper_navigation_description">
                            	<span class="navigation_description_title">动&nbsp;&nbsp;漫</span>
                                <span class="navigation_description_content">哦哦哦呼～</span>
                            </div>
                        </div>
                    </div>     
                    <div class="wrapper_navigation_div">
                        <div class="wrapper_navigation_title">
                        	<a href="" class="wrapper_navigation_a">
                            	<img src="img/mainpage_lightnovel.png" alt="">
                            </a>
                            <div class="wrapper_navigation_description">
                            	<span class="navigation_description_title">轻&nbsp;小&nbsp;说</span>
                                <span class="navigation_description_content">隐约雷鸣，阴霾天空</span>
                            </div>
                        </div>
                    </div>     
                    <div class="wrapper_navigation_div">
                        <div class="wrapper_navigation_title" id="style_none">
                        	<a href="" class="wrapper_navigation_a">
                            	<img src="img/mainpage_music.png" alt="">
                            </a>
                            <div class="wrapper_navigation_description">
                            	<span class="navigation_description_title">音&nbsp;&nbsp;乐</span>
                                <span class="navigation_description_content">老司机，带带我我要去</span>
                            </div>
                        </div>
                    </div>     
                </div>
            </div>
            <div class="mainpage_main">
                <div class="mainpage_main_position">
                    <div class="mainpage_main_title">
                    	<h3 id="main_title">您当前位于：最新文章</h3>
                    </div>
                    <div class="mainpage_main_content">
                        <div class="main_content_articles">
                        	<%= str %>;
                           
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="display:none" runat="server" id="tempContent"></div>  
</body>
</html>
