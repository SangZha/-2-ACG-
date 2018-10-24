<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Head.aspx.cs" Inherits="Head" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Head</title>
<script type="text/javascript" src="javascript/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="javascript/cropbox.js"></script>
<script type="text/javascript" src="javascript/backto_navigation.js"></script>

<link rel="stylesheet" href="css/head_avator.css"/>
<link rel="stylesheet" href="css/header_white.css"/>
<link rel="stylesheet" href="css/font-awesome.min.css"/>
<link rel="stylesheet" href="css/scale_fadein.css"/>
<link rel="stylesheet" href="css/blur_fadein.css"/>
<link rel="stylesheet" href="css/navigation_white.css"/>
<link rel="stylesheet" href="css/Head.css"/>
    <style>
        #upload_head{
            height:57px;
            width:210px;
            background-color:#f38e81;
            border-radius:3px;
            text-decoration:none;
            box-shadow:0px 0px 5px #B0B0B0;
            color:#ffffff;
            font-size:20px;
            border:0 #fff solid;
            position:absolute;
            right:0;
            top:500px;
            margin-top:12px;
        }
    </style>
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
                    	<img id="user_head" runat="server" src="img/header_head.jpg" alt="SB PY"/>
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
                <div class="main_content_head">
                    <span id="head_title">更换头像</span>
                    <form runat="server">
                    <div class="container">
                        <div class="imageBox" id="imageBox" style="background-size:cover">
                            <div class="thumbBox"></div>
                            <div class="spinner" style="display: none">Loading...</div>
                   		</div>
                        <div class="action"> 
                        <!-- <input type="file" id="file" style=" width: 200px">-->
                       		<div class="new-contentarea tc"> 
                        		<a href="javascript:void(0)" class="upload-img">
                        			<label for="upload-file">上传图像</label>
                        		</a>
                        		<input type="file" class="" name="upload-file" id="upload-file" />
                        	</div>
                            <input type="button" id="btnCrop"  class="Btnsty_peyton" value="预览"/>
                            <input type="button" id="btnZoomIn" class="Btnsty_peyton" value="+"  />
                            <input type="button" id="btnZoomOut" class="Btnsty_peyton" value="-" />
                        </div>
                        <div class="cropped"></div>
                        <asp:Button ID="upload_head" runat="server" Text="确定上传" OnClick="upload_head_Click" />
                        <div class="temp_hidden">
                            <input type="hidden" runat="server" id="tempBase"/>
                        </div>
                    </div>
                    </form>
                </div>    
            </div>
        </div>
    </div> 
<script type="text/javascript">
//调用Cropbox.js
    $(window).load(function() {
	    var options =
	    {
		    thumbBox: '.thumbBox',
		    spinner: '.spinner',
		    imgSrc: 'img/avatar.png'
	    }
	    var cropper = $('.imageBox').cropbox(options);
	    $('#upload-file').on('change', function(){
		    var reader = new FileReader();
		    reader.onload = function(e) {
			    options.imgSrc = e.target.result;
			    cropper = $('.imageBox').cropbox(options);
		    }
		    reader.readAsDataURL(this.files[0]);
		    this.files = [];
	    })
	    $('#btnCrop').on('click', function(){
		    var img = cropper.getDataURL();
		    $('.cropped').html('');
		    $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:64px;margin-top:4px;border-radius:64px;box-shadow:0px 0px 12px #7E7E7E;" ><p>64px*64px</p>');
		    $('.cropped').append('<img src="'+img+'" align="absmiddle" style="width:128px;margin-top:4px;border-radius:128px;box-shadow:0px 0px 12px #7E7E7E;"><p>128px*128px</p>');
		    $('.cropped').append('<img src="' + img + '" runat="server" id="head_done" align="absmiddle" style="width:180px;margin-top:4px;border-radius:180px;box-shadow:0px 0px 12px #7E7E7E;"><p>180px*180px</p>');
		    tempBase.value = img;
	    })
	    $('#btnZoomIn').on('click', function(){
		    cropper.zoomIn();
	    })
	    $('#btnZoomOut').on('click', function(){
		    cropper.zoomOut();
	    })
    });

//禁止上传头像区域的滚轮页面滚动
    var firefox = navigator.userAgent.indexOf('Firefox ') != -1;
    function MouseWheel(e) {
        ///对img按下鼠标滚路，阻止视窗滚动
        e = e || window.event;
        if (e.stopPropagation) e.stopPropagation();
        else e.cancelBubble = true;
        if (e.preventDefault) e.preventDefault();
        else e.returnValue = false;

        //其他代码
    }
    window.onload = function () {
        var img = document.getElementById('imageBox');
        firefox ? img.addEventListener('DOMMouseScroll', MouseWheel, false) : (img.onmousewheel = MouseWheel);
    }
    //记录 ..http://www.w3dev.cn/article/20130712/javascript-bind-object-mouse-scroll-event.aspx
</script>
</body>
</html>
