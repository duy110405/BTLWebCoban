<%@ Page Title="Laptop" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="Laptop.aspx.cs" Inherits="btlweb.Laptop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Laptop.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

  <div class="page-container">
    <!-- ====== SIDEBAR: BỘ LỌC ====== -->
    <aside class="filter" aria-label="Bộ lọc sản phẩm">
      <h3>Tìm kiếm</h3>
      <asp:TextBox ID="txtSearch" runat="server" CssClass="auth-input" placeholder="Tìm theo tên..." />

      <h3>Thương hiệu</h3>
      <asp:DropDownList ID="ddlBrand" runat="server" CssClass="auth-input" AppendDataBoundItems="true">
        <asp:ListItem Text="-- Tất cả --" Value="" />
      </asp:DropDownList>

      <h3>Khoảng giá</h3>
      <div class="check-group">
        <asp:TextBox ID="txtMinPrice" runat="server" CssClass="auth-input" placeholder="Từ (VNĐ)" />
        <asp:TextBox ID="txtMaxPrice" runat="server" CssClass="auth-input" placeholder="Đến (VNĐ)" />
      </div>

      <h3>Sắp xếp</h3>
      <asp:DropDownList ID="ddlSort" runat="server" CssClass="auth-input">
        <asp:ListItem Text="Mới nhất" Value="moi-nhat" />
        <asp:ListItem Text="Giá tăng dần" Value="gia-asc" />
        <asp:ListItem Text="Giá giảm dần" Value="gia-desc" />
        <asp:ListItem Text="Tên A → Z" Value="ten-asc" />
        <asp:ListItem Text="Tên Z → A" Value="ten-desc" />
      </asp:DropDownList>

      <asp:Button ID="btnApplyFilters" runat="server" CssClass="btn btn-primary" Text="Lọc sản phẩm" />
      <div style="margin-top:10px;color:#666;">
        Tổng: <asp:Literal ID="litTotal" runat="server" />
      </div>
    </aside>

    <!-- ====== CONTENT: LƯỚI SẢN PHẨM ====== -->
    <section class="product-grid">
      <asp:Repeater ID="rptProducts" runat="server">
        <ItemTemplate>
          <article class="card">
            <!-- Link phủ toàn bộ card -->
            <a class="card-link" href='<%# "ChitietLegion5.aspx?masp=" + Eval("MaSP") %>' aria-label='<%# "Xem " + Eval("TenSP") %>'></a>

            <img src='<%# Eval("AnhChinh") %>' alt='<%# Eval("TenSP") %>' />
            <div class="spec-lines">
              <div class="spec-line spec-1">
                  <span><%# Eval("CPU") %></span>
                  <span><%# Eval("GPU") %></span>
              </div>
              <div class="spec-line spec-2">
                  <span>RAM <%# Eval("RAMGB") %>GB</span>
                  <span>SSD <%# Eval("SSDGB") %>GB</span>
                  <span><%# Eval("ManHinhInch") %>" <%# Eval("DoPhanGiai") %></span>
              </div>
            </div>
            <p class="name"><%# Eval("TenSP") %></p>
            <p class="price">
              <%# String.Format("{0:N0}đ", Eval("Gia")) %>
            </p>
          </article>
        </ItemTemplate>
      </asp:Repeater>

      <!-- PAGER -->
      <div style="grid-column:1/-1; display:flex; align-items:center; justify-content:center; gap:12px; margin-top:10px;">
        <asp:Button ID="btnPrev" runat="server" CssClass="btn" Text="&laquo; Trang trước" />
        <asp:Label ID="lblPageInfo" runat="server" />
        <asp:Button ID="btnNext" runat="server" CssClass="btn" Text="Trang sau &raquo;" />
      </div>
    </section>
  </div>

</asp:Content>
