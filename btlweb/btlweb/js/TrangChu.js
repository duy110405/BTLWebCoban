document.addEventListener('DOMContentLoaded', function () {
    /* ===== Cuộn mượt từ banner ===== */
    const smoothGo = (hash) => {
        const el = document.querySelector(hash);
        if (!el) return;
        const top = el.getBoundingClientRect().top + window.pageYOffset - 8;
        window.scrollTo({ top, behavior: 'smooth' });
    };

    const ctaLike = document.querySelector('a[href="#bancothethich"]');
    const ctaFlash = document.querySelector('a[href="#flash"]');
    ctaLike?.addEventListener('click', (e) => { e.preventDefault(); smoothGo('#bancothethich'); });
    ctaFlash?.addEventListener('click', (e) => { e.preventDefault(); smoothGo('#flash'); });

    /* ================================================== GỢI Ý HÔM NAY ============================== */
    const goiy = document.querySelector('.section[data-tabs]');
    if (goiy) {
        const tabs = Array.from(goiy.querySelectorAll('.tabs .tab'));
        const panels = Array.from(goiy.querySelectorAll('.panel'));

        // Ngăn nút <button> bị submit WebForms
        tabs.forEach(btn => btn.setAttribute('type', 'button'));

        function showPanel(selector) {
            panels.forEach(p => {
                const on = ('#' + p.id) === selector;
                p.classList.toggle('is-active', on);
                p.classList.toggle('hidden', !on);
                p.style.display = on ? 'block' : 'none';
            });
        }

        const current = tabs.find(t => t.classList.contains('is-active')) || tabs[0];
        showPanel(current.getAttribute('data-target'));

        goiy.querySelector('.tabs')?.addEventListener('click', (e) => {
            const btn = e.target.closest('.tab');
            if (!btn) return;
            tabs.forEach(t => t.classList.toggle('is-active', t === btn));
            showPanel(btn.getAttribute('data-target'));
        });
    }

    /* ================================================== BẠN CÓ THỂ THÍCH ============================== */
    const likeSection = document.querySelector('#bancothethich');
    if (likeSection) {
        const tabs = Array.from(likeSection.querySelectorAll('.chips .tab'));
        const panels = Array.from(likeSection.querySelectorAll('.panel, .panel-hidden'));

        tabs.forEach(btn => btn.setAttribute('type', 'button'));

        function showPanel(selector) {
            panels.forEach(p => {
                const on = ('#' + p.id) === selector;
                p.classList.toggle('is-active', on);
                p.style.display = on ? 'block' : 'none';
            });
        }

        // Mặc định mở Laptop
        const current = tabs.find(t => t.classList.contains('is-active')) || tabs[0];
        showPanel(current.getAttribute('data-target'));

        // Khi bấm tab
        likeSection.querySelector('.chips')?.addEventListener('click', (e) => {
            const btn = e.target.closest('.tab');
            if (!btn) return;
            tabs.forEach(t => t.classList.toggle('is-active', t === btn));
            showPanel(btn.getAttribute('data-target'));
        });
    }
});
