<%@ Page Title="" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="Dangky.aspx.cs" Inherits="btlweb.Dangky" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Dangky.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <section class="auth-page">
        <div class="auth-card">
            <h1 class="auth-title">ĐĂNG KÝ</h1>
            <p class="auth-sub">
                Đã có tài khoản,
                <a class="link-inline" href="Taikhoan.aspx">đăng nhập tại đây</a>
            </p>

            <div class="auth-form">
                <asp:TextBox ID="txtHo" runat="server" CssClass="auth-input" placeholder="Họ"></asp:TextBox>
                <asp:TextBox ID="txtTen" runat="server" CssClass="auth-input" placeholder="Tên"></asp:TextBox>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="auth-input" placeholder="Email" TextMode="Email"></asp:TextBox>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="auth-input" placeholder="Số điện thoại"></asp:TextBox>
                <asp:TextBox ID="txtPass" runat="server" CssClass="auth-input" placeholder="Mật khẩu" TextMode="Password"></asp:TextBox>

                <asp:Button ID="btnDangKy" runat="server" Text="Đăng ký" CssClass="btn-primary"
                     />

                <div class="social-sep"><span>Hoặc đăng nhập bằng</span></div>

                <div class="social-row">
                    <button type="button" class="social-btn fb">
                        <span class="ico">f</span><span>Facebook</span>
                    </button>
                    <button type="button" class="social-btn gg">
                        <span class="ico">G+</span><span>Google</span>
                    </button>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
