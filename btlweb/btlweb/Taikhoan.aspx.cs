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
            string user = (txtUsername.Text ?? "").Trim(); // email hoặc sđt
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
                    cmd.CommandText = @"
SELECT TOP 1 Id, HoTen, Email, MatKhau, IsAdmin
FROM dbo.NguoiDung
WHERE (Email = @u OR SoDienThoai = @u)";
                    cmd.Parameters.AddWithValue("@u", user);

                    using (var rd = cmd.ExecuteReader())
                    {
                        if (!rd.Read())
                        {
                            ShowError("Email hoặc mật khẩu không đúng.");
                            return;
                        }

                        var dbPass = Convert.ToString(rd["MatKhau"]);
                        var email = Convert.ToString(rd["Email"]);
                        var hoTen = Convert.ToString(rd["HoTen"]);
                        var userId = Convert.ToInt32(rd["Id"]);
                        var isAdmin = rd["IsAdmin"] != DBNull.Value && Convert.ToBoolean(rd["IsAdmin"]);

                        // So khớp mật khẩu (nếu bạn dùng hash, thay bằng VerifyHash)
                        if (pass != dbPass)
                        {
                            ShowError("Email hoặc mật khẩu không đúng.");
                            return;
                        }

                        // ===== Set session CHUẨN =====
                        Session["UserId"] = userId;
                        Session["UserName"] = string.IsNullOrWhiteSpace(hoTen) ? email : hoTen; // cho menu
                        Session["UserEmail"] = email;
                        Session["HoTen"] = hoTen;
                        Session["IsAdmin"] = isAdmin;

                        // Nếu bạn muốn coi email cụ thể là admin dù IsAdmin=0:
                        // if (!isAdmin && email.Equals("admin123@gmail.com", StringComparison.OrdinalIgnoreCase)) 
                        //     Session["IsAdmin"] = true;

                        var ret = Request.QueryString["return"];
                        Response.Redirect(string.IsNullOrEmpty(ret) ? "Trangchu.aspx" : ret, false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }
                }

                // Không còn rd.Read() => rơi xuống đây là sai
                ShowError("Email hoặc mật khẩu không đúng.");
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
