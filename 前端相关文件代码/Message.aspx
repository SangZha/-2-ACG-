<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Message.aspx.cs" Inherits="Message" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Message</title>
<script type="text/javascript" src="javascript/jquery-3.1.1.js"></script>
<script type="text/javascript" src="javascript/backto_navigation.js"></script>
<link rel="stylesheet" href="css/rotate_shake.css"/>
<link rel="stylesheet" href="css/scale_fadein.css"/>
<link rel="stylesheet" href="css/header_black.css"/>
<link rel="stylesheet" href="css/navigation_black.css"/>
<link rel="stylesheet" href="css/Message.css"/>
<link rel="stylesheet" href="css/font-awesome.min.css"/>
</head>
<!-- P站ID ：59053359-->
<!-- margin存在子标签无法撑开父标签的情况（背景色无法延伸），通常是未设置高度，可以在父容器尾添加伪元素设置清除浮动并隐藏
      http://blog.sina.com.cn/s/blog_e5dde9620102wbxn.html
-->
<!-- 图片本身过大需要进行缩放否则会因为不显示全图看不到 background-size:cover 目前可以 -->
<!-- inline-block 赋予的同行属性可以使得父元素的 text-align效果对块级使用 -->
<!-- 伪元素可以用在自适应长度，随着文字增加父元素拉长或者是获得父元素宽度-->
<!-- 使用伪元素让垂直居中  居中程度由伪元素父元素高决定，  需要设置成行块元素inline-block并且伪元素和子元素都要设置vertical-align middle
     这样使用会造成 4px右移不知道为什么
-->
<!-- offset().top获取某个元素的页顶距离   然后scrollTop 减去该值，已完成滑动到该元素出现事件（导航出现）
     完成渐隐出现消失直接使用fadeTo即可  注意Stop()
-->
<body id="message_bg" >
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
            <div class="navigation_style" id="navigation_love">
            	<a href="Love.aspx">
                	<img src="img/navigation_love.png" alt="">
                </a>
            </div>
            <div class="navigation_style" id="navigation_reply">
                <a href="Message.aspx">
                	<img src="img/navigation_reply.png" alt="">
                </a>
            </div>
            <div class="navigation_style" id="navigation_whisper">
                <a href="Whisper.aspx">
                	<img src="img/navigation_whisper.png" alt="">
                </a>            
            </div>
            <div class="navigation_style" id="navigation_system">
                <a href="Notice.aspx">
                	<img src="img/navigation_system.png" alt="">
                </a>            
            </div>
            <div class="navigation_style" id="navigation_back_top">
                <a>
                	<img src="img/navigation_top.png" alt="">
                </a>            
            </div>
    </div>	 
    <div class="message_center">
    	<div class="message_header">
    		<div class="message_title">
            	<i id="message_iconplane"></i>
                <span id="message_title">消息中心</span>
            </div>
        	<div class="message_pagnation">
        		<ul>
            	   <li><a href="Love.aspx">
                       <span class="message_type">收到点赞</span>
                       </a>
                   </li>
            	   <li><a href="Message.aspx">
                       <span class="message_type">回复我的</span>
                       </a>
                   </li>
            	   <li><a href="Whisper.aspx">
                       <span class="message_type">我的私信</span>
                       </a>
                   </li>
            	   <li><a href="Notice.aspx">
                       <span class="message_type">系统通知</span>
                       </a>
                   </li>
        	    </ul>
        	</div>
        </div>
        <div class="message_main">
        	<div class="message_group_title">
            	<span id="emoticons">(ノ｀Д´)ノ</span> 	 
                <span>这里是您收到的回复</span>
            </div>
            <ul class="message_main_ul">
            	<% = ReplyHtml %>
                <!--连接数据库获取相关信息-->
            </ul>
        </div>
    </div>
</body>
</html>
