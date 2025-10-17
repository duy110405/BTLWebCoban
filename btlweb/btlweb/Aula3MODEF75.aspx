<%@ Page Title="" Language="C#" MasterPageFile="~/Khung.Master" AutoEventWireup="true" CodeBehind="Aula3MODEF75.aspx.cs" Inherits="btlweb.Aula3MODEF75" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/Aula3MODEF75.css" />
    <script src="js/Aula3MODEF75.js" defer></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
<div class="detail-wrap">
    <!-- CỘT TRÁI -->
    <section class="gallery-card card">
        <div class="main-img">
            <img id="jsMainImg" src='<%= ResolveUrl("~/anh/banphim1.jpg") %>' alt="Bàn phím Aula 3 MODE F75" />
        </div>

        <ul class="thumbs">
            <li><img class="jsThumb active" src='<%= ResolveUrl("~/anh/banphim1.jpg") %>' alt=""></li>
            <li><img class="jsThumb" src='<%= ResolveUrl("~/anh/banphim11.jpg") %>' alt=""></li>
            <li><img class="jsThumb" src='<%= ResolveUrl("~/anh/banphim12.jpg") %>' alt=""></li>
            <li><img class="jsThumb" src='<%= ResolveUrl("~/anh/banphim13.jpg") %>' alt=""></li>
            <li><img class="jsThumb" src='<%= ResolveUrl("~/anh/banphim14.jpg") %>' alt=""></li>
        </ul>

        <div class="specs">
            <h3>Thông số kỹ thuật chi tiết:</h3>

            <div class="kv">
                <div class="k">Kiểu dáng:</div><div class="v">Tenkeyless (87 phím)</div>
                <div class="k">Kết nối:</div><div class="v">Bluetooth / 2.4G / Có dây Type-C</div>
                <div class="k">Switch:</div><div class="v">Reaper switch (Hot-swap 5 pin)</div>
                <div class="k">Keycap:</div><div class="v">PBT Double-shot</div>
                <div class="k">Đèn:</div><div class="v">RGB 16.8 triệu màu</div>
                <div class="k">Pin:</div><div class="v">4000mAh, sạc Type-C</div>
                <div class="k">Trọng lượng:</div><div class="v">~975g</div>
                <div class="k">Phụ kiện:</div><div class="v">Cáp USB-C, dụng cụ thay switch, sách hướng dẫn</div>
            </div>

            <div class="info-block">
                <h4>Vận chuyển:</h4>
                <p>Miễn phí toàn quốc với đơn hàng trên 500.000đ</p>
            </div>

            <div class="info-block">
                <h4>Bảo hành & đổi trả:</h4>
                <p>Bảo hành 12 tháng chính hãng. Đổi mới trong 7 ngày nếu lỗi do nhà sản xuất.</p>
            </div>

            <div class="info-block">
                <h4>Mô tả sản phẩm:</h4>
                <p>Aula 3 MODE F75 là bàn phím cơ 3-mode cao cấp với khả năng kết nối linh hoạt, thiết kế hiện đại và cảm giác gõ êm ái. Phù hợp cho cả công việc lẫn chơi game.</p>
            </div>
        </div>
    </section>

    <!-- CỘT PHẢI -->
    <aside class="buy-card card">
        <h2 class="title">Aula 3 MODE F75 Mechanical Keyboard</h2>

        <label class="form-label">Phiên bản:</label>
        <select class="select">
            <option selected>Bluetooth + 2.4G + Type-C</option>
            <option>Có dây Type-C</option>
        </select>

        <label class="form-label">Màu sắc:</label>
        <div class="color-row">
            <button type="button" class="chip">Đen</button>
            <button type="button" class="chip">Trắng</button>
            <button type="button" class="chip">Xám</button>
        </div>

        <label class="form-label">Loại hàng:</label>
        <select class="select">
            <option>Mới, full box, chính hãng</option>
            <option>Like new</option>
        </select>

        <div class="price-row">
            <span>Giá niêm yết:</span>
            <strong class="price">1.290.000đ</strong>
        </div>

        <div class="action-row">
            <button type="button" class="btn btn-buy">Mua ngay</button>
            <button type="button" class="btn btn-ghost">Thêm vào giỏ hàng</button>
        </div>

        <div class="meter-box">
            <h3>Đánh giá hiệu năng:</h3>

            <div class="meter"><span class="label">Văn phòng:</span><div class="bar"><i style="--val:95%"></i></div><span class="score">9.5/10</span></div>
            <div class="meter"><span class="label">Gaming:</span><div class="bar"><i style="--val:90%"></i></div><span class="score">9/10</span></div>
            <div class="meter"><span class="label">Độ bền:</span><div class="bar"><i style="--val:100%"></i></div><span class="score">10/10</span></div>
            <div class="meter"><span class="label">Thẩm mỹ:</span><div class="bar"><i style="--val:85%"></i></div><span class="score">8.5/10</span></div>
        </div>
    </aside>
</div>
</asp:Content>
