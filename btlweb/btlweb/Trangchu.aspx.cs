using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;

namespace btlweb
{
    public partial class Trangchu : System.Web.UI.Page
    {
        private readonly CultureInfo vi = new CultureInfo("vi-VN");
        private string ConnStr => ConfigurationManager.ConnectionStrings["Baitaplonlaptrinhweb"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBanChay();
                BindHangMoi();
                BindFlashSale();
                BindTheoLoai("Laptop", rptLaptop, 8);
                BindTheoLoai("Bàn phím", rptBanPhim, 8);
                BindTheoLoai("PC", rptPC, 8);
            }
        }

        private DataTable Query(string sql, params SqlParameter[] ps)
        {
            using (var con = new SqlConnection(ConnStr))
            using (var da = new SqlDataAdapter(sql, con))
            {
                if (ps != null && ps.Length > 0) da.SelectCommand.Parameters.AddRange(ps);
                var dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        private string PriceText(object v)
        {
            if (v == DBNull.Value || v == null) return "";
            var d = Convert.ToDecimal(v);
            return string.Format(vi, "{0:N0}đ", d);
        }

        private string Safe(object o) => o == DBNull.Value || o == null ? "" : o.ToString();

        private string JoinParts(string sep, params string[] parts)
        {
            var list = new System.Collections.Generic.List<string>();
            foreach (var p in parts) if (!string.IsNullOrWhiteSpace(p)) list.Add(p.Trim());
            return string.Join(sep, list);
        }

        private string BuildSpecHTML(DataRow r)
        {
            var s1 = r["SpecLine1"] as string;
            var s2 = r["SpecLine2"] as string;
            if (!string.IsNullOrWhiteSpace(s1) || !string.IsNullOrWhiteSpace(s2))
                return (s1 ?? "").Trim() + "<br />" + (s2 ?? "").Trim();

            string cpu = Safe(r["CPU"]);
            string gpu = Safe(r["GPU"]);
            string ram = r["RAMGB"] != DBNull.Value ? $"{r["RAMGB"]}gb" : "";
            string ssd = r["SSDGB"] != DBNull.Value ? $"{r["SSDGB"]}gb" : "";
            string inch = r["ManHinhInch"] != DBNull.Value ? $"{Convert.ToDecimal(r["ManHinhInch"]):0.#} inch" : "";
            string res = Safe(r["DoPhanGiai"]);
            string hz = r["TanSoQuetHz"] != DBNull.Value ? $"{r["TanSoQuetHz"]}hz" : "";

            string line1 = JoinParts(" | ", cpu, gpu);
            string line2 = JoinParts(" | ", JoinParts(" ", ram, ssd), inch, res, hz);
            if (string.IsNullOrWhiteSpace(line2)) return line1;
            if (string.IsNullOrWhiteSpace(line1)) return line2;
            return $"{line1}<br />{line2}";
        }

        private void Decorate(DataTable dt)
        {
            if (!dt.Columns.Contains("GiaText")) dt.Columns.Add("GiaText", typeof(string));
            if (!dt.Columns.Contains("GiaGocText")) dt.Columns.Add("GiaGocText", typeof(string));
            if (!dt.Columns.Contains("HasDiscount")) dt.Columns.Add("HasDiscount", typeof(bool));
            if (!dt.Columns.Contains("Badge")) dt.Columns.Add("Badge", typeof(string));
            if (!dt.Columns.Contains("SpecHTML")) dt.Columns.Add("SpecHTML", typeof(string));

            foreach (DataRow r in dt.Rows)
            {
                var gia = r["Gia"] == DBNull.Value ? 0m : Convert.ToDecimal(r["Gia"]);
                var giagocObj = r.Table.Columns.Contains("GiaGoc") ? r["GiaGoc"] : DBNull.Value;
                var giagoc = giagocObj == DBNull.Value ? 0m : Convert.ToDecimal(giagocObj);

                r["GiaText"] = PriceText(gia);

                bool hasDiscount = giagoc > gia && giagoc > 0m;
                r["HasDiscount"] = hasDiscount;
                r["GiaGocText"] = hasDiscount ? PriceText(giagoc) : "";

                int percent = 0;
                if (hasDiscount)
                    percent = (int)Math.Round((giagoc - gia) * 100m / giagoc, MidpointRounding.AwayFromZero);

                r["Badge"] = percent > 0 ? "-" + percent + "%" : "0%";
                r["SpecHTML"] = BuildSpecHTML(r);
            }
        }

        private void BindBanChay()
        {
            string sql = @"
SELECT TOP 4 sp.MaSP, sp.TenSP, sp.Gia, sp.GiaGoc, sp.AnhChinh,
       sp.SpecLine1, sp.SpecLine2,
       sp.CPU, sp.RAMGB, sp.SSDGB, sp.GPU, sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz,
       mg.GiamGia
FROM dbo.SanPham sp
LEFT JOIN dbo.MaGiamGia mg ON mg.MaGiam = sp.MaGiam
ORDER BY sp.SoLuong DESC, sp.NgayTao DESC, sp.MaSP DESC;";
            var dt = Query(sql);
            Decorate(dt);
            rptBanChay.DataSource = dt;
            rptBanChay.DataBind();
        }

        private void BindHangMoi()
        {
            string sql = @"
SELECT TOP 4 sp.MaSP, sp.TenSP, sp.Gia, sp.GiaGoc, sp.AnhChinh,
       sp.SpecLine1, sp.SpecLine2,
       sp.CPU, sp.RAMGB, sp.SSDGB, sp.GPU, sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz,
       mg.GiamGia
FROM dbo.SanPham sp
LEFT JOIN dbo.MaGiamGia mg ON mg.MaGiam = sp.MaGiam
ORDER BY sp.NgayTao DESC, sp.MaSP DESC;";
            var dt = Query(sql);
            Decorate(dt);
            rptHangMoi.DataSource = dt;
            rptHangMoi.DataBind();
        }

        private void BindFlashSale()
        {
            string sql = @"
SELECT TOP 4 sp.MaSP, sp.TenSP, sp.Gia, sp.GiaGoc, sp.AnhChinh,
       sp.SpecLine1, sp.SpecLine2,
       sp.CPU, sp.RAMGB, sp.SSDGB, sp.GPU, sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz,
       mg.GiamGia
FROM dbo.SanPham sp
INNER JOIN dbo.MaGiamGia mg ON mg.MaGiam = sp.MaGiam
WHERE sp.GiaGoc IS NOT NULL AND sp.Gia < sp.GiaGoc
ORDER BY (sp.GiaGoc - sp.Gia) DESC, sp.NgayTao DESC;";
            var dt = Query(sql);
            Decorate(dt);
            rptFlashSale.DataSource = dt;
            rptFlashSale.DataBind();
        }

        private void BindTheoLoai(string tenLoai, System.Web.UI.WebControls.Repeater rpt, int top)
        {
            string sql = @"
SELECT TOP (@top) sp.MaSP, sp.TenSP, sp.Gia, sp.GiaGoc, sp.AnhChinh,
       sp.SpecLine1, sp.SpecLine2,
       sp.CPU, sp.RAMGB, sp.SSDGB, sp.GPU, sp.ManHinhInch, sp.DoPhanGiai, sp.TanSoQuetHz,
       mg.GiamGia
FROM dbo.SanPham sp
INNER JOIN dbo.LoaiSanPham l ON l.MaLoaiSP = sp.MaLoaiSP
LEFT JOIN dbo.MaGiamGia mg ON mg.MaGiam = sp.MaGiam
WHERE l.TenLoai = @tenLoai
ORDER BY sp.NgayTao DESC, sp.MaSP DESC;";
            var dt = Query(sql,
                new SqlParameter("@top", SqlDbType.Int) { Value = top },
                new SqlParameter("@tenLoai", SqlDbType.NVarChar, 50) { Value = tenLoai }
            );
            Decorate(dt);
            rpt.DataSource = dt;
            rpt.DataBind();
        }

        protected void btnTrangChuLogo_Click(object sender, EventArgs e) { Response.Redirect("Trangchu.aspx"); }
        protected void btnTrangChu_Click(object sender, EventArgs e) { Response.Redirect("Trangchu.aspx"); }
        protected void btnTimKiem_Click(object sender, EventArgs e) { }
        protected void btnTaiKhoan_Click(object sender, EventArgs e) { Response.Redirect("Taikhoan.aspx"); }
        protected void btnGioHang_Click(object sender, EventArgs e) { Response.Redirect("Giohang.aspx"); }
        protected void btnBanPhim_Click(object sender, EventArgs e) { Response.Redirect("Banphim.aspx"); }
        protected void btnLaptop_Click(object sender, EventArgs e) { Response.Redirect("Laptop.aspx"); }
        protected void btnPC_Click(object sender, EventArgs e) { Response.Redirect("Pc.aspx"); }
        protected void btnLienHe_Click(object sender, EventArgs e) { Response.Redirect("Lienhe.aspx"); }
        protected void btnGioiThieu_Click(object sender, EventArgs e) { Response.Redirect("Gioithieu.aspx"); }
    }
}
