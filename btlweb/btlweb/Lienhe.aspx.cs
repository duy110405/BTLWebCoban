using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace btlweb
{
    public partial class Lienhe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                errFullName.Visible = false;
                errEmail.Visible = false;
                errPhone.Visible = false;
                errMessage.Visible = false;
                lblStatusMessage.Text = "";
            }
        }
        protected void btnGuiYeuCau_Click(object sender , EventArgs e)
        {
            bool isValid = true;

            if (string.IsNullOrWhiteSpace(txtFullName.Text))
            {
                errFullName.Visible = true;
                isValid = false;
            }
            else
            {
                errFullName.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                errEmail.Visible = true;
                isValid = false;
            }
            else
            {
                errEmail.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                errPhone.Visible = true;
                isValid = false;
            }
            else
            {
                errPhone.Visible = false;
            }

            if (string.IsNullOrWhiteSpace(txtMessage.Text))
            {
                errMessage.Visible = true;
                isValid = false;
            }
            else
            {
                errMessage.Visible = false;
            }

            if (isValid)
            {
                // Xử lý gửi thông tin ở đây
                lblStatusMessage.Text = "Thông tin của bạn đã được gửi thành công!";
            }
            else
            {
                lblStatusMessage.Text = "";
            }
        }
    }
}