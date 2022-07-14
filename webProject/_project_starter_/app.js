const panels = document.querySelectorAll('.panel');
const active = document.querySelector('.active');

// 밑에 함수랑 똑같이 돌아가는 함수
/*
for (let i = 0; i < panels.length; i++) {
    panels[i].addEventListener('click', function () {
        panels.forEach(panel => {
            panel.classList.remove('active');
        })
        panels[i].classList.add('active');
    });
}
*/

// ↓↓↓↓↓↓↓↓사진 확대 하는 함수??↓↓↓↓↓↓↓↓↓↓↓↓↓
panels.forEach(function (panel) {
    // console.log(panel);
    panel.addEventListener('mouseenter', function () {
        removeActiveClass();
        panel.classList.add('active');
    })
})

// active제거 함수 만들기
function removeActiveClass() {
    panels.forEach(function (panel) {
        panel.classList.remove('active');
    })
}
// ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
