<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Login</title>
<script type="text/javascript" src="javascript/jquery-3.1.1.js"></script>
<link rel="stylesheet" href="css/Login.css"/>
</head>

<body>
<form id="form" runat="server" >
<div class="main">
     <div class="contain">
        <div class="header">
          <h1 class="signin-signup">登录</h1>
          <h2> HAHA,HA hahaha</h2>
        </div>
        <div class="signin-input">
          <div class="signin-input-account">
            <asp:textbox runat="server" id="account" type="text" placeholder="账号"/>
            <asp:Label runat="server" ID="account_none" class="signin-input-none">请输入您的账号</asp:Label>
            <asp:Label runat="server" ID="account_wrong" class="signin-input-wrong">该账号不存在</asp:Label>
          </div>
          <div class="signin-input-password">
            <asp:textbox runat="server" ID="password" type="password" placeholder="密码"/>
            <asp:Label runat="server" ID="password_none" class="signin-input-none">请输入您的密码</asp:Label>
            <asp:Label runat="server" ID="password_wrong" class="signin-input-wrong">您输入的密码错误</asp:Label>
          </div>            
        </div> 
        <div class="signin-input-confirm">
            <asp:Button  runat="server" id="login_button" text="登录" OnClick="login_button_Click"/>
        </div>
     </div>
     <div class="switch">
     	<a href="Register.aspx" class="signup">注册</a>
     </div>
</div>
</form>
<script type="text/javascript">
    $(function () {
        $("#account").focus(function () {
            $("#account_wrong").hide();
            $("#account_none").hide();
        })

        $("#password").focus(function () {
            $("#password_none").hide();
            $("#password_wrong").hide();
        })
    });
</script>
</body>
</html>

