<%@ Page Title="" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="Dangky.aspx.cs" Inherits="btlweb.Dangky" ClientIDMode="Static" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Dangky.css" />
    <script src="js/DangKy.js" defer></script>
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
                <!-- Họ -->
                <div class="auth-field">
                    <label for="txtHo" class="auth-label">Họ</label>
                    <asp:TextBox ID="txtHo" runat="server" CssClass="auth-input" placeholder="Nhập họ"></asp:TextBox>
                </div>

                <!-- Tên -->
                <div class="auth-field">
                    <label for="txtTen" class="auth-label">Tên</label>
                    <asp:TextBox ID="txtTen" runat="server" CssClass="auth-input" placeholder="Nhập tên"></asp:TextBox>
                </div>

                <!-- Email -->
                <div class="auth-field">
                    <label for="txtEmail" class="auth-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="auth-input" TextMode="Email" placeholder="ví dụ: ten@gmail.com"></asp:TextBox>
                </div>

                <!-- Số điện thoại -->
                <div class="auth-field">
                    <label for="txtPhone" class="auth-label">Số điện thoại</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="auth-input" placeholder="Nhập số điện thoại"></asp:TextBox>
                </div>

                <!-- Mật khẩu -->
                <div class="auth-field">
                    <label for="txtPass" class="auth-label">Mật khẩu</label>
                    <asp:TextBox ID="txtPass" runat="server" CssClass="auth-input" TextMode="Password" placeholder="Tối thiểu 8 ký tự"></asp:TextBox>
                </div>

                <!-- Nhập lại mật khẩu -->
                <div class="auth-field">
                    <label for="txtPass2" class="auth-label">Nhập lại mật khẩu</label>
                    <asp:TextBox ID="txtPass2" runat="server" CssClass="auth-input" TextMode="Password" placeholder="Nhập lại mật khẩu"></asp:TextBox>
                </div>

                <asp:Button ID="btnDangKy" runat="server" Text="Đăng ký" CssClass="btn-primary"
                    OnClick="btnDangKy_Click" OnClientClick="return Dangkyjs_Click();" UseSubmitBehavior="true" />

                <!-- Thông báo -->
                <asp:Literal ID="ltMsg" runat="server"></asp:Literal>

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
