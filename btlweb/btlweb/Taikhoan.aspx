<%@ Page Title="" Language="C#" MasterPageFile="~/khung.Master" AutoEventWireup="true" CodeBehind="Taikhoan.aspx.cs" Inherits="btlweb.Taikhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Taikhoan.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="login-wrap">
    <section class="login-card" role="group" aria-label="Đăng nhập tài khoản">
      <h2 class="login-title">Đăng nhập tài khoản</h2>

      <div class="form-group">
        <asp:TextBox ID="txtUsername" runat="server" CssClass="input" placeholder="Tên đăng nhập"></asp:TextBox>
      </div>

      <div class="form-group">
        <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" placeholder="Mật khẩu"></asp:TextBox>
      </div>

      <div class="row-between">
        <span></span>
        <span class="pseudo-link">Quên mật khẩu?</span>
      </div>

      <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Đăng nhập" />

      <div class="divider"><span>hoặc đăng nhập bằng</span></div>

      <div class="social-row">
        <button type="button" class="btn-social fb">Facebook</button>
        <button type="button" class="btn-social gg">Google</button>
      </div>
    </section>
  </div>
</asp:Content>
