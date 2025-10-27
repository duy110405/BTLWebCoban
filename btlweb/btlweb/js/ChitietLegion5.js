document.addEventListener('DOMContentLoaded', () => {
    /* ===== Gallery: đổi ảnh lớn theo thumbnail ===== */
    const mainImg = document.getElementById('jsMainImg');
    const thumbs = document.querySelectorAll('.jsThumb');
    if (thumbs.length) {
        thumbs.forEach(t => {
            t.addEventListener('click', () => {
                mainImg.src = t.src;               // nếu có ảnh lớn riêng, thay bằng t.dataset.large
                thumbs.forEach(x => x.classList.remove('active'));
                t.classList.add('active');
            });
        });
        thumbs[0].classList.add('active');
    }

    /* ===== Related scroller: nút trái/phải ===== */
    const track = document.getElementById('relTrack');
    const btnL = document.querySelector('.rel-arrow.left');
    const btnR = document.querySelector('.rel-arrow.right');

    if (track && btnL && btnR) {
        const cardWidth = () => {
            const card = track.querySelector('.p-card');
            if (!card) return 300;
            const style = getComputedStyle(track);
            const gap = parseFloat(style.columnGap || style.gap || 20);
            return card.getBoundingClientRect().width + gap;
        };

        const updateArrows = () => {
            const tol = 4;
            btnL.disabled = track.scrollLeft <= tol;
            btnR.disabled = track.scrollLeft + track.clientWidth >= track.scrollWidth - tol;
        };

        btnL.addEventListener('click', () => {
            track.scrollBy({ left: -cardWidth(), behavior: 'smooth' });
        });
        btnR.addEventListener('click', () => {
            track.scrollBy({ left: cardWidth(), behavior: 'smooth' });
        });

        track.addEventListener('scroll', updateArrows);
        window.addEventListener('resize', updateArrows);
        updateArrows();
    }
});
