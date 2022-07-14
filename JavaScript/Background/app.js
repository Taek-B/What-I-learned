// alert(1)
const h3 = document.querySelector('h3'); // 숨어있는 태그
const color1 = document.querySelector('.color1'); //색을 지정가능한 입력창
const color2 = document.querySelector('.color2'); //색을 지정가능한 입력창
const body = document.querySelector('body'); // 바디태그



// JS 이벤트 함수 addEventListener(a,b) a는 'click' 이벤트종류, b는 실행함수
color1.addEventListener('input', setGradient);
color2.addEventListener('input', setGradient);

function setGradient() {
    body.style.background = `linear-gradient(to right,${color1.value} , ${color2.value}, ${color3.value})`;
    h3.textContent = body.style.background + ";";
}



/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
color3을 추가해줘서 위에 함수 안에 color3도 추가해줌 */

// 자체적으로 만드는 중~
const color3 = document.querySelector('.color3');
color3.addEventListener('input', setGradient);