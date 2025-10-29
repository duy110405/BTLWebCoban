<%@ Page Title="" Language="C#" MasterPageFile="~/Khung.Master"
    AutoEventWireup="true" CodeBehind="Chitiettaikhoan.aspx.cs" Inherits="btlweb.Chitiettaikhoan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="css/Chitiettaikhoan.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
<section class="account">
  <div class="account-wrap">

    <!-- NAV -->
    <aside class="acc-nav" aria-label="Điều hướng tài khoản">
      <button class="acc-nav-toggle" type="button" aria-expanded="false">Menu tài khoản</button>
      <nav class="acc-nav-inner">
        <a href="?tab=overview"  data-tab="overview"  class="acc-link">Tổng quan</a>
        <a href="?tab=orders"    data-tab="orders"    class="acc-link active">Đơn hàng</a>
        <a href="?tab=addresses" data-tab="addresses" class="acc-link">Địa chỉ</a>
        <a href="?tab=billing"   data-tab="billing"   class="acc-link">Thanh toán &amp; Hóa đơn</a>
        <a href="?tab=vouchers"  data-tab="vouchers"  class="acc-link">Voucher &amp; Điểm</a>
        <a href="?tab=security"  data-tab="security"  class="acc-link">Bảo mật</a>
        <a href="?tab=support"   data-tab="support"   class="acc-link">Hỗ trợ</a>
        <a href="?tab=privacy"   data-tab="privacy"   class="acc-link">Quyền riêng tư</a>
      </nav>
    </aside>

    <!-- CONTENT -->
    <div class="acc-content">

      <!-- Đơn hàng -->
      <section class="view active" id="view-orders">
        <h2 class="section-title">Đơn hàng của bạn</h2>

        <asp:Repeater ID="rptOrders" runat="server" OnItemDataBound="rptOrders_ItemDataBound">
          <ItemTemplate>
            <article class="order">
              <header class="order-head">
                <span><b><%# Eval("MaDon") %></b> • <%# ((DateTime)Eval("NgayTao")).ToString("dd/MM/yyyy HH:mm") %></span>
                <span class="order-status done"><%# Eval("TrangThai") %></span>
              </header>
              <div class="order-body">
                <asp:Repeater ID="rptOrderItems" runat="server">
                  <ItemTemplate>
                    <div class="order-line">
                      <img src='<%# ResolveUrl(Eval("AnhChinh") as string ?? "~/anh/no-image.png") %>' alt="">
                      <div>
                        <p class="name"><%# Eval("TenSP") %></p>
                        <p class="muted">
                          CPU: <%# Eval("CPU") %> • RAM: <%# Eval("RAMGB") %>GB • SSD: <%# Eval("SSDGB") %>GB
                          • GPU: <%# Eval("GPU") %> • Màn: <%# Eval("ManHinhInch") %>" <%# Eval("DoPhanGiai") %> @ <%# Eval("TanSoQuetHz") %>Hz
                        </p>
                        <p class="muted">SL: <%# Eval("SoLuong") %></p>
                      </div>
                      <div class="price"><%# string.Format(new System.Globalization.CultureInfo("vi-VN"), "{0:N0}đ", Eval("ThanhTien")) %></div>
                    </div>
                  </ItemTemplate>
                </asp:Repeater>
                <div class="right" style="margin-top:8px"><b>Tổng: <%# string.Format(new System.Globalization.CultureInfo("vi-VN"), "{0:N0}đ", Eval("TongTien")) %></b></div>
              </div>
            </article>
          </ItemTemplate>
        </asp:Repeater>
      </section>

      <!-- Hóa đơn -->
      <section class="view" id="view-billing">
        <h2 class="section-title">Hóa đơn của bạn</h2>

        <asp:Repeater ID="rptInvoices" runat="server" OnItemDataBound="rptInvoices_ItemDataBound">
          <ItemTemplate>
            <article class="order">
              <header class="order-head">
                <span><b>HD: <%# Eval("SoHoaDon") %></b> • Đơn: <%# Eval("MaDon") %></span>
                <span class="order-status done"><%# ((DateTime)Eval("NgayLap")).ToString("dd/MM/yyyy HH:mm") %></span>
              </header>
              <div class="order-body">
                <asp:Repeater ID="rptInvoiceItems" runat="server">
                  <ItemTemplate>
                    <div class="order-line">
                      <img src='<%# ResolveUrl(Eval("AnhChinh") as string ?? "~/anh/no-image.png") %>' alt="">
                      <div>
                        <p class="name"><%# Eval("TenSP") %></p>
                        <p class="muted">
                          CPU: <%# Eval("CPU") %> • RAM: <%# Eval("RAMGB") %>GB • SSD: <%# Eval("SSDGB") %>GB
                          • GPU: <%# Eval("GPU") %> • Màn: <%# Eval("ManHinhInch") %>" <%# Eval("DoPhanGiai") %> @ <%# Eval("TanSoQuetHz") %>Hz
                        </p>
                        <p class="muted">SL: <%# Eval("SoLuong") %></p>
                      </div>
                      <div class="price"><%# string.Format(new System.Globalization.CultureInfo("vi-VN"), "{0:N0}đ", Eval("ThanhTien")) %></div>
                    </div>
                  </ItemTemplate>
                </asp:Repeater>
                <div class="right" style="margin-top:8px"><b>Tổng: <%# string.Format(new System.Globalization.CultureInfo("vi-VN"), "{0:N0}đ", Eval("TongTien")) %></b></div>
              </div>
            </article>
          </ItemTemplate>
        </asp:Repeater>
      </section>

    </div>
  </div>
</section>

<script>
    (function () {
        const root = document.querySelector('.account');
        if (!root) return;
        const nav = root.querySelector('.acc-nav');
        const links = root.querySelectorAll('.acc-link');
        const views = root.querySelectorAll('.view');
        const toggle = root.querySelector('.acc-nav-toggle');

        function qs(name) { const m = new URLSearchParams(location.search).get(name); return m || ''; }
        function activate(tab) {
            links.forEach(a => a.classList.toggle('active', a.dataset.tab === tab));
            views.forEach(v => v.classList.toggle('active', v.id === 'view-' + tab));
        }
        let tab = qs('tab') || 'orders';
        if (!root.querySelector('#view-' + tab)) tab = 'orders';
        activate(tab);

        links.forEach(a => {
            a.addEventListener('click', e => {
                e.preventDefault();
                const t = a.dataset.tab;
                history.pushState({}, '', '?tab=' + t);
                activate(t);
                if (nav.classList.contains('open')) {
                    nav.classList.remove('open');
                    toggle?.setAttribute('aria-expanded', 'false');
                }
            })
        });
        toggle?.addEventListener('click', () => {
            const open = nav.classList.toggle('open');
            toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
        });
        window.addEventListener('popstate', () => {
            const t = qs('tab') || 'orders';
            activate(t);
        });
    })();
</script>
</asp:Content>
