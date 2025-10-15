(function () {
    const main = document.getElementById('jsMainImg');
    const thumbs = Array.from(document.querySelectorAll('.jsThumb'));
    if (!main || !thumbs.length) return;

    function setActive(img) {
        // đổi ảnh lớn = đúng ảnh của thumbnail
        main.src = img.currentSrc || img.src;
        thumbs.forEach(t => t.classList.remove('active'));
        img.classList.add('active');
    }

    // active ban đầu
    setActive(thumbs[0]);

    // click + bàn phím
    thumbs.forEach(img => {
        img.tabIndex = 0;
        img.setAttribute('role', 'button');
        img.addEventListener('click', () => setActive(img));
        img.addEventListener('keydown', e => {
            if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); setActive(img); }
        });
    });
})();