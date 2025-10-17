<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="Trangchu.aspx.cs" Inherits="btlweb.Trangchu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="css/Trangchu.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

     <!-- HERO -->
  <section class="home-hero" aria-label="Ảnh trưng bày">
    <img src="anh/anhtrungbay.jpg" alt="Ảnh trưng bày" />
  </section>

  <!-- GIẢM GIÁ MẠNH -->
  <section class="section">
    <div class="section-box">
      <h2 class="section-tag tag-sale">Giảm Giá Mạnh</h2>

      <div class="grid">
          <a href="ChitietLegion5.aspx"> 
          <article class="card">
          <img src="anh/sp_legion_pro5.jpg" alt="Legion Pro 5" />
          <p class="spec">i5 12400hx | Rtx 4060<br>16gb | 512gb | 16 full hd</p>
          <h3 class="name">Laptop Legion pro 5</h3>
          <p class="price">25.000.000đ</p>
          </article>
          </a>


        <article class="card">
          <img src="anh/sp_x1_carbon.jpg" alt="ThinkPad X1 Carbon" />
          <p class="spec">i5 1240u | iris xe plus<br>32gb | 512gb | 14 quad hd</p>
          <h3 class="name">Laptop thinkpad x1 carbon</h3>
          <p class="price">23.000.000đ</p>
        </article>

        <article class="card">
          <img src="anh/banphim2.jpg" alt="Aula S2022" />
          <p class="spec">Kiểu dáng: Full Size<br>Kết nối: Dây USB</p>
          <h3 class="name">Bàn phím cơ Aula S2022 Đen Blue Switch</h3>
          <p class="price">399.000 ₫</p>
        </article>

        <article class="card">
          <img src="anh/pc1.jpg" alt="PC Lenovo ThinkCentre Neo 50T G5" />
          <p class="spec">i3 14100 | 8GB | 512GB SSD<br>Intel UHD 730</p>
          <h3 class="name">PC Lenovo ThinkCentre Neo 50T G5 12UB0001VA</h3>
          <p class="price">10.590.000đ</p>
        </article>
      </div>
    </div>
  </section>

  <!-- BÁN CHẠY -->
  <section class="section">
    <div class="section-box">
      <h2 class="section-tag tag-hot">Bán Chạy</h2>

      <div class="grid">
        <article class="card">
          <img src="anh/sp_legion_pro5.jpg" alt="Legion Pro 5" />
          <p class="spec">i5 12400hx | Rtx 4060<br>16gb | 512gb | 16 full hd</p>
          <h3 class="name">Laptop Legion pro 5</h3>
          <p class="price">25.000.000đ</p>
        </article>

        <article class="card">
          <img src="anh/banphim1.jpg" alt="Aula 3 MODE F75" />
          <p class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br>Kết nối: Bluetooth/ Wireless</p>
          <h3 class="name">Bàn phím cơ Aula 3 MODE F75 đen + hồng gradient</h3>
          <p class="price">1.290.000 ₫</p>
        </article>

        <article class="card">
          <img src="anh/banphim2.jpg" alt="Aula S2022" />
          <p class="spec">Kiểu dáng: Full Size<br>Kết nối: Dây USB</p>
          <h3 class="name">Bàn phím cơ Aula S2022 Đen Blue Switch</h3>
          <p class="price">399.000 ₫</p>
        </article>

        <article class="card">
          <img src="anh/sp_thinkbook14p.jpg" alt="ThinkBook 14p" />
          <p class="spec">r7 5800u | vega 8<br>16gb | 512 ssd | full hd</p>
          <h3 class="name">Laptop lenovo thinkbook 14p</h3>
          <p class="price">15.000.000đ</p>
        </article>
      </div>
    </div>
  </section>

  <!-- BẠN CÓ THỂ THÍCH -->
  <section class="section">
    <div class="section-box">
      <h2 class="section-tag tag-like">Bạn Có Thể Thích</h2>

      <div class="chips">
        <span>LapTop</span>
        <span>Bàn Phím</span>
        <span>PC</span>
      </div>

      <div class="section-divider"></div>

      <div class="grid">
        <article class="card">
          <img src="anh/sp_legion_pro5.jpg" alt="Legion Pro 5" />
          <p class="spec">i5 12400hx | Rtx 4060<br>16gb | 512gb | 16 full hd</p>
          <h3 class="name">Laptop Legion pro 5</h3>
          <p class="price">25.000.000đ</p>
        </article>

        <article class="card">
          <img src="anh/sp_rog_strix16.jpg" alt="ROG Strix 16" />
          <p class="spec">i7 12900hx | Rtx 4070<br>32gb | 1tb | 16 quad hd</p>
          <h3 class="name">Laptop rog strix 16</h3>
          <p class="price">45.000.000đ</p>
        </article>

        <article class="card">
          <img src="anh/sp_yoga9i.jpg" alt="Lenovo Yoga 9i" />
          <p class="spec">r7 7840hs | Amd 780m<br>32gb | 1tb | 14 quad hd</p>
          <h3 class="name">Laptop lenovo yoga 9i</h3>
          <p class="price">35.000.000đ</p>
        </article>

        <article class="card">
          <img src="anh/sp_xps14.jpg" alt="Dell XPS 14" />
          <p class="spec">i7 1260p | iris xe plus<br>16gb | 512gb | 14 full hd</p>
          <h3 class="name">Laptop dell xps 14</h3>
          <p class="price">40.000.000đ</p>
        </article>
      </div>
    </div>
  </section>
</asp:Content>
