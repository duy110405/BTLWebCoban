<%@ Page Title="" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="Chitiettaikhoan.aspx.cs" Inherits="btlweb.Chitiettaikhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link rel="stylesheet" href="css/Chitiettaikhoan.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <section class="account">
  <div class="account-wrap">

    <!-- NAV (Sidebar) -->
    <aside class="acc-nav" aria-label="Điều hướng tài khoản">
      <button class="acc-nav-toggle" type="button" aria-expanded="false">Menu tài khoản</button>
      <nav class="acc-nav-inner">
        <a href="?tab=overview"     data-tab="overview"     class="acc-link active">Tổng quan</a>
        <a href="?tab=orders"       data-tab="orders"       class="acc-link">Đơn hàng</a>
        <a href="?tab=addresses"    data-tab="addresses"    class="acc-link">Địa chỉ</a>
        <a href="?tab=billing"      data-tab="billing"      class="acc-link">Thanh toán &amp; Hóa đơn</a>
        <a href="?tab=vouchers"     data-tab="vouchers"     class="acc-link">Voucher &amp; Điểm</a>
        <a href="?tab=security"     data-tab="security"     class="acc-link">Bảo mật</a>
        <a href="?tab=support"      data-tab="support"      class="acc-link">Hỗ trợ</a>
        <a href="?tab=privacy"      data-tab="privacy"      class="acc-link">Quyền riêng tư</a>
      </nav>
    </aside>

    <!-- CONTENT -->
    <div class="acc-content">

      <!-- Tổng quan -->
      <section class="view active" id="view-overview">
        <div class="grid-3">
          <article class="card">
            <h3 class="card-title">Đơn đang giao</h3>
            <p class="muted">Mã đơn: <b>#DH24831</b></p>
            <div class="progress">
              <div class="bar" style="width: 65%"></div>
            </div>
            <p>Trạng thái: <b>Đang vận chuyển</b></p>
            <button class="btn">Theo dõi vận đơn</button>
          </article>

          <article class="card">
            <h3 class="card-title">Bảo hành sắp hết</h3>
            <ul class="list">
              <li>Legion Pro 5 — còn <b>32 ngày</b></li>
              <li>Dell XPS 13 — còn <b>71 ngày</b></li>
            </ul>
            <button class="btn ghost">Xem chi tiết bảo hành</button>
          </article>

          <article class="card">
            <h3 class="card-title">Voucher sắp hết hạn</h3>
            <div class="vouchers">
              <span class="voucher">-200k | HSD: 30/11</span>
              <span class="voucher">FREESHIP | 15/12</span>
            </div>
            <button class="btn ghost">Xem ví voucher</button>
          </article>
        </div>
      </section>

      <!-- Đơn hàng -->
      <section class="view" id="view-orders">
        <h2 class="section-title">Đơn hàng của bạn</h2>
        <article class="order">
          <header class="order-head">
            <span>#DH24831</span>
            <span class="order-status ship">Đang vận chuyển</span>
          </header>
          <div class="order-body">
            <div class="order-line">
              <img src="anh/sp_legion_pro5.jpg" alt="">
              <div>
                <p class="name">Lenovo Legion Pro 5 — i5/RTX 4060/16G/512G</p>
                <p class="muted">Màu: Grey • Mới, full box</p>
              </div>
              <div class="price">25.000.000đ</div>
            </div>
            <div class="timeline">
              <span class="dot done"></span><span class="seg done"></span>
              <span class="dot done"></span><span class="seg done"></span>
              <span class="dot current"></span><span class="seg"></span>
              <span class="dot"></span>
            </div>
            <div class="order-actions">
              <button class="btn">Theo dõi vận đơn</button>
              <button class="btn ghost">Xuất hóa đơn</button>
            </div>
          </div>
        </article>

        <article class="order">
          <header class="order-head">
            <span>#DH24512</span>
            <span class="order-status done">Hoàn tất</span>
          </header>
          <div class="order-body">
            <div class="order-line">
              <img src="anh/thinkpad.jpg" alt="">
              <div>
                <p class="name">ThinkPad X1 Carbon Gen 11 — i7/16G/512G</p>
                <p class="muted">Đã mua ngày 10/09</p>
              </div>
              <div class="price">23.000.000đ</div>
            </div>
            <div class="order-actions">
              <button class="btn ghost">Yêu cầu bảo hành</button>
              <button class="btn ghost">Đổi trả</button>
              <button class="btn">Đánh giá sản phẩm</button>
            </div>
          </div>
        </article>
      </section>

      <!-- Địa chỉ -->
      <section class="view" id="view-addresses">
        <div class="flex-between">
          <h2 class="section-title">Sổ địa chỉ</h2>
          <button class="btn">+ Thêm địa chỉ</button>
        </div>
        <div class="grid-2">
          <article class="card">
            <h3 class="card-title">Địa chỉ giao hàng (Mặc định)</h3>
            <p>Nguyễn Văn A — 0900 123 456</p>
            <p>96 Định Công, Hoàng Mai, Hà Nội</p>
            <div class="right">
              <button class="btn ghost">Sửa</button>
              <button class="btn ghost">Xóa</button>
            </div>
          </article>
          <article class="card">
            <h3 class="card-title">Địa chỉ xuất hóa đơn</h3>
            <p>Công ty ABC — 0102xxxx</p>
            <p>Tầng 5, Tòa XYZ, Cầu Giấy, Hà Nội</p>
            <div class="right">
              <button class="btn ghost">Sửa</button>
              <button class="btn ghost">Xóa</button>
            </div>
          </article>
        </div>
      </section>

      <!-- Thanh toán & Hóa đơn -->
      <section class="view" id="view-billing">
        <h2 class="section-title">Thanh toán &amp; Hóa đơn</h2>
        <div class="grid-2">
          <article class="card">
            <h3 class="card-title">Phương thức ưa thích</h3>
            <label class="radio"><input type="radio" name="pay" checked> COD khi nhận hàng</label>
            <label class="radio"><input type="radio" name="pay"> Chuyển khoản</label>
            <label class="radio"><input type="radio" name="pay"> QR ngân hàng</label>
            <button class="btn">Lưu thay đổi</button>
          </article>
          <article class="card">
            <h3 class="card-title">Thông tin xuất hóa đơn</h3>
            <div class="form">
              <input class="inp" placeholder="Tên công ty">
              <input class="inp" placeholder="Mã số thuế">
              <input class="inp" placeholder="Địa chỉ">
            </div>
            <button class="btn">Lưu thông tin</button>
          </article>
        </div>
      </section>

      <!-- Voucher & Điểm -->
      <section class="view" id="view-vouchers">
        <h2 class="section-title">Voucher &amp; Điểm</h2>
        <article class="card">
          <p>Điểm tích lũy: <b>1,250</b> điểm • Hạng: <b>Silver</b></p>
          <div class="vouchers">
            <span class="voucher green">-5% • HSD 31/12</span>
            <span class="voucher">-200k • 30/11</span>
            <span class="voucher">FREESHIP • 15/12</span>
          </div>
          <div class="right"><button class="btn ghost">Xem lịch sử điểm</button></div>
        </article>
      </section>

      <!-- Bảo mật -->
      <section class="view" id="view-security">
        <h2 class="section-title">Bảo mật</h2>
        <div class="grid-2">
          <article class="card">
            <h3 class="card-title">Đổi mật khẩu</h3>
            <div class="form">
              <input class="inp" type="password" placeholder="Mật khẩu hiện tại">
              <input class="inp" type="password" placeholder="Mật khẩu mới">
              <input class="inp" type="password" placeholder="Nhập lại mật khẩu mới">
            </div>
            <button class="btn">Cập nhật</button>
          </article>
          <article class="card">
            <h3 class="card-title">Phiên đăng nhập</h3>
            <ul class="list">
              <li>Chrome — Windows • Hà Nội • Vừa xong <button class="chip">Đăng xuất</button></li>
              <li>iPhone • Hôm qua 21:10 <button class="chip">Đăng xuất</button></li>
            </ul>
            <button class="btn ghost">Đăng xuất tất cả</button>
          </article>
        </div>
      </section>

      <!-- Hỗ trợ -->
      <section class="view" id="view-support">
        <h2 class="section-title">Trung tâm hỗ trợ</h2>
        <article class="card">
          <p>Nếu sản phẩm gặp vấn đề, bạn có thể tạo yêu cầu bảo hành/đổi trả (RMA).</p>
          <div class="form">
            <input class="inp" placeholder="Mã đơn hàng (#DH...)">
            <textarea class="inp" rows="4" placeholder="Mô tả vấn đề"></textarea>
          </div>
          <button class="btn">Tạo yêu cầu hỗ trợ</button>
        </article>
      </section>

      <!-- Quyền riêng tư -->
      <section class="view" id="view-privacy">
        <h2 class="section-title">Quyền riêng tư</h2>
        <article class="card">
          <p>Bạn có thể tải dữ liệu cá nhân hoặc yêu cầu xóa tài khoản (không thể hoàn tác).</p>
          <div class="right">
            <button class="btn ghost">Tải dữ liệu</button>
            <button class="btn danger">Yêu cầu xóa tài khoản</button>
          </div>
        </article>
      </section>

    </div>
  </div>
