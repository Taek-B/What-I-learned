//  1. 첫번째 버튼을 클릭하면 alert 메세지 '클릭됨!' 을 화면에 출력 (addEventListen 사용)


const btn1 = document.querySelector('button');
btn1.addEventListener('click', clickButton); // 콜백함수는 매개변수로함수가 입력될 때

function clickButton() {
    // alert('클릭됨!')    // 3.번째 순서에 나온 설명처럼 주석으로 만듬
    console.log(this.textContent); // 현재 클릭한 객체
    this.style.color = 'white';
    drumSound(this.textContent);

    // 4.으로 만든 스위치를 함수에 넣음
    // switch (this.textContent) {
    //     case 'w':
    //         var audio = new Audio('sounds/tom-1.mp3');
    //         audio.play();
    //         break;
    //     case 'a':
    //         var audio = new Audio('sounds/tom-2.mp3');
    //         audio.play();
    //         break;
    //     case 's':
    //         var audio = new Audio('sounds/tom-3.mp3');
    //         audio.play();
    //         break;
    //     case 'd':
    //         var audio = new Audio('sounds/tom-4.mp3');
    //         audio.play();
    //         break;
    //     case 'j':
    //         var audio = new Audio('sounds/snare.mp3');
    //         audio.play();
    //         break;
    //     case 'k':
    //         var audio = new Audio('sounds/crash.mp3');
    //         audio.play();
    //         break;
    //     case 'l':
    //         var audio = new Audio('sounds/kick-bass.mp3');
    //         audio.play();
    //         break;
    // }


    // ↓↓↓↓ 소리를 내게 해주는 코드 ↓↓↓↓
    /* 
    const audio = new Audio('sounds/tom-1.mp3');
    audio.play();
    */
}

// 2.  모든 클래스 drum 이 있는 버튼들은 클릭하면 '클릭됨!'을 화면에 출력

const btns = document.querySelectorAll('.drum');

for (let i = 0; i < btns.length; i++) {
    btns[i].addEventListener('click', clickButton);
}

// 3. 자바스크립트로 audio play 하는 방법 검색하여 alert함수 대신에 입력하여 버튼을 클릭하면 드럼 소리가 나도록 한다.
// function clickButton에 넣음


// 4. 이제 각각의 드럼을 클릭했을때 => 드럼의 소리를 play 하는데 if else 문으로 하기엔 7개 => 많음 => 그래서 switch 문으로 작성


// 5. 키보드를 눌렀을 때 이벤트 만들기
document.addEventListener('keydown', function (e) {
    console.log(e.key); // 이벤트 객체(자동생성)

    drumSound(event.key);

})

// 중복 코드를 리팩토일을 통해 함수로 만들어서 중복 제거
function drumSound(key) {
    switch (key) {
        case 'w':
            var audio = new Audio('sounds/tom-1.mp3');
            audio.play();
            break;
        case 'a':
            var audio = new Audio('sounds/tom-2.mp3');
            audio.play();
            break;
        case 's':
            var audio = new Audio('sounds/tom-3.mp3');
            audio.play();
            break;
        case 'd':
            var audio = new Audio('sounds/tom-4.mp3');
            audio.play();
            break;
        case 'j':
            var audio = new Audio('sounds/snare.mp3');
            audio.play();
            break;
        case 'k':
            var audio = new Audio('sounds/crash.mp3');
            audio.play();
            break;
        case 'l':
            var audio = new Audio('sounds/kick-bass.mp3');
            audio.play();
            break;


    }
}

