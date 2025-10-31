using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace btlweb
{
    public partial class khung : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HighlightCurrent();
                SetupBreadcrumb();
                BuildAccountMenu();
            }
            btnAdmin.Visible = IsAdmin();
        }

        private bool IsAdmin()
        {
            var username = Convert.ToString(Session["UserName"]);
            return !string.IsNullOrWhiteSpace(username)
                   && username.Equals("admin", StringComparison.OrdinalIgnoreCase);
        }

        private void HighlightCurrent()
        {
            var file = VirtualPathUtility.GetFileName(Request.AppRelativeCurrentExecutionFilePath) ?? "";
            void Active(System.Web.UI.WebControls.LinkButton b)
            {
                if (b == null) return;
                b.CssClass = (b.CssClass + " is-active").Trim();
                b.Attributes["aria-current"] = "page";
            }

            switch ((file ?? "").ToLower())
            {
                case "trangchu.aspx": Active(btnTrangChu); break;
                case "laptop.aspx": Active(btnSanPham); Active(btnLaptop); break;
                case "banphim.aspx": Active(btnSanPham); Active(btnBanPhim); break;
                case "pc.aspx": Active(btnSanPham); Active(btnPC); break;
                case "lienhe.aspx": Active(btnLienHe); break;
                case "gioithieu.aspx": Active(btnGioiThieu); break;
            }
        }

        private void SetupBreadcrumb()
        {
            var file = VirtualPathUtility.GetFileName(Request.AppRelativeCurrentExecutionFilePath) ?? "";
            if (file.Equals("Trangchu.aspx", StringComparison.OrdinalIgnoreCase))
            {
                breadcrumbWrap.Visible = false;
                return;
            }
            breadcrumbWrap.Visible = true;

            string label = Page.Title ?? "";
            switch (file.ToLower())
            {
                case "laptop.aspx": label = "Laptop"; break;
                case "banphim.aspx": label = "Bàn phím"; break;
                case "pc.aspx": label = "PC"; break;
                case "giohang.aspx": label = "Giỏ hàng"; break;
                case "taikhoan.aspx":
                case "chitiettaikhoan.aspx": label = "Tài khoản"; break;
                case "lienhe.aspx": label = "Liên hệ"; break;
                case "gioithieu.aspx": label = "Giới thiệu"; break;
            }
            litBreadcrumb.Text = $"<span class='current'>{Server.HtmlEncode(label)}</span>";
        }

        private void BuildAccountMenu()
        {
            bool loggedIn = (Session["UserId"] != null);
            pnlAccountGuest.Visible = !loggedIn;
            pnlAccountUser.Visible = loggedIn;
            if (loggedIn)
            {
                var name = Convert.ToString(Session["UserName"]);
                if (string.IsNullOrWhiteSpace(name)) name = "Tài khoản";
                litUserName.Text = Server.HtmlEncode(name);
            }
        }

        // Logo + nav
        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            if (!IsAdmin())
            {
                // Không phải admin -> đá về trang đăng nhập, kèm return
                Response.Redirect("Taikhoan.aspx?return=Admin.aspx&error=forbidden");
                return;
            }

            Response.Redirect("Admin.aspx");
        }

        protected void btnTrangChuLogo_Click(object sender, EventArgs e) { Response.Redirect("Trangchu.aspx"); }
        protected void btnTrangChu_Click(object sender, EventArgs e) { Response.Redirect("Trangchu.aspx"); }

        protected void btnTimKiem_Click(object sender, EventArgs e)
        {
            string searchTerm = txtTimKiem.Text.Trim();
            if (!string.IsNullOrEmpty(searchTerm))
                Response.Redirect($"Laptop.aspx?search={Server.UrlEncode(searchTerm)}");
            else
                Response.Redirect("Laptop.aspx");
        }

        // Account icon click: vào trang tài khoản phù hợp
        protected void btnAccount_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
                Response.Redirect("Chitiettaikhoan.aspx");
            else
                Response.Redirect("Taikhoan.aspx");
        }

        protected void lnkDangNhap_Click(object sender, EventArgs e) { Response.Redirect("Taikhoan.aspx"); }
        protected void lnkDangKy_Click(object sender, EventArgs e) { Response.Redirect("Taikhoan.aspx"); }
        protected void lnkDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Trangchu.aspx");
        }

        protected void btnGioHang_Click(object sender, EventArgs e) { Response.Redirect("Giohang.aspx"); }
        protected void btnBanPhim_Click(object sender, EventArgs e) { Response.Redirect("Banphim.aspx"); }
        protected void btnLaptop_Click(object sender, EventArgs e) { Response.Redirect("Laptop.aspx"); }
        protected void btnPC_Click(object sender, EventArgs e) { Response.Redirect("Pc.aspx"); }
        protected void btnLienHe_Click(object sender, EventArgs e) { Response.Redirect("Lienhe.aspx"); }
        protected void btnGioiThieu_Click(object sender, EventArgs e) { Response.Redirect("Gioithieu.aspx"); }

        // Search suggestions API
        public class ProductSuggestion
        {
            public int MaSP { get; set; }
            public string TenSP { get; set; }
            public decimal Gia { get; set; }
            public string AnhChinh { get; set; }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static System.Collections.Generic.List<ProductSuggestion> GetSearchSuggestions(string searchText)
        {
            var list = new System.Collections.Generic.List<ProductSuggestion>();
            var connStr = ConfigurationManager.ConnectionStrings["Baitaplonlaptrinhweb"].ConnectionString;
            if (string.IsNullOrWhiteSpace(searchText) || searchText.Length < 2) return list;

            const string sql = @"SELECT TOP 5 MaSP, TenSP, Gia, AnhChinh
                                 FROM dbo.SanPham
                                 WHERE TenSP LIKE @q
                                 ORDER BY TenSP";
            using (var con = new SqlConnection(connStr))
            using (var cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@q", "%" + searchText + "%");
                con.Open();
                using (var rd = cmd.ExecuteReader())
                {
                    while (rd.Read())
                    {
                        list.Add(new ProductSuggestion
                        {
                            MaSP = Convert.ToInt32(rd["MaSP"]),
                            TenSP = rd["TenSP"].ToString(),
                            Gia = Convert.ToDecimal(rd["Gia"]),
                            AnhChinh = rd["AnhChinh"].ToString()
                        });
                    }
                }
            }
            return list;
        }
    }
}
