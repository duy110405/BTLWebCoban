<%@ Page Title="" Language="C#" MasterPageFile="~/khung.Master" AutoEventWireup="true" CodeBehind="Giohang.aspx.cs" Inherits="btlweb.Giohang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Giohang.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="cart-wrap">

    <h2 class="cart-title">Giỏ hàng của bạn</h2>

    <div class="cart-grid">
      <!-- CỘT TRÁI -->
      <section class="cart-left">

        <!-- Sản phẩm 1 -->
        <article class="cart-item card">
          <img class="thumb" src="<%= ResolveUrl("~/anh/sp_legion_pro5.jpg") %>" alt="Lenovo ThinkPad X1 Carbon" />
          <div class="info">
            <h3 class="name">Lenovo ThinkPad X1 Carbon Gen 11</h3>
            <p class="desc">i7 1356U, 16GB, 256GB, FHD+ Touch, Black, Outlet, Nhập khẩu</p>

            <div class="controls">
              <div class="qty">
                <button type="button" class="stepper minus" aria-label="Giảm">−</button>
                <input type="text" value="1" inputmode="numeric" />
                <button type="button" class="stepper plus" aria-label="Tăng">+</button>
              </div>
            </div>
          </div>
          <div class="price">23.000.000đ</div>
        </article>

        <!-- Quà tặng -->
        <article class="gift card">
          <header class="gift-head">Tặng kèm: Trị giá tới 400.000đ</header>
          <div class="gift-body">
            <img class="gift-thumb" src="<%= ResolveUrl("~/anh/bag.jpg") %>" alt="Balo" />
            <div class="gift-name">Balo laptop</div>
            <div class="gift-price">0đ</div>
          </div>
        </article>

        <!-- Sản phẩm 2 -->
        <article class="cart-item card">
          <img class="thumb" src="<%= ResolveUrl("~/anh/sp_legion_pro5.jpg") %>" alt="Lenovo Legion Pro 5" />
          <div class="info">
            <h3 class="name">Lenovo Legion Pro 5</h3>
            <p class="desc">i9 14900HX, RTX 4070 8GB, 32GB, 1TB, WQXGA 240Hz, Grey, Mới, Full box, Chính hãng</p>

            <div class="controls">
              <div class="qty">
                <button type="button" class="stepper minus" aria-label="Giảm">−</button>
                <input type="text" value="1" inputmode="numeric" />
                <button type="button" class="stepper plus" aria-label="Tăng">+</button>
              </div>
            </div>
          </div>
          <div class="price">25.000.000đ</div>
        </article>

        <!-- Thông tin người đặt -->
        <section class="customer card">
          <h3 class="block-title">Thông tin người đặt hàng:</h3>

          <div class="form-grid">
            <label>Họ tên:</label>
            <input type="text" class="input" />

            <label>Số điện thoại:</label>
            <input type="text" class="input" />

            <label>Email:</label>
            <input type="email" class="input" />

            <label>Địa chỉ:</label>
            <input type="text" class="input" />

            <label>Phương thức thanh toán:</label>
            <select class="select">
              <option>Thanh toán trực tiếp</option>
              <option>Chuyển khoản</option>
              <option>COD</option>
            </select>

            <label>Ghi chú:</label>
            <textarea class="textarea" rows="3"></textarea>
          </div>
        </section>
      </section>

      <!-- CỘT PHẢI -->
      <aside class="cart-right">

        <section class="coupon card">
          <h3 class="block-title">Khuyến mãi</h3>
          <button type="button" class="btn btn-ghost">Chọn hoặc nhập khuyến mãi</button>
        </section>

        <section class="summary card">
          <h3 class="block-title">Tóm tắt đơn hàng</h3>

          <div class="row">
            <span>Tạm tính:</span>
            <strong class="money">48.000.000đ</strong>
          </div>

          <div class="row total">
            <span>Tổng cộng:</span>
            <strong class="money">48.000.000đ</strong>
          </div>

          <!-- Nút thanh toán ở CUỐI và Ở GIỮA -->
          <div class="summary-actions">
            <button type="button" class="btn btn-primary">Thanh toán</button>
          </div>
        </section>

      </aside>
    </div>
  </div>
</asp:Content>
