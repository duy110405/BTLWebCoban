<%@ Page Title="Chi tiết PC Lenovo ThinkCentre" Language="C#" MasterPageFile="~/khung.Master" AutoEventWireup="true" CodeBehind="LenovoThinkCentre.aspx.cs" Inherits="btlweb.LenovoThinkCentre" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/LenovoThinkCentre.css" />
    <script src="js/LenovoThinkCentre.js" defer></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">

    <div class="detail-wrap">
      <!-- CỘT TRÁI: GALLERY + THÔNG SỐ -->
      <section class="gallery-card card">
        <div class="main-img">
          <img id="jsMainImg" src="anh/pc1.jpg" alt="PC Lenovo ThinkCentre Neo 50T G5" />
        </div>

        <ul class="thumbs" id="jsThumbs">
          <li><img class="jsThumb active" src="anh/pc1.jpg" alt="front"></li>
          <li><img class="jsThumb" src="anh/pc11.jpg" alt="side"></li>
          <li><img class="jsThumb" src="anh/pc12.jpg" alt="open"></li>
          <li><img class="jsThumb" src="anh/pc13.jpg" alt="back"></li>
          <li><img class="jsThumb" src="anh/pc14.jpg" alt="ports"></li>
        </ul>

        <div class="specs">
          <h3>Cấu hình và đặc điểm chi tiết:</h3>

          <div class="kv">
            <div class="k">Dòng CPU:</div><div class="v">Core i3</div>
            <div class="k">Mã CPU:</div><div class="v">14100</div>
            <div class="k">Tốc độ CPU:</div><div class="v">3.40GHz (Up to 4.70GHz)</div>
            <div class="k">Số lõi / luồng:</div><div class="v">4 Cores / 8 Threads</div>
            <div class="k">Bộ nhớ đệm:</div><div class="v">12MB Cache</div>
            <div class="k">Chipset:</div><div class="v">Intel B760</div>

            <div class="k">Dung lượng RAM:</div><div class="v">8GB DDR5 4800</div>
            <div class="k">Hỗ trợ RAM tối đa:</div><div class="v">Up to 64GB DDR5-5600 (2 khe UDIMM)</div>
            <div class="k">Khe cắm RAM:</div><div class="v">2 khe RAM</div>

            <div class="k">Ổ cứng:</div><div class="v">512GB SSD (M.2)</div>
            <div class="k">Chuẩn ổ:</div><div class="v">Hỗ trợ tối đa: 3 ổ (1 x 3.5" HDD, 1 x 2.5" HDD, 1 x M.2)</div>

            <div class="k">Card đồ họa:</div><div class="v">Intel UHD Graphics 730 (onboard)</div>
            <div class="k">Kết nối không dây:</div><div class="v">Wi-Fi 6 AX201 + Bluetooth 5.1</div>

            <div class="k">Cổng trước:</div><div class="v">1×USB-C, 4×USB-A, 1×Headphone/Mic</div>
            <div class="k">Cổng sau:</div><div class="v">HDMI 2.1, DisplayPort 1.4a, VGA, RJ45...</div>

            <div class="k">Khe mở rộng:</div><div class="v">1×PCIe4.0 x16, 2×PCIe3.0 x1, 2×M.2</div>
            <div class="k">Hệ điều hành:</div><div class="v">Windows 11</div>
            <div class="k">Bộ nguồn:</div><div class="v">180W (85%)</div>

            <div class="k">Kích thước:</div><div class="v">145 x 294 x 340 mm</div>
            <div class="k">Trọng lượng:</div><div class="v">~5.5 kg</div>

            <div class="k">Phụ kiện:</div><div class="v">Bàn phím USB Calliope, Chuột USB Calliope</div>
            <div class="k">Bảo hành:</div><div class="v">1 năm</div>
          </div>

          <div class="info-block">
            <h4>Vận chuyển:</h4>
            <p>Miễn phí HN, TP.HCM (xem chi tiết khu vực)</p>
          </div>

          <div class="info-block">
            <h4>Bảo hành:</h4>
            <p>Bảo hành chính hãng 12 tháng. Hỗ trợ đổi trả theo điều kiện của cửa hàng.</p>
          </div>

          <div class="info-block">
            <h4>Mô tả ngắn:</h4>
            <p>Máy tính cấu hình Core i3 14100, phù hợp cho văn phòng, học tập và giải trí nhẹ. Case nhỏ gọn, kèm bàn phím và chuột.</p>
          </div>
        </div>
      </section>

      <!-- CỘT PHẢI: MUA HÀNG -->
      <aside class="buy-card card">
        <h2 class="title">PC Lenovo ThinkCentre - Core i3 14100 | 8GB DDR5 | 512GB SSD</h2>

        <label class="form-label">Phiên bản:</label>
        <select class="select">
          <option>i3 14100, 8GB, 512GB SSD</option>
          <option>i3 14100, 16GB, 1TB SSD</option>
        </select>

        <label class="form-label">Màu:</label>
        <div class="color-row">
          <button type="button" class="chip">Đen</button>
          <button type="button" class="chip">Xám</button>
        </div>

        <label class="form-label">Tình trạng:</label>
        <select class="select">
          <option selected>Mới, full box, chính hãng</option>
          <option>Like new</option>
        </select>

        <div class="price-row">
          <span>Giá niêm yết:</span>
          <strong class="price">10.590.000đ</strong>
        </div>

        <div class="action-row">
          <button type="button" class="btn btn-buy">Mua ngay</button>
          <button type="button" class="btn btn-ghost">Thêm vào giỏ hàng</button>
        </div>

        <div class="meter-box">
          <h3>Hiệu năng:</h3>

          <div class="meter">
            <span class="label">Sinh viên:</span>
            <div class="bar"><i style="--val:70%"></i></div>
            <span class="score">7/10</span>
          </div>

          <div class="meter">
            <span class="label">Văn phòng:</span>
            <div class="bar"><i style="--val:85%"></i></div>
            <span class="score">8.5/10</span>
          </div>

          <div class="meter">
            <span class="label">Gaming nhẹ:</span>
            <div class="bar"><i style="--val:40%"></i></div>
            <span class="score">4/10</span>
          </div>

          <div class="meter">
            <span class="label">Lưu trữ:</span>
            <div class="bar"><i style="--val:60%"></i></div>
            <span class="score">6/10</span>
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
