document.addEventListener("DOMContentLoaded", function () {
    // Hàm hiển thị lỗi
    function showJsError(input, message) {
        // Xóa lỗi cũ cạnh ô
        const next = input.nextElementSibling;
        if (next && next.classList && next.classList.contains('js-error')) next.remove();

        const span = document.createElement('span');
        span.className = 'js-error';
        span.textContent = message;
        input.insertAdjacentElement('afterend', span);
    }
    window.btnLoginJs_Click = function () {
        // Xóa toàn bộ thông báo lỗi cũ
        document.querySelectorAll('.js-error').forEach(n => n.remove());
        let valid = true;

        const username = document.getElementById('txtUsername');
        const password = document.getElementById('txtPassword');

        //kiểm tra dữ liệu 
        if (!username.value.trim()) {
            showJsError(username, 'Tên đăng nhập không được để trống');
            valid = false;
        }
        if (!password.value.trim()) {
            showJsError(password, 'Mật khẩu không được để trống');
            valid = false;
        }
        // Nếu có lỗi => chặn postback
        return valid;
    };
});