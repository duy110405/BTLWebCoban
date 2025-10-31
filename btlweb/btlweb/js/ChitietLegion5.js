document.addEventListener('DOMContentLoaded', () => {
    /* ===== Gallery ===== */
    const mainImg = document.getElementById('jsMainImg');
    const thumbs = document.querySelectorAll('.jsThumb');
    if (mainImg && thumbs.length) {
        thumbs.forEach(t => {
            t.addEventListener('click', (e) => {
                e.preventDefault();
                mainImg.src = t.src || t.getAttribute('src');
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
            const noScroll = track.scrollWidth <= track.clientWidth + tol;
            btnL.disabled = noScroll || track.scrollLeft <= tol;
            btnR.disabled = noScroll || (track.scrollLeft + track.clientWidth >= track.scrollWidth - tol);
        };

        btnL.addEventListener('click', (e) => {
            e.preventDefault();
            track.scrollBy({ left: -cardWidth(), behavior: 'smooth' });
        });
        btnR.addEventListener('click', (e) => {
            e.preventDefault();
            track.scrollBy({ left: cardWidth(), behavior: 'smooth' });
        });

        track.addEventListener('scroll', updateArrows);
        window.addEventListener('resize', updateArrows);
        updateArrows();
    }

    /* ===== Tabs “Sản phẩm tương tự” / “Đánh giá” ===== */
    const tabsWrap = document.querySelector('.rel-tabs'); // delegation cho chắc
    const btnSimilar = document.getElementById('btnSimilar');
    const btnReview = document.getElementById('btnReview');
    const similarSection = document.getElementById('similarSection');
    const reviewSection = document.getElementById('reviewSection');

    const setTab = (tab) => {
        const isSimilar = tab === 'similar';
        btnSimilar.classList.toggle('active', isSimilar);
        btnReview.classList.toggle('active', !isSimilar);
        btnSimilar.setAttribute('aria-selected', String(isSimilar));
        btnReview.setAttribute('aria-selected', String(!isSimilar));

        // Ẩn/hiện bằng class
        similarSection.classList.toggle('is-hidden', !isSimilar);
        reviewSection.classList.toggle('is-hidden', isSimilar);
    };

    if (tabsWrap) {
        tabsWrap.addEventListener('click', (e) => {
            const btn = e.target.closest('button.rel-tab');
            if (!btn) return;
            e.preventDefault();
            setTab(btn.id === 'btnSimilar' ? 'similar' : 'review');
        });
        setTab('similar'); // mặc định mở tab Sản phẩm tương tự
    }

    /* ===== Gửi đánh giá ===== */
    const btnSendReview = document.getElementById('btnSendReview');
    const reviewList = document.getElementById('reviewList');

    if (btnSendReview && reviewList) {
        btnSendReview.addEventListener('click', (e) => {
            e.preventDefault();

            const nameEl = document.getElementById('reviewName');
            const ratingEl = document.getElementById('reviewRating');
            const textEl = document.getElementById('reviewText');

            const name = (nameEl?.value || '').trim();
            const text = (textEl?.value || '').trim();
            let ratingNum = parseInt(ratingEl?.value, 10);
            if (Number.isNaN(ratingNum)) ratingNum = 5;
            ratingNum = Math.max(1, Math.min(5, ratingNum));

            if (!name || !text) {
                alert('Vui lòng nhập tên và nội dung đánh giá!');
                return;
            }

            const starsStr = '★'.repeat(ratingNum) + '☆'.repeat(5 - ratingNum);

            const div = document.createElement('div');
            div.className = 'review';

            const strong = document.createElement('strong');
            strong.textContent = name;

            const spanStars = document.createElement('span');
            spanStars.className = 'stars';
            spanStars.textContent = starsStr;

            const p = document.createElement('p');
            p.textContent = text;

            div.appendChild(strong);
            div.appendChild(document.createTextNode(' '));
            div.appendChild(spanStars);
            div.appendChild(p);

            reviewList.prepend(div);

            if (nameEl) nameEl.value = '';
            if (textEl) textEl.value = '';
            if (ratingEl) ratingEl.value = '5';
        });
    }
});
