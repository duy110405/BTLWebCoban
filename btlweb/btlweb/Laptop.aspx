<%@ Page Title="" Language="C#" MasterPageFile="~/khung.Master" AutoEventWireup="true" CodeBehind="Laptop.aspx.cs" Inherits="btlweb.Laptop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Laptop.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
     <div class="page-container">
        <!-- SIDEBAR: BỘ LỌC -->
        <aside class="filter" aria-label="Bộ lọc sản phẩm">
            <h3>Danh mục sản phẩm:</h3>
            <ul class="cat-list">
                <li><a href="#">Laptop gaming</a></li>
                <li><a href="#">Laptop văn phòng</a></li>
                <li><a href="#">Laptop mỏng nhẹ</a></li>
                <li><a href="#">Laptop đồ hoạ</a></li>
                <li><a href="#">Laptop cảm ứng</a></li>
                <li><a href="#">Laptop AI</a></li>
            </ul>

            <h3>Sắp xếp:</h3>
            <div class="check-group">
                <label><input type="checkbox" /> Theo giá</label>
                <label><input type="checkbox" /> Tên A-Z</label>
                <label><input type="checkbox" /> Tên Z-A</label>
                <label><input type="checkbox" /> Giá từ thấp tới cao</label>
                <label><input type="checkbox" /> Giá từ cao tới thấp</label>
            </div>

            <h3>Thương hiệu</h3>
            <div class="check-group">
                <label><input type="checkbox" /> Asus</label>
                <label><input type="checkbox" /> Acer</label>
                <label><input type="checkbox" /> Dell</label>
                <label><input type="checkbox" /> Lenovo</label>
                <label><input type="checkbox" /> Msi</label>
            </div>
        </aside>

        <!-- CONTENT: LƯỚI SẢN PHẨM -->
        <section class="product-grid">
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

            <article class="card">
                <img src="anh/sp_thinkbook14p.jpg" alt="ThinkBook 14p" />
                <h4 class="spec">r7 5800u | vega 8<br />16gb | 512 ssd | full hd</h4>
                <p class="name">Laptop lenovo thinkbook 14p</p>
                <p class="price">15.000.000đ</p>
            </article>
        </section>
    </div>
</asp:Content>
