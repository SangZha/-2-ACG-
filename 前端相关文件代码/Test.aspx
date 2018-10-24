<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Test</title>
<link rel="stylesheet" href="css/header_white.css"/>
<link rel="stylesheet" href="css/font-awesome.min.css" />
<script type="text/javascript" src="javascript/jquery-3.1.1.min.js"></script>

<style>
html,body{
		padding:0;
		margin:0;
		font-family:"Microsoft YaHei",Arial,Helvetica,sans-serif;
		background:rgba(250,250,250,1.00);
	}
	body{
		overflow-y:scroll;
	}
	ul,li,h1,p{
	    margin:0;
	    padding:0;
	    list-style:none;
    }
    a{
	    text-decoration:none;
		color: #000;
    }
    
	.test_bg{
		background:url(img/test-bg.png) fixed bottom right no-repeat;
		height:590px;
		width:1190px;
		position: fixed;
		bottom: 0;
		right: 0;
	}
    .test_rsp{
        width: 100%;
        height: 100%;
        position: fixed;
        top:0;left:0;
        background: rgba(0,0,0,0.8);
        z-index: 99999;
    }
            .subject_choose{
                background:url(img/test_rsp.png) rgba(57,69,45,1);
                position:fixed;
                top:0;left:0;bottom:0;right:0;
                margin:auto;
                width:1000px;
                height:500px;
            }
                .subject_name{
                    width: 450px;height: 200px;display:inline-block;
                    position: absolute;top: 150px;left: 112px;
                }
                    .subject_chosefirst:after,.subject_choselast:after{
                        content:'';
                        width:120px;height:80px;display:block;
                        position:absolute;right: -42px;bottom: -24px;
                        background:url(img/test_rspchose.png);
                    }
                    .SUBJECTDIV,.SUBJECTDIV_confirm{
                        display: inline-block;
                        position: absolute;
                        cursor:pointer;
                    }
                .gameposition{width: 128px;height: 72px;top: 3px;left: 6px;}   
                .animeposition{width: 128px;height: 72px;top: 3px;right: 62px;}
                .lightnovelposition{width: 186px;height: 72px;bottom: 3px;left: 6px;}
                .coldposition{width: 188px;height: 72px;bottom: 3px;right: 2px;}
                .confirm_position{width: 138px;height: 64px;bottom: 44px;right: 300px;}

    .test_content{
		background-color:rgba(255,255,255,0.95);
		position: relative;
		margin: 10px auto;
		width: 1200px;
        min-height:800px;
		box-shadow: rgba(0,0,0,0.3) 1px 5px 5px;
	}
		.test_content_zhejiao{
			background-image:url(img/zhejiao.png);
			width:100px;
			height: 130px;
			position: absolute;
			top:-2px;
			left:-4px;
			box-shadow: rgba(0,0,0,0.3) 6px 4px 5px
		}
		.test_main{
			padding: 20px 0;
		}
			.test_title{
				width: 600px;
				height: 120px;
				background:url(img/test_title.png);
				margin: 0 auto;
			}
				.test_userinfo{
					font-family:STHupo,"Microsoft YaHei",Arial,Helvetica,sans-serif;
					font-size:24px;
					text-align: center;
					padding: 10px 0 30px 0;
                    position:relative;
				}
					.userinfo_username,.userinfo_usertime,.userinfo_userchose{
						display: inline-block;
						margin-right: 20px;
					}
						.userinfo_output{
							display: inline-block;
						}
						.userinfo_input{
							 border-bottom:3px solid rgba(0,0,0,1);
							 display: inline-block;
							 width: 200px;
							 text-align: center;
						}
				.test_subject{
					width:1040px;
					margin: 0 auto;
					border-left:4px dashed black;
                    position:relative;
				}
					.subject_block{
						padding-left: 60px;
					}
						.block_title{
							font-size:32px;
							font-family:YouYuan,STHupo,"Microsoft YaHei",Arial;
							text-align: center;
						}
                            .block_allchecked{
                                font-size:32px;
							    font-family:YouYuan,STHupo,"Microsoft YaHei",Arial;
							    text-align: center;
                                padding:250px 0;
                            }
							.block_output{
							}
							.block_input{
							}
						.block_subject{
						}
							.TESTUI{
							}
								.TESTLI{
									padding: 15px 0;
                                    position:relative;
								}
                                    .subject_notdone:before{
                                        content:'';
                                        background-image:url(img/test_notdone.png);
                                        width:300px;height:30px;
                                        display:inline-block;
                                        position:absolute;
                                        top:-15px;
                                    }
									.subject_title{
										font-family:SimHei;
										font-size:18px;
										line-height:31px;
									}
										.subject_no{
											font-size:22px;
											color:rgba(155,155,155,1);
											display: inline-block;
											vertical-align:top;
										}
										.subject_info{
                                            display: inline-block;
                                            position:relative;
                                            left:-5px;
										}
									.subject_solution{
										display: inline-block;
                                        padding-left:5px;
									}
										.SOLUTIONUL{
											margin-left: 40px;
											position: relative;
										}
											.SOLUTIONLI{
												padding: 5px 0;
												cursor:pointer;
												position: relative;
												-webkit-user-select:none; -moz-user-select:none; -ms-user-select:none; user-select:none;
											}
												.solution_chose:before{
													content:'';
													background-image:url(img/choose.png);
													background-size:cover;
													width: 32px;
													height: 32px;
													display: block;
													position: absolute;
													left:-8px;
												}
												.solution_N{
													vertical-align:top;
													display: inline-block;
													line-height:20px;
													font-size:15px;
												}
                                                .solution_N_Wrong{color:#ffafc9;}
			.test_foot{
				width: 600px;
				height: 40px;
				background:url(img/test_foot.png);
				margin: 20px auto 0 auto;
			}
	.test_post{
		position: fixed;
		width: 90px;
		height: 123px;
		bottom:0;
		right:10%;
	}
		.post_button{
			position: absolute;
			width: 90px;
			height: 60px;
			cursor:pointer;
		}
		.post_image{
			background-image:url(img/test_post.png);
			background-size:cover;
			width: 100%;height: 100%;
		}
        .back_image{
			background-image:url(img/test_back.png);
			background-size:cover;
			width: 100%;height: 100%;
        }
	.userinfo_userpoint{
        background:url(img/point/100.png);
        width:300px;
        height:120px;
        position:absolute;
        right:-80px;
        top:0;
        cursor:pointer;
	}

</style>
</head>
<!-- span标签和其他标签对齐 ： 给span标签 VERTICLE-ALIGN:TOP 其他标签 LINE-HEIGHT:(SPAN'S HEIGHT)-->
<body>
    <!--尽量少的通过在非创建网页阶段 通过Html标签取值，因为Html标签用户是可以修改的 -->
    <!--这次答题试卷 对答直接抽Html标签里的值，后面再想办法看看有没有安全效率的 -->
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
<div class="test_rsp">
    <div class="subject_choose">
        <div class="subject_name">
            <div class="SUBJECTDIV gameposition"></div>
            <div class="SUBJECTDIV animeposition"></div>
            <div class="SUBJECTDIV lightnovelposition"></div>
            <div class="SUBJECTDIV coldposition"></div>
        </div>
        <div class="SUBJECTDIV_confirm confirm_position"></div>
    </div>
</div>
<div class="test_bg"></div>
<div class="test_content">
	<div class="test_content_zhejiao"></div>
    <div class="test_main">
    	<div class="test_title"></div>
        <div class="test_userinfo">
        	<div class="userinfo_username">
            	<div class="userinfo_output">姓名：</div>
                <div class="userinfo_input" id="test_name" runat="server">绅士新人</div>
            </div>
            <div class="userinfo_usertime">
            	<div class="userinfo_output">年级：</div>
                <div class="userinfo_input" id="test_time" runat="server">2017年04月04日</div>            
            </div>
            <div class="userinfo_userchose">
            	<div class="userinfo_output">科目：</div>
                <div class="userinfo_input" id="test_subject" runat="server">语数英文科</div> 
            </div>
        </div>
        <div class="test_subject">
            <div class="subject_block">
                <div class="block_allchecked">
                    <h1 class="block_output">稍等嗷..正在生成题目...</h1>
                </div>
            </div>
        </div>
        <div class="test_foot"></div>
    </div>
</div>    
<div class="test_post">
    	<div class="post_button"></div>
        <div class="post_image"></div>
</div>
</body>
    <script>
        //现阶段 对答案的方式有极大问题 （将用户答案和标准答案放俩数组对比） 想办法改
        //尚未优化用户的交互 （用户选好题目后 -> 题目生成） （用户交卷后的 内容）

        $(function () {
            var Subject_FirstChose;
            var Subject_LastChose;
            var Array_Solutions = new Array();
            var Array_SolutionsId = new Array();
            var point;
            var str = '';
            var str_id = '';
            var i = 0;
            var JumpOut_Click = true; //判断当前数组是否已建立，已建立就运行下面的 没有直接跳出Click
            //函数：一个问题只能勾一个答案，勾其他自动取消已有的，点击两次消除勾中
            $(".test_subject").on("click", ".SOLUTIONLI", function () {
                if ($(this).hasClass("solution_chose")) {
                    $(this).removeClass("solution_chose");
                }
                else {
                    if ($(this).parents(".TESTLI").hasClass("subject_notdone")) {
                        $(this).parents(".TESTLI").removeClass("subject_notdone");
                    }
                    if ($(this).siblings().hasClass("solution_chose")) {
                        $(this).siblings().removeClass("solution_chose");
                        $(this).addClass("solution_chose");
                    }
                    else {
                        $(this).addClass("solution_chose");
                    }
                }
            });
            //函数：上传答案数组
            //思路：运用JQ遍历each()函数，遍历所有题目。先判断题目是否为空，不为空 -> 判断题目的答案是否已经推入数组(i变量控制当前是第几道题) -> 未推入 i+1(计算下一次运算是否推入)再推入
            //                                                                                                                         -> 已推入 i+1(仍然加一，否则永远不会对未赋值的数组[i]赋值新数)，判断已推入的答案是否被修改
            //                                                         为空 -> 做出人机交互效果，初始化i为0(每次点击提交都会重头遍历，不初始化就乱套)，然后跳出遍历 
            $('.post_button').on("click",function () {
                $('.SOLUTIONUL').each(function () {
                    if (!$(this).find('.SOLUTIONLI').hasClass("solution_chose")) {
                        $(this).parents(".TESTLI").addClass("subject_notdone");
                        $("html,body").animate({ scrollTop: $(this).offset().top - 280 }, 800);
                        i = 0;
                        JumpOut_Click = false;
                        return false;
                    }
                    else {
                        JumpOut_Click = true;
                        str = $(this).find('.solution_chose:first').find('.solution_N:first').text().substring(0, 1);
                        str_id = $(this).parents(".subject_solution").siblings(".subject_title").find(".subject_info").data("id");
                        if (Array_Solutions[i] == null) {
                            i++;
                            Array_Solutions.push([str]);
                            Array_SolutionsId.push([str_id]);
                        }
                        else if (Array_Solutions[i] != str) {
                            i++;
                            Array_Solutions[i] = str;
                            Array_SolutionsId[i] = str_id;
                        }
                    }
                });
                //判断数组是否已建立完整完整就开始传值
                if (JumpOut_Click) {
                    $.ajax({
                        type: "POST",
                        url: "Ajax/ChecktheSolutions.ashx",
                        data: {
                            Array_Solutions: Array_Solutions,
                            Array_SolutionsId: Array_SolutionsId,
                            Solutions_Length: Array_Solutions.length,
                        },
                        traditional: true,     //不加这个传过去的 会自动加上[]
                        success: function (data) {
                            $(".test_subject").html(data);        //接收ashx传过来的数据，动态创建错题信息
                            point = $(".userinfo_userpoint").data("id")   //用户所得分数
                            $(".userinfo_userpoint").css("background", "url(img/point/" + point + ".png)");  //根据分数调用不同分数图片
                            $(".post_image").removeClass().addClass("back_image");
                        },
                    });
                }
            });

            //控制用户选择题目类型时的函数
            //想要达到用户点击第三个标签时 自动消除最早的标签，保证用户点的都是最新的 消除最老的 不知道有没有好办法    ××××××××××××
            //当前：俩种类，当两个都被选了时，把first清楚，再把last改为first，再给当前加个last，以此类推    -----  ((突然发现这没啥很大用处.......))
            // .length 判断当前返回的东西的长度  index() 判断当前标签在其同兄弟标签的位置   eq(N)获取该同类标签的第N个
            $('.SUBJECTDIV').click(function () {
                if ($(this).hasClass("subject_chosefirst")) {
                    $(this).removeClass("subject_chosefirst");
                }
                else if ($(this).hasClass("subject_choselast")) {
                    $(this).removeClass("subject_choselast");
                }
                else {
                    if ($(this).siblings().hasClass("subject_chosefirst") && $(this).siblings().hasClass("subject_choselast")) {
                        Subject_FirstChose = Subject_LastChose;
                        $(this).siblings(".subject_chosefirst").removeClass("subject_chosefirst");
                        $(this).siblings(".subject_choselast").removeClass("subject_choselast").addClass("subject_chosefirst");
                        $(this).addClass("subject_choselast");
                        Subject_LastChose = $(this).attr("class");
                    }
                    else if ($(this).siblings().hasClass("subject_chosefirst")) {
                        $(this).addClass("subject_choselast");
                        Subject_LastChose = $(this).attr("class");
                    }
                    else {
                        $(this).addClass("subject_chosefirst")
                        Subject_FirstChose = $(this).attr("class");
                    }
                }
            });

            $('.confirm_position').click(function () {
                //由于上面已取得已被选中的题目的class，现在只要判断是否用户选完毕即可将参数给后台
                if ($(".SUBJECTDIV").hasClass("subject_chosefirst") && $(".SUBJECTDIV").hasClass("subject_choselast")) {
                    //将参数传给后台 一个带参数的函数当中的办法 （dataType为Json  data的格式为 "{'（与后台函数参数同名）':'XX'}"）
                    $.ajax({
                        type: "Post",
                        url: "Test.aspx/SayHello",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'str1':'" + Subject_FirstChose + "','str2':'" + Subject_LastChose + "'}",
                        success: function (data) {
                            //返回的数据用data.d获取内容   
                            $(".test_subject").html(data.d);
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                    $(".test_rsp").remove();

                }
                else {
                    alert("喵喵喵喵喵，你选的啥来着？");
                }
            });
        })
/*hasClass,removeClass,addClass 都是添加或判断是否有一个类或者多个*/
</script>
</html>

