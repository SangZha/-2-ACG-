<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Space.aspx.cs" Inherits="Space" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Space</title>
<script type="text/javascript" src="javascript/jquery-3.1.1.js"></script>
<script type="text/javascript" src="javascript/backto_navigation.js"></script>
<link rel="stylesheet" href="css/header_white.css"/>
<link rel="stylesheet" href="css/font-awesome.min.css"/>
<link rel="stylesheet" href="css/scale_fadein.css"/>
<link rel="stylesheet" href="css/blur_fadein.css"/>
<link rel="stylesheet" href="css/navigation_white.css"/>
<link rel="stylesheet" href="css/Space.css"/>
</head>

<body>
<!-- 采用absolute绝对定位 必须给相应的父元素赋予position值，否则会根据最近的有position值的元素（祖父元素）定位 -->
<!-- 绝对定位会使元素脱离父元素的块级中 可以利用此进行排版 而不是margin等-->
<!-- 这里因为绝对定位把 关于用户信息的元素 拉高了，又在同一容器下使用了伪元素自适应高度，导致一段空白
     再嵌套一个容器应该可以解决该问题（虽然本页面是正好）
-->
<!-- 修改宽高要设定成块级元素 如<a> -->
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
                  <li class="header_user" runat="server" id="login_li" style="display:inline-block">
                      <a href="Login.aspx" id="user_login">登录</a>
                      <i id="line"></i>
                  </li>
                  <li class="header_user" runat="server" id="register_li" style="display:inline-block">
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
	<div class="space_content">
        <div class="space_wrapper">
            <div class="space_wrapper_cover">
                <div class="space_wrapper_shadow"></div>
            </div>  		      
            <div class="space_wrapper_user">              <!-- 数据库用户信息 -->
                <div class="space_wrapper_userbox"> 	 
                    <div class="wrapper_user_head">
                        <img class="user_head" src="img/header_head.jpg" alt="SB PY"/>
                    </div>
                    <div class="wrapper_user_info">
                        <span runat="server" id="user_name">我是你亲父亲啊</span>
                        <div id="name_line"></div>
                        <span id="user_sex"></span>
                    </div>
                    <div class="wrapper_user_sign">
                        <h4 id="resume_person">个人简介：</h4>
                        <span runat="server" id="user_sign"> 这家伙一点也不懒却什么都没写</span>
                    </div>
                </div>
                <div class="space_wrapper_useredit">
                    <button id="user_edit">编辑个人资料</button>
                </div>
            </div>
        </div>
        <div class="space_main">
        	<div class="space_main_navigation">
            	<div class="main_navigation_title">
                	<i id="title_img"></i>
                    <span id="title_content">个人中心</span>
                </div>
                <div class="main_navigation_index">
                	<ul>
                    	<li class="navigation_index_li">
                        	<i class="space_li_imgs" id="imgs_home"></i>
                            <a href="Space.aspx" class="space_li_links">主&nbsp;&nbsp;页</a>
                        </li>
                        <li class="navigation_index_li">
                            <i class="space_li_imgs" id="imgs_head"></i>
                            <a href="Head.aspx" class="space_li_links">更改头像</a>
                        </li>
                        <li class="navigation_index_li">
                            <i class="space_li_imgs" id="imgs_edit"></i>
                            <a href="Setting.aspx" class="space_li_links">编辑资料</a>
                        </li>
                        <li class="navigation_index_li">
                        	<i class="space_li_imgs" id="imgs_history"></i>
                        	<a href="History.aspx" class="space_li_links">浏览历史</a>
                        </li>
                        <li class="navigation_index_li">	
                      		<i class="space_li_imgs" id="imgs_message"></i>
                        	<a href="Message.aspx" class="space_li_links">消息中心</a>
                        </li>
                        <li class="navigation_index_li">
                        	<i class="space_li_imgs" id="imgs_test"></i>
                        	<a href="Test.aspx" class="space_li_links">答题测试</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="space_main_content">
            	<div class="main_content_articles">
                    <span id="articles_title">发布文章</span>
                    <article>
                    	<div class="articles_entire_inner">
                            <header class="articles_entire_header">
                                <h1 class="articles_entire_title">
                                    <a href="" class="entire_title">[葵せきな][碧陽学園生徒会議事録][共23卷收錄][EPUB]</a>
                                </h1>
                                <div class="articles_entire_time">
                                    <time class="entire_time" datetime="2016-12-03T15:08:43+00:00">2016年12月3日</time>
                                </div>
                            </header>
                            <div class="articles_entire_content">
                                <p>好麻烦啊，随便便打个标题先，还有用户上传头像和背景的插件不会链接，用户的文章不会链接，根据用户情况是否发表文章更改用户个人中心内容也不会。还有后台链接，完蛋了啊。</p>
                            </div>
                            <footer class="articles_entire_footer">
                            	<span class="articles_entire_source">该文章被发布在</span>
                                <a href="">轻小说</a>
                            </footer>
                        </div>
                    </article>
                    <article>
                    	<div class="articles_entire_inner">
                            <header class="articles_entire_header">
                                <h1 class="articles_entire_title">
                                    <a href="" class="entire_title">[汪汪][汪汪汪喵喵][共11汪汪][EPUB]</a>
                                </h1>
                                <div class="articles_entire_time">
                                    <time class="entire_time" datetime="2016-12-03T15:08:43+00:00">2016年12月3日</time>
                                </div>
                            </header>
                            <div class="articles_entire_content">
                                <p>喵喵喵喵喵喵，喵喵喵喵喵喵喵喵喵喵喵喵，喵喵喵喵喵喵 ：） </p>
                            </div>
                            <footer class="articles_entire_footer">
                            	<span class="articles_entire_source">该文章被发布在</span>
                                <a href="">轻小说</a>
                            </footer>
                        </div>
                    </article>
                    <article>
                    	<div class="articles_entire_inner">
                            <header class="articles_entire_header">
                                <h1 class="articles_entire_title">
                                    <a href="" class="entire_title">[汪汪][汪汪汪喵喵][共11汪汪][EPUB]</a>
                                </h1>
                                <div class="articles_entire_time">
                                    <time class="entire_time" datetime="2016-12-03T15:08:43+00:00">2016年12月3日</time>
                                </div>
                            </header>
                            <div class="articles_entire_content">
                                <p>喵喵喵喵喵喵，喵喵喵喵喵喵喵喵喵喵喵喵，喵喵喵喵喵喵 ：） </p>
                            </div>
                            <footer class="articles_entire_footer">
                            	<span class="articles_entire_source">该文章被发布在</span>
                                <a href="">轻小说</a>
                            </footer>
                        </div>
                    </article>
                    <article>
                    	<div class="articles_entire_inner">
                            <header class="articles_entire_header">
                                <h1 class="articles_entire_title">
                                    <a href="" class="entire_title">[汪汪][汪汪汪喵喵][共11汪汪][EPUB]</a>
                                </h1>
                                <div class="articles_entire_time">
                                    <time class="entire_time" datetime="2016-12-03T15:08:43+00:00">2016年12月3日</time>
                                </div>
                            </header>
                            <div class="articles_entire_content">
                                <p>喵喵喵喵喵喵，喵喵喵喵喵喵喵喵喵喵喵喵，喵喵喵喵喵喵 ：） </p>
                            </div>
                            <footer class="articles_entire_footer">
                            	<span class="articles_entire_source">该文章被发布在</span>
                                <a href="">轻小说</a>
                            </footer>
                        </div>
                    </article>
                    <article>
                    	<div class="articles_entire_inner">
                            <header class="articles_entire_header">
                                <h1 class="articles_entire_title">
                                    <a href="" class="entire_title">[汪汪][汪汪汪喵喵][共11汪汪][EPUB]</a>
                                </h1>
                                <div class="articles_entire_time">
                                    <time class="entire_time" datetime="2016-12-03T15:08:43+00:00">2016年12月3日</time>
                                </div>
                            </header>
                            <div class="articles_entire_content">
                                <p>喵喵喵喵喵喵，喵喵喵喵喵喵喵喵喵喵喵喵，喵喵喵喵喵喵 ：） </p>
                            </div>
                            <footer class="articles_entire_footer">
                            	<span class="articles_entire_source">该文章被发布在</span>
                                <a href="">轻小说</a>
                            </footer>
                        </div>
                    </article>
                </div>	
            </div>
        </div>
    </div>
</body>
</html>
