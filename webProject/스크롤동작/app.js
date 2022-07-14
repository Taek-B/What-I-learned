//모든 박스를 boxes 상수에 저장
const boxes = document.querySelectorAll('.box');
//윈도우창에서 스크롤하면 => checkBoxes 함수 실행
window.addEventListener('scroll', checkBoxes);
//처음 시작시 실행
checkBoxes();

function checkBoxes() {
    //윈도우 창의 아래쪽 px 을 약간 높게(박스를 보여주거나 사라지는 트리거포인트)
    //window.innerHeight : 화면창의 크기 
    const triggerBottom = (window.innerHeight / 5) * 4;

    boxes.forEach((box) => {
        //모든 박스에 상단 높이
        const boxTop = box.getBoundingClientRect().top;
        // 박스높이 < 트리거포인트 => 박스 보이기(박스에 클래스 show 달기)
        if (boxTop < triggerBottom) {
            box.classList.add('show');
        } else {
            //박스 안보이기(박스에 클래스 show 삭제)
            box.classList.remove('show');
        }
    });
}

const addButton = document.querySelector('btn');

addButton.addEventListener('click', () => {
    const input = document.querySelector('#input');
    const text = input.value.trim();

});