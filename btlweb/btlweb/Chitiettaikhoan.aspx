  <%@ Page Title="" Language="C#" MasterPageFile="~/Khung.Master"
    AutoEventWireup="true" CodeBehind="Chitiettaikhoan.aspx.cs" Inherits="btlweb.Chitiettaikhoan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="css/Chitiettaikhoan.css" />
   <script src="js/ChitietTaikhoan.js" defer></script>
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

         <!-- ------------------------Địa chỉ-----------------------  -->
         <section class="view active" id="view-addresses">
        <h2 class="section-title">Địa chỉ của bạn</h2>
         <!-- Form thông tin khách -->
        <section class="customer card">
          <h3 class="block-title">Thông tin người đặt hàng:</h3>
          <div class="form-grid">

            <label>Họ tên:</label>
            <asp:TextBox ID="txtHoTen"  ClientIDMode="Static" runat="server" CssClass="input" />
            <asp:Label   ID="errHoten"  runat="server" CssClass="field-error" Visible="false" />

            <label>Số điện thoại:</label>
            <asp:TextBox ID="txtSDT"    ClientIDMode="Static" runat="server" CssClass="input" />
            <asp:Label   ID="errSdt"    runat="server" CssClass="field-error" Visible="false" />


            <label>Email:</label>
            <asp:TextBox ID="txtEmail"  ClientIDMode="Static" runat="server" CssClass="input" TextMode="Email" />
            <asp:Label   ID="errEmail"  runat="server" CssClass="field-error" Visible="false" />

            <label>Địa chỉ:</label>
            <asp:TextBox ID="txtDiaChi" ClientIDMode="Static" runat="server" CssClass="input" />
            <asp:Label   ID="errDiachi" runat="server" CssClass="field-error" Visible="false" />

            <label>Phương thức thanh toán:</label>
            <asp:DropDownList ID="ddlPTTT" runat="server" CssClass="select">
              <asp:ListItem Text="Thanh toán trực tiếp" Value="Thanh toán trực tiếp" Selected="True" />
              <asp:ListItem Text="Chuyển khoản" Value="Chuyển khoản" />
              <asp:ListItem Text="COD" Value="COD" />
            </asp:DropDownList>

            <label>Ghi chú:</label>
            <asp:TextBox ID="txtGhiChu" runat="server" CssClass="textarea" TextMode="MultiLine" Rows="3" />
            <asp:Button ID ="btnThemdiachi" runat="server" CssClass="button" OnClick="btnThemdiachi_Click"   OnClientClick="return ThemDiaChijs_Click();"   UseSubmitBehavior="true" Text="Thêm địa chỉ"/>
          </div>
        </section>

              <!-- Hiển thị địa chỉ đã lưu -->
   <asp:PlaceHolder ID="phAddresses" runat="server" Visible="false">
  <asp:Repeater ID="rptAddresses" runat="server" OnItemCommand="rptAddresses_ItemCommand">
    <HeaderTemplate>
      <div class="addresses-grid">
    </HeaderTemplate>

    <ItemTemplate>
      <article class='address-card <%# Convert.ToBoolean(Eval("IsDefault")) ? "is-default" : "" %>'>
        <div class="addr-head">
          <span class="badge"><%# Convert.ToBoolean(Eval("IsDefault")) ? "Mặc định" : "" %></span>
          <span class="created"><%# ((DateTime)Eval("NgayTao")).ToString("dd/MM/yyyy HH:mm") %></span>
        </div>

        <h4 class="name"><%# Eval("HoTen") %></h4>
        <p class="muted">📞 <%# Eval("SDT") %> • ✉️ <%# Eval("Email") %></p>
        <p class="address">📍 <%# Eval("DiaChi") %></p>
        <p class="muted">PT thanh toán: <%# Eval("PhuongThucTT") %></p>
        <p class="note"><%# Eval("GhiChu") %></p>

        <div class="actions">
          <asp:LinkButton runat="server" CssClass="btn"
            CommandName="makeDefault" CommandArgument='<%# Eval("Id") %>'
            Visible='<%# !Convert.ToBoolean(Eval("IsDefault")) %>'>Đặt mặc định</asp:LinkButton>

          <asp:LinkButton runat="server" CssClass="btn danger"
            CommandName="delete" CommandArgument='<%# Eval("Id") %>'
            OnClientClick="return confirm('Xoá địa chỉ này?');">Xoá</asp:LinkButton>
        </div>
      </article>
    </ItemTemplate>

    <FooterTemplate>
      </div>
    </FooterTemplate>
  </asp:Repeater>
</asp:PlaceHolder>


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

</asp:Content>
