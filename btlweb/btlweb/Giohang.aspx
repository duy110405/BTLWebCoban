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
        <!-- Khi rỗng -->
        <asp:Panel ID="pEmpty" runat="server" Visible="false">
          <article class="card" style="padding:12px">Giỏ hàng đang trống.</article>
        </asp:Panel>

        <!-- Danh sách sản phẩm -->
        <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
          <ItemTemplate>
            <article class="cart-item card">
              <img class="thumb"
                   src='<%# ResolveUrl(Eval("Anh") as string ?? "~/anh/no-image.png") %>'
                   alt='<%# Eval("TenSP") %>' />

              <div class="info">
                <h3 class="name"><%# Eval("TenSP") %></h3>
                <p class="desc"><%# Eval("MoTaNgan") %></p>

                <div class="controls">
                  <div class="qty">
                    <asp:LinkButton runat="server" CssClass="stepper minus"
                                    CommandName="Minus" CommandArgument='<%# Eval("MaSP") %>'
                                    CausesValidation="false" Text="−" />
                    <asp:TextBox runat="server" ReadOnly="true" Text='<%# Eval("Qty") %>' />
                    <asp:LinkButton runat="server" CssClass="stepper plus"
                                    CommandName="Plus" CommandArgument='<%# Eval("MaSP") %>'
                                    CausesValidation="false" Text="+" />
                  </div>

                  <asp:LinkButton runat="server" CssClass="btn-remove"
                                  CommandName="Remove" CommandArgument='<%# Eval("MaSP") %>'
                                  CausesValidation="false" Text="Xóa" />
                </div>
              </div>

              <div class="price">
                <%# string.Format(new System.Globalization.CultureInfo("vi-VN"),
                                  "{0:N0}đ",
                                  Convert.ToDecimal(Eval("Gia")) * Convert.ToInt32(Eval("Qty"))) %>
              </div>
            </article>
          </ItemTemplate>
        </asp:Repeater>

        <!-- Quà tặng (tham khảo) -->
        <article class="gift card">
          <header class="gift-head">Tặng kèm: Trị giá tới 400.000đ</header>
          <div class="gift-body">
            <img class="gift-thumb" src="<%= ResolveUrl("~/anh/bag.jpg") %>" alt="Balo" />
            <div class="gift-name">Balo laptop</div>
            <div class="gift-price">0đ</div>
          </div>
        </article>

       <!-- CHỌN ĐỊA CHỈ ĐÃ LƯU -->
<section class="customer card">
  <h3 class="block-title">Địa chỉ giao hàng</h3>

  <div class="form-grid">
    <label>Chọn địa chỉ:</label>
    <asp:DropDownList ID="ddlAddress" runat="server" CssClass="select">
      <asp:ListItem Value="">-- Chọn địa chỉ đã lưu --</asp:ListItem>
    </asp:DropDownList>

    <span></span>
    <asp:HyperLink ID="lnkManageAddr" runat="server"
                   NavigateUrl="Chitiettaikhoan.aspx?tab=addresses"
                   CssClass="link">+ Quản lý / thêm địa chỉ</asp:HyperLink>
  </div>

  <!-- Ô xem nhanh địa chỉ đã chọn -->
  <asp:Panel ID="pAddrPreview" runat="server" CssClass="addr-preview" Visible="false">
    <p class="name"><asp:Literal ID="litAddrName" runat="server" /></p>
    <p class="muted">📞 <asp:Literal ID="litAddrPhone" runat="server" /> • ✉️ <asp:Literal ID="litAddrEmail" runat="server" /></p>
    <p class="address">📍 <asp:Literal ID="litAddrFull" runat="server" /></p>
    <p class="muted">PT thanh toán ưa dùng: <asp:Literal ID="litAddrPTTT" runat="server" /></p>
    <asp:Literal ID="litAddrNote" runat="server" />
  </asp:Panel>

  <asp:HiddenField ID="hfAddressId" runat="server" />
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
            <strong class="money"><asp:Literal ID="litSub" runat="server" /></strong>
          </div>

          <div class="row total">
            <span>Tổng cộng:</span>
            <strong class="money"><asp:Literal ID="litTotal" runat="server" /></strong>
          </div>

          <div class="summary-actions">
            <asp:Button ID="btnPay" runat="server" CssClass="btn btn-primary"
                        Text="Thanh toán" OnClick="btnPay_Click" UseSubmitBehavior="false" />
          </div>
        </section>
      </aside>
    </div>
  </div>

  <!-- ===== MODAL Thanh toán ===== -->
  <div id="payModal" class="pay-modal hidden" aria-hidden="true" role="dialog" aria-modal="true">
    <div class="backdrop" onclick="closePayModal()"></div>
    <div class="modal-box" role="document">
      <div class="icon-wrap"><span class="icon">✓</span></div>
      <h3 class="title" id="payModalTitle">Thanh toán thành công!</h3>
      <p class="desc" id="payModalDesc">
        Đơn hàng <b id="payOrderCode">#DHxxxx</b> đã được tạo. Cảm ơn bạn!
      </p>
      <div class="actions">
        <a id="btnViewOrder" href="Chitiettaikhoan.aspx?tab=orders" class="btn btn-primary">Xem đơn hàng</a>
        <button type="button" class="btn btn-ghost" onclick="closePayModal()">Tiếp tục mua sắm</button>
      </div>
    </div>
  </div>

  <script>
    function openPayModal(title, htmlDesc, orderCode) {
      if (title)  document.getElementById('payModalTitle').textContent = title;
      if (htmlDesc) document.getElementById('payModalDesc').innerHTML = htmlDesc;
      if (orderCode) document.getElementById('payOrderCode').textContent = orderCode;

      const el = document.getElementById('payModal');
      el.classList.remove('hidden');
      el.setAttribute('aria-hidden','false');
      document.body.style.overflow = 'hidden';
    }
    function closePayModal() {
      const el = document.getElementById('payModal');
      el.classList.add('hidden');
      el.setAttribute('aria-hidden','true');
      document.body.style.overflow = '';
    }
  </script>
</asp:Content>
