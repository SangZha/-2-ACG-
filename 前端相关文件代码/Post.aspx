<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Post.aspx.cs" Inherits="Post" ValidateRequest="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Post</title>
<link rel="stylesheet" type="text/css" href="Simditor/css/simditor.css" />
<script type="text/javascript" src="Simditor/javascript/jquery.min.js"></script>
<script type="text/javascript" src="Simditor/javascript/module.js"></script>
<script type="text/javascript" src="Simditor/javascript/hotkeys.js"></script>
<script type="text/javascript" src="Simditor/javascript/uploader.js"></script>
<script type="text/javascript" src="Simditor/javascript/simditor.js"></script>
    <style>
        #post_main{
            width:960px;
            margin:0 auto;
        }
        .post_title_container{
            width: 100%; 
            outline: 0; 
            border: 0; 
            word-wrap: break-word;
            overflow-x: hidden;
            overflow-y: auto;
            font-size:36px;
            font-weight:bold;
            margin:10px 0;
        }
            .post_title_container:empty:before{
                content: attr(placeholder);
                color:rgb(169,169,169);
                line-height:47px;
            }
            .post_title_container:focus:before{
                content:none;
            }
    </style>
</head>

<body>
    <form runat="server">
        <div id="post_main">
            <div runat="server" id="post_title_container" class="post_title_container" contenteditable="true" placeholder="在这里输入文章标题" >     
            </div>
            <textarea id="editor_content" placeholder="在这里输入文章内容" runat="server" autofocus></textarea>
            <asp:Button ID="article_submit" runat="server" Text="Button" OnClick="article_submit_Click" />
            <asp:HiddenField ID="hidden" runat="server" />
        </div>
    </form>
<script type="text/javascript">
//使用文本编辑器前请静下心熟读文档，一般文本编辑器会把内容自动给textarea，后台直接拿就行！！！ 
//  http//www.xuanfengge.com/textarea-on-how-to-achieve-a-high-degree-of-adaptive.html textarea高度自适应
// 使用 伪元素 empty，focus判断状态 before放置内容 来实现div的placeholder 
    // 这里使用contenteditable有个烦人的地方，后台没办法取值
    // 采用的是给一个按钮绑定后台以及前台两个事件，前台赋值给一个隐藏域，后台取隐藏域的值
    // 还好是先运行js再运行 后台
    var editor = new Simditor({
        textarea: $('#editor_content'),
        imageButton: ['upload']
    });

    $("#article_submit").click(function () {
        var temp ;
        temp = $("#post_title_container").html()
        $("#hidden").val(temp);
    })

//	var content = "test";
//	function post_article() {
//	    var title = $('#post-title-input').val();
//	    var content = editor.getValue();
//	    $.ajax({
//	        type: "POST",
//	        url: "Ajax/GetArticleContent.ashx",
//	        data: {"title": title },
//	        success: function (msg) {
//	            alert(content);
//               
//	        },
//	        error:function(msg){
//	            alert("错误" + msg);
//	        }            
//	    })
//	}
</script>
</body>
</html>