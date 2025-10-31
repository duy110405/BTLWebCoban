using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace btlweb
{
    public partial class Giohang : Page
    {
        string ConnStr => ConfigurationManager.ConnectionStrings["Baitaplonlaptrinhweb"].ConnectionString;
        int? UserId => Session["UserId"] is int id ? id : (int?)null;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Tránh yêu cầu jQuery của UnobtrusiveValidation
            System.Web.UI.ValidationSettings.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                BindCart();
                BindAddresses();
            }
        }

        // ===== Cart helpers =====
        private List<CartItem> GetCart()
        {
            var cart = Session["Cart"] as List<CartItem>;
            if (cart == null)
            {
                cart = new List<CartItem>();
                Session["Cart"] = cart;
            }
            return cart;
        }

        private void BindCart()
        {
            var cart = GetCart();

            if (cart.Count == 0)
            {
                pEmpty.Visible = true;
                rptCart.Visible = false;
                SetMoney(0m);
                return;
            }

            pEmpty.Visible = false;
            rptCart.Visible = true;

            // bind kèm Qty để hiển thị giá dòng
            rptCart.DataSource = cart.Select(x => new
            {
                x.MaSP,
                x.TenSP,
                x.Anh,
                MoTaNgan = x.MoTaNgan,
                x.Gia,
                x.Qty
            }).ToList();
            rptCart.DataBind();

            var sub = cart.Sum(i => i.Gia * i.Qty);
            SetMoney(sub);
        }

        private void SetMoney(decimal sub)
        {
            var vi = CultureInfo.GetCultureInfo("vi-VN");
            litSub.Text = string.Format(vi, "{0:N0}đ", sub);
            litTotal.Text = string.Format(vi, "{0:N0}đ", sub); // chưa cộng ship/thuế
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int maSp = Convert.ToInt32(e.CommandArgument);
            var cart = GetCart();
            var item = cart.FirstOrDefault(x => x.MaSP == maSp);
            if (item == null) return;

            switch (e.CommandName)
            {
                case "Plus":
                    item.Qty = Math.Min(item.Qty + 1, 99);
                    break;
                case "Minus":
                    item.Qty -= 1;
                    if (item.Qty <= 0) cart.Remove(item);
                    break;
                case "Remove":
                    cart.Remove(item);
                    break;
            }

            Session["Cart"] = cart;
            BindCart();
        }

        private void BindAddresses()
        {
            ddlAddress.Items.Clear();

            if (UserId == null)
            {
                ddlAddress.Items.Add(new ListItem("-- Đăng nhập để chọn địa chỉ --", ""));
                return;
            }

            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(@"
        SELECT Id,
               (HoTen + ' | ' + SDT + ' | ' + DiaChi) AS Text,
               IsDefault
        FROM dbo.DiaChiNguoiDung
        WHERE UserId = @uid
        ORDER BY IsDefault DESC, Id DESC;", con))
            {
                cmd.Parameters.Add("@uid", SqlDbType.Int).Value = UserId.Value;
                con.Open();
                using (var rd = cmd.ExecuteReader())
                {
                    ddlAddress.DataSource = rd;
                    ddlAddress.DataTextField = "Text";
                    ddlAddress.DataValueField = "Id";
                    ddlAddress.DataBind();
                }
            }

            ddlAddress.Items.Insert(0, new ListItem("-- Chọn địa chỉ đã lưu --", ""));

            // Auto chọn địa chỉ mặc định (nếu có)
            using (var con2 = new SqlConnection(ConnStr))
            using (var cmd2 = new SqlCommand(@"
        SELECT TOP 1 Id FROM dbo.DiaChiNguoiDung
        WHERE UserId=@uid AND IsDefault=1 ORDER BY Id DESC;", con2))
            {
                cmd2.Parameters.Add("@uid", SqlDbType.Int).Value = UserId.Value;
                con2.Open();
                var defIdObj = cmd2.ExecuteScalar();
                if (defIdObj != null)
                {
                    var defId = defIdObj.ToString();
                    if (ddlAddress.Items.FindByValue(defId) != null)
                        ddlAddress.SelectedValue = defId;
                }
            }
        }

        // ===== Thanh toán =====
        protected void btnPay_Click(object sender, EventArgs e)
        {
            var cart = GetCart();
            if (cart.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "pay_empty",
                    "openPayModal('Giỏ hàng trống', 'Bạn chưa có sản phẩm nào trong giỏ.', '');", true);
                return;
            }

            if (UserId == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "need_login",
                    "openPayModal('Cần đăng nhập', 'Vui lòng đăng nhập và thêm địa chỉ trước khi thanh toán.', 'Dangnhap.aspx');", true);
                return;
            }

            if (string.IsNullOrEmpty(ddlAddress.SelectedValue) || !int.TryParse(ddlAddress.SelectedValue, out var addressId))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "addr_need",
                    "openPayModal('Chưa chọn địa chỉ', 'Hãy chọn một địa chỉ giao hàng trong danh sách.', 'Chitiettaikhoan.aspx?tab=addresses');", true);
                return;
            }

            // Lấy snapshot địa chỉ đã chọn
            string hoten, sdt, email, diachi, pttt, ghichu;
            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand(@"
        SELECT HoTen, SDT, Email, DiaChi, PhuongThucTT, GhiChu
        FROM dbo.DiaChiNguoiDung
        WHERE Id=@id AND UserId=@uid;", con))
            {
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = addressId;
                cmd.Parameters.Add("@uid", SqlDbType.Int).Value = UserId.Value;
                con.Open();
                using (var rd = cmd.ExecuteReader())
                {
                    if (!rd.Read())
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "addr_invalid",
                            "openPayModal('Địa chỉ không hợp lệ', 'Vui lòng chọn lại địa chỉ.', '');", true);
                        return;
                    }
                    hoten = rd["HoTen"].ToString();
                    sdt = rd["SDT"].ToString();
                    email = rd["Email"].ToString();
                    diachi = rd["DiaChi"].ToString();
                    pttt = rd["PhuongThucTT"] as string ?? "COD";
                    ghichu = rd["GhiChu"] as string ?? "";
                }
            }

            var vi = CultureInfo.GetCultureInfo("vi-VN");
            decimal tong = cart.Sum(i => i.Gia * i.Qty);
            string maDon = "DH" + DateTime.Now.ToString("yyMMddHHmm");

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();
                using (var tran = con.BeginTransaction())
                {
                    try
                    {
                        // DonHang
                        int donHangId;
                        using (var cmd = new SqlCommand(@"
INSERT INTO dbo.DonHang(MaDon, UserId, AddressId, HoTen, SDT, Email, DiaChi, PhuongThucTT, GhiChu, TongTien, TrangThai, NgayTao)
VALUES (@MaDon, @UserId, @AddressId, @HoTen, @SDT, @Email, @DiaChi, @PTTT, @GhiChu, @TongTien, N'Đã thanh toán', GETDATE());
SELECT CAST(SCOPE_IDENTITY() AS INT);", con, tran))
                        {
                            cmd.Parameters.AddWithValue("@MaDon", maDon);
                            cmd.Parameters.AddWithValue("@UserId", (object)UserId ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@AddressId", addressId); // cần cột AddressId trong DonHang
                            cmd.Parameters.AddWithValue("@HoTen", hoten);
                            cmd.Parameters.AddWithValue("@SDT", sdt);
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.Parameters.AddWithValue("@DiaChi", diachi);
                            cmd.Parameters.AddWithValue("@PTTT", pttt);
                            cmd.Parameters.AddWithValue("@GhiChu", (object)ghichu ?? DBNull.Value);
                            var pTong = cmd.Parameters.Add("@TongTien", SqlDbType.Decimal);
                            pTong.Precision = 18; pTong.Scale = 2; pTong.Value = tong;

                            donHangId = (int)cmd.ExecuteScalar();
                        }

                        // DonHangCT
                        foreach (var it in cart)
                        {
                            using (var cmd = new SqlCommand(@"
INSERT INTO dbo.DonHangCT(DonHangId, MaSP, TenSP, DonGia, SoLuong, ThanhTien)
VALUES (@DonHangId, @MaSP, @TenSP, @DonGia, @SoLuong, @ThanhTien);", con, tran))
                            {
                                cmd.Parameters.AddWithValue("@DonHangId", donHangId);
                                cmd.Parameters.AddWithValue("@MaSP", it.MaSP);
                                cmd.Parameters.AddWithValue("@TenSP", it.TenSP);
                                var pDonGia = cmd.Parameters.Add("@DonGia", SqlDbType.Decimal);
                                pDonGia.Precision = 18; pDonGia.Scale = 2; pDonGia.Value = it.Gia;
                                cmd.Parameters.AddWithValue("@SoLuong", it.Qty);
                                var pTT = cmd.Parameters.Add("@ThanhTien", SqlDbType.Decimal);
                                pTT.Precision = 18; pTT.Scale = 2; pTT.Value = it.Gia * it.Qty;
                                cmd.ExecuteNonQuery();
                            }
                        }

                        // HoaDon
                        string soHD = "HD" + DateTime.Now.ToString("yyMMddHHmm");
                        int hoaDonId;
                        using (var cmd = new SqlCommand(@"
INSERT INTO dbo.HoaDon(DonHangId, SoHoaDon, NgayLap, TongTien, PhuongThucTT)
VALUES (@DonHangId, @SoHoaDon, GETDATE(), @TongTien, @PTTT);
SELECT CAST(SCOPE_IDENTITY() AS INT);", con, tran))
                        {
                            cmd.Parameters.AddWithValue("@DonHangId", donHangId);
                            cmd.Parameters.AddWithValue("@SoHoaDon", soHD);
                            var pTong = cmd.Parameters.Add("@TongTien", SqlDbType.Decimal);
                            pTong.Precision = 18; pTong.Scale = 2; pTong.Value = tong;
                            cmd.Parameters.AddWithValue("@PTTT", pttt);
                            hoaDonId = (int)cmd.ExecuteScalar();
                        }

                        // HoaDonCT
                        foreach (var it in cart)
                        {
                            using (var cmd = new SqlCommand(@"
INSERT INTO dbo.HoaDonCT(HoaDonId, MaSP, TenSP, DonGia, SoLuong, ThanhTien)
VALUES (@HoaDonId, @MaSP, @TenSP, @DonGia, @SoLuong, @ThanhTien);", con, tran))
                            {
                                cmd.Parameters.AddWithValue("@HoaDonId", hoaDonId);
                                cmd.Parameters.AddWithValue("@MaSP", it.MaSP);
                                cmd.Parameters.AddWithValue("@TenSP", it.TenSP);
                                var pDonGia = cmd.Parameters.Add("@DonGia", SqlDbType.Decimal);
                                pDonGia.Precision = 18; pDonGia.Scale = 2; pDonGia.Value = it.Gia;
                                cmd.Parameters.AddWithValue("@SoLuong", it.Qty);
                                var pTT = cmd.Parameters.Add("@ThanhTien", SqlDbType.Decimal);
                                pTT.Precision = 18; pTT.Scale = 2; pTT.Value = it.Gia * it.Qty;
                                cmd.ExecuteNonQuery();
                            }
                        }

                        tran.Commit();

                        // Reset giỏ
                        Session["Cart"] = new List<CartItem>();
                        BindCart();

                        string desc = $"Đơn hàng <b>{maDon}</b> đã được tạo. Tổng tiền <b>{tong.ToString("N0", vi)}đ</b>.";
                        string js = $"openPayModal('Thanh toán thành công!', `{desc}`, '{maDon}');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "pay_ok", js, true);
                    }
                    catch
                    {
                        tran.Rollback();
                        ScriptManager.RegisterStartupScript(this, GetType(), "pay_err",
                            "openPayModal('Lỗi thanh toán', 'Có lỗi xảy ra khi tạo đơn. Vui lòng thử lại.', '');", true);
                    }
                }
            }
        }

    }
}
