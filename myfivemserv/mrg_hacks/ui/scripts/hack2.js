const hack2_html = document.querySelector('.hack2');
const hack2_container = hack2_html.querySelector('.container');
const hack2_hackFunction = hack2_html.querySelector('.hackFunction');
const hack2_hackAllButtons = hack2_html.querySelector('.hackAllButtons');
const hack2_hackText = hack2_html.querySelector('.hackText');
const hack2_progressBar = hack2_html.querySelector('#progressBox');
const hack2_hackInfo = hack2_html.querySelector('.hackInfo');
const hack2_textInfo = hack2_html.querySelector('#textInfo');
const hack2_progressBarId = hack2_html.querySelector('#progress-bar');
const hack2_hackClickButtons = hack2_html.querySelector('#hackClickButtons');
const hack2_hackClick = hack2_html.querySelector('#hackClick');

var hack2_settings = {
	questions: 0,
	devMode: false,
};

var hack2_success = false;

var hack2__timePlay = 900;
var hack2_progressBarInterval;
var hack2_buttonsInterval;
var hack2_finish = true;
var hack2_buttonsTimeout;
var hack2_clickButton = 0;
var hack2_clickButtons = 0;

function hack2_display(bool) {
	if (bool) {
		hack2_container.classList.add('showHack');
		hack2_html.style.display = '';
		hack2_gameStart();
	} else {
		hack2_container.classList.remove('showHack');
		hack2_html.style.display = 'none';
	}
}

function hack2_fetchSuccess() {
	fetch(`https://${GetParentResourceName()}/hack2/finished`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json; charset=UTF-8',
		},
		body: JSON.stringify({ result: true }),
	})
	.then(resp => resp.json())
	.then(resp => console.log(resp));

	hack2_display(false);
}

function hack2_fetchFailed() {
	fetch(`https://${GetParentResourceName()}/hack2/finished`, {
		method: 'POST',
		headers: { 'Content-Type': 'application/json; charset=UTF-8' },
		body: JSON.stringify({ result: false }),
	})
	.then(resp => resp.json())
	.then(resp => console.log(resp));

	hack2_display(false);
	return;
}

const hack2_gameReset = () => {
	clearTimeout(hack2_buttonsTimeout);
	clearInterval(hack2_buttonsInterval);
	hack2_clickButtons = 0;
	hack2_clickButton = 0;
	hack2_hackAllButtons.innerHTML = '';
};

const hack2_gameStart = () => {
	hack2_gameReset();
	hack2_progressBar.style.display = 'block';
	hack2_hackInfo.style.display = 'block';
	hack2_textInfo.innerHTML = 'Przygotuj się...';
	hack2_finish = true;
	hack2_progressBarStart('start', 5);
};

const hack2_gameOver = () => {
	hack2_gameReset();
	hack2_hackInfo.style.display = 'block';
	hack2_textInfo.innerHTML = 'Hack nieudany!';
	hack2_hackFunction.style.display = 'none';
	hack2_hackText.style.display = 'none';
	hack2_progressBar.style.display = '';
	hack2_finish = true;
	hack2_progressBarStart('end', 5);
	hack2_success = false;
};

const hack2_gameWin = () => {
	hack2_gameReset();
	hack2_hackInfo.style.display = 'block';
	hack2_textInfo.innerHTML = 'Hack udany!';
	hack2_hackFunction.style.display = 'none';
	hack2_hackText.style.display = 'none';
	hack2_progressBar.style.display = '';
	hack2_finish = true;
	hack2_progressBarStart('end', 5);
	hack2_success = true;
};

function hack2_progressBarStart(type, time) {
	hack2_progressBarId.style.width = '100%';

	let maxwidth = hack2_finish ? 1000 : hack2_settings.questions;
	let width = maxwidth;
	const process = () => {
		if (width > 0) {
			if (hack2_finish) {
				width--;
				hack2_progressBarId.style.width = (width * 100.0) / maxwidth + '%';
			} else {
				hack2_progressBarId.style.width = (hack2_clickButtons * 100.0) / maxwidth + '%';

				if ((hack2_clickButtons * 100.0) / maxwidth >= 100.0) {
					hack2_gameWin();
				}
			}
		} else {
			if (type === 'start') {
				hack2_hackFunction.style.display = '';
				hack2_hackText.style.display = '';
				hack2_hackInfo.style.display = 'none';
				hack2_progressBar.style.display = '';
				hack2_finish = false;

				hack2_createButton();
				hack2_moveButtons();

				hack2_progressBarStart('game', 5);
				return;
			}
			if (type === 'game') {
				hack2_hackFunction.style.display = 'none';
				hack2_hackInfo.style.display = 'block';
				hack2_hackText.style.display = 'none';
			}
			if (type === 'end') {
				hack2_hackFunction.style.display = 'none';
				hack2_hackText.style.display = 'none';
				hack2_progressBar.style.display = 'none';
				hack2_hackInfo.style.display = 'none';

				clearInterval(hack2_progressBarInterval);

				hack2_success ? hack2_fetchSuccess() : hack2_fetchFailed();
				return;
			}
		}
	};

	clearInterval(hack2_progressBarInterval);
	hack2_progressBarInterval = setInterval(process, time);
}

function hack2_getRndInteger(min, max) {
	return Math.floor(Math.random() * (max - min)) + min;
}

function hack2_getRandomFloat(min, max, decimals) {
	return parseFloat((Math.random() * (max - min) + min).toFixed(decimals));
}

function hack2_isColliding(a, b) {
	const rect1 = a.getBoundingClientRect();
	const rect2 = b.getBoundingClientRect();
	const isInHoriztonalBounds = rect1.x < rect2.x + rect2.width && rect1.x + rect1.width > rect2.x;
	const isInVerticalBounds = rect1.y < rect2.y + rect2.height && rect1.y + rect1.height > rect2.y;
	return isInHoriztonalBounds && isInVerticalBounds;
}

function hack2_createButton() {
	if (hack2_clickButton >= hack2_settings.questions) return;

	const symbols = ['+', '-', '*'];
	const randomSymbol = symbols[Math.floor(Math.random() * symbols.length)];
	const calculateMath = `${hack2_getRndInteger(1, randomSymbol === '*' ? 25 : 500)} ${randomSymbol} ${hack2_getRndInteger(1, randomSymbol === '*' ? 25 : 500)}`;

	const button = document.createElement('div');
	button.classList.add('button');
	button.setAttribute('id', 'button' + hack2_clickButton);
	button.setAttribute('data-math', eval(calculateMath));
	button.setAttribute('data-speed', hack2_getRndInteger(1, 4));

	button.textContent = hack2_settings.devMode ? `${calculateMath} ${eval(calculateMath) % 2 === 0 ? 'lewy' : 'prawy'}` : calculateMath;
	button.style.left = hack2_getRndInteger(0, 400) + 'px';
	button.style.top = '-40px';

	button.onmousedown = function (event) {
		if (hack2_hasClass(this, 'check1') || hack2_hasClass(this, 'check2')) return;

		switch (event.which) {
			case 1:
				if (this.dataset.math % 2 == 0) {
					this.classList.add('check1');
					this.setAttribute('data-speed', 10);
				} else hack2_gameOver();
				break;
			case 3:
				if (this.dataset.math % 2 == 0) {
					hack2_gameOver();
				} else {
					this.classList.add('check2');
					this.setAttribute('data-speed', 10);
				}
				break;
		}
	};

	hack2_hackAllButtons.appendChild(button);
	hack2_clickButton++;

	hack2_buttonsTimeout = setTimeout(() => {
		hack2_createButton();
	}, hack2_getRndInteger(2000, 3000));
}

function hack2_hasClass(element, className) {
	return (' ' + element.className + ' ').indexOf(' ' + className + ' ') > -1;
}

function hack2_moveButtons() {
	hack2_buttonsInterval = setInterval(() => {
		if (!hack2_finish) {
			const buttonItem = hack2_hackAllButtons.querySelectorAll('.button');

			buttonItem.forEach(item => {
				let y = parseInt(item.style.top, 10);
				y += parseInt(item.dataset.speed);

				if (y >= 490) {
					if (hack2_hasClass(item, 'check1') || hack2_hasClass(item, 'check2')) {
						item.remove();
						hack2_clickButtons++;
					} else {
						hack2_gameOver();
					}
					return;
				}
				item.style.top = y + 'px';
			});
		}
	}, 20);
}

const hack2_gameInit = () => {
	hack2_gameReset();
	hack2_hackFunction.style.display = 'none';
	hack2_hackText.style.display = 'none';
	hack2_progressBar.style.display = 'none';
	hack2_hackInfo.style.display = 'none';
	document.addEventListener('contextmenu', event => event.preventDefault());
	hack2_display(false);
};

CreateScriptMessageListener("hack2", function(data) {
	if (data.type === 'openHack') {
		hack2_settings.questions = data.questions;
		hack2_settings.devMode = data.devMode;

		document.querySelector('.dev').style.display = hack2_settings.devMode ? '' : 'none';

		hack2_display(true);
	}
});

hack2_gameInit();