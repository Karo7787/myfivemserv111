const container = document.querySelector('.container');
const hackFunction = document.querySelector('.hackFunction');
const hackText = document.querySelector('.hackText');
const progressBar = document.getElementById('progressBox');
const hackInfo = document.querySelector('.hackInfo');
const textInfo = document.getElementById('textInfo');
const scoreInfo = document.getElementById('score');
const progressBarId = document.getElementById('progress-bar');
const eatPoints = document.getElementById('eatPoints');
const canvas = document.createElement('canvas');
const CTX = canvas.getContext('2d');
const html = document.querySelector('html');

const W = (canvas.width = 480);
const H = (canvas.height = 480);

var settings = {
	time: 0,
	food: 0,
	devMode: false,
};

var collect = {
	food: 0,
};

var success = false;

var snake;
var food;
var cells = 10;
var cellSize;
var isGameOver = false;
var cellsCount;
var loopTimeout;

var shaking = false;
var shakeInterval;
var progressBarInterval;

function display(bool) {
	if (bool) {
		container.classList.add('showHack');
		html.style.display = '';
		gameStart();
	} else {
		container.classList.remove('showHack');
		html.style.display = 'none';
	}
}

function fetchSuccess() {
	fetch(`https://${GetParentResourceName()}/finished`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json; charset=UTF-8',
		},
		body: JSON.stringify({
			result: true,
		}),
	})
		.then(resp => resp.json())
		.then(resp => console.log(resp));

	display(false);
}

function fetchFailed() {
	fetch(`https://${GetParentResourceName()}/finished`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json; charset=UTF-8',
		},
		body: JSON.stringify({
			result: false,
		}),
	})
		.then(resp => resp.json())
		.then(resp => console.log(resp));

	display(false);
	return;
}

let helpers = {
	Vec: class {
		constructor(x, y) {
			this.x = x;
			this.y = y;
		}
		add(v) {
			this.x += v.x;
			this.y += v.y;
			return this;
		}
		mult(v) {
			if (v instanceof helpers.Vec) {
				this.x *= v.x;
				this.y *= v.y;
				return this;
			} else {
				this.x *= v;
				this.y *= v;
				return this;
			}
		}
	},
	isCollision(v1, v2) {
		return v1.x == v2.x && v1.y == v2.y;
	},

	drawGrid() {
		CTX.lineWidth = 0.5;
		CTX.strokeStyle = 'rgba(34 38 34 / 50%)';
		CTX.shadowBlur = 0;
		for (let i = 1; i < cells; i++) {
			let f = (W / cells) * i;
			CTX.beginPath();
			CTX.moveTo(f, 0);
			CTX.lineTo(f, H);
			CTX.stroke();
			CTX.beginPath();
			CTX.moveTo(0, f);
			CTX.lineTo(W, f);
			CTX.stroke();
			CTX.closePath();
		}
	},
};

let KEY = {
	ArrowUp: false,
	ArrowRight: false,
	ArrowDown: false,
	ArrowLeft: false,
	resetState() {
		this.ArrowUp = false;
		this.ArrowRight = false;
		this.ArrowDown = false;
		this.ArrowLeft = false;
	},
	listen() {
		addEventListener(
			'keydown',
			e => {
				if (e.key === 'ArrowUp' && this.ArrowDown) return;
				if (e.key === 'ArrowDown' && this.ArrowUp) return;
				if (e.key === 'ArrowLeft' && this.ArrowRight) return;
				if (e.key === 'ArrowRight' && this.ArrowLeft) return;
				this[e.key] = true;
				Object.keys(this)
					.filter(f => f !== e.key && f !== 'listen' && f !== 'resetState')
					.forEach(k => {
						this[k] = false;
					});
			},
			false
		);
	},
};

class Snake {
	constructor(i, type) {
		this.pos = new helpers.Vec(W / 2, H / 2);
		this.dir = new helpers.Vec(0, 0);
		this.type = type;
		this.index = i;
		this.delay = 5;
		this.size = W / cells;
		if (!settings.devMode) this.color = 'white';
		else this.color = 'red';
		this.history = [];
		this.total = 1;
	}
	draw() {
		let { x, y } = this.pos;
		CTX.fillStyle = this.color;
		CTX.shadowBlur = 70;
		CTX.shadowColor = 'rgba(255,255,255,.1 )';

		if (!settings.devMode) CTX.shadowColor = 'rgba(255,255,255,.1 )';
		else CTX.shadowColor = 'rgba(255,0,0,.1 )';

		CTX.fillRect(x, y, this.size, this.size);

		if (this.total >= 2) {
			for (let i = 0; i < this.history.length - 1; i++) {
				let { x, y } = this.history[i];
				CTX.lineWidth = 1;
				if (!settings.devMode) CTX.fillStyle = 'rgba(255,255,255, 1 )';
				else CTX.fillStyle = 'rgba(255,0,0, 1 )';
				CTX.shadowBlur = 5;
				if (!settings.devMode) CTX.shadowColor = 'rgba(255,255,255,.3 )';
				else CTX.shadowColor = 'rgba(255,0,0,.3 )';
				CTX.fillRect(x, y, this.size, this.size);
			}
		}
		CTX.shadowBlur = 0;
	}
	walls() {
		let { x, y } = this.pos;
		if (x + cellSize > W) this.pos.x = 0;
		if (y + cellSize > W) this.pos.y = 0;
		if (y < 0) this.pos.y = H - cellSize;
		if (x < 0) this.pos.x = W - cellSize;
	}
	controlls() {
		let dir = this.size;
		if (KEY.ArrowUp) this.dir = new helpers.Vec(0, -dir);
		if (KEY.ArrowDown) this.dir = new helpers.Vec(0, dir);
		if (KEY.ArrowLeft) this.dir = new helpers.Vec(-dir, 0);
		if (KEY.ArrowRight) this.dir = new helpers.Vec(dir, 0);
	}
	selfCollision() {
		for (let i = 0; i < this.history.length; i++) {
			let p = this.history[i];
			if (helpers.isCollision(this.pos, p)) {
				if (!settings.devMode) isGameOver = true;
				else isGameOver = false;
			}
		}
	}
	update() {
		this.walls();
		this.draw();
		this.controlls();
		if (!this.delay--) {
			if (helpers.isCollision(this.pos, food.pos)) {
				food.spawn();
				this.total++;
				collect.food = this.total;
				if (this.total > settings.food) {
					gameWin();
				}
				scoreInfo.innerText = this.total - 1;
			}
			this.history[this.total - 1] = new helpers.Vec(this.pos.x, this.pos.y);
			for (let i = 0; i < this.total - 1; i++) {
				this.history[i] = this.history[i + 1];
			}
			this.pos.add(this.dir);
			this.delay = 5;
			this.total > 3 ? this.selfCollision() : null;
		}
	}
}

class Food {
	constructor() {
		this.pos = new helpers.Vec(~~(Math.random() * cells) * cellSize, ~~(Math.random() * cells) * cellSize);
		this.color = `rgb(30, 102, 170)`;
		this.color2 = `rgb(30, 102, 170)`;
		this.size = cellSize;
	}
	draw() {
		let { x, y } = this.pos;
		CTX.globalCompositeOperation = 'lighter';
		CTX.shadowBlur = 90;
		CTX.shadowColor = this.color2;
		CTX.fillStyle = this.color;
		CTX.fillRect(x, y, this.size, this.size);
		CTX.globalCompositeOperation = 'source-over';
		CTX.shadowBlur = 0;
	}
	spawn() {
		let randX = ~~(Math.random() * cells) * this.size;
		let randY = ~~(Math.random() * cells) * this.size;
		for (let path of snake.history) {
			if (helpers.isCollision(new helpers.Vec(randX, randY), path)) {
				return this.spawn();
			}
		}
		this.color = `rgb(30, 102, 170)`;
		this.pos = new helpers.Vec(randX, randY);
	}
}

