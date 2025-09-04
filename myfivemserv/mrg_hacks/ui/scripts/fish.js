(function() {
    const fish2Container = document.querySelector('.fish');
    if (!fish2Container) return;

    let fish2Ingame = false;
    let fish2GameOver = true;
    let fish2KeyPressed = false;

    const fish2GameBody = fish2Container.querySelector('.game-body');
    const fish2IndicatorElem = fish2Container.querySelector('.indicator');
    const fish2ProgressBarElem = fish2Container.querySelector('.progress-bar');
    const fish2FishElem = fish2Container.querySelector('.fish'); // optional if nested

    function fish2Display(bool) {
        const fish2InnerContainer = fish2Container.querySelector('#container');
        if (!fish2InnerContainer) return;

        if (bool) {
            fish2InnerContainer.style.display = "block";
            fish2Ingame = true;
        } else {
            fish2InnerContainer.style.display = "none";
            fish2Ingame = false;
        }
    }
    CreateScriptMessageListener("fish", function(fish2Data) {
        if (fish2Data.type === "ui") {
            fish2Display(fish2Data.status);
            fish2GameOver = fish2Data.status
        }
    });

    document.addEventListener('keyup', function(fish2Event) {
        if (fish2Event.which === 27 && fish2Ingame) {
            $.post(`https://${GetParentResourceName()}/fish/exit`, JSON.stringify({}));
        }
    });

    class Fish2Indicator {
        constructor() {
            this.indicator = fish2IndicatorElem;
            this.height = this.indicator.clientHeight;
            this.y = 0;
            this.velocity = 0;
            this.acceleration = 0;
            this.topBounds = (fish2GameBody.clientHeight * -1) + 48;
            this.bottomBounds = 0;
        }

        applyForce(force) {
            this.acceleration += force;
        }

        updatePosition() {
            this.velocity += this.acceleration;
            this.y += this.velocity;
            this.acceleration = 0;

            if (this.y > this.bottomBounds) {
                this.y = 0;
                this.velocity *= -0.5;
            }

            if (this.y < this.topBounds) {
                this.y = this.topBounds;
                this.velocity = 0;
            } else if (fish2KeyPressed) {
                this.applyForce(-0.5);
            }

            this.applyForce(0.3);
            this.indicator.style.transform = `translateY(${this.y}px)`;
        }

        detectCollision() {
            if (
                fish2Fish.y < this.y && fish2Fish.y > this.y - this.height ||
                fish2Fish.y - fish2Fish.height < this.y && fish2Fish.y - fish2Fish.height > this.y - this.height
            ) {
                fish2ProgressBar.fill();
                fish2Container.classList.add('collision');
            } else {
                fish2ProgressBar.drain();
                fish2Container.classList.remove('collision');
            }
        }
    }

    class Fish2Fish {
        constructor() {
            this.fish = fish2FishElem;
            this.height = this.fish.clientHeight;
            this.y = 5;
            this.direction = null;
            this.randomPosition = null;
            this.randomCountdown = null;
            this.speed = 2;
        }

        resetPosition() {
            this.y = 5;
        }

        updateFishPosition() {
            if (!this.randomPosition || this.randomCountdown < 0) {
                this.randomPosition = Math.ceil(Math.random() * (fish2GameBody.clientHeight - this.height)) * -1;
                this.randomCountdown = Math.abs(this.y - this.randomPosition);
                this.speed = Math.abs(Math.random() * (3 - 1) + 1);
            }

            this.y += (this.randomPosition < this.y) ? -this.speed : this.speed;
            this.fish.style.transform = `translateY(${this.y}px)`;
            this.randomCountdown -= this.speed;
        }
    }

    class Fish2ProgressBar {
        constructor() {
            this.wrapper = fish2ProgressBarElem;
            this.progressBar = this.wrapper.querySelector('.progress-gradient-wrapper');
            this.progress = 5;
        }

        reset() {
            this.progress = 5;
        }

        drain() {
            this.progress = Math.max(0, this.progress - 0.8);
        }

        fill() {
            this.progress = Math.min(100, this.progress + 2.4);
        }

        detectGameEnd() {
            if (this.progress >= 100 && fish2GameOver && fish2Ingame) {
                setTimeout(() => {
                    $.post(`https://${GetParentResourceName()}/fish/success`, JSON.stringify({}));
                    this.progress = 5;
                    fish2GameOver = false;
                }, 500);
            }
        }

        updateUi() {
            this.progressBar.style.height = `${this.progress}%`;
        }
    }

    const fish2Indicator = new Fish2Indicator();
    const fish2ProgressBar = new Fish2ProgressBar();
    const fish2Fish = new Fish2Fish();

    function fish2IndicatorActive () {
        if (!fish2KeyPressed && fish2Ingame) {
            fish2KeyPressed = true;
            fish2Container.classList.add('indicator-active');
        }
    }

    function fish2IndicatorInactive () {
        if (fish2KeyPressed) {
            fish2KeyPressed = false;
            fish2Container.classList.remove('indicator-active');
        }
    }

    window.addEventListener('mousedown', fish2IndicatorActive);
    window.addEventListener('mouseup', fish2IndicatorInactive);
    window.addEventListener('keydown', fish2IndicatorActive);
    window.addEventListener('keyup', fish2IndicatorInactive);
    window.addEventListener('touchstart', fish2IndicatorActive);
    window.addEventListener('touchend', fish2IndicatorInactive);

    var firshlimitLoop = function (fn, fps) {
 
        // Use var then = Date.now(); if you
        // don't care about targetting < IE9
        var then = new Date().getTime();
    
        // custom fps, otherwise fallback to 60
        fps = fps || 60;
        var interval = 1000 / fps;
     
        return (function loop(time){
            requestAnimationFrame(loop);
     
            // again, Date.now() if it's available
            var now = new Date().getTime();
            var delta = now - then;
     
            if (delta > interval) {
                // Update time
                // now - (delta % interval) is an improvement over just 
                // using then = now, which can end up lowering overall fps
                then = now - (delta % interval);
     
                // call the fn
                fn();
            }
        }(0));
    };

    function fish2AnimationLoop() {
        firshlimitLoop(() => {
            if(fish2Ingame){
                if (fish2GameOver) {
                    fish2Indicator.updatePosition();
                    fish2Indicator.detectCollision();
                    fish2ProgressBar.updateUi();
                    fish2ProgressBar.detectGameEnd();
                    fish2Fish.updateFishPosition();
                } else {
                    fish2Indicator.updatePosition();
                    fish2Indicator.detectCollision();
                    fish2ProgressBar.updateUi();
                    fish2Fish.updateFishPosition();
                }
            }
        }, 60)
    }

    fish2AnimationLoop();
    fish2Display(false)
})();