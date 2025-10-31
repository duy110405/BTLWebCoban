using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace btlweb
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var username = Convert.ToString(Session["UserName"]);
            if (!"admin123@gmail.com".Equals(username, StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Taikhoan.aspx?return=Admin.aspx&error=forbidden");
                return;
            }
            if (!IsPostBack)
            {     
            }

        }
    }
}