<%@ Page  Language="C#" AutoEventWireup="true" CodeFile="Article.aspx.cs" Inherits="Article" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Article</title>
<script type="text/javascript" src="javascript/jquery-3.1.1.js"></script>
<script type="text/javascript" src="javascript/backto_navigation.js"></script>
<script type="text/javascript" src="javascript/article.js"></script>
<link rel="stylesheet" href="css/navigation_black.css"/>
<link rel="stylesheet" href="css/font-awesome.min.css"/>
<link rel="stylesheet" href="css/Article.css"/>
     <style>
        .article_reply{margin:auto 60px ;}
            .article_reply_box{margin:auto 120px;position:relative;}
                .reply_box_notice{margin-bottom:20px;cursor:pointer;}
                .reply_box_input{
                    resize:none;
                    width:720px;
                    height:54px;
                    padding:5px 10px;
                    border-radius:4px;
                    border:1px solid #e0e0e0;
                    background-color:#f5f5f5;
                    font-family:"Microsoft YaHei",Arial,Helvetica,sans-serif;
                    display:inline-block;
                    outline:none;
                }
                    .reply_box_input:hover{
                        border:1px solid #337ab7;
                    }
                .reply_box_submit{
                    height:66px;
                    width:66px;
                    border:0;
                    padding:5px 14px;
                    position:absolute;
                    margin-left:20px;
                    text-align:center;
                    background-image:url(../img/huaji.png);
                    background-size:cover;
                    background-color:#ECECEC;
                    color:rgba(240,240,240,0);
                    font-size:14px;
                    outline:none;
                    cursor:pointer;
                }
                    .reply_box_submit:hover{
                        height:66px;
                        border-radius:5px;
                        background-image:url();
                        background-color:#337ab7;
                        color:rgba(240,240,240,1);    
                    }
                    .article_reply_box:hover textarea{
                        border:1px solid #337ab7;
                    }
                .article_reply_list{
                    margin:auto 48px;
                    padding-top:20px;
                }
                        .reply_list_head{
                        float:left;
                        position:relative;
                        vertical-align:middle;
                        margin-top:28px;
                    }
                            .reply_user_head{
                                width:48px;
                                height:48px;
                                border-radius:50%;
                            }
                        .reply_list_main{
                            border-top:1px solid #e0e0e0;
                            padding-top:28px;
                        }
                            .reply_list_main:after{
                                content: ".";
                                height: 0;
                                visibility: hidden;
                                display: block;
                                clear: both;
                            }
                            .reply_user_name,.reply_user_name+p{margin-left:78px;padding-bottom:5px}
                            .reply_user_name a{
                                font-size:14px;
                                font-weight:700;
                                line-height:18px;
                                color:rgba(34,49,63,0.7);
                                cursor:pointer;
                            }
                            .reply_user_name a:hover{color:#337ab7}
                        .reply_list_meta{
                            margin-top:5px;
                        }
                            .floor{
                                display:inline-block;width:48px;                     
                                font-size:14px;color:rgba(34,49,63,0.7);
                                margin-right:25px;
                                text-align:center;                  
                            }
                            .time{
                                display:inline-block;
                                font-size:12px;color:rgba(34,49,63,0.7);
                                margin-right:8px;
                            }
                        .reply_list_box{
                            margin-top:10px
                        }
                                .reply_button{
                                float:left;
                                margin-left:9px;
                                font-size:15px;color:#337ab7;
                                text-align:center;
                                cursor:pointer;
                            }
                                .reply_button:hover{color:#588dba}
                            .reply_box{ margin:10px 0 0 72px}
                        
                       .reply_list_answer{margin-left:78px;}
                            .list_answer_box{padding:10px 0;}    
                                
                                .list_answer_head{
                                    float:left;
                                    position:relative;
                                }
                                    .reply_answer_head{
                                        width:24px;
                                        height:24px;
                                        border-radius:50%;
                                    }
                                .list_answer_main{margin-left:32px;}
                                        .list_answer_name{
                                            float:left;
                                            font-size: 14px;
                                            font-weight: 700;
                                            line-height: 18px;
                                            cursor:pointer;
                                        }
                                            .reply_answer_name{
                                                color: rgba(34,49,63,0.7);
                                                position:relative;
                                                top:1px;
                                            }.reply_answer_name:hover{color:#337ab7;}
                                            
                                             .list_answer_name i{padding-right:8px;display:inline-block;}

                                        .list_answer_content{
                                            font-size:14px;
                                            font-weight:400;
                                        }
                                        .list_answer_meta{
                                            padding-top:8px;
                                            font-size:12px;color:rgba(34,49,63,0.7);
                                        }
                                            .answer_button{
                                                display:inline-block;                                          
                                                color:#337ab7;
                                                cursor:pointer;
                                            }.answer_button:hover{color:#588dba}


    </style>
</head>

<body>
<!-- 网站的颜色确实很乱，全当拿来练习前端设计方法，该界面是尝试B站采用的 Head毛玻璃效果-->

<!-- box-shadow 不声明直接使用 参数分别为 颜色，X的偏移（正右负左），y的偏移（正下负上），模糊程度 -->
<!-- #的色彩自白向黑  F到A越来越深16位进制  -->
<!-- vertical-align 算是个比较麻烦的了，图片的垂直居中利用这个的话可以将父元素 line-height高设为父元素本身高度，这样vertical就可以使图片居中，
	 但由于line-height特性需要将 font-size设为0达到完全居中，具体在你的 标签栏-记录 中 -->
<!-- li使用float，li下的a标签（可能是所有子标签）也使用float  子标签会继承li的高度和宽度（填满） 
     给子标签加 display 也会填满   （应该是同一个机制）-->
<!-- 父标签固定了长度 那么子标签更大就会超出-->
<!-- background-color :tranparent  透明-->
<!-- css:input等属性在chorme下自动给input加蓝色框框样式   用outline:none取消 -->
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
                              <p runat="server" id="user_name">北大西洋扇贝</p>
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
                       <img id="user_head" src="img/header_head.jpg"/>
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
    <div class="navigation">
            <div class="navigation_style" id="navigation_back_top">
                <a>
                	<img src="img/navigation_top.png" alt=""/>
                </a>            
            </div>
    </div>
    <div class="header_img"></div>
    <div class="article_content"> 
   	    <div class="article_wrapper">
            <div class="article_wrapper_title">
                <h1 id="wrapper_title">大三项目★（暂定）</h1>
                <h3 id="wrapper_description">同性恋交友平台（大雾）</h3>
            </div>
            <div class="article_wrapper_logion">
            	<p>哈啊哈哈哈哈哈哈哈哈哈哈哈啊啊哦。《老子》</p>
            </div>
            <div class="article_wrapper_background">
        		<img src="img/article_head_bg.jpg" alt="">
       		</div>
            <div class="article_wrapper_navigation">
            	<div class="wrapper_navigation">
                	<div class="wrapper_navigation_div">   
                        <a href="News.aspx" class="wrapper_navigation_a">
                            <img src="img/mainpage_news.png" alt=""/>
                        </a>
                    </div>
                    <div class="wrapper_navigation_div">   
                        <a href="Game.aspx" class="wrapper_navigation_a">
                            <img src="img/mainpage_game.png" alt=""/>
                        </a>
                    </div>
                    <div class="wrapper_navigation_div">   
                        <a href="Anime.aspx" class="wrapper_navigation_a">
                            <img src="img/mainpage_anime.png" alt=""/>
                        </a>
                    </div>
                    <div class="wrapper_navigation_div">   
                        <a href="Lightnovel.aspx" class="wrapper_navigation_a">
                            <img src="img/mainpage_lightnovel.png" alt=""/>
                        </a>
                    </div>
                    <div class="wrapper_navigation_div">   
                        <a href="Music.aspx" class="wrapper_navigation_a">
                            <img src="img/mainpage_music.png" alt=""/>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="article_main">
        	<div class="article_main_meta">
            	<span class="meta_source">本文章由</span>
                <a runat="server" href="" class="meta_up" id="meta_up">我是你亲父亲啊</a>
                <span class="meta_source">发布于</span>
                <time runat="server" class="meta_time" datetime="" id="meta_time">2016年12月15日</time>
            </div>
            <div class="article_main_content">
            	<article>
                	<header class="content_header">
                    	<h1 runat="server" id="content_title" class="content_title">[喵喵喵][喵喵喵喵喵喵喵喵喵][喵喵喵喵喵喵喵喵喵][喵喵喵喵喵喵]</h1>
                    </header>
                    <div runat="server" id="content_detail" class="content_detail">
                    	<p>喵喵喵，喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵，喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵喵，喵喵喵喵喵喵喵喵喵喵喵喵。</p>
                    </div>
                </article>
            </div>
        </div>
        <div class="article_reply">
            <div class="reply_box_notice"></div>
            <div class="article_reply_box">
                <textarea name="reply_box" runat="server" class="reply_box_input" placeholder="请发布健康、积极向上，符合社会主义核心价值观的评论哦"></textarea>
                <button runat="server" type="button" class="reply_box_submit" >发表评论</button>
            </div>
            <%= str %>
        </div>
    </div>
    <div style="display:none" runat="server" id="temp"></div>
</body>
    <script>
        $(function () {
            //jq 正则法获取当前url的参数值
            function GetQueryString(name) {
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //匹配正则 eg: name=abc 取 abc
                var r = window.location.search.substr(1).match(reg); //window.location.search 即 ?name=abc ，substr(1)取第一个索引开始 ， match(reg)匹配正则
                if (r != null) return unescape(r[2]); return null; //unescape() 解码的函数   这里没用 但不删
            }
            
            var article_id = GetQueryString("id");  //调用获取url参数的函数  赋值给article_id

            $(".reply_box_submit").click(function () {
                $.ajax({
                    type: "POST",
                    url: "Ajax/PosttheReply.ashx",
                    data: {
                        ReplyContent: $(this).prev(".reply_box_input").val(),    //抽取前兄弟标签textarea内容
                        ArticleId: article_id,          //放文章ID
                        NewReplyId: "0",
                    },
                    success: function (msg) {
                        alert(msg);
                    },
                });
            });
//此处上方是已有的评论区点击事件，下方是动态生成的评论区点击事件绑定，暂时分开，之后再想办法合并
            //动态生成的html标签需要用事件监听方法绑定事件
            $(".reply_list_main").on("click", ".reply_box_submit", function () {
                $.ajax({
                    type: "POST",
                    url: "Ajax/PosttheReply.ashx",
                    data: {
                        ReplyContent: $(this).prev(".reply_box_input").val(),   //同上
                        ArticleId: article_id,  //同上
                        ReplyToId: $(this).data('aid'),     //存放被回复评论ID
                        ReplyToUserId: $(this).data('uid'),   //存放被回复评论 评论者的ID
                    },
                    success: function (msg) {
                        alert(msg);
                    },
                });
            });
        })
    </script>
</html>