</section>

<script>
(function(){
  const nav = document.querySelector('.acc-nav');
  const links = document.querySelectorAll('.acc-link');
  const views = document.querySelectorAll('.view');
  const toggle = document.querySelector('.acc-nav-toggle');

  function qs(name){
    const m = new URLSearchParams(location.search).get(name);
    return m || '';
  }
  function activate(tab){
    links.forEach(a=>{
      a.classList.toggle('active', a.dataset.tab === tab);
    });
    views.forEach(v=>{
      v.classList.toggle('active', v.id === 'view-' + tab);
    });
  }
  // init
  let tab = qs('tab') || 'overview';
  if(!document.getElementById('view-' + tab)) tab = 'overview';
  activate(tab);

  // click nav
  links.forEach(a=>{
    a.addEventListener('click', e=>{
      e.preventDefault();
      const t = a.dataset.tab;
      history.pushState({}, '', '?tab=' + t);
      activate(t);
      if (nav.classList.contains('open')) {
        nav.classList.remove('open');
        toggle.setAttribute('aria-expanded','false');
      }
    });
  });

  // mobile toggle
  if (toggle){
    toggle.addEventListener('click', ()=>{
      const open = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
  }

  // back/forward
  window.addEventListener('popstate', ()=>{
    const t = qs('tab') || 'overview';
    activate(t);
  });
})();
</script>
</asp:Content>
