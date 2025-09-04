function throttle(func, limit) {
    let timeoutId = null;
    let lastRan = 0;

    return function(...args) {
        const now = Date.now();
        const timeElapsed = now - lastRan;

        if (timeElapsed >= limit) {
            func(...args);
            lastRan = now;
        } else {
            clearTimeout(timeoutId);
            timeoutId = setTimeout(() => {
                func(...args);
                lastRan = Date.now();
            }, limit - timeElapsed);
        }
    };
}

const updateSoundBar = throttle(function(data) {
    const soundLevelElement = document.getElementById('soundLevel');
    const soundBarElement = document.querySelector('.sound-bar');

    const noiseLevel = Math.min(Math.max(data.noiseLevel, 0), 100);
    soundLevelElement.style.width = `${noiseLevel}%`;

    if (noiseLevel < 33) {
        soundBarElement.setAttribute('data-noise-level', 'low');
    } else if (noiseLevel < 66) {
        soundBarElement.setAttribute('data-noise-level', 'medium');
    } else {
        soundBarElement.setAttribute('data-noise-level', 'high');
    }
}, 150);

window.addEventListener('message', ({ data }) => {
    if (data.action === 'updateBar') updateSoundBar(data);
    else if (data.action === 'toggleBar') document.querySelector('.sound-bar').style.display = data.show ? 'block' : 'none';
});
