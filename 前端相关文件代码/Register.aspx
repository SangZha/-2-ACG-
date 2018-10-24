<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Register</title>
<script type="text/javascript" src="javascript/jquery-3.1.1.js"></script>
<link rel="stylesheet" href="css/Register.css"/>
<style type="text/css">
    #form{
        width:100%;
        height:100%;
    }
    #register_button{
        background-color:#525558;
	    color:#f5f5f5;  
	    font-family:"Microsoft YaHei",微软雅黑,"MicrosoftJhengHei",华文细黑,STHeiti,MingLiu;
	    letter-spacing:10px;
	    padding-left:20px;   
    }
    input{
        font-family:'Helvetica Neue',Helvetica,'PingFang SC','Hiragino Sans GB','Microsoft YaHei',Arial,sans-serif;
        background-color:#fff;
    }
    .signup-input > div{
        position:relative;
        font-family:'Helvetica Neue',Helvetica,'PingFang SC','Hiragino Sans GB','Microsoft YaHei',Arial,sans-serif;
    }
    .signup-input-none{
        position:absolute;
        display:inline-block;
        top: 1px;
        right: 5px;
        line-height:41px;
        padding:0 10px;
        background-color:#fff;
        color:#c33;
        display:none;
    }
    .signup-input-wrong{
        position:absolute;
        display:inline-block;
        top: 1px;
        right: 5px;
        line-height:41px;
        padding:0 10px;
        background-color:#fff;
        color:#c33;
        display:none;
    }
    .signup-input-same{
        position:absolute;
        display:inline-block;
        top: 1px;
        right: 5px;
        line-height:41px;
        padding:0 10px;
        background-color:#fff;
        color:#c33;
        display:none;
    }
</style>
</head>

<body>
<form id="form" runat="server" >
<!--不知道为什么input都用padding设计大小 -->
<!--boxing-size:borderbox 使Padding border不占据宽度，方便布局-->
<!--outline input选中后出现的蓝色边框-->
  <div class="main">
     <div class="contain">
        <div class="header">
          <h1 class="signin-signup">注册</h1>
          <h2> HAHA,HA hahaha</h2>
        </div>
        <div class="signup-input">
          <div class="signup-input-name">
            <asp:TextBox runat="server" ID="name" type="text" placeholder="昵称"/>
            <asp:Label runat="server" ID="name_none" class="signup-input-none">昵称不可以为空</asp:Label>
            <asp:RegularExpressionValidator ID="name_wrong" runat="server" class="signup-input-wrong" ErrorMessage="RegularExpressionValidator" Text="请输入2-10个之间汉字" ControlToValidate="name" Display="Dynamic" ValidationExpression="^[A-Za-z\u4e00-\u9fa5]{2,10}$"></asp:RegularExpressionValidator>
            <asp:Label runat="server" ID="name_same" class="signup-input-same">该昵称已经被人使用</asp:Label>
          </div>
          <div class="signup-input-account">
            <asp:TextBox runat="server" ID="account" type="text" placeholder="账号"/>
            <asp:Label runat="server" ID="account_none" class="signup-input-none">账号不可以为空</asp:Label>
            <asp:RegularExpressionValidator ID="account_wrong" runat="server" class="signup-input-wrong" ErrorMessage="RegularExpressionValidator" Text="请输入6-16英文或数字组合" ControlToValidate="account" Display="Dynamic" ValidationExpression="^[a-zA-Z][a-zA-Z0-9]{6,16}"></asp:RegularExpressionValidator>
            <asp:Label runat="server" ID="account_same" class="signup-input-same">该账号已经被人注册</asp:Label>
          </div>
          <div class="signup-input-password">
            <asp:TextBox runat="server" ID="password" type="password" placeholder="密码"/>
            <asp:RequiredFieldValidator ID="password_none" runat="server"  class="signup-input-none" ErrorMessage="RequiredFieldValidator" ControlToValidate="password" Display="Dynamic">密码不可以为空</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="password_wrong" runat="server" class="signup-input-wrong" ErrorMessage="RegularExpressionValidator" Text="请输入8-20个英文或数字组合" ControlToValidate="password" Display="Dynamic" ValidationExpression="^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{8,20}$"></asp:RegularExpressionValidator>
          </div>          
          <div class="signup-input-passwordcheck">
            <asp:TextBox runat="server" ID="password_confirm" type="password" placeholder="确认密码"/>
            <asp:CompareValidator ID="passwordconfirm_wrong" runat="server" class="signup-input-wrong" ErrorMessage="CompareValidator" Text="请确认两次密码相同" ControlToCompare="password_confirm" ControlToValidate="password" Display="Dynamic"></asp:CompareValidator>
          </div>         
        </div> 
        <div class="signup-input-confirm">
            <asp:Button runat="server" ID="register_button" type="button" text="注册" OnClick="register_button_Click"/>
        </div>
     </div>
     <div class="switch">
     	<a href="Login.aspx" class="signin">登录</a>
     </div>
  </div>
</form>
<script type="text/javascript">
    $(function () {
        $("#name").focus(function () {
            $("#name_wrong").hide();
            $("#name_same").hide();
            $("#name_none").hide();
        })

        $("#account").focus(function () {
            $("#account_wrong").hide();
            $("#account_same").hide();
        })
    });
</script>
</body>
</html>
