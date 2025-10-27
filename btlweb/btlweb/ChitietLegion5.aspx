<%@ Page Title="" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="ChitietLegion5.aspx.cs" Inherits="btlweb.ChitietLegion5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/ChitietLegion5.css" />
    <script src="js/ChitietLegion5.js" defer></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="detail-wrap">
    <!-- LEFT: GALLERY + SPECS -->
    <section class="gallery-card card">
      <div class="main-img">
        <img id="jsMainImg" src='<%= ResolveUrl("~/anh/sp_legion_pro5.jpg") %>' alt="Lenovo Legion Pro 5" />
      </div>

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

    <!-- RIGHT: BUY BOX -->
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

  <!-- ===================== RELATED ===================== -->
  <section class="rel-section" aria-label="Sản phẩm tương tự">
    <h3 class="rel-title">Sản phẩm tương tự</h3>

    <div class="rel-track-wrap">
      <button type="button" class="rel-arrow left" aria-label="Sản phẩm trước">‹</button>

      <div id="relTrack" class="rel-track">
        <!-- 1 -->
        <article class="p-card">
          <div class="p-img">
            <img src="anh/sp_legion_pro5.jpg" alt="Laptop Legion pro 5">
          </div>
          <a class="p-name" href="#">Laptop Legion pro 5</a>
          <p class="p-spec">i5 12400hx • RTX 4060 • 16GB • 512GB • 16” FHD</p>
          <div class="p-price">25.000.000đ</div>
        </article>

        <!-- 2 -->
        <article class="p-card">
          <div class="p-img">
            <img src="anh/sp_rog_strix16.jpg" alt="Laptop rog strix 16">
          </div>
          <a class="p-name" href="#">Laptop rog strix 16</a>
          <p class="p-spec">i7 12900hx • RTX 4070 • 32GB • 1TB • 16” QHD</p>
          <div class="p-price">45.000.000đ</div>
        </article>

        <!-- 3 -->
        <article class="p-card">
          <div class="p-img">
            <img src="anh/sp_yoga9i.jpg" alt="Lenovo yoga 9i">
          </div>
          <a class="p-name" href="#">Laptop lenovo yoga 9i</a>
          <p class="p-spec">R7 7840HS • 780M • 32GB • 1TB • 14” QHD</p>
          <div class="p-price">35.000.000đ</div>
        </article>

        <!-- 4 -->
        <article class="p-card">
          <div class="p-img">
            <img src="anh/sp_xps14.jpg" alt="Dell XPS 14">
          </div>
          <a class="p-name" href="#">Dell XPS 14</a>
          <p class="p-spec">i7-1260P • Iris Xe • 16GB • 512GB • 14” FHD</p>
          <div class="p-price">40.000.000đ</div>
        </article>

        <!-- 5 -->
        <article class="p-card">
          <div class="p-img">
            <img src="anh/sp_thinkbook14p.jpg" alt="ThinkBook 14p">
          </div>
          <a class="p-name" href="#">ThinkBook 14p</a>
          <p class="p-spec">R7 5800U • Vega 8 • 16GB • 512GB • 14” FHD</p>
          <div class="p-price">15.000.000đ</div>
        </article>
      </div>

      <button type="button" class="rel-arrow right" aria-label="Sản phẩm tiếp">›</button>
    </div>
  </section>
</asp:Content>
