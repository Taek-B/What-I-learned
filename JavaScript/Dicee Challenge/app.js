'use strict'
// 오류를 잡아준다?

const img1 = document.querySelector('.img1');
const img2 = document.querySelector('.img2');

// img1, img2에 JS 주사위6이 나오도록 한다.
img1.setAttribute('src', 'images/dice6.png');
img2.setAttribute('src', 'images/dice6.png');

// 랜덤 숫자를 1~6로 만들어서 randomNumber1에 입력
// Math.floor() = 소수점밑으로 숫자 제거한다.
// Math.random() = 숫자를 랜덤하게 나온다.



// 함수 생성
function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min; //최댓값도 포함, 최솟값도 포함
}
// 함수 이용했을 때
let randomNum1 = getRandomInt(1, 6);
let randomNum2 = getRandomInt(1, 6);

// 함수 이용 안했을 때
let randomNumber1 = Math.floor(Math.random() * 6) + 1;
let randomNumber2 = Math.floor(Math.random() * 6) + 1;



// 랜덤 숫자의 주사위 사진을 img들에게 나오게 한다.
img1.setAttribute('src', `images/dice${randomNumber1}.png`);
img2.setAttribute('src', `images/dice${randomNumber2}.png`);

// h1태그에 결과 나오게 하기
const h1 = document.querySelector('h1');

if (randomNumber1 > randomNumber2) {
    h1.textContent = '🚩Player1 Win!'
}
else if (randomNumber1 < randomNumber2) {
    h1.textContent = 'Player2 Win!🚩'
}
else {
    h1.textContent = 'Draw!'
}