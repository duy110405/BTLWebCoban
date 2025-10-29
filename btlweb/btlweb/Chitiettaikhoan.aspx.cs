using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
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
            }
        }

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
