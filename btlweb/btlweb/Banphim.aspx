<%@ Page Title="" Language="C#" MasterPageFile="~/khung.Master" AutoEventWireup="true" CodeBehind="Banphim.aspx.cs" Inherits="btlweb.Banphim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Banphim.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="page-container">
        <!-- SIDEBAR: BỘ LỌC -->
        <aside class="filter" aria-label="Bộ lọc sản phẩm">
            <h3>Danh mục sản phẩm:</h3>
            <ul class="cat-list">
                <li><a href="#">Bàn phím cơ</a></li>
                <li><a href="#">Bàn phím không dây</a></li>
                <li><a href="#">Bàn phím văn phòng</a></li>
                <li><a href="#">Bàn phím gaming</a></li>
            </ul>

            <h3>Thương hiệu</h3>
            <div class="check-group">
                <label><input type="checkbox" /> Aula</label>
                <label><input type="checkbox" /> DareU</label>
                <label><input type="checkbox" /> KENOO</label>
                <label><input type="checkbox" /> E-Dra</label>
                <label><input type="checkbox" /> HyperWork</label>
                <label><input type="checkbox" /> Newmen</label>
                <label><input type="checkbox" /> SingPC</label>
            </div>
        </aside>

        <!-- CONTENT: LƯỚI SẢN PHẨM -->
        <section class="product-grid">

            <article class="card">
                <a href="Aula3MODEF75.aspx">
                <img src="anh/banphim1.jpg" alt="Aula 3 MODE F75" />
                </a>
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Bluetooth/ Wireless<br />Switch: Reaper switch<br />Keycap: PBT cao cấp<br />Đèn: LED RGB</h4>
                <a href="Aula3MODEF75.aspx" class="name">Bàn phím cơ Aula 3 MODE F75 đen + hồng gradient</a>
                <p class="price">1.290.000 ₫</p>
            </article>

            <article class="card">
                <img src="anh/banphim2.jpg" alt="Aula S2022" />
                <h4 class="spec">Kiểu dáng: Full Size<br />Kết nối: Dây USB<br />Switch: Blue Switch<br />Keycap: ABS<br />Đèn: LED Rainbows</h4>
                <p class="name">Bàn phím cơ Aula S2022 Đen Blue Switch</p>
                <p class="price">399.000 ₫</p>
            </article>

            <article class="card">
                <img src="anh/banphim3.jpg" alt="Dareu EK87 Pro" />
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Bluetooth/ Wireless<br />Switch: DareU Cloud<br />Keycap: PBT cao cấp<br />Đèn: LED RGB</h4>
                <p class="name">Bàn phím cơ không dây Dareu EK87 Pro Triple Mode</p>
                <p class="price">999.000 ₫</p>
            </article>

            <article class="card">
                <img src="anh/banphim4.jpg" alt="Aula F75 Xám" />
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Bluetooth/ Wireless<br />Switch: Reaper switch<br />Keycap: PBT cao cấp<br />Đèn: LED RGB</h4>
                <p class="name">Bàn phím cơ Aula 3 MODE F75 Xám + Đen gradient</p>
                <p class="price">1.159.000 ₫</p>
            </article>

            <article class="card">
                <img src="anh/banphim5.jpg" alt="KENOO EK87" />
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Dây USB<br />Switch: Brown Switch<br />Đèn: LED Rainbows</h4>
                <p class="name">Bàn phím cơ KENOO ESPORT EK87</p>
                <p class="price">459.000 ₫</p>
            </article>

            <article class="card">
                <img src="anh/banphim6.jpg" alt="E-Dra EK302" />
                <h4 class="spec">Kiểu dáng: Full Size<br />Kết nối: Dây USB<br />Keycap: ABS</h4>
                <p class="name">Bàn phím Gaming E-Dra EK302 Blue + Yellow</p>
                <p class="price">399.000 ₫</p>
            </article>

            <article class="card">
                <img src="anh/banphim7.jpg" alt="HyperWork SilentKey" />
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Bluetooth/ Wireless</h4>
                <p class="name">Bàn phím không dây HyperWork SilentKey Mini</p>
                <p class="price">599.000 ₫</p>
            </article>

            <article class="card">
                <img src="anh/banphim8.jpg" alt="SingPC KB-M330" />
                <h4 class="spec">Kiểu dáng: Full Size<br />Kết nối: Dây USB</h4>
                <p class="name">Bàn phím SingPC KB-M330</p>
                <p class="price">99.000 ₫</p>
            </article>

            <article class="card">
                <img src="anh/banphim9.jpg" alt="Newmen E340" />
                <h4 class="spec">Kiểu dáng: Full Size<br />Kết nối: Dây USB</h4>
                <p class="name">Bàn phím Newmen E340</p>
                <p class="price">139.000 ₫</p>
            </article>

        </section>
    </div>
</asp:Content>
