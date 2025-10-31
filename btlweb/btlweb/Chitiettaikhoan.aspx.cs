using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace btlweb
{
    public partial class Chitiettaikhoan : Page
    {
        string ConnStr => ConfigurationManager.ConnectionStrings["Baitaplonlaptrinhweb"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                BindOrders();
                BindInvoices();
                BindAddresses();
            }
        }

        protected void btnThemdiachi_Click(object sender, EventArgs e)
        {
            if (UserId == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "addr_login",
                    "openPayModal('Cần đăng nhập', 'Bạn cần đăng nhập để lưu địa chỉ.', 'Dangnhap.aspx');", true);
                return;
            }
            XoaThongBaoLoi();
            bool hopLe = true;

            // Lấy & kiểm tra input
            string hoten = (txtHoTen.Text ?? "").Trim();
            string sdt = (txtSDT.Text ?? "").Trim();
            string email = (txtEmail.Text ?? "").Trim();
            string diachi = (txtDiaChi.Text ?? "").Trim();
            string pttt = (ddlPTTT.SelectedValue ?? "").Trim();
            string ghichu = (txtGhiChu.Text ?? "").Trim();


            // kiểm tra dữ liệu nhập 
            if (string.IsNullOrWhiteSpace(hoten))
            {
                errHoten.Text = "Họ tên không được để trống";
                errHoten.Visible = true;
                hopLe = false;
            }
            if (string.IsNullOrWhiteSpace(email) || !Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                errEmail.Text = "Email không hợp lệ";
                errEmail.Visible = true;
                hopLe = false;
            }
            if (string.IsNullOrWhiteSpace(sdt) || !Regex.IsMatch(sdt, @"^\d{10}$"))
            {
                errSdt.Text = "Số điện thoại không hợp lệ (10 số)";
                errSdt.Visible = true;
                hopLe = false;
            }
            if (string.IsNullOrWhiteSpace(diachi))
            {
                errDiachi.Text = "Địa chỉ không được để trống.";
                errDiachi.Visible = true;
                hopLe = false;
            }

            // Nếu có LỖI => KHÔNG vào SQL, giữ tab 'addresses' rồi THOÁT
            if (!hopLe)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "stay_on_addresses_err",
                    "if(!location.search.includes('tab=addresses')){history.replaceState({},'', '?tab=addresses');}", true);
                return;
            }
            // Kết nối sql
            using (var con = new SqlConnection(ConnStr))
            {
                con.Open(); 
                using (var tran = con.BeginTransaction())
                {
                    try
                    {
                        // Là địa chỉ đầu tiên? -> set mặc định
                        bool first;
                        using (var cnt = new SqlCommand(
                            "SELECT COUNT(*) FROM dbo.DiaChiNguoiDung WHERE UserId=@uid;", con, tran))
                        {
                            cnt.Parameters.Add("@uid", SqlDbType.Int).Value = UserId.Value;
                            first = (int)cnt.ExecuteScalar() == 0;
                        }

                        using (var cmd = new SqlCommand(@"
INSERT INTO dbo.DiaChiNguoiDung
(UserId, HoTen, SDT, Email, DiaChi, PhuongThucTT, GhiChu, IsDefault)
VALUES (@UserId, @HoTen, @SDT, @Email, @DiaChi, @PhuongThucTT, @GhiChu, @IsDefault);", con, tran))
                        {
                            cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = UserId.Value;
                            cmd.Parameters.Add("@HoTen", SqlDbType.NVarChar, 100).Value = hoten;
                            cmd.Parameters.Add("@SDT", SqlDbType.NVarChar, 20).Value = sdt;
                            cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 150).Value = email;
                            cmd.Parameters.Add("@DiaChi", SqlDbType.NVarChar, 300).Value = diachi;
                            cmd.Parameters.Add("@PhuongThucTT", SqlDbType.NVarChar, 50).Value = (object)pttt ?? DBNull.Value;
                            cmd.Parameters.Add("@GhiChu", SqlDbType.NVarChar, 300).Value = string.IsNullOrWhiteSpace(ghichu) ? (object)DBNull.Value : ghichu;
                            cmd.Parameters.Add("@IsDefault", SqlDbType.Bit).Value = first ? 1 : 0;
                            cmd.ExecuteNonQuery();
                        }

                        tran.Commit();
                    }
                    catch (Exception ex)
                    {
                        tran.Rollback();
                        ScriptManager.RegisterStartupScript(this, GetType(), "addr_err",
                            $"openPayModal('Lỗi', 'Không thêm được địa chỉ: {ex.Message.Replace("'", "\\'")}', '');", true);
                        return;
                    }
                }
            }
            // Bind lại danh sách
            BindAddresses();
            // Giữ nguyên tab 'addresses' sau postback (nếu URL thiếu query)
            ScriptManager.RegisterStartupScript(this, GetType(), "stay_on_addresses",
                "if(!location.search.includes('tab=addresses')){history.replaceState({},'', '?tab=addresses');}", true);
            // Thông báo & dọn form
            ScriptManager.RegisterStartupScript(this, GetType(), "addr_ok",
                "openPayModal('Đã lưu địa chỉ', 'Địa chỉ mới đã được thêm thành công.', '');", true);
            txtHoTen.Text = txtSDT.Text = txtEmail.Text = txtDiaChi.Text = txtGhiChu.Text = string.Empty;
        }
        private void XoaThongBaoLoi()
        {
            errHoten.Text = errEmail.Text = errSdt.Text = "";
            errDiachi.Text = "";
            errHoten.Visible = errEmail.Visible = errSdt.Visible = false;
            errDiachi.Visible = false;

        }

        /*=============================================================================== Đơn Hàng===================================== */
        int? UserId => Session["UserId"] is int id ? id : (int?)null;
        string LastOrderCode => Session["LastOrderCode"] as string;

        void BindOrders()
        {
            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(@"
SELECT Id, MaDon, TrangThai, TongTien, NgayTao
FROM dbo.DonHang
WHERE (UserId = @uid) OR (@uid IS NULL AND MaDon = @code)
ORDER BY NgayTao DESC;", con))
            {
                cmd.Parameters.AddWithValue("@uid", (object)UserId ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@code", (object)LastOrderCode ?? DBNull.Value);
                con.Open();
                var dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                rptOrders.DataSource = dt;
                rptOrders.DataBind();
            }
        }

        protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            int donHangId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "Id"));
            var child = (Repeater)e.Item.FindControl("rptOrderItems");

            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(@"
SELECT ct.MaSP, ct.TenSP, ct.SoLuong, ct.DonGia,
       (ct.DonGia * ct.SoLuong) AS ThanhTien,
       sp.CPU, sp.RAMGB, sp.SSDGB, sp.HDDGB, sp.GPU,
       sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz, sp.TrongLuongKg,
       sp.AnhChinh
FROM dbo.DonHangCT ct
LEFT JOIN dbo.SanPham sp ON sp.MaSP = ct.MaSP
WHERE ct.DonHangId = @id;", con))
            {
                cmd.Parameters.AddWithValue("@id", donHangId);
                con.Open();
                var dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                child.DataSource = dt;
                child.DataBind();
            }
        }

        void BindInvoices()
        {
            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(@"
SELECT hd.Id, hd.SoHoaDon, hd.NgayLap, hd.TongTien, dh.MaDon
FROM dbo.HoaDon hd
JOIN dbo.DonHang dh ON dh.Id = hd.DonHangId
WHERE (dh.UserId = @uid) OR (@uid IS NULL AND dh.MaDon = @code)
ORDER BY hd.NgayLap DESC;", con))
            {
                cmd.Parameters.AddWithValue("@uid", (object)UserId ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@code", (object)LastOrderCode ?? DBNull.Value);
                con.Open();
                var dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                rptInvoices.DataSource = dt;
                rptInvoices.DataBind();
            }
        }

        /*=============================================================================== Địa chỉ===================================== */
        void BindAddresses()
        {
            if (UserId == null)
            {
                phAddresses.Visible = false;
                rptAddresses.DataSource = null;
                rptAddresses.DataBind();
                return;
            }

            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(@"
SELECT Id, HoTen, SDT, Email, DiaChi, PhuongThucTT, GhiChu, IsDefault, NgayTao
FROM dbo.DiaChiNguoiDung
WHERE UserId = @uid
ORDER BY IsDefault DESC, Id DESC;", con))
            {
                cmd.Parameters.Add("@uid", SqlDbType.Int).Value = UserId.Value;
                con.Open();
                var dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);

                rptAddresses.DataSource = dt;
                rptAddresses.DataBind();

                phAddresses.Visible = dt.Rows.Count > 0; // rỗng thì ẩn cả block
            }
        }
        protected void rptAddresses_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (UserId == null) return;
            int addrId = int.Parse(e.CommandArgument.ToString());

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();
                using (var tran = con.BeginTransaction())
                {
                    try
                    {
                        if (e.CommandName == "makeDefault")
                        {
                            using (var off = new SqlCommand(
                                "UPDATE dbo.DiaChiNguoiDung SET IsDefault=0 WHERE UserId=@uid;", con, tran))
                            using (var on = new SqlCommand(
                                "UPDATE dbo.DiaChiNguoiDung SET IsDefault=1 WHERE Id=@id AND UserId=@uid;", con, tran))
                            {
                                off.Parameters.Add("@uid", SqlDbType.Int).Value = UserId.Value;
                                on.Parameters.Add("@uid", SqlDbType.Int).Value = UserId.Value;
                                on.Parameters.Add("@id", SqlDbType.Int).Value = addrId;
                                off.ExecuteNonQuery();
                                on.ExecuteNonQuery();
                            }
                        }
                        else if (e.CommandName == "delete")
                        {
                            using (var del = new SqlCommand(
                                "DELETE FROM dbo.DiaChiNguoiDung WHERE Id=@id AND UserId=@uid;", con, tran))
                            {
                                del.Parameters.Add("@uid", SqlDbType.Int).Value = UserId.Value;
                                del.Parameters.Add("@id", SqlDbType.Int).Value = addrId;
                                del.ExecuteNonQuery();
                            }
                        }

                        tran.Commit();
                    }
                    catch
                    {
                        tran.Rollback();
                        throw;
                    }
                }
            }
            BindAddresses();
        }

        /*=============================================================================== DonHangCT===================================== */
        protected void rptInvoices_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            int hoaDonId = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "Id"));
            var child = (Repeater)e.Item.FindControl("rptInvoiceItems");

            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(@"
SELECT ct.MaSP, ct.TenSP, ct.SoLuong, ct.DonGia,
       (ct.DonGia * ct.SoLuong) AS ThanhTien,
       sp.CPU, sp.RAMGB, sp.SSDGB, sp.HDDGB, sp.GPU,
       sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz, sp.TrongLuongKg,
       sp.AnhChinh
FROM dbo.HoaDonCT ct
LEFT JOIN dbo.SanPham sp ON sp.MaSP = ct.MaSP
WHERE ct.HoaDonId = @id;", con))
            {
                cmd.Parameters.AddWithValue("@id", hoaDonId);
                con.Open();
                var dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                child.DataSource = dt;
                child.DataBind();
            }
        }
    }
}
