<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="Trangchu.aspx.cs" Inherits="btlweb.Trangchu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="css/Trangchu.css" />
    <script src="js/TrangChu.js" defer></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

    <!-- HERO -->
    <section class="hero">
        <div class="hero-grid">
            <article class="banner" style="background-image: url('anh/banner.jpg');">
                <div class="content">
                    <div>
                        <h1 style="color:#ffffff;">SẢN PHẨM CÔNG NGHỆ CAO CẤP</h1>
                        <p style="color:#e5e7eb;">Deal xịn mỗi ngày. Freeship nội thành từ 1.5 triệu.</p>
                        <div style="display:flex;gap:8px;">
                            <a class="btn primary" href="#bancothethich">Khám phá ngay</a>
                            <a class="btn outline-light" href="#flash">Flash sale</a>
                        </div>
                    </div>
                    <div style="display:grid;place-items:center;"></div>
                </div>
            </article>

            <aside class="mini">
                <div style="text-align:center;padding:16px;">
                    <h3 style="margin:0 0 6px;color:var(--accent);">Ưu đãi học sinh, sinh viên</h3>
                    <p style="margin:0 0 10px;color:#6b7280;">Giảm 5% cho đơn laptop kèm balo</p>
                    <a class="btn primary" href="Giohang.aspx">Lấy mã</a>
                </div>
            </aside>
        </div>
    </section>

    <!-- Policy strip -->
    <div class="strip">
        <div class="policy">
            <div class="ic">🚚</div>
            <div>
                <h4>Giao nhanh 2h</h4>
                <p>Nội thành Hà Nội, theo khung giờ bạn chọn.</p>
            </div>
        </div>
        <div class="policy">
            <div class="ic">🔁</div>
            <div>
                <h4>Đổi trả 7 ngày</h4>
                <p>Đổi mẫu khác nếu chưa ưng, miễn phí 1 lần.</p>
            </div>
        </div>
        <div class="policy">
            <div class="ic">🛡️</div>
            <div>
                <h4>Bảo hành chuẩn hãng</h4>
                <p>Hỗ trợ tận nơi đối với lỗi do nhà sản xuất.</p>
            </div>
        </div>
    </div>

    <!-- GỢI Ý HÔM NAY -->
    <section class="section" id="goiy" data-tabs>
        <div class="section-box">
            <div class="section-head">
                <h2 class="section-title">Gợi ý hôm nay</h2>
                <div class="tabs" role="tablist">
                    <button class="tab is-active" data-target="#tab-suggested" role="tab">Bán chạy</button>
                    <button class="tab" data-target="#tab-new" role="tab">Hàng mới</button>
                </div>
            </div>

            <div class="tab-panels">
                <!-- BÁN CHẠY -->
                <div class="panel is-active" id="tab-suggested">
                    <div class="grid">
                        <asp:Repeater ID="rptBanChay" runat="server">
                            <ItemTemplate>
                                <article class="card">
                                    <span class="badge"><%# Eval("Badge") %></span>
                                    <img src="<%# Eval("AnhChinh") %>" alt="<%# Eval("TenSP") %>" />
                                    <h4 class="spec"><%# Eval("SpecHTML") %></h4>
                                    <p class="name"><%# Eval("TenSP") %></p>
                                    <p class="price">
                                        <span class="cur"><%# Eval("GiaText") %></span>
                                        <asp:PlaceHolder runat="server" Visible='<%# (bool)Eval("HasDiscount") %>'>
                                            <span class="old"><%# Eval("GiaGocText") %></span>
                                        </asp:PlaceHolder>
                                    </p>
                                    <div class="rating">★★★★★</div>
                                </article>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <!-- HÀNG MỚI -->
                <div class="panel hidden" id="tab-new">
                    <div class="grid">
                        <asp:Repeater ID="rptHangMoi" runat="server">
                            <ItemTemplate>
                                <article class="card">
                                    <span class="badge"><%# Eval("Badge") %></span>
                                    <img src="<%# Eval("AnhChinh") %>" alt="<%# Eval("TenSP") %>" />
                                    <h4 class="spec"><%# Eval("SpecHTML") %></h4>
                                    <p class="name"><%# Eval("TenSP") %></p>
                                    <p class="price">
                                        <span class="cur"><%# Eval("GiaText") %></span>
                                        <asp:PlaceHolder runat="server" Visible='<%# (bool)Eval("HasDiscount") %>'>
                                            <span class="old"><%# Eval("GiaGocText") %></span>
                                        </asp:PlaceHolder>
                                    </p>
                                    <div class="rating">★★★★☆</div>
                                </article>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- GIẢM GIÁ -->
    <section class="section" id="flash">
        <div class="section-box">
            <h2 class="section-title">Flash Sale trong ngày</h2>
            <div class="grid">
                <asp:Repeater ID="rptFlashSale" runat="server">
                    <ItemTemplate>
                        <article class="card">
                            <span class="badge"><%# Eval("Badge") %></span>
                            <img src="<%# Eval("AnhChinh") %>" alt="<%# Eval("TenSP") %>" />
                            <h4 class="spec"><%# Eval("SpecHTML") %></h4>
                            <p class="name"><%# Eval("TenSP") %></p>
                            <p class="price">
                                <span class="cur"><%# Eval("GiaText") %></span>
                                <asp:PlaceHolder runat="server" Visible='<%# (bool)Eval("HasDiscount") %>'>
                                    <span class="old"><%# Eval("GiaGocText") %></span>
                                </asp:PlaceHolder>
                            </p>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- BẠN CÓ THỂ THÍCH -->
    <section class="section" id="bancothethich">
        <div class="section-box">
            <h2 class="section-title">Bạn Có Thể Thích</h2>

            <div class="chips">
                <button class="tab is-active" data-target="#tab-Laptop" role="tab">LapTop</button>
                <button class="tab" data-target="#tab-BanPhim" role="tab">Bàn Phím</button>
                <button class="tab" data-target="#tab-PC" role="tab">PC</button>
            </div>

            <div class="section-divider"></div>

            <!-- Laptop -->
            <div class="panel is-active" id="tab-Laptop">
                <div class="grid">
                    <asp:Repeater ID="rptLaptop" runat="server">
                        <ItemTemplate>
                            <article class="card">

                                 <a class="card-link" href='<%# "ChitietLegion5.aspx?masp=" + Eval("MaSP") %>' aria-label='<%# "Xem " + Eval("TenSP") %>'></a>

                                <img src="<%# Eval("AnhChinh") %>" alt="<%# Eval("TenSP") %>" />
                                <h4 class="spec"><%# Eval("SpecHTML") %></h4>
                                <p class="name"><%# Eval("TenSP") %></p>
                                <p class="price"><span class="cur"><%# Eval("GiaText") %></span></p>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- Bàn phím -->
            <div class="panel-hidden" id="tab-BanPhim">
                <div class="grid">
                    <asp:Repeater ID="rptBanPhim" runat="server">
                        <ItemTemplate>
                            <article class="card">
                                <img src="<%# Eval("AnhChinh") %>" alt="<%# Eval("TenSP") %>" />
                                <h4 class="spec"><%# Eval("SpecHTML") %></h4>
                                <p class="name"><%# Eval("TenSP") %></p>
                                <p class="price"><span class="cur"><%# Eval("GiaText") %></span></p>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- PC -->
            <div class="panel-hidden" id="tab-PC">
                <div class="grid">
                    <asp:Repeater ID="rptPC" runat="server">
                        <ItemTemplate>
                            <article class="card">
                                <img src="<%# Eval("AnhChinh") %>" alt="<%# Eval("TenSP") %>" />
                                <h4 class="spec"><%# Eval("SpecHTML") %></h4>
                                <p class="name"><%# Eval("TenSP") %></p>
                                <p class="price"><span class="cur"><%# Eval("GiaText") %></span></p>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

        </div>
    </section>

</asp:Content>
