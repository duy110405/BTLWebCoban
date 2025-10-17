<%@ Page Title="Trang chủ" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="Trangchu.aspx.cs" Inherits="btlweb.Trangchu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="css/Trangchu.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

        <!------------------------------------------------ ----------------------- ẢNH TRƯNG BÀY  ------------------------------------------ -->
    <div class ="anhTrungBay">
         <img src="anh/anhtrungbay.jpg" alt ="Ảnh trưng bày " />
    </div>
    
         <!------------------------------------------------ ----------------------- GIẢM GIÁ  ------------------------------------------ -->
    <div class="khungGiamGia khung-san-pham-chung">
        <div class="tieudegiamgia tieude-chung">
            Giảm Giá Mạnh 
        </div>
        <div class="khungSpGiamGia khung-noi-dung-chung">

        <article class="card">
            <img src="anh/sp_legion_pro5.jpg" alt="Legion Pro 5" />
            <h4 class="spec">i5 12400hx | Rtx 4060<br />16gb | 512gb | 16 full hd</h4>
            <p class="name">Laptop Legion pro 5</p>
            <p class="price">25.000.000đ</p>
        </article>    

            <article class="card">
                <img src="anh/sp_x1_carbon.jpg" alt="ThinkPad X1 Carbon" />
                <h4 class="spec">i5 1240u | iris xe plus<br />32gb | 512gb | 14 quad hd</h4>
                <p class="name">Laptop thinkpad x1 carbon</p>
                <p class="price">23.000.000đ</p>
            </article>

            <article class="card">
                <img src="anh/banphim2.jpg" alt="Aula S2022" />
                <h4 class="spec">Kiểu dáng: Full Size<br />Kết nối: Dây USB<br />
                <p class="name">Bàn phím cơ Aula S2022 Đen Blue Switch</p>
                <p class="price">399.000 ₫</p>
            </article> 

             <article class="card">
                <img src="anh/pc1.jpg" alt="PC Lenovo ThinkCentre Neo 50T G5" />
                <h4 class="spec">i3 14100 | 8GB | 512GB SSD<br />Intel UHD 730</h4>
                <p class="name">PC Lenovo ThinkCentre Neo 50T G5 12UB0001VA</p>
                <p class="price">10.590.000đ</p>
            </article>

        </div>
    </div>

              <!------------------------------------------------ ----------------------- BÁN CHẠY  ------------------------------------------ -->
      <div class="khungBanChay khung-san-pham-chung">
        <div class="tieudebanchay tieude-chung" >
            Bán Chạy 
        </div>
        <div class="khungSpBanChay khung-noi-dung-chung">

        <article class="card">
            <img src="anh/sp_legion_pro5.jpg" alt="Legion Pro 5" />
            <h4 class="spec">i5 12400hx | Rtx 4060<br />16gb | 512gb | 16 full hd</h4>
            <p class="name">Laptop Legion pro 5</p>
            <p class="price">25.000.000đ</p>
        </article>       
            
            <article class="card">
                <img src="anh/banphim1.jpg" alt="Aula 3 MODE F75" />
                <h4 class="spec">Kiểu dáng: Tenkeyless (nhỏ gọn)<br />Kết nối: Bluetooth/ Wireless<br />
                <p class="name">Bàn phím cơ Aula 3 MODE F75 đen + hồng gradient</p>
                <p class="price">1.290.000 ₫</p>
            </article>

            <article class="card">
                <img src="anh/banphim2.jpg" alt="Aula S2022" />
                <h4 class="spec">Kiểu dáng: Full Size<br />Kết nối: Dây USB<br />
                <p class="name">Bàn phím cơ Aula S2022 Đen Blue Switch</p>
                <p class="price">399.000 ₫</p>
            </article> 

             
            <article class="card">
                <img src="anh/sp_thinkbook14p.jpg" alt="ThinkBook 14p" />
                <h4 class="spec">r7 5800u | vega 8<br />16gb | 512 ssd | full hd</h4>
                <p class="name">Laptop lenovo thinkbook 14p</p>
                <p class="price">15.000.000đ</p>
            </article>
        </div>
    </div>


        <!------------------------------------------------ ----------------------- SP CÓ THỂ THÍCH ------------------------------------------ -->
     <div class ="khungThich khung-noi-dung-chung">
         <div class="tieudethich tieude-chung">
             Bạn Có Thể Thích
         </div>

         <div class="dongMenu">
             <p >LapTop</p>
             <p >Bàn Phím</p>
             <p >PC</p>
         </div>

         <div class="vachKeNgang"></div>


         <div class="khungSpThich khung-san-pham-chung">

             <article class="card">
                <img src="anh/sp_legion_pro5.jpg" alt="Legion Pro 5" />
                <h4 class="spec">i5 12400hx | Rtx 4060<br />16gb | 512gb | 16 full hd</h4>
                <p class="name">Laptop Legion pro 5</p>
                <p class="price">25.000.000đ</p>
             </article>       
            
             <article class="card">
                <img src="anh/sp_rog_strix16.jpg" alt="ROG Strix 16" />
                <h4 class="spec">i7 12900hx | Rtx 4070<br />32gb | 1tb | 16 quad hd</h4>
                <p class="name">Laptop rog strix 16</p>
                <p class="price">45.000.000đ</p>
            </article>

            <article class="card">
                <img src="anh/sp_yoga9i.jpg" alt="Lenovo Yoga 9i" />
                <h4 class="spec">r7 7840hs | Amd 780m<br />32gb | 1tb | 14 quad hd</h4>
                <p class="name">Laptop lenovo yoga 9i</p>
                <p class="price">35.000.000đ</p>
            </article>

            <article class="card">
                <img src="anh/sp_xps14.jpg" alt="Dell XPS 14" />
                <h4 class="spec">i7 1260p | iris xe plus<br />16gb | 512gb | 14 full hd</h4>
                <p class="name">Laptop dell xps 14</p>
                <p class="price">40.000.000đ</p>
            </article>
         </div>

     </div>
</asp:Content>
