function simonsays() {
    const simonsaysDiv = document.querySelector('.simonsays');
    if (!simonsaysDiv) return;

    var keypad = null;
    let onClickAudio = new Audio("https://cdn.discordapp.com/attachments/1053976576179568721/1061414043937689742/hack-click.mp3");
    let successAudio = new Audio("https://cdn.discordapp.com/attachments/1053976576179568721/1061411326158716928/hack-success.mp3");
    var canclick = true;

    class Keypad {
        clickKey(key) {
            if (!this.lockKeys) {
                if (this.progress === 0 && this.setProgress === 0) {
                    this.startTime = new Date();
                }

                onClickAudio.play();

                if (key === this.sequence[this.setProgress]) {
                    this.correctKeyClicked(key);
                    canclick = false;
                    setTimeout(() => {
                        canclick = true;
                    }, 300);
                } else {
                    this.incorrectKeyClicked();
                }
            }
        }

        reset(sequenceLength) {
            this.sequenceLength = sequenceLength;
            this.setSequence(sequenceLength);
            this.progress = 0;
            this.showSequence(0);
            this.setProgress = 0;
        }

        setSequence(length) {
            this.sequence = [];
            for (let i = 0; i < length; i++) {
                this.sequence.push(Math.floor(Math.random() * (this.fieldSize * this.fieldSize)));
            }
        }

        correctKeyClicked(key) {
            const button = simonsaysDiv.querySelector('#key_' + key);
            this.setProgress += 1;
            button.className = "keypad__key keypad__key--clicked_correct";
            let timeout = setTimeout(() => {
                button.className = "keypad__key";
            }, 300);

            if (this.setProgress > this.progress) {
                this.setProgress = 0;
                if (this.progress + 1 === this.sequenceLength) {
                    this.blinkKeys(true, 0);
                    setTimeout(() => this.reset(this.sequenceLength), 1000);
                    timeout = 0;
                    successAudio.play();
                    $.post(`https://${GetParentResourceName()}/simonsays/success`, JSON.stringify({}));
                    simonsaysDiv.querySelector('#container').style.display = 'none';
                } else {
                    this.progress += 1;
                    setTimeout(() => {
                        this.showSequence(this.progress);
                    }, 500);
                }
            }
        }

        incorrectKeyClicked() {
            this.blinkKeys(false, 0);
            setTimeout(() => {
                this.reset(this.sequenceLength);
                $.post(`https://${GetParentResourceName()}/simonsays/failed`, JSON.stringify({}));
                simonsaysDiv.querySelector('#container').style.display = 'none';
            }, 1750);
        }

        async showSequence(progress) {
            this.lockKeys = true;
            for (let i = 0; i <= progress; i++) {
                const button = simonsaysDiv.querySelector("#key_" + this.sequence[i]);
                await sleep(100);
                button.className = 'keypad__key keypad__key--highlight';
                await sleep(300);
                button.className = 'keypad__key';
                if (i === progress) {
                    this.lockKeys = false;
                }
            }
        }

        blinkKeys(correct, count = 0) {
            const keys = simonsaysDiv.querySelectorAll('.keypad__key');
            keys.forEach(key => {
                key.className = "keypad__key " + (correct ? "keypad__key--clicked_correct" : "keypad__key--clicked_incorrect");
            });
            setTimeout(() => {
                keys.forEach(key => {
                    key.className = 'keypad__key';
                });
            }, 200);
            if (count < 2) {
                setTimeout(() => this.blinkKeys(correct, count + 1), 500);
            }
        }

        drawButtons(fieldSize) {
            this.fieldSize = fieldSize;
            const keypadContainer = simonsaysDiv.querySelector('#keypad');
            while (keypadContainer.firstChild) {
                keypadContainer.removeChild(keypadContainer.lastChild);
            }
            let keyNumber = 0;
            for (let i = 0; i < fieldSize; i++) {
                const row = document.createElement('div');
                row.className = "keypad__row";
                for (let j = 0; j < fieldSize; j++) {
                    const key = document.createElement('div');
                    const keyId = keyNumber;
                    key.className = "keypad__key";
                    key.onclick = () => {
                        if (canclick) keypad.clickKey(keyId);
                    };
                    key.id = "key_" + keyNumber;
                    key.style.height = Math.floor(100 * (1 / (fieldSize + 1))) + "vw";
                    key.style.width = Math.floor(100 * (1 / (fieldSize + 1))) + "vw";
                    row.appendChild(key);
                    keyNumber++;
                }
                keypadContainer.appendChild(row);
            }
        }

        handleSizeChange() {
            const sizeInput = simonsaysDiv.querySelector('#sizeInput');
            if (sizeInput.value > 1 && sizeInput.value < 6) {
                this.drawButtons(parseInt(sizeInput.value));
            }
            this.reset(this.sequenceLength);
        }

        handleSequenceChange() {
            const sequenceInput = simonsaysDiv.querySelector('#sequenceInput');
            this.reset(parseInt(sequenceInput.value));
        }
    }

    CreateScriptMessageListener("simonsays", function(data) {
        if (!data.buttonGrid || !data.length) {
            BeginHack(3, 5);
        } else {
            BeginHack(data.buttonGrid, data.length);
        }
    });

    function BeginHack(buttonGrid, length) {
        const container = simonsaysDiv.querySelector('#container');
        container.style.display = 'flex';

        keypad = new Keypad();
        keypad.drawButtons(buttonGrid);
        keypad.reset(length);
    }

    function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
}

simonsays();
