using System;
using System.Configuration;
using System.Data.SqlClient;

namespace btlweb
{
    public partial class Taikhoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Nếu đã đăng nhập thì không cần vào nữa (tùy bạn dùng)
            // if (Session["UserId"] != null) Response.Redirect("Trangchu.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string user = (txtUsername.Text ?? "").Trim(); // email hoặc SĐT
            string pass = txtPassword.Text ?? "";

            if (string.IsNullOrWhiteSpace(user) || string.IsNullOrWhiteSpace(pass))
            {
                ShowError("Vui lòng nhập đầy đủ thông tin.");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["Baitaplonlaptrinhweb"].ConnectionString;

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = conn.CreateCommand())
                {
                    conn.Open();

                    // Cho phép đăng nhập bằng Email hoặc SĐT + mật khẩu chuỗi
                    cmd.CommandText = @"
SELECT TOP 1 Id, HoTen, Email
FROM dbo.NguoiDung
WHERE (Email = @u OR SoDienThoai = @u) AND MatKhau = @p";
                    cmd.Parameters.AddWithValue("@u", user);
                    cmd.Parameters.AddWithValue("@p", pass);

                    using (var rd = cmd.ExecuteReader())
                    {
                        if (rd.Read())
                        {
                            Session["UserId"] = rd.GetInt32(0);
                            Session["HoTen"] = rd["HoTen"] as string ?? "";
                            Session["UserEmail"] = rd["Email"] as string ?? "";

                            // Login ok: về trang chủ (hoặc nơi bạn muốn)
                            Response.Redirect("Trangchu.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                            return;
                        }
                    }

                    ShowError("Thông tin đăng nhập không đúng.");
                }
            }
            catch
            {
                ShowError("Không thể kết nối máy chủ. Thử lại sau.");
            }
        }

        private void ShowError(string msg)
        {
            ltMsg.Text = $"<div style='margin-top:10px;padding:10px 12px;border-radius:6px;font-size:14px;background:#ffe8e6;color:#a11;border:1px solid #f3b4ae'>{Server.HtmlEncode(msg)}</div>";
        }
    }
}
