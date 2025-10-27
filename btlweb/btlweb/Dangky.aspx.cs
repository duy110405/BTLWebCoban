using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace btlweb
{
    public partial class Dangky : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            string ho = (txtHo.Text ?? "").Trim();
            string ten = (txtTen.Text ?? "").Trim();
            string hoTen = (ho + " " + ten).Trim();

            string email = (txtEmail.Text ?? "").Trim();
            string phone = (txtPhone.Text ?? "").Trim();
            string pass = txtPass.Text ?? "";
            string pass2 = txtPass2.Text ?? "";

            // Validate nhẹ
            if (string.IsNullOrWhiteSpace(hoTen) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(pass))
            {
                ShowError("Vui lòng nhập đầy đủ Họ tên, Email và Mật khẩu.");
                return;
            }
            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ShowError("Email không hợp lệ.");
                return;
            }
            if (pass.Length < 6)
            {
                ShowError("Mật khẩu tối thiểu 6 ký tự.");
                return;
            }
            if (!string.Equals(pass, pass2, StringComparison.Ordinal))
            {
                ShowError("Mật khẩu nhập lại không khớp.");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["Baitaplonlaptrinhweb"].ConnectionString;

            try
            {
                using (var conn = new SqlConnection(connStr))
                using (var cmd = conn.CreateCommand())
                {
                    conn.Open();

                    // Check trùng email
                    cmd.CommandText = "SELECT COUNT(1) FROM dbo.NguoiDung WHERE Email = @Email";
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Email", email);
                    int exists = Convert.ToInt32(cmd.ExecuteScalar());
                    if (exists > 0)
                    {
                        ShowError("Email đã tồn tại. Vui lòng dùng email khác.");
                        return;
                    }

                    // Insert (mật khẩu plain theo yêu cầu)
                    cmd.CommandText = @"
INSERT INTO dbo.NguoiDung(HoTen, Email, MatKhau, SoDienThoai)
VALUES (@HoTen, @Email, @MatKhau, @SoDienThoai);";
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@HoTen", hoTen);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@MatKhau", pass);
                    cmd.Parameters.AddWithValue("@SoDienThoai", string.IsNullOrWhiteSpace(phone) ? (object)DBNull.Value : phone);

                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        // Báo nhẹ rồi điều hướng sang trang đăng nhập
                        ShowOk("Đăng ký thành công. Đang chuyển tới trang đăng nhập...");
                        Response.Redirect("Taikhoan.aspx", false);  // tránh ThreadAbortException
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }

                    ShowError("Không thể tạo tài khoản. Thử lại sau.");
                }
            }
            catch (Exception)
            {
                ShowError("Có lỗi khi lưu dữ liệu. Vui lòng thử lại.");
            }
        }

        private void ShowError(string msg)
        {
            ltMsg.Text = $"<div class='auth-msg error'>{Server.HtmlEncode(msg)}</div>";
        }

        private void ShowOk(string msg)
        {
            ltMsg.Text = $"<div class='auth-msg ok'>{Server.HtmlEncode(msg)}</div>";
        }
    }
}
