document.addEventListener('DOMContentLoaded', function () {
    const mainImg = document.getElementById('jsMainImg');
    const thumbs = Array.from(document.querySelectorAll('.jsThumb'));
    const buyBtn = document.querySelector('.btn-buy');
    const addBtn = document.querySelector('.btn-ghost');

    // Đổi ảnh khi click thumbnail
    thumbs.forEach(thumb => {
        thumb.addEventListener('click', function () {
            thumbs.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            mainImg.src = this.src;
        });
    });

    // Nút hành động
    buyBtn.addEventListener('click', () => {
        alert('Cảm ơn bạn đã mua hàng! Nhân viên sẽ liên hệ xác nhận đơn sớm nhất.');
    });

    addBtn.addEventListener('click', () => {
        alert('Sản phẩm đã được thêm vào giỏ hàng!');
    });
});
