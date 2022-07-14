// %표시 글자 , 벡그라운드 객체 상수로 저장
const loadText = document.querySelector('.loading-text');
const bg = document.querySelector('.bg');
// 로딩 숫자 초기값 0
let load = 0;

// setInterval : 함수를 주기적으로 실행 
let int = setInterval(blurring, 30);    // 시간 0.03초에 한번씩 blurring 함수 실행

function blurring() {
    load++;
    //console.log(load);
    if (load > 99) {
        //로드가 숫자 100이상이면 clearInterval(인터벌객체이름) 으로 해제한다.
        // clearInterval : setInterval를 중단시킴
        clearInterval(int);
    }

    loadText.textContent = `${load}%` //load 변수를 벡틱으로 표시한다.
    loadText.style.opacity = scale(load, 0, 100, 1, 0);  //(0~100) => (1,0) 으로 변경한다.
    bg.style.filter = `blur(${scale(load, 0, 100, 50, 0)}px)`; //(0~100) => (30,0) 으로 변경한다.
}

// 한 레인지(0~100)를 다른 레인지 (1~0) , 블러(30~0) 로 변환하는 함수 공식 => 스택오버플로우 검색
// https://stackoverflow.com/questions/10756313/javascript-jquery-map-a-range-of-numbers-to-another-range-of-numbers


function scale(number, inMin, inMax, outMin, outMax) {
    return (number - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
}