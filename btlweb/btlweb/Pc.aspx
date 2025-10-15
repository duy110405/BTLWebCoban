<%@ Page Title="" Language="C#" MasterPageFile="~/khung.Master" AutoEventWireup="true" CodeBehind="Pc.aspx.cs" Inherits="btlweb.Pc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Pc.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="page-container">
        <!-- SIDEBAR: BỘ LỌC -->
        <aside class="filter" aria-label="Bộ lọc sản phẩm">
            <h3>Danh mục sản phẩm:</h3>
            <ul class="cat-list">
                <li><a href="#">PC văn phòng</a></li>
                <li><a href="#">PC gaming</a></li>
                <li><a href="#">PC đồ hoạ</a></li>
                <li><a href="#">PC mini</a></li>
                <li><a href="#">PC all in one</a></li>
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
                <label><input type="checkbox" /> Dell</label>
                <label><input type="checkbox" /> HP</label>
                <label><input type="checkbox" /> Lenovo</label>
                <label><input type="checkbox" /> Asus</label>
                <label><input type="checkbox" /> Acer</label>
            </div>
        </aside>

        <!-- GRID: DANH SÁCH PC -->
        <section class="product-grid">

            <article class="card">
                <img src="anh/pc1.jpg" alt="PC Lenovo ThinkCentre Neo 50T G5" />
                <h4 class="spec">i3 14100 | 8GB | 512GB SSD<br />Intel UHD 730</h4>
                <p class="name">PC Lenovo ThinkCentre Neo 50T G5 12UB0001VA</p>
                <p class="price">10.590.000đ</p>
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

            <article class="card">
                <img src="anh/pc9.jpg" alt="PC Lenovo ThinkCentre M70t G5 Extra" />
                <h4 class="spec">i5 14400 | 8GB | 512GB SSD<br />Intel UHD 730</h4>
                <p class="name">PC Lenovo ThinkCentre M70t G5 (Phiên bản mở rộng)</p>
                <p class="price">13.690.000đ</p>
            </article>

        </section>
    </div>
</asp:Content>
