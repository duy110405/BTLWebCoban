using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace btlweb
{
    public partial class Laptop : System.Web.UI.Page
    {
        private const int PageSize = 9;
        private string ConnStr => ConfigurationManager.ConnectionStrings["Baitaplonlaptrinhweb"].ConnectionString;

        private int PageIndex
        {
            get => ViewState["PageIndex"] is int i ? i : 1;
            set => ViewState["PageIndex"] = value < 1 ? 1 : value;
        }

        private int TotalRows
        {
            get => ViewState["TotalRows"] is int i ? i : 0;
            set => ViewState["TotalRows"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            btnApplyFilters.Click += BtnApplyFilters_Click;
            btnPrev.Click += BtnPrev_Click;
            btnNext.Click += BtnNext_Click;

            if (!IsPostBack)
            {
                LoadBrands();
                PageIndex = 1;

                // == PHẦN MỚI THÊM ==
                // Kiểm tra xem có từ khóa tìm kiếm từ QueryString không
                if (Request.QueryString["search"] != null)
                {
                    // Gán từ khóa vào ô text
                    txtSearch.Text = Request.QueryString["search"].ToString();
                }
                // ====================

                BindData();
            }
        }

        private void LoadBrands()
        {
            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand("SELECT MaNCC, TenNCC FROM dbo.NhaCungCap ORDER BY TenNCC", con))
            {
                con.Open();
                using (var rdr = cmd.ExecuteReader())
                {
                    ddlBrand.DataSource = rdr;
                    ddlBrand.DataTextField = "TenNCC";
                    ddlBrand.DataValueField = "MaNCC";
                    ddlBrand.DataBind();
                }
            }
        }

        private int GetMaLoaiLaptop()
        {
            if (ViewState["MaLoaiLaptop"] is int cached) return cached;

            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand("SELECT MaLoaiSP FROM dbo.LoaiSanPham WHERE TenLoai = N'Laptop'", con))
            {
                con.Open();
                var obj = cmd.ExecuteScalar();
                int id = (obj == null || obj == DBNull.Value) ? 0 : Convert.ToInt32(obj);
                ViewState["MaLoaiLaptop"] = id;
                return id;
            }
        }

        private void BindData()
        {
            int maLoai = GetMaLoaiLaptop();
            int? maNCC = string.IsNullOrWhiteSpace(ddlBrand.SelectedValue) ? (int?)null : Convert.ToInt32(ddlBrand.SelectedValue);

            decimal? minGia = null, maxGia = null;
            if (decimal.TryParse(txtMinPrice.Text.Replace(".", "").Replace(",", ""), out var g1)) minGia = g1;
            if (decimal.TryParse(txtMaxPrice.Text.Replace(".", "").Replace(",", ""), out var g2)) maxGia = g2;

            string search = string.IsNullOrWhiteSpace(txtSearch.Text) ? null : txtSearch.Text.Trim();
            string sort = ddlSort.SelectedValue;

            using (var con = new SqlConnection(ConnStr))
            using (var cmd = new SqlCommand("dbo.usp_SanPham_FilterPage", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MaLoaiSP", (object)maLoai ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MaNCC", (object)maNCC ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MinGia", (object)minGia ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MaxGia", (object)maxGia ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@SearchText", (object)search ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Sort", string.IsNullOrEmpty(sort) ? "moi-nhat" : sort);
                cmd.Parameters.AddWithValue("@PageIndex", PageIndex);
                cmd.Parameters.AddWithValue("@PageSize", PageSize);

                con.Open();
                var ds = new DataSet();
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }

                var dt = ds.Tables.Count > 0 ? ds.Tables[0] : null;
                var dtCount = ds.Tables.Count > 1 ? ds.Tables[1] : null;

                rptProducts.DataSource = dt;
                rptProducts.DataBind();

                if (dtCount != null && dtCount.Rows.Count > 0)
                    TotalRows = Convert.ToInt32(dtCount.Rows[0]["TotalRows"]);
                else
                    TotalRows = 0;

                litTotal.Text = TotalRows.ToString("N0");

                UpdatePagerUI();
            }
        }

        private void UpdatePagerUI()
        {
            int totalPages = (int)Math.Ceiling((double)Math.Max(TotalRows, 0) / PageSize);
            if (totalPages == 0) totalPages = 1;

            if (PageIndex > totalPages) PageIndex = totalPages;

            btnPrev.Enabled = PageIndex > 1;
            btnNext.Enabled = PageIndex < totalPages;

            lblPageInfo.Text = $"Trang {PageIndex:N0}/{totalPages:N0}";
        }

        private void BtnApplyFilters_Click(object sender, EventArgs e)
        {
            PageIndex = 1;
            BindData();
        }

        private void BtnPrev_Click(object sender, EventArgs e)
        {
            if (PageIndex > 1)
            {
                PageIndex--;
                BindData();
            }
        }

        private void BtnNext_Click(object sender, EventArgs e)
        {
            int totalPages = (int)Math.Ceiling((double)Math.Max(TotalRows, 0) / PageSize);
            if (PageIndex < totalPages)
            {
                PageIndex++;
                BindData();
            }
        }
    }
}