<%@ Page Title="" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="ChitietLegion5.aspx.cs" Inherits="btlweb.ChitietLegion5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/ChitietLegion5.css" />
    <script src="js/ChitietLegion5.js" defer></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="detail-wrap">
    <!-- CỘT TRÁI: GALLERY + THÔNG SỐ -->
    <section class="gallery-card card">
<!-- ẢNH LỚN -->
<!--        <div class="main-img">
          <img id="jsMainImg" src="anh/sp_legion_pro5.jpg" alt="Lenovo Legion Pro 5" />
        </div>

        <!-- THUMBNAILS 
        <ul class="thumbs">
          <li><img class="jsThumb" src="anh/sp_legion_pro5.jpg" data-large="anh/sp_legion_pro5.jpg" alt=""></li>
          <li><img class="jsThumb" src="anh/sp_legion_side.png"   data-large="anh/sp_legion_side.jpg"   alt=""></li>
          <li><img class="jsThumb" src="anh/sp_legion_open.jpg"   data-large="anh/sp_legion_open.jpg"   alt=""></li>
          <li><img class="jsThumb" src="anh/sp_legion_back.jpg"   data-large="anh/sp_legion_back.jpg"   alt=""></li>
          <li><img class="jsThumb" src="anh/sp_legion_ports.jpg"  data-large="anh/sp_legion_ports.jpg"  alt=""></li>
        </ul> -->

                <div class="main-img">
          <img id="jsMainImg" src='<%= ResolveUrl("~/anh/sp_legion_pro5") %>' alt="Lenovo Legion Pro 5" />
        </div>

        <!-- THUMBNAILS (KHÔNG cần data-large nếu dùng cùng file) -->
        <ul class="thumbs">
          <li><img class="jsThumb" src='<%= ResolveUrl("~/anh/sp_legion_pro5.jpg") %>' alt=""></li>
          <li><img class="jsThumb" src='<%= ResolveUrl("~/anh/sp_legion_side.png") %>' alt=""></li>
          <li><img class="jsThumb" src='<%= ResolveUrl("~/anh/sp_legion_open.png") %>' alt=""></li>
          <li><img class="jsThumb" src='<%= ResolveUrl("~/anh/sp_legion_back.png") %>' alt=""></li>
          <li><img class="jsThumb" src='<%= ResolveUrl("~/anh/sp_legion_port.png") %>' alt=""></li>
        </ul>
        

      <div class="specs">
        <h3>Cấu hình và đặc điểm chi tiết:</h3>

        <div class="kv">
          <div class="k">Loại CPU:</div><div class="v">Intel Core i5 12400HX, 24C/32T</div>
          <div class="k">Tốc độ:</div><div class="v">2.2GHz, Lên tới 5.8GHz</div>
          <div class="k">Bộ nhớ đệm:</div><div class="v">36MB</div>
          <div class="k">Card onboard:</div><div class="v">Intel UHD Graphics</div>
          <div class="k">Card rời:</div><div class="v">GeForce RTX 4060 6GB</div>
          <div class="k">Dung lượng:</div><div class="v">16GB DDR5 5600MHz</div>
          <div class="k">Hỗ trợ tối đa:</div><div class="v">16GB</div>
          <div class="k">Dung lượng SSD:</div><div class="v">512GB (M.2 2280 PCIe® 4.0x4 NVMe)</div>
        </div>

        <div class="info-block">
          <h4>Vận chuyển:</h4>
          <p>Miễn phí HN, TP HCM</p>
        </div>

        <div class="info-block">
          <h4>Bảo hành và đổi trả:</h4>
          <p>Bảo hành chính hãng 24 tháng Lenovo Việt Nam (12 tháng đầu bảo hành Premium Care). Đổi mới trong 15 ngày đầu tiên.</p>
        </div>

        <div class="info-block">
          <h4>Bài viết mô tả:</h4>
          <p>Sở hữu ngoại hình mạnh mẽ cùng cấu hình ấn tượng, Legion Pro 5 16IRX9 83DF0046VN hướng đến nhu cầu chiến game và đồ họa đỉnh cao.</p>
        </div>
      </div>
    </section>

    <!-- CỘT PHẢI: MUA HÀNG -->
    <aside class="buy-card card">
      <h2 class="title">Lenovo Legion Pro 5 16IRX9 83DF0047VN</h2>

      <label class="form-label">Phiên bản:</label>
      <select class="select">
        <option>i9 14900hx, Rtx 4070 8gb, 32gb, 1tb</option>
        <option selected>i5 12400hx, Rtx 4060 6gb, 16gb, 512tb, full hd 160hz</option>
      </select>

      <label class="form-label">Màu:</label>
      <div class="color-row">
        <button type="button" class="chip">Grey</button>
        <button type="button" class="chip">Black</button>
      </div>

      <label class="form-label">Loại hàng:</label>
      <select class="select">
        <option>Mới, full box, chính hãng</option>
        <option>Like new</option>
      </select>

      <div class="price-row">
        <span>Giá niêm yết:</span>
        <strong class="price">25.000.000đ</strong>
      </div>

      <div class="action-row">
        <button type="button" class="btn btn-buy">Mua ngay</button>
        <button type="button" class="btn btn-ghost">Thêm vào giỏ hàng</button>
      </div>

      <div class="meter-box">
        <h3>Hiệu năng:</h3>

        <div class="meter">
          <span class="label">Sinh viên:</span>
          <div class="bar"><i style="--val:80%"></i></div>
          <span class="score">8/10</span>
        </div>

        <div class="meter">
          <span class="label">Văn phòng:</span>
          <div class="bar"><i style="--val:50%"></i></div>
          <span class="score">5/10</span>
        </div>

        <div class="meter">
          <span class="label">Gaming:</span>
          <div class="bar"><i style="--val:100%"></i></div>
          <span class="score">10/10</span>
        </div>

        <div class="meter">
          <span class="label">Lập trình:</span>
          <div class="bar"><i style="--val:60%"></i></div>
          <span class="score">6/10</span>
        </div>

        <div class="meter">
          <span class="label">Đồ hoạ:</span>
          <div class="bar"><i style="--val:80%"></i></div>
          <span class="score">8/10</span>
        </div>

        <div class="meter">
          <span class="label">Laptop AI:</span>
          <div class="bar"><i style="--val:70%"></i></div>
          <span class="score">7/10</span>
        </div>

        <div class="meter">
          <span class="label">Mỏng nhẹ:</span>
          <div class="bar"><i style="--val:50%"></i></div>
          <span class="score">5/10</span>
        </div>
      </div>
    </aside>
  </div>
</asp:Content>
