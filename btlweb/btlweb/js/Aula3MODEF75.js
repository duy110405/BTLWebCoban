document.addEventListener("DOMContentLoaded", function () {
    const mainImg = document.getElementById("jsMainImg");
    const thumbs = document.querySelectorAll(".jsThumb");

    thumbs.forEach((thumb) => {
        thumb.addEventListener("click", () => {
            if (thumb.classList.contains("active")) return;

            // Hiệu ứng fade-out
            mainImg.classList.add("fade-out");

            setTimeout(() => {
                mainImg.src = thumb.src;
                mainImg.classList.remove("fade-out");
                mainImg.classList.add("fade-in");

                // Reset animation sau khi chạy
                setTimeout(() => mainImg.classList.remove("fade-in"), 300);
            }, 200);

            // Cập nhật active thumbnail
            thumbs.forEach((t) => t.classList.remove("active"));
            thumb.classList.add("active");
        });
    });
});
