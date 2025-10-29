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

        protected void Page_Load(object sender, EventArgs e)
        {
            // Tránh yêu cầu jQuery của UnobtrusiveValidation
            System.Web.UI.ValidationSettings.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;

            if (!IsPostBack) BindCart();
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

            // Lấy & kiểm tra thông tin
            string hoten = txtHoTen.Text.Trim();
            string sdt = txtSDT.Text.Trim();
            string email = txtEmail.Text.Trim();
            string diachi = txtDiaChi.Text.Trim();
            string pttt = ddlPTTT.SelectedValue;
            string ghichu = txtGhiChu.Text.Trim();

            if (string.IsNullOrWhiteSpace(hoten) ||
                string.IsNullOrWhiteSpace(sdt) ||
                string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(diachi))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "pay_missing",
                    "openPayModal('Thiếu thông tin', 'Vui lòng nhập đầy đủ <b>Họ tên, SĐT, Email, Địa chỉ</b>.', '');", true);
                return;
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
INSERT INTO dbo.DonHang(MaDon, UserId, HoTen, SDT, Email, DiaChi, PhuongThucTT, GhiChu, TongTien, TrangThai, NgayTao)
VALUES (@MaDon, @UserId, @HoTen, @SDT, @Email, @DiaChi, @PTTT, @GhiChu, @TongTien, N'Đã thanh toán', GETDATE());
SELECT CAST(SCOPE_IDENTITY() AS INT);", con, tran))
                        {
                            cmd.Parameters.AddWithValue("@MaDon", maDon);
                            cmd.Parameters.AddWithValue("@UserId", (object)(Session["userId"] as int?) ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@HoTen", hoten);
                            cmd.Parameters.AddWithValue("@SDT", sdt);
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.Parameters.AddWithValue("@DiaChi", diachi);
                            cmd.Parameters.AddWithValue("@PTTT", pttt);
                            cmd.Parameters.AddWithValue("@GhiChu", (object)ghichu ?? DBNull.Value);
                            cmd.Parameters.Add("@TongTien", SqlDbType.Decimal).Value = tong;
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
                                cmd.Parameters.Add("@DonGia", SqlDbType.Decimal).Value = it.Gia;
                                cmd.Parameters.AddWithValue("@SoLuong", it.Qty);
                                cmd.Parameters.Add("@ThanhTien", SqlDbType.Decimal).Value = it.Gia * it.Qty;
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
                            cmd.Parameters.Add("@TongTien", SqlDbType.Decimal).Value = tong;
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
                                cmd.Parameters.Add("@DonGia", SqlDbType.Decimal).Value = it.Gia;
                                cmd.Parameters.AddWithValue("@SoLuong", it.Qty);
                                cmd.Parameters.Add("@ThanhTien", SqlDbType.Decimal).Value = it.Gia * it.Qty;
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
