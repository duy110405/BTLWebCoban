document.addEventListener("DOMContentLoaded", function () {
    // =============== CHUYỂN TAB =========================

    const root = document.querySelector('.account');
    if (!root) return;

    const nav = root.querySelector('.acc-nav');
    const links = root.querySelectorAll('.acc-link');
    const views = root.querySelectorAll('.view');
    const toggle = root.querySelector('.acc-nav-toggle');

    // Hàm lấy giá trị query string
    function qs(name) {
        return new URLSearchParams(location.search).get(name) || '';
    }

    // Hàm kích hoạt tab
    function activate(tab) {
        links.forEach(a => a.classList.toggle('active', a.dataset.tab === tab));
        views.forEach(v => v.classList.toggle('active', v.id === 'view-' + tab));
    }

    // Lấy tab hiện tại
    let tab = qs('tab') || 'orders';
    if (!root.querySelector('#view-' + tab)) tab = 'orders';
    activate(tab);

    // Khi click vào link tab
    links.forEach(a => {
        a.addEventListener('click', e => {
            e.preventDefault();
            const t = a.dataset.tab;
            history.pushState({}, '', '?tab=' + t);
            activate(t);

            if (nav.classList.contains('open')) {
                nav.classList.remove('open');
                toggle?.setAttribute('aria-expanded', 'false');
            }
        });
    });

    // Toggle menu tab khi ở mobile
    toggle?.addEventListener('click', () => {
        const open = nav.classList.toggle('open');
        toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
    });

    // Khi bấm nút Back/Forward trình duyệt
    window.addEventListener('popstate', () => {
        const t = qs('tab') || 'orders';
        activate(t);
    });

    // =============== CHECK FORM NHẬP ============
    // Hàm hiển thị lỗi
    function showJsError(input, message) {
        // Xóa js-error cạnh ô (nếu có)
        const next = input.nextElementSibling;
        if (next && next.classList && next.classList.contains('js-error')) next.remove();

        const span = document.createElement('span');
        span.className = 'js-error';
        span.textContent = message;
        input.insertAdjacentElement('afterend', span);
    }


    // Hàm kiểm tra form khi bấm "Thêm địa chỉ"
    window.ThemDiaChijs_Click = function () {
        // Xóa toàn bộ js-error cũ (không đụng label server .field-error)
        document.querySelectorAll('.js-error').forEach(n => n.remove());

        let valid = true;
        const hoten = document.getElementById('txtHoTen');
        const sdt = document.getElementById('txtSDT');
        const email = document.getElementById('txtEmail');
        const diachi = document.getElementById('txtDiaChi');

        if (!hoten.value.trim()) { showJsError(hoten, 'Họ tên không được để trống'); valid = false; }
        if (!/^\d{10}$/.test(sdt.value.trim())) { showJsError(sdt, 'SĐT phải đủ 10 số'); valid = false; }
        if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email.value.trim())) { showJsError(email, 'Email không hợp lệ'); valid = false; }
        if (!diachi.value.trim()) { showJsError(diachi, 'Địa chỉ không được để trống'); valid = false; }

        return valid; // false => chặn submit/postback
    };

});