const gameInit = () => {
	hackFunction.style.display = 'none';
	hackText.style.display = 'none';
	progressBar.style.display = 'none';
	hackInfo.style.display = 'none';
	clearInterval(shakeInterval);
	document.querySelector('#canvas').appendChild(canvas);

	KEY.listen();
	cellsCount = cells * cells;
	cellSize = W / cells;
	snake = new Snake();
	food = new Food();

	updateSnake();
	document.addEventListener('contextmenu', event => event.preventDefault());

	display(false);
};

const gameStart = () => {
	clearInterval(shakeInterval);
	progressBar.style.display = 'block';
	hackInfo.style.display = 'block';
	textInfo.innerHTML = 'Przygotuj się...';
	gameReset();
	scoreInfo.innerText = 0;
	progressBarStart('start', 5);
};

const gameWin = () => {
	clearInterval(shakeInterval);
	hackInfo.style.display = 'block';
	textInfo.innerHTML = 'Hack Udany';
	hackFunction.style.display = 'none';
	hackText.style.display = 'none';
	gameReset();
	progressBarStart('end', 5);

	success = true;
};

function gameReset() {
	clearInterval(shakeInterval);
	container.classList.remove('shake');
	shaking = false;
	snake = new Snake();
	food.spawn();
	KEY.resetState();
	isGameOver = false;
	clearTimeout(loopTimeout);
	updateSnake();
}

const gameOver = () => {
	hackInfo.style.display = 'block';
	textInfo.innerHTML = 'Hack nieudany!';
	hackFunction.style.display = 'none';
	hackText.style.display = 'none';
	gameReset();
	progressBarStart('end', 5);

	success = false;
};

function progressBarStart(type, time) {
	progressBarId.style.width = '100%';

	var maxwidth = 1000;
	var width = maxwidth;
	const process = () => {
		if (width > 0) {
			width--;

			let per = (width * 100.0) / maxwidth;

			progressBarId.style.width = per + '%';

			if (shaking) container.classList.add('shake');
			else container.classList.remove('shake');
		} else {
			if (type == 'start') {
				hackFunction.style.display = '';
				hackText.style.display = '';
				hackInfo.style.display = 'none';
				clearInterval(shakeInterval);
				shakeInterval = setInterval(() => {
					shake();
				}, 2000);

				progressBarStart('game', settings.time);
				return;
			}
			if (type == 'game') {
				gameReset();
				hackFunction.style.display = 'none';
				hackInfo.style.display = 'block';
				textInfo.innerHTML = 'Hack nieudany';
				hackText.style.display = 'none';
				gameOver();
				return;
			}
			if (type == 'end') {
				gameReset();
				hackFunction.style.display = 'none';
				hackText.style.display = 'none';
				progressBar.style.display = 'none';
				hackInfo.style.display = 'none';
				clearInterval(progressBarInterval);

				success ? fetchSuccess() : fetchFailed();
				return;
			}
		}
	};
	clearInterval(progressBarInterval);
	progressBarInterval = setInterval(process, time);
}

function shake() {
	if (randomInt(1, 100) < 30 && settings.food / 2 < collect.food) {
		shaking = true;
	} else shaking = false;
}

function randomInt(min, max) {
	return Math.floor(Math.random() * (max - min + 1) + min);
}

function updateSnake() {
	CTX.clearRect(0, 0, W, H);
	if (!isGameOver) {
		loopTimeout = setTimeout(updateSnake, 1000 / 60);
		helpers.drawGrid();
		snake.update();
		food.draw();
	} else {
		CTX.clearRect(0, 0, W, H);
		gameOver();
	}
}

window.addEventListener('message', function (event) {
	var item = event.data;
	if (item.type === 'openHack') {
		settings.time = item.time;
		settings.food = item.points;
		settings.devMode = item.devMode;
		eatPoints.textContent = settings.food;

		if (settings.devMode) document.querySelector('.dev').style.display = '';
		else document.querySelector('.dev').style.display = 'none';

		display(true);
	}
});
