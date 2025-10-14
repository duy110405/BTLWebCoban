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

        }
        protected void btnGuiYeuCau_Click(object sender , EventArgs e)
        {
            txtFullName.Text = txtEmail.Text = txtPhone.Text = txtMessage.Text = "" ;
            lblStatusMessage.Text = "Bạn đã gửi yêu cầu thành công";
        }
    }
}