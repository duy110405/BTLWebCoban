using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace btlweb
{
    public partial class khung : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnTrangChuLogo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Trangchu.aspx");
        }

        protected void btnTrangChu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Trangchu.aspx");
        }
        protected void btnTimKiem_Click(object sender, EventArgs e)
        {
        }

        protected void btnTaiKhoan_Click(object sender, EventArgs e)
        {
            Response.Redirect("Taikhoan.aspx");
        }

        protected void btnGioHang_Click(object sender, EventArgs e)
        {
            Response.Redirect("Giohang.aspx");
        }

        protected void btnBanPhim_Click(object sender, EventArgs e)
        {
            Response.Redirect("Banphim.aspx");
        }

        protected void btnLaptop_Click(object sender, EventArgs e)
        {
            Response.Redirect("Laptop.aspx");
        }

        protected void btnPC_Click(object sender, EventArgs e)
        {
            Response.Redirect("Pc.aspx");
        }

        protected void btnLienHe_Click(object sender, EventArgs e)
        {
            Response.Redirect("Lienhe.aspx");
        }

        protected void btnGioiThieu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Gioithieu.aspx");
        }
    }
}