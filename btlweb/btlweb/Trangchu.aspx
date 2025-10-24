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
                    <h1 style="color: #ffffff;">SẢN PHẨM CÔNG NGHỆ CAO CẤP</h1>
                    <p style="color: #e5e7eb;">Deal xịn mỗi ngày. Freeship nội thành từ 1.5 triệu.</p>
                    <div style="display:flex; gap:8px;">
                        <a class="btn primary" href="#bancothethich">Khám phá ngay</a>
                        <a class="btn outline-light" href="#flash">Flash sale</a>
                    </div>
                </div>
                <div style="display:grid; place-items:center;">
                    </div>
            </div>
        </article>

        <aside class="mini">
            <div style="text-align:center; padding:16px;">
                <h3 style="margin:0 0 6px; color: var(--accent);">Ưu đãi học sinh, sinh viên</h3>
                <p style="margin:0 0 10px; color:#6b7280;">Giảm 5% cho đơn laptop kèm balo</p>
                <a class="btn primary" href="Giohang.aspx">Lấy mã</a>
            </div>
        </aside>
    </div>
</section>

    <!-- Policy trip -->
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

            <!-- BÁN CHẠY -->

        <div class="tab-panels">
         
        <div class="panel" id="tab-suggested">

          <div class="grid">
            <!-- Product card sample -->
             <article class="card">
                <span class="badge">-15%</span>
                <img src="anh/banphim2.jpg" alt="Aula S2022" />
                <h4 class="spec">Kiểu dáng: Full Size<br />Kết nối: Dây USB</h4>
                <p class="name">Bàn phím cơ Aula S2022 Đen Blue Switch</p>
                <p class="price"><span class="cur">399.000đ</span> <span class="old">340.000đ</span></p>
                <div class="rating">★★★★★ 123 đánh giá</div>
            </article>


            
             <article class="card">
                <span class="badge">0%</span>
                <img src="anh/sp_legion_pro5.jpg" alt="Legion Pro 5" />
                <h4 class="spec">i5 12400hx | Rtx 4060<br />16gb | 512gb | 16 full hd</h4>
                <p class="name">Laptop Legion pro 5</p>
                <p class="price">25.000.000đ</p>
                <div class="rating">★★★★★ 56 đánh giá</div>
                </article>

               <article class="card">
                <span class="badge">0%</span>
                <img src="anh/sp_inspiron3000.jpg" alt="Inspiron 3000" />
                <h4 class="spec">i3 1115g4 | mx 2000<br />8gb | 256 ssd | 14 full hd</h4>
                <p class="name">Laptop dell inspiron 3000</p>
                <p class="price">15.000.000đ</p>
                <div class="rating">★★★★★ 30 đánh giá</div>
            </article>

                <article class="card">
                <span class="badge">0%</span>
                <img src="anh/banphim5.jpg" alt="KENOO EK87" />
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Dây USB</h4>
                <p class="name">Bàn phím cơ KENOO ESPORT EK87</p>
                <p class="price">459.000 ₫</p>
                <div class="rating">★★★★★ 25 đánh giá</div>
            </article>
            </div>
          </div>
        
       
             <!-- HÀNG MỚI -->

             <div class="panel hidden" id="tab-new">
          <div class="grid">

             <article class="card">
                 <span class="badge">New</span>
                <img src="anh/banphim2.jpg" alt="Aula S2022" />
                <h4 class="spec">Kiểu dáng: Full Size<br />Kết nối: Dây USB<br />Switch: Blue Switch<br />Keycap: ABS<br />Đèn: LED Rainbows</h4>
                <p class="name">Bàn phím cơ Aula S2022 Đen Blue Switch</p>
                <p class="price">399.000 ₫</p>
                  <div class="rating">★★★★☆ 58 đánh giá</div>
            </article>

            <article class="card">
                 <span class="badge">New</span>
                <img src="anh/pc2.jpg" alt="PC HP Pro Tower 280 G9" />
                <h4 class="spec">i3 13100 | 8GB | 256GB SSD<br />Intel UHD 730 | Win 11</h4>
                <p class="name">PC HP Pro Tower 280 G9 B91LVAT</p>
                <p class="price">10.490.000đ</p>
                 <div class="rating">★★★★☆ 45 đánh giá</div>
            </article>

             <article class="card">
                <span class="badge">New</span>
                <img src="anh/banphim7.jpg" alt="HyperWork SilentKey" />
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Bluetooth/ Wireless</h4>
                <p class="name">Bàn phím không dây HyperWork SilentKey Mini</p>
                <p class="price">599.000 ₫</p>
                <div class="rating">★★★☆☆ 11 đánh giá</div>
            </article>

           
            <article class="card">
                <span class="badge">New</span>
                <img src="anh/sp_thinkbook14p.jpg" alt="ThinkBook 14p" />
                <h4 class="spec">r7 5800u | vega 8<br />16gb | 512 ssd | full hd</h4>
                <p class="name">Laptop lenovo thinkbook 14p</p>
                <p class="price">15.000.000đ</p>
                <div class="rating">★★★★★ 30 đánh giá</div>
            </article>

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

          <article class="card">
              <span class="badge">-35%</span>
                <img src="anh/sp_inspiron3000.jpg" alt="Inspiron 3000" />
                <h4 class="spec">i3 1115g4 | mx 2000<br />8gb | 256 ssd | 14 full hd</h4>
                <p class="name">Laptop dell inspiron 3000</p>
                <p class="price"><span class="cur">15.000.000đ</span> <span class="old">9.725.000đ</span></p>
            </article>
       
            <article class="card">
                <span class="badge">-20%</span>
                <img src="anh/pc8.jpg" alt="PC Dell Slim DS-14100-8-512G" />
                <h4 class="spec">i3 14100 | 8GB | 512GB SSD<br />Intel UHD | Win 11</h4>
                <p class="name">PC Dell Slim DS-14100-8-512G</p>
                <p class="price"><span class="cur">12.000.000đ</span> <span class="old">8.500.000đ</span></p>
            </article>

        <article class="card">
                <span class="badge">-15%</span>
                <img src="anh/pc9.jpg" alt="PC Lenovo ThinkCentre M70t G5 Extra" />
                <h4 class="spec">i5 14400 | 8GB | 512GB SSD<br />Intel UHD 730</h4>
                <p class="name">PC Lenovo ThinkCentre M70t G5 (Phiên bản mở rộng)</p>
                <p class="price"><span class="cur">13.690.000đ</span> <span class="old">11.950.000đ</span></p>
            </article>

          <article class="card">
                <span class="badge">-25%</span>
                <img src="anh/sp_acer_nitro5.jpg" alt="Acer Nitro 5" />
                <h4 class="spec">i7 12500hx | rtx 3050 ti<br />16 gb | 1tb | quad hd</h4>
                <p class="name">Laptop acer nitro 5</p>
                <p class="price"><span class="cur">21.000.000đ</span><span class="old">15.490.000đ</span></p>
            </article>

      </div>

      </div>
    </section>

  <!------------------------------------------------ BẠN CÓ THỂ THÍCH -------------------------->
  <section class="section" id="bancothethich">
    <div class="section-box">
      <h2 class="section-title">Bạn Có Thể Thích</h2>

      <div class="chips">
         <button class="tab is-active" data-target="#tab-Laptop" role="tab">LapTop</button>
          <button class="tab" data-target="#tab-BanPhim" role="tab">Bàn Phím </button>
         <button class="tab" data-target="#tab-PC" role="tab">PC </button>
      </div>

      <div class="section-divider"></div>

        <!------------LAPTOP------------->

        <div class ="panel is-active" id ="tab-Laptop">
      <div class="grid">
         <a href="ChitietLegion5.aspx">
                <article class="card">
                <img src="anh/sp_legion_pro5.jpg" alt="Legion Pro 5" />
                <h4 class="spec">i5 12400hx | Rtx 4060<br />16gb | 512gb | 16 full hd</h4>
                <p class="name">Laptop Legion pro 5</p>
                <p class="price">25.000.000đ</p>
                </article>
            </a>

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

          <article class="card">
                <img src="anh/sp_x1_carbon.jpg" alt="ThinkPad X1 Carbon" />
                <h4 class="spec">i5 1240u | iris xe plus<br />32gb | 512gb | 14 quad hd</h4>
                <p class="name">Laptop thinkpad x1 carbon</p>
                <p class="price">23.000.000đ</p>
            </article>

          
            <article class="card">
                <img src="anh/sp_inspiron3000.jpg" alt="Inspiron 3000" />
                <h4 class="spec">i3 1115g4 | mx 2000<br />8gb | 256 ssd | 14 full hd</h4>
                <p class="name">Laptop dell inspiron 3000</p>
                <p class="price">15.000.000đ</p>
            </article>

            <article class="card">
                <img src="anh/sp_msi_modern15.jpg" alt="MSI Modern 15" />
                <h4 class="spec">r7 5700u | vega 8<br />16gb | 512gb | full hd</h4>
                <p class="name">Laptop msi modern 15</p>
                <p class="price">19.990.000đ</p>
            </article>

            <article class="card">
                <img src="anh/sp_acer_nitro5.jpg" alt="Acer Nitro 5" />
                <h4 class="spec">i7 12500hx | rtx 3050 ti<br />16 gb | 1tb | quad hd</h4>
                <p class="name">Laptop acer nitro 5</p>
                <p class="price">21.000.000đ</p>
            </article>


      </div>
      </div>

        <!---------------------BÀN PHÍM----------------- -->
        <div class ="panel-hidden" id ="tab-BanPhim">
      <div class="grid">
         <article class="card">
                <a href="Aula3MODEF75.aspx">
                <img src="anh/banphim1.jpg" alt="Aula 3 MODE F75" />
                </a>
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Bluetooth/ Wireless</h4>
                <a href="Aula3MODEF75.aspx" class="name">Bàn phím cơ Aula 3 MODE F75 đen + hồng gradient</a>
                <p class="price">1.290.000 ₫</p>
            </article>

             <article class="card">
                <img src="anh/banphim2.jpg" alt="Aula S2022" />
                <h4 class="spec">Kiểu dáng: Full Size<br />Kết nối: Dây USB</h4>
                <p class="name">Bàn phím cơ Aula S2022 Đen Blue Switch</p>
                <p class="price">399.000 ₫</p>
            </article>

           <article class="card">
                <img src="anh/banphim3.jpg" alt="Dareu EK87 Pro" />
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Bluetooth/ Wireless</h4>
                <p class="name">Bàn phím cơ không dây Dareu EK87 Pro Triple Mode</p>
                <p class="price">999.000 ₫</p>
            </article>

        <article class="card">
                <img src="anh/banphim4.jpg" alt="Aula F75 Xám" />
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Bluetooth/ Wireless</h4>
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

      </div>
      </div>

        <!----------------------------PC-------------------------->
        <div class ="panel-hidden" id ="tab-PC">
      <div class="grid">
        <article class="card">
                <a href="LenovoThinkCentre.aspx">
                    <img src="anh/pc1.jpg" alt="PC Lenovo ThinkCentre Neo 50T G5" />
                    <h4 class="spec">i3 14100 | 8GB | 512GB SSD<br />Intel UHD 730</h4>
                    <p class="name">PC Lenovo ThinkCentre Neo 50T G5 12UB0001VA</p>
                    <p class="price">10.590.000đ</p>
                </a>
            </article>

        <article class="card">
                <img src="anh/pc2.jpg" alt="PC HP Pro Tower 280 G9" />
                <h4 class="spec">i3 13100 | 8GB | 256GB SSD<br />Intel UHD 730 | Win 11</h4>
                <p class="name">PC HP Pro Tower 280 G9 B91LVAT</p>
                <p class="price">10.490.000đ</p>
            </article>

        <article class="card">
                <img src="anh/pc3.jpg" alt="PC Dell Tower ECT1250 71066637" />
                <h4 class="spec">i5 14400 | 16GB | 1TB SSD<br />Intel UHD | Win 11</h4>
                <p class="name">PC Dell Tower ECT1250 71066637</p>
                <p class="price">18.190.000đ</p>
            </article>

        <article class="card">
                <img src="anh/pc4.jpg" alt="PC Dell Tower ECT1250 " />
                <h4 class="spec">i5 14400 | 16GB | 1TB SSD<br />Intel UHD | Win 11</h4>
                <p class="name">PC Dell Tower ECT1250 </p>
                <p class="price">18.190.000đ</p>
            </article>

          <article class="card">
                <img src="anh/pc5.jpg" alt="PC Lenovo ThinkCentre M70t G5" />
                <h4 class="spec">i5 14400 | 8GB | 512GB SSD<br />Intel UHD 730</h4>
                <p class="name">PC Lenovo ThinkCentre M70t G5 12U0000DVA</p>
                <p class="price">13.690.000đ</p>
            </article>

            <article class="card">
                <img src="anh/pc6.jpg" alt="PC Dell Slim DS-14400-16-512G" />
                <h4 class="spec">i5 14400 | 16GB | 512GB SSD<br />Intel UHD | Win 11</h4>
                <p class="name">PC Dell Slim DS-14400-16-512G</p>
                <p class="price">16.590.000đ</p>
            </article>

            <article class="card">
                <img src="anh/pc7.jpg" alt="PC Dell Tower ECT1250 TFPC81" />
                <h4 class="spec">i5 14400 | 8GB | 512GB SSD<br />Intel UHD | Win 11</h4>
                <p class="name">PC Dell Tower ECT1250 TFPC81</p>
                <p class="price">14.990.000đ</p>
            </article>

            <article class="card">
                <img src="anh/pc8.jpg" alt="PC Dell Slim DS-14100-8-512G" />
                <h4 class="spec">i3 14100 | 8GB | 512GB SSD<br />Intel UHD | Win 11</h4>
                <p class="name">PC Dell Slim DS-14100-8-512G</p>
                <p class="price">12.190.000đ</p>
            </article>

      </div>
      </div>
    </div>
  </section>

</asp:Content>
