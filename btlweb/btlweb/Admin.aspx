<%@ Page Title="Quản trị" Language="C#" MasterPageFile="~/Khung.Master"
    AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="btlweb.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="css/Admin.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
  <section class="admin">
    <div class="admin-wrap">

      <!-- NAV -->
      <aside class="acc-nav" aria-label="Điều hướng quản trị">
        <nav class="acc-nav-inner">
          <a href="Admin.aspx?tab=add"  class="acc-link" runat="server" id="lnkAdd">Thêm sản phẩm</a>
          <a href="Admin.aspx?tab=list" class="acc-link" runat="server" id="lnkEdit">Sửa sản phẩm</a>
          <a href="Admin.aspx?tab=list" class="acc-link" runat="server" id="lnkDelete">Xoá sản phẩm</a>
        </nav>
      </aside>

      <!-- MAIN -->
      <main class="acc-main">
        <asp:MultiView ID="mv" runat="server">

          <!-- ======= LIST ======= -->
          <asp:View ID="vList" runat="server">
            <h2 class="block-title">Danh sách sản phẩm</h2>

            <asp:GridView ID="gvList" runat="server"
              CssClass="table"
              AutoGenerateColumns="False"
              AllowPaging="true" PageSize="10"
              OnPageIndexChanging="gvList_PageIndexChanging"
              OnRowCommand="gvList_RowCommand"
              DataKeyNames="MaSP">
              <Columns>
                <asp:BoundField DataField="MaSP" HeaderText="Mã" />
                <asp:BoundField DataField="TenSP" HeaderText="Tên sản phẩm" />
                <asp:BoundField DataField="TenNCC" HeaderText="NCC" />
                <asp:BoundField DataField="TenLoai" HeaderText="Loại" />

                <asp:TemplateField HeaderText="Cấu hình">
                  <ItemTemplate>
                    <div class="col-spec">
                      <div><b>CPU:</b> <%# Eval("CPU") %></div>
                      <div><b>RAM/SSD/HDD:</b>
                        <%# Eval("RAMGB") %>GB /
                        <%# Eval("SSDGB") %>GB /
                        <%# (Eval("HDDGB") == DBNull.Value ? "0" : Eval("HDDGB")) %>GB
                      </div>
                      <div><b>GPU:</b> <%# Eval("GPU") %></div>
                    </div>
                  </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Màn hình">
                  <ItemTemplate>
                    <%# Eval("ManHinhInch") %>" <%# Eval("DoPhanGiai") %> / <%# Eval("TanSoQuetHz") %>Hz
                  </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="MauSac" HeaderText="Màu" />
                <asp:BoundField DataField="TrongLuongKg" HeaderText="Nặng (kg)" />
                <asp:BoundField DataField="SoLuong" HeaderText="SL" />

                <asp:BoundField DataField="Gia" HeaderText="Giá" DataFormatString="{0:N0}đ" HtmlEncode="false" />
                <asp:BoundField DataField="GiaGoc" HeaderText="Giá gốc" DataFormatString="{0:N0}đ" HtmlEncode="false" />
                <asp:BoundField DataField="GiamGia" HeaderText="Giảm (%)" />

                <asp:TemplateField HeaderText="Ghi chú">
                  <ItemTemplate>
                    <%# BuildSpec(Eval("SpecLine1"), Eval("SpecLine2")) %>
                  </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Thao tác">
                  <ItemTemplate>
                    <asp:LinkButton ID="btnEdit" runat="server"
                      CssClass="btn btn-sm"
                      CommandName="editRow"
                      CommandArgument='<%# Eval("MaSP") %>'>Sửa</asp:LinkButton>

                    <asp:LinkButton ID="btnDelete" runat="server"
                      CssClass="btn btn-sm btn-danger"
                      OnClientClick="return confirm('Xoá sản phẩm này?');"
                      CommandName="deleteRow"
                      CommandArgument='<%# Eval("MaSP") %>'>Xoá</asp:LinkButton>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
              <PagerStyle CssClass="pager" />
            </asp:GridView>

            <asp:Literal ID="ltListMsg" runat="server"></asp:Literal>
          </asp:View>

          <!-- ======= ADD ======= -->
          <asp:View ID="vAdd" runat="server">
            <h2 class="block-title">Thêm sản phẩm</h2>
            <asp:Literal ID="ltAddMsg" runat="server"></asp:Literal>

            <div class="form-grid">
              <label>Tên sản phẩm*</label>
              <asp:TextBox ID="txtTenAdd" runat="server" CssClass="input" />

              <label>Giá (đ)*</label>
              <asp:TextBox ID="txtGiaAdd" runat="server" CssClass="input" TextMode="Number" />

              <label>Nhà cung cấp*</label>
              <asp:DropDownList ID="ddlNCCAdd" runat="server" CssClass="select" />

              <label>Loại sản phẩm*</label>
              <asp:DropDownList ID="ddlLoaiAdd" runat="server" CssClass="select" />

              <label>Số lượng*</label>
              <asp:TextBox ID="txtSLAdd" runat="server" CssClass="input" TextMode="Number" />

              <label>Ảnh chính (đường dẫn)</label>
              <asp:TextBox ID="txtAnhAdd" runat="server" CssClass="input" Placeholder="vd: anh/sp_xxx.jpg" />

              <label>CPU</label>
              <asp:TextBox ID="txtCPUAdd" runat="server" CssClass="input" />
              <label>RAM (GB)</label>
              <asp:TextBox ID="txtRAMAdd" runat="server" CssClass="input" TextMode="Number" />
              <label>SSD (GB)</label>
              <asp:TextBox ID="txtSSDAdd" runat="server" CssClass="input" TextMode="Number" />
              <label>HDD (GB)</label>
              <asp:TextBox ID="txtHDDAdd" runat="server" CssClass="input" TextMode="Number" />
              <label>GPU</label>
              <asp:TextBox ID="txtGPUAdd" runat="server" CssClass="input" />
              <label>Màn hình (inch)</label>
              <asp:TextBox ID="txtInchAdd" runat="server" CssClass="input" />
              <label>Độ phân giải</label>
              <asp:TextBox ID="txtDpgAdd" runat="server" CssClass="input" />
              <label>Tần số quét (Hz)</label>
              <asp:TextBox ID="txtHzAdd" runat="server" CssClass="input" TextMode="Number" />
              <label>Trọng lượng (kg)</label>
              <asp:TextBox ID="txtWeightAdd" runat="server" CssClass="input" />
              <label>Màu sắc</label>
              <asp:TextBox ID="txtMauAdd" runat="server" CssClass="input" />

              <label>Gia gốc (nếu có)</label>
              <asp:TextBox ID="txtGiaGocAdd" runat="server" CssClass="input" TextMode="Number" />
              <label>Mã giảm (tuỳ chọn)</label>
              <asp:DropDownList ID="ddlGiamAdd" runat="server" CssClass="select" />

              <label>Spec dòng 1</label>
              <asp:TextBox ID="txtSpec1Add" runat="server" CssClass="input" />
              <label>Spec dòng 2</label>
              <asp:TextBox ID="txtSpec2Add" runat="server" CssClass="input" />

              <label>Mô tả</label>
              <asp:TextBox ID="txtMoTaAdd" runat="server" CssClass="textarea" TextMode="MultiLine" Rows="3" />
            </div>

            <div class="summary-actions">
              <asp:Button ID="btnAddSave" runat="server" CssClass="btn btn-primary" Text="Thêm"
                OnClick="btnAddSave_Click" />
              <a class="btn btn-ghost" href="Admin.aspx?tab=list">Huỷ</a>
            </div>
          </asp:View>

          <!-- ======= EDIT ======= -->
          <asp:View ID="vEdit" runat="server">
            <h2 class="block-title">Sửa sản phẩm</h2>
            <asp:Literal ID="ltEditMsg" runat="server"></asp:Literal>

            <asp:HiddenField ID="hfEditId" runat="server" />

            <div class="form-grid">
              <label>Tên sản phẩm*</label>
              <asp:TextBox ID="txtTenEdit" runat="server" CssClass="input" />

              <label>Giá (đ)*</label>
              <asp:TextBox ID="txtGiaEdit" runat="server" CssClass="input" TextMode="Number" />

              <label>Nhà cung cấp*</label>
              <asp:DropDownList ID="ddlNCCEdit" runat="server" CssClass="select" />

              <label>Loại sản phẩm*</label>
              <asp:DropDownList ID="ddlLoaiEdit" runat="server" CssClass="select" />

              <label>Số lượng*</label>
              <asp:TextBox ID="txtSLEdit" runat="server" CssClass="input" TextMode="Number" />

              <label>Ảnh chính</label>
              <asp:TextBox ID="txtAnhEdit" runat="server" CssClass="input" />

              <label>Gia gốc</label>
              <asp:TextBox ID="txtGiaGocEdit" runat="server" CssClass="input" TextMode="Number" />
              <label>Mã giảm</label>
              <asp:DropDownList ID="ddlGiamEdit" runat="server" CssClass="select" />

              <label>Mô tả</label>
              <asp:TextBox ID="txtMoTaEdit" runat="server" CssClass="textarea" TextMode="MultiLine" Rows="3" />
            </div>

            <div class="summary-actions">
              <asp:Button ID="btnEditSave" runat="server" CssClass="btn btn-primary" Text="Lưu"
                OnClick="btnEditSave_Click" />
              <a class="btn btn-ghost" href="Admin.aspx?tab=list">Huỷ</a>
            </div>
          </asp:View>

        </asp:MultiView>
      </main>
    </div>
  </section>
</asp:Content>
