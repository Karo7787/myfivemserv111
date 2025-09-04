window.addEventListener('DOMContentLoaded', () => {
    const container = document.querySelector('.wordgame');

    let wordgame_gameConfig = {};
    let wordgame_gameState = {
        isPlaying: false,
        currentWord: '',
        seenWords: [],
        currentWordIndex: 0,
        errors: 0,
        timeLeft: 0,
        timer: null,
        wordPool: [],
        isWordSeen: false
    };
    
    const wordgame_elements = {
        gameContainer: container.querySelector('#gameContainer'),
        gameScreen: container.querySelector('#gameScreen'),
        resultScreen: container.querySelector('#resultScreen'),
        wordDisplay: container.querySelector('#wordDisplay'),
        gameButtons: container.querySelector('#gameButtons'),
        timeLeft: container.querySelector('#timeLeft'),
        wordCount: container.querySelector('#wordCount'),
        totalWords: container.querySelector('#totalWords'),
        errors: container.querySelector('#errors'),
        maxErrors: container.querySelector('#maxErrors'),
        progressBar: container.querySelector('#progressBar'),
        resultTitle: container.querySelector('#resultTitle'),
        resultStats: container.querySelector('#resultStats'),
        btnSeen: container.querySelector('#btnSeen'),
        btnNew: container.querySelector('#btnNew'),
        btnClose: container.querySelector('#btnClose')
    };
    
    wordgame_elements.btnSeen.addEventListener('click', () => wordgame_answerSeen());
    wordgame_elements.btnNew.addEventListener('click', () => wordgame_answerNew());
    CreateScriptMessageListener("wordgame", function(data) {
        if (data.action === 'startGame') {
            wordgame_gameConfig = data.config;
            wordgame_startGame();
        }
    });
    
    
    function wordgame_startGame() {
        wordgame_resetGame();
        wordgame_elements.gameContainer.style.display = 'block';
    
        wordgame_gameState.timer = setInterval(() => {
            wordgame_gameState.timeLeft--;
            wordgame_updateUI();
    
            if (wordgame_gameState.timeLeft <= 0) {
                wordgame_endGame(false, 'Time is UP!');
            }
        }, 1000);
    
        setTimeout(() => {
            wordgame_showNextWord();
        }, 1000);
    }
    
    function wordgame_resetGame() {
        wordgame_gameState.isPlaying = true;
        wordgame_gameState.currentWord = '';
        wordgame_gameState.seenWords = [];
        wordgame_gameState.currentWordIndex = 0;
        wordgame_gameState.errors = 0;
        wordgame_gameState.timeLeft = wordgame_gameConfig.timeLimit;
        wordgame_gameState.wordPool = [...wordgame_gameConfig.words];
        wordgame_elements.wordDisplay.textContent = 'Starting...';
    
        if (wordgame_gameState.timer) {
            clearInterval(wordgame_gameState.timer);
        }
    
        wordgame_elements.gameScreen.style.display = 'block';
        wordgame_elements.resultScreen.style.display = 'none';
        wordgame_updateUI();
    }
    
    function wordgame_showNextWord() {
        if (wordgame_gameState.currentWordIndex >= wordgame_gameConfig.totalWords) {
            wordgame_endGame(true, 'Complimenti!');
            return;
        }
    
        const showSeenWord = wordgame_gameState.seenWords.length > 0 && Math.random() < 0.5;
    
        if (showSeenWord) {
            wordgame_gameState.currentWord = wordgame_gameState.seenWords[Math.floor(Math.random() * wordgame_gameState.seenWords.length)];
            wordgame_gameState.isWordSeen = true;
        } else {
            if (wordgame_gameState.wordPool.length === 0) {
                wordgame_gameState.currentWord = wordgame_gameState.seenWords[Math.floor(Math.random() * wordgame_gameState.seenWords.length)];
                wordgame_gameState.isWordSeen = true;
            } else {
                const randomIndex = Math.floor(Math.random() * wordgame_gameState.wordPool.length);
                wordgame_gameState.currentWord = wordgame_gameState.wordPool[randomIndex];
                wordgame_gameState.wordPool.splice(randomIndex, 1);
                wordgame_gameState.seenWords.push(wordgame_gameState.currentWord);
                wordgame_gameState.isWordSeen = false;
            }
        }
    
        wordgame_elements.wordDisplay.textContent = wordgame_gameState.currentWord;
        wordgame_gameState.currentWordIndex++;
        wordgame_updateUI();
    }
    
    function wordgame_answerSeen() {
        wordgame_checkAnswer(true);
    }
    
    function wordgame_answerNew() {
        wordgame_checkAnswer(false);
    }
    
    function wordgame_checkAnswer(userSaidSeen) {
        if (!wordgame_gameState.isPlaying) return;
    
        const correct = userSaidSeen === wordgame_gameState.isWordSeen;
    
        if (!correct) {
            wordgame_gameState.errors++;
            if (wordgame_gameState.errors >= wordgame_gameConfig.maxErrors) {
                wordgame_endGame(false, 'Troppi errori!');
                return;
            }
        }
    
        wordgame_showNextWord();
    }
    
    function wordgame_endGame(success, message) {
        wordgame_gameState.isPlaying = false;
        clearInterval(wordgame_gameState.timer);
    
        wordgame_elements.gameScreen.style.display = 'none';
        wordgame_elements.resultScreen.style.display = 'block';
    
        let finalMessage = success ? 'YOU WON THE MINIGAME!' :
            (wordgame_gameState.timeLeft <= 0 ? 'TIME IS UP' : 'MINIGAME FAILED');
    
        wordgame_elements.resultTitle.textContent = finalMessage;
        wordgame_elements.resultTitle.className = `result-title ${success ? 'success' : 'failure'}`;
        wordgame_elements.resultStats.innerHTML = '';
    
        setTimeout(() => {
            wordgame_closeGame();
        }, 2000);
    
        $.post(`https://${GetParentResourceName()}/wordgame/gameResult`, JSON.stringify({
            success: success,
            wordsCompleted: wordgame_gameState.currentWordIndex - 1,
            totalWords: wordgame_gameConfig.totalWords,
            errors: wordgame_gameState.errors,
            maxErrors: wordgame_gameConfig.maxErrors,
            timeLeft: wordgame_gameState.timeLeft,
            reason: message
        }));
    }
    
    function wordgame_closeGame() {
        wordgame_elements.gameContainer.style.display = 'none';
        $.post(`https://${GetParentResourceName()}/wordgame/closeGame`, JSON.stringify({}));
    }
    
    function wordgame_updateUI() {
        wordgame_elements.timeLeft.textContent = wordgame_gameState.timeLeft;
        wordgame_elements.wordCount.textContent = wordgame_gameState.currentWordIndex - 1;
        wordgame_elements.totalWords.textContent = wordgame_gameConfig.totalWords;
        wordgame_elements.errors.textContent = wordgame_gameState.errors;
        wordgame_elements.maxErrors.textContent = wordgame_gameConfig.maxErrors;
    
        const progress = ((wordgame_gameState.currentWordIndex - 1) / wordgame_gameConfig.totalWords) * 100;
        wordgame_elements.progressBar.style.width = `${Math.max(0, progress)}%`;
    }
})