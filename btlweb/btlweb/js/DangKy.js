document.addEventListener("DOMContentLoaded", function () {
    // Hàm hiển thị lỗi
    function showJsError(input, message) {
        const container = input.closest('.auth-field');
        // Xóa lỗi cũ trong phạm vi container
        if (container) {
            container.querySelectorAll('.js-error').forEach(n => n.remove());
        } else {
            //Xóa lỗi cũ theo cách ban đầu
            const next = input.nextElementSibling;
            if (next && next.classList && next.classList.contains('js-error')) next.remove();
        }
        const span = document.createElement('span');
        span.className = 'js-error';
        span.textContent = message;
        if (container && (input.type === 'radio' || input.type === 'checkbox')) {
            // Nếu là Radio Button/Checkbox chèn vào cuối container
            container.appendChild(span);
        } else {
            // Với các input text chèn ngay sau input
            input.insertAdjacentElement('afterend', span);
        }
    }

    window.Dangkyjs_Click = function () {
        // Xóa toàn bộ thông báo lỗi cũ
        document.querySelectorAll('.js-error').forEach(n => n.remove());
        let valid = true;

        const ho = document.getElementById('txtHo');
        const ten = document.getElementById('txtTen');
        const email = document.getElementById('txtEmail');
        const phone = document.getElementById('txtPhone');
        const pass = document.getElementById('txtPass');
        const pass2 = document.getElementById('txtPass2');

        // ==== Kiểm tra dữ liệu ====
        if (!ho.value.trim()) {
            showJsError(ho, 'Họ không được để trống');
            valid = false;
        }
        if (!ten.value.trim()) {
            showJsError(ten, 'Tên không được để trống');
            valid = false;
        }
        if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email.value.trim())) {
            showJsError(email, 'Email không hợp lệ');
            valid = false;
        }
        if (!/^\d{10}$/.test(phone.value.trim())) {
            showJsError(phone, 'Số điện thoại phải đủ 10 chữ số');
            valid = false;
        }
        if (!/^\d{6,}$/.test(pass.value.trim())) {
            showJsError(pass, 'Mật khẩu phải có ít nhất 6 chữ số');
            valid = false;
        }
        if (pass2.value.trim() !== pass.value.trim()) {
            showJsError(pass2, 'Mật khẩu nhập lại không khớp');
            valid = false;
        }

        // Nếu có lỗi => chặn postback
        return valid;
    };

});