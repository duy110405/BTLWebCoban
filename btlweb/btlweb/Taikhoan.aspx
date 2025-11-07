<%@ Page Title="" Language="C#" MasterPageFile="~/khung.Master" AutoEventWireup="true"  ClientIDMode="Static" CodeBehind="Taikhoan.aspx.cs" Inherits="btlweb.Taikhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Taikhoan.css" />
    <script src ="js/DangNhap.js" defer></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
<div class="login-wrap">
    <section class="login-card" role="group" aria-label="Đăng nhập tài khoản">
      <h2 class="login-title">Đăng nhập tài khoản</h2>

      <div class="form-group">
        <label style="margin-bottom:8px">Tên đăng nhập</label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="input" placeholder="Email hoặc SĐT"></asp:TextBox>
      </div>

      <div class="form-group">
          <label style="margin-bottom:8px">Mật khẩu</label>
        <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" placeholder="Mật khẩu"></asp:TextBox>
      </div>

      <div class="row-between">
        <a href="Dangky.aspx"><span class="pseudo-link">Đăng ký</span></a>
        <span class="pseudo-link">Quên mật khẩu?</span>
      </div>

      <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Đăng nhập" OnClick="btnLogin_Click" 
          OnClientClick ="return btnLoginJs_Click()" UseSubmitBehavior="true" />

      <!-- thông báo -->
      <asp:Literal ID="ltMsg" runat="server"></asp:Literal>


      <div class="divider"><span>hoặc đăng nhập bằng</span></div>

      <div class="social-row">
        <button type="button" class="btn-social fb">Facebook</button>
        <button type="button" class="btn-social gg">Google</button>
      </div>
    </section>
  </div>

</asp:Content>

