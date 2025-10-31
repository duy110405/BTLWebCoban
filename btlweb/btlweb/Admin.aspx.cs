using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace btlweb
{
    public partial class Admin : System.Web.UI.Page
    {
        string ConnStr => ConfigurationManager.ConnectionStrings["Baitaplonlaptrinhweb"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Chặn non-admin
            var username = Convert.ToString(Session["UserEmail"]);
            var isAdmin = Session["IsAdmin"] is bool b && b;
            if (!isAdmin && !"admin123@gmail.com".Equals(username, StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Taikhoan.aspx?return=Admin.aspx&error=forbidden");
                return;
            }

            if (!IsPostBack)
            {
                string tab = (Request.QueryString["tab"] ?? "list").ToLower();
                SwitchTab(tab);

                if (tab == "list")
                {
                    BindList();
                }
                else if (tab == "add")
                {
                    BindDropdowns(add: true);
                }
                else if (tab == "edit")
                {
                    BindDropdowns(add: false);
                    LoadEdit();
                }
            }
        }

        void SwitchTab(string tab)
        {
            // highlight nav
            lnkAdd.Attributes["class"] = "acc-link";
            lnkEdit.Attributes["class"] = "acc-link";
            lnkDelete.Attributes["class"] = "acc-link";

            switch (tab)
            {
                case "add":
                    mv.SetActiveView(vAdd);
                    lnkAdd.Attributes["class"] += " is-active";
                    break;
                case "edit":
                    mv.SetActiveView(vEdit);
                    lnkEdit.Attributes["class"] += " is-active";
                    break;
                default:
                    mv.SetActiveView(vList);
                    lnkEdit.Attributes["class"] += " is-active";
                    lnkDelete.Attributes["class"] += " is-active";
                    break;
            }
        }

        /* ================== LIST ================== */

        void BindList()
        {
            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(@"
SELECT
    sp.MaSP, sp.TenSP,
    ncc.TenNCC, lsp.TenLoai,
    sp.CPU, sp.RAMGB, sp.SSDGB, sp.HDDGB, sp.GPU,
    sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz,
    sp.MauSac, sp.TrongLuongKg, sp.SoLuong,
    sp.Gia, sp.GiaGoc, mg.GiamGia,
    sp.SpecLine1, sp.SpecLine2
FROM dbo.SanPham sp
JOIN dbo.NhaCungCap  ncc ON ncc.MaNCC    = sp.MaNCC
JOIN dbo.LoaiSanPham lsp ON lsp.MaLoaiSP = sp.MaLoaiSP
LEFT JOIN dbo.MaGiamGia mg ON mg.MaGiam  = sp.MaGiam
ORDER BY sp.MaSP DESC;", con))
            using (var da = new SqlDataAdapter(cmd))
            {
                var tb = new DataTable();
                con.Open();
                da.Fill(tb);
                gvList.DataSource = tb;
                gvList.DataBind();
            }
        }

        protected void gvList_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            gvList.PageIndex = e.NewPageIndex;
            BindList();
        }

        protected void gvList_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id;
            if (e.CommandName == "editRow" && int.TryParse(Convert.ToString(e.CommandArgument), out id))
            {
                Response.Redirect("Admin.aspx?tab=edit&id=" + id);
                return;
            }
            if (e.CommandName == "deleteRow" && int.TryParse(Convert.ToString(e.CommandArgument), out id))
            {
                TryDelete(id, out string msg, out bool ok);
                ltListMsg.Text = ok
                    ? $"<div class='alert ok'>Đã xoá sản phẩm #{id}.</div>"
                    : $"<div class='alert err'>{Server.HtmlEncode(msg)}</div>";
                BindList();
            }
        }

        void TryDelete(int id, out string msg, out bool ok)
        {
            msg = ""; ok = false;
            try
            {
                using (var con = new SqlConnection(ConnStr))
                using (var cmd = new SqlCommand("DELETE FROM dbo.SanPham WHERE MaSP=@id", con))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    int n = cmd.ExecuteNonQuery();
                    ok = n > 0;
                    if (!ok) msg = "Không tìm thấy sản phẩm.";
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                ok = false;
            }
        }

        /* ================== helpers ================== */

        protected string BuildSpec(object s1, object s2)
        {
            var a = Convert.ToString(s1);
            var b = Convert.ToString(s2);
            if (string.IsNullOrWhiteSpace(a)) return b ?? "";
            if (string.IsNullOrWhiteSpace(b)) return a ?? "";
            return a + " — " + b;
        }

        void BindDropdowns(bool add)
        {
            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();

                // NCC
                using (var cmd = new SqlCommand("SELECT MaNCC, TenNCC FROM dbo.NhaCungCap ORDER BY TenNCC", con))
                using (var rd = cmd.ExecuteReader())
                {
                    if (add)
                    {
                        ddlNCCAdd.DataSource = rd;
                        ddlNCCAdd.DataValueField = "MaNCC";
                        ddlNCCAdd.DataTextField = "TenNCC";
                        ddlNCCAdd.DataBind();
                    }
                    else
                    {
                        ddlNCCEdit.DataSource = rd;
                        ddlNCCEdit.DataValueField = "MaNCC";
                        ddlNCCEdit.DataTextField = "TenNCC";
                        ddlNCCEdit.DataBind();
                    }
                }

                // Loại
                using (var cmd = new SqlCommand("SELECT MaLoaiSP, TenLoai FROM dbo.LoaiSanPham ORDER BY TenLoai", con))
                using (var rd = cmd.ExecuteReader())
                {
                    if (add)
                    {
                        ddlLoaiAdd.DataSource = rd;
                        ddlLoaiAdd.DataValueField = "MaLoaiSP";
                        ddlLoaiAdd.DataTextField = "TenLoai";
                        ddlLoaiAdd.DataBind();
                    }
                    else
                    {
                        ddlLoaiEdit.DataSource = rd;
                        ddlLoaiEdit.DataValueField = "MaLoaiSP";
                        ddlLoaiEdit.DataTextField = "TenLoai";
                        ddlLoaiEdit.DataBind();
                    }
                }

                // Mã giảm (tuỳ chọn)
                using (var cmd = new SqlCommand("SELECT MaGiam, CAST(GiamGia as varchar(10)) + '%' AS Label FROM dbo.MaGiamGia ORDER BY GiamGia", con))
                using (var rd = cmd.ExecuteReader())
                {
                    if (add)
                    {
                        ddlGiamAdd.DataSource = rd;
                        ddlGiamAdd.DataValueField = "MaGiam";
                        ddlGiamAdd.DataTextField = "Label";
                        ddlGiamAdd.DataBind();
                        ddlGiamAdd.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Không áp dụng --", ""));
                    }
                    else
                    {
                        ddlGiamEdit.DataSource = rd;
                        ddlGiamEdit.DataValueField = "MaGiam";
                        ddlGiamEdit.DataTextField = "Label";
                        ddlGiamEdit.DataBind();
                        ddlGiamEdit.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Không áp dụng --", ""));
                    }
                }
            }
        }

        decimal? ParseDec(string s)
        {
            if (string.IsNullOrWhiteSpace(s)) return null;
            if (decimal.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, out var d)) return d;
            if (decimal.TryParse(s, NumberStyles.Any, new CultureInfo("vi-VN"), out d)) return d;
            return null;
        }
        int? ParseInt(string s)
        {
            if (string.IsNullOrWhiteSpace(s)) return null;
            if (int.TryParse(s, NumberStyles.Any, CultureInfo.InvariantCulture, out var x)) return x;
            if (int.TryParse(s, NumberStyles.Any, new CultureInfo("vi-VN"), out x)) return x;
            return null;
        }

        object DbVal(object v) => v ?? DBNull.Value;

        /* ================== ADD ================== */

        protected void btnAddSave_Click(object sender, EventArgs e)
        {
            // validate tối thiểu
            if (string.IsNullOrWhiteSpace(txtTenAdd.Text))
            {
                ltAddMsg.Text = "<div class='alert err'>Tên sản phẩm bắt buộc.</div>";
                return;
            }
            var gia = ParseDec(txtGiaAdd.Text);
            var sl = ParseInt(txtSLAdd.Text);
            if (gia == null || sl == null)
            {
                ltAddMsg.Text = "<div class='alert err'>Giá và Số lượng phải là số hợp lệ.</div>";
                return;
            }

            try
            {
                using (var con = new SqlConnection(ConnStr))
                using (var cmd = con.CreateCommand())
                {
                    cmd.CommandText = @"
INSERT INTO dbo.SanPham
(TenSP, Gia, MaNCC, MaLoaiSP,
 CPU, RAMGB, SSDGB, HDDGB, GPU,
 ManHinhInch, DoPhanGiai, TanSoQuetHz,
 TrongLuongKg, MauSac, SoLuong, AnhChinh, MoTa,
 SpecLine1, SpecLine2, GiaGoc, MaGiam)
VALUES
(@Ten, @Gia, @NCC, @Loai,
 @CPU, @RAM, @SSD, @HDD, @GPU,
 @Inch, @Dpg, @Hz,
 @Weight, @Mau, @SL, @Anh, @MoTa,
 @Spec1, @Spec2, @GiaGoc, @MaGiam);

SELECT SCOPE_IDENTITY();";

                    cmd.Parameters.AddWithValue("@Ten", txtTenAdd.Text.Trim());
                    cmd.Parameters.AddWithValue("@Gia", gia.Value);
                    cmd.Parameters.AddWithValue("@NCC", ddlNCCAdd.SelectedValue);
                    cmd.Parameters.AddWithValue("@Loai", ddlLoaiAdd.SelectedValue);

                    cmd.Parameters.AddWithValue("@CPU", DbVal(string.IsNullOrWhiteSpace(txtCPUAdd.Text) ? null : txtCPUAdd.Text.Trim()));
                    cmd.Parameters.AddWithValue("@RAM", DbVal(ParseInt(txtRAMAdd.Text)));
                    cmd.Parameters.AddWithValue("@SSD", DbVal(ParseInt(txtSSDAdd.Text)));
                    cmd.Parameters.AddWithValue("@HDD", DbVal(ParseInt(txtHDDAdd.Text)));
                    cmd.Parameters.AddWithValue("@GPU", DbVal(string.IsNullOrWhiteSpace(txtGPUAdd.Text) ? null : txtGPUAdd.Text.Trim()));

                    cmd.Parameters.AddWithValue("@Inch", DbVal(ParseDec(txtInchAdd.Text)));
                    cmd.Parameters.AddWithValue("@Dpg", DbVal(string.IsNullOrWhiteSpace(txtDpgAdd.Text) ? null : txtDpgAdd.Text.Trim()));
                    cmd.Parameters.AddWithValue("@Hz", DbVal(ParseInt(txtHzAdd.Text)));
                    cmd.Parameters.AddWithValue("@Weight", DbVal(ParseDec(txtWeightAdd.Text)));
                    cmd.Parameters.AddWithValue("@Mau", DbVal(string.IsNullOrWhiteSpace(txtMauAdd.Text) ? null : txtMauAdd.Text.Trim()));

                    cmd.Parameters.AddWithValue("@SL", sl.Value);
                    cmd.Parameters.AddWithValue("@Anh", DbVal(string.IsNullOrWhiteSpace(txtAnhAdd.Text) ? null : txtAnhAdd.Text.Trim()));
                    cmd.Parameters.AddWithValue("@MoTa", DbVal(string.IsNullOrWhiteSpace(txtMoTaAdd.Text) ? null : txtMoTaAdd.Text.Trim()));

                    cmd.Parameters.AddWithValue("@Spec1", DbVal(string.IsNullOrWhiteSpace(txtSpec1Add.Text) ? null : txtSpec1Add.Text.Trim()));
                    cmd.Parameters.AddWithValue("@Spec2", DbVal(string.IsNullOrWhiteSpace(txtSpec2Add.Text) ? null : txtSpec2Add.Text.Trim()));

                    cmd.Parameters.AddWithValue("@GiaGoc", DbVal(ParseDec(txtGiaGocAdd.Text)));
                    cmd.Parameters.AddWithValue("@MaGiam", DbVal(string.IsNullOrWhiteSpace(ddlGiamAdd.SelectedValue) ? null : (object)Convert.ToInt32(ddlGiamAdd.SelectedValue)));

                    con.Open();
                    var newId = Convert.ToInt32(Math.Round(Convert.ToDecimal(cmd.ExecuteScalar())));
                    ltAddMsg.Text = $"<div class='alert ok'>Đã thêm sản phẩm #{newId}. <a href='Admin.aspx?tab=list'>Về danh sách</a></div>";

                    // clear
                    txtTenAdd.Text = txtGiaAdd.Text = txtSLAdd.Text = txtAnhAdd.Text = "";
                    txtCPUAdd.Text = txtRAMAdd.Text = txtSSDAdd.Text = txtHDDAdd.Text = "";
                    txtGPUAdd.Text = txtInchAdd.Text = txtDpgAdd.Text = txtHzAdd.Text = "";
                    txtWeightAdd.Text = txtMauAdd.Text = txtGiaGocAdd.Text = "";
                    txtSpec1Add.Text = txtSpec2Add.Text = txtMoTaAdd.Text = "";
                }
            }
            catch (Exception ex)
            {
                ltAddMsg.Text = $"<div class='alert err'>{Server.HtmlEncode(ex.Message)}</div>";
            }
        }

        /* ================== EDIT ================== */

        void LoadEdit()
        {
            if (!int.TryParse(Request.QueryString["id"], out var id))
            {
                ltEditMsg.Text = "<div class='alert err'>Thiếu tham số id.</div>";
                return;
            }
            hfEditId.Value = id.ToString();

            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(@"SELECT MaSP, TenSP, Gia, MaNCC, MaLoaiSP, SoLuong, AnhChinh, GiaGoc, MaGiam, MoTa
                                              FROM dbo.SanPham WHERE MaSP=@id", con))
            {
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                using (var rd = cmd.ExecuteReader())
                {
                    if (!rd.Read())
                    {
                        ltEditMsg.Text = "<div class='alert err'>Không tìm thấy sản phẩm.</div>";
                        return;
                    }

                    txtTenEdit.Text = Convert.ToString(rd["TenSP"]);
                    txtGiaEdit.Text = Convert.ToDecimal(rd["Gia"]).ToString(CultureInfo.InvariantCulture);
                    ddlNCCEdit.SelectedValue = Convert.ToString(rd["MaNCC"]);
                    ddlLoaiEdit.SelectedValue = Convert.ToString(rd["MaLoaiSP"]);
                    txtSLEdit.Text = Convert.ToString(rd["SoLuong"]);
                    txtAnhEdit.Text = Convert.ToString(rd["AnhChinh"]);
                    txtGiaGocEdit.Text = rd["GiaGoc"] == DBNull.Value ? "" : Convert.ToDecimal(rd["GiaGoc"]).ToString(CultureInfo.InvariantCulture);
                    ddlGiamEdit.SelectedValue = rd["MaGiam"] == DBNull.Value ? "" : Convert.ToString(rd["MaGiam"]);
                    txtMoTaEdit.Text = Convert.ToString(rd["MoTa"]);
                }
            }
        }

        protected void btnEditSave_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(hfEditId.Value, out var id))
            {
                ltEditMsg.Text = "<div class='alert err'>Thiếu id.</div>";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtTenEdit.Text) || ParseDec(txtGiaEdit.Text) == null || ParseInt(txtSLEdit.Text) == null)
            {
                ltEditMsg.Text = "<div class='alert err'>Tên, Giá, Số lượng không hợp lệ.</div>";
                return;
            }

            try
            {
                using (var con = new SqlConnection(ConnStr))
                using (var cmd = con.CreateCommand())
                {
                    cmd.CommandText = @"
UPDATE dbo.SanPham
SET TenSP=@Ten, Gia=@Gia, MaNCC=@NCC, MaLoaiSP=@Loai,
    SoLuong=@SL, AnhChinh=@Anh, GiaGoc=@GiaGoc, MaGiam=@MaGiam, MoTa=@MoTa
WHERE MaSP=@Id";

                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Parameters.AddWithValue("@Ten", txtTenEdit.Text.Trim());
                    cmd.Parameters.AddWithValue("@Gia", ParseDec(txtGiaEdit.Text));
                    cmd.Parameters.AddWithValue("@NCC", ddlNCCEdit.SelectedValue);
                    cmd.Parameters.AddWithValue("@Loai", ddlLoaiEdit.SelectedValue);
                    cmd.Parameters.AddWithValue("@SL", ParseInt(txtSLEdit.Text));
                    cmd.Parameters.AddWithValue("@Anh", DbVal(string.IsNullOrWhiteSpace(txtAnhEdit.Text) ? null : txtAnhEdit.Text.Trim()));
                    cmd.Parameters.AddWithValue("@GiaGoc", DbVal(ParseDec(txtGiaGocEdit.Text)));
                    cmd.Parameters.AddWithValue("@MaGiam", DbVal(string.IsNullOrWhiteSpace(ddlGiamEdit.SelectedValue) ? null : (object)Convert.ToInt32(ddlGiamEdit.SelectedValue)));
                    cmd.Parameters.AddWithValue("@MoTa", DbVal(string.IsNullOrWhiteSpace(txtMoTaEdit.Text) ? null : txtMoTaEdit.Text.Trim()));

                    con.Open();
                    cmd.ExecuteNonQuery();

                    ltEditMsg.Text = "<div class='alert ok'>Đã lưu thay đổi. <a href='Admin.aspx?tab=list'>Về danh sách</a></div>";
                }
            }
            catch (Exception ex)
            {
                ltEditMsg.Text = $"<div class='alert err'>{Server.HtmlEncode(ex.Message)}</div>";
            }
        }
    }
}
