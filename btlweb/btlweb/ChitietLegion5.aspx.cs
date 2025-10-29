using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using static btlweb.Giohang;

namespace btlweb
{
    public partial class ChitietLegion5 : System.Web.UI.Page
    {
        private string ConnStr => ConfigurationManager.ConnectionStrings["Baitaplonlaptrinhweb"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!int.TryParse(Request.QueryString["masp"], out var maSP))
                {
                    Response.Redirect("Laptop.aspx");
                    return;
                }
                hfMaSP.Value = maSP.ToString();
                LoadBasic(maSP);
            }
        }

        private void LoadBasic(int maSP)
        {
            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand("dbo.usp_SanPham_GetById", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MaSP", maSP);
                con.Open();

                using (var rdr = cmd.ExecuteReader())
                {
                    if (!rdr.Read())
                    {
                        litTitle.Text = "Sản phẩm không tồn tại";
                        litPrice.Text = "—";
                        SetAllMeters(6, 6, 6, 6, 6, 6, 6);
                        return;
                    }

                    // ===== TÊN MÁY =====
                    litTitle.Text = rdr["TenSP"]?.ToString() ?? "";

                    // ===== ẢNH =====
                    string mainUrl = BuildImgUrl(rdr["AnhChinh"] as string ?? "");
                    jsMainImg.ImageUrl = mainUrl; // đổi sang jsMainImg
                    imgT1.ImageUrl = mainUrl;

                    // ===== GIÁ =====
                    litPrice.Text = Money(rdr["GiaHienThi"]);

                    // ===== GHÉP "PHIÊN BẢN" =====
                    string cpu = rdr["CPU"] as string ?? "";
                    string gpu = rdr["GPU"] as string ?? "";
                    int? ram = rdr["RAMGB"] == DBNull.Value ? (int?)null : Convert.ToInt32(rdr["RAMGB"]);
                    int? ssd = rdr["SSDGB"] == DBNull.Value ? (int?)null : Convert.ToInt32(rdr["SSDGB"]);
                    decimal? inch = rdr["ManHinhInch"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(rdr["ManHinhInch"]);
                    string res = rdr["DoPhanGiai"] as string ?? "";
                    int? hz = rdr["TanSoQuetHz"] == DBNull.Value ? (int?)null : Convert.ToInt32(rdr["TanSoQuetHz"]);

                    string versionText = BuildVersionText(cpu, gpu, ram, ssd, inch, res, hz);
                    ddlVersion.Items.Clear();
                    ddlVersion.Items.Add(new ListItem(versionText, "v1"));

                    // ===== THANH HIỆU NĂNG =====
                    decimal? w = rdr["TrongLuongKg"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(rdr["TrongLuongKg"]);
                    int cpuScore = ScoreCPU(cpu);
                    int gpuScore = ScoreGPU(gpu);
                    int ramScore = ram.HasValue ? (ram.Value >= 32 ? 9 : ram.Value >= 16 ? 8 : ram.Value >= 8 ? 7 : 5) : 7;
                    int thinScore = ScoreThin(w);

                    int office = Clamp((int)Math.Round((cpuScore + ramScore) / 2.0));
                    int gaming = Clamp(gpuScore);
                    int dev = Clamp((int)Math.Round(cpuScore * 0.6 + ramScore * 0.4));
                    int design = Clamp((int)Math.Round(gpuScore * 0.7 + ramScore * 0.3));
                    int ai = Clamp(gpuScore >= 7 ? 7 : 5);
                    int student = Clamp((int)Math.Round((office + thinScore) / 2.0 + 3));

                    SetAllMeters(student, office, gaming, dev, design, ai, thinScore);
                }
            }
        }

        // ========= SỰ KIỆN GIỎ HÀNG =========
        protected void BtnAddToCart_Click(object sender, EventArgs e)
        {
            if (int.TryParse(hfMaSP.Value, out var maSP))
            {
                AddToCart(maSP, 1);
            }
        }

        protected void BtnBuyNow_Click(object sender, EventArgs e)
        {
            if (int.TryParse(hfMaSP.Value, out var maSP))
            {
                AddToCart(maSP, 1);
                Response.Redirect("Giohang.aspx");
            }
        }

        private void AddToCart(int maSP, int qty)
        {
            var cart = Session["Cart"] as List<CartItem> ?? new List<CartItem>();

            // Nếu sản phẩm đã có trong giỏ thì tăng số lượng
            var existed = cart.Find(x => x.MaSP == maSP);
            if (existed != null)
            {
                existed.Qty += qty;
                Session["Cart"] = cart;
                return;
            }

            // Đọc DB để lấy thông tin
            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand("dbo.usp_SanPham_GetById", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MaSP", maSP);
                con.Open();

                using (var rdr = cmd.ExecuteReader())
                {
                    if (!rdr.Read()) return;

                    string cpu = rdr["CPU"] as string ?? "";
                    string gpu = rdr["GPU"] as string ?? "";
                    int? ram = rdr["RAMGB"] == DBNull.Value ? (int?)null : Convert.ToInt32(rdr["RAMGB"]);
                    int? ssd = rdr["SSDGB"] == DBNull.Value ? (int?)null : Convert.ToInt32(rdr["SSDGB"]);
                    decimal? inch = rdr["ManHinhInch"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(rdr["ManHinhInch"]);
                    string res = rdr["DoPhanGiai"] as string ?? "";
                    int? hz = rdr["TanSoQuetHz"] == DBNull.Value ? (int?)null : Convert.ToInt32(rdr["TanSoQuetHz"]);

                    var item = new CartItem
                    {
                        MaSP = maSP,
                        TenSP = rdr["TenSP"]?.ToString() ?? "",
                        Anh = BuildImgUrl(rdr["AnhChinh"] as string ?? ""),
                        Gia = rdr["GiaHienThi"] == DBNull.Value ? 0 : Convert.ToDecimal(rdr["GiaHienThi"]),
                        Qty = qty,
                        MoTaNgan = BuildShort(cpu, gpu, ram, ssd, inch, res, hz)
                    };

                    cart.Add(item);
                }
            }

            Session["Cart"] = cart;
        }

        private string BuildShort(string cpu, string gpu, int? ram, int? ssd, decimal? inch, string res, int? hz)
        {
            string size = inch.HasValue ? (inch.Value % 1 == 0 ? $"{(int)inch.Value}”" : $"{inch.Value:0.#}”") : null;
            string screen = JoinNonEmpty(size, res, hz.HasValue ? $"{hz.Value}Hz" : null);
            return JoinNonEmpty(cpu, gpu, ram.HasValue ? $"{ram}GB" : null, ssd.HasValue ? $"{ssd}GB" : null, screen);
        }

        private string JoinNonEmpty(params string[] parts)
            => string.Join(", ", Array.FindAll(parts, p => !string.IsNullOrWhiteSpace(p)));

        private string BuildVersionText(string cpu, string gpu, int? ram, int? ssd,
                                        decimal? inch, string res, int? hz)
        {
            string _ram = ram.HasValue ? $"{ram.Value}gb" : null;
            string _ssd = ssd.HasValue ? $"{ssd.Value}gb" : null;
            string size = inch.HasValue ? (inch.Value % 1 == 0 ? $"{(int)inch.Value}”" : $"{inch.Value:0.#}”") : null;
            string screen = JoinNonEmpty(size, string.IsNullOrWhiteSpace(res) ? null : res);
            string _hz = hz.HasValue ? $"{hz.Value}hz" : null;
            return JoinNonEmpty(cpu, gpu, _ram, _ssd, screen, _hz);
        }

        private string BuildImgUrl(string path)
        {
            if (string.IsNullOrWhiteSpace(path)) return ResolveUrl("~/anh/no-image.png");
            if (path.StartsWith("~") || path.StartsWith("/")) return ResolveUrl(path);
            return ResolveUrl("~/" + path);
        }

        private string Money(object v)
        {
            if (v == null || v == DBNull.Value) return "";
            if (!decimal.TryParse(v.ToString(), out var d)) return "";
            return string.Format(CultureInfo.GetCultureInfo("vi-VN"), "{0:N0}đ", d);
        }

        private static int Clamp(int x) => Math.Max(1, Math.Min(10, x));

        private int ScoreCPU(string cpu)
        {
            cpu = (cpu ?? "").ToLowerInvariant();
            if (cpu.Contains("i9") || cpu.Contains("ryzen 9")) return 10;
            if (cpu.Contains("i7-13") || cpu.Contains("i7 13") || cpu.Contains("i7-14") || cpu.Contains("ryzen 7 7")) return 9;
            if (cpu.Contains("12400hx") || cpu.Contains("i5-12") || cpu.Contains("i7-12") || cpu.Contains("ryzen 7 5") || cpu.Contains("ryzen 5 7")) return 8;
            if (cpu.Contains(" u")) return 6;
            return 7;
        }

        private int ScoreGPU(string gpu)
        {
            gpu = (gpu ?? "").ToLowerInvariant();
            if (gpu.Contains("rtx 4090") || gpu.Contains("rtx 4080") || gpu.Contains("rtx 4070")) return 10;
            if (gpu.Contains("rtx 4060")) return 10;
            if (gpu.Contains("rtx 4050") || gpu.Contains("rtx 3060")) return 8;
            if (gpu.Contains("rtx 3050") || gpu.Contains("gtx")) return 7;
            if (gpu.Contains("780m")) return 7;
            if (gpu.Contains("iris xe")) return 5;
            if (gpu.Contains("uhd")) return 4;
            return 6;
        }

        private int ScoreThin(decimal? weightKg)
        {
            if (!weightKg.HasValue) return 5;
            var w = weightKg.Value;
            if (w <= 1.3m) return 9;
            if (w <= 1.5m) return 8;
            if (w <= 1.8m) return 7;
            if (w <= 2.2m) return 5;
            return 4;
        }

        private void SetAllMeters(int student, int office, int gaming, int dev, int design, int ai, int thin)
        {
            SetBar(barStudent, scoreStudent, student);
            SetBar(barOffice, scoreOffice, office);
            SetBar(barGaming, scoreGaming, gaming);
            SetBar(barDev, scoreDev, dev);
            SetBar(barDesign, scoreDesign, design);
            SetBar(barAI, scoreAI, ai);
            SetBar(barThin, scoreThin, thin);
        }

        private void SetBar(HtmlGenericControl bar, Literal lbl, int score)
        {
            var pct = Math.Max(0, Math.Min(100, score * 10));
            bar.Attributes["style"] = $"--val:{pct}%";
            lbl.Text = $"{score}/10";
        }
    }
}
