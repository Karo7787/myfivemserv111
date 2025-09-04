
const config = {
    "ImageCount": 71,
    "startVolume": 20,
    "songs": [
        "lnsNlnbvxyo"
    ],
    "buttons" : [
        {
            "icon" : "discord",
            "url" : "https://discord.com/invite/mirageroleplay",
            "description" : "Nasz serwer discord!"
        },
        {
            "icon" : "youtube",
            "url" : "https://www.youtube.com/channel/UC1US4d3j9Ey3MmFxiZZRrfg",
            "description" : "Nasz YouTube!"
        },
        {
            "icon" : "tiktok",
            "url" : "https://www.tiktok.com/@naszmirage",
            "description" : "Nasz TikTok!"
        }
    ]
}


let currentLayer = 0;
let currentImage = getRandomIntFrom1To(config.ImageCount);
let CurrentSound = 0
let MusicPaused = false

function getRandomIntFrom1To(max) {
    return Math.floor(Math.random() * max) + 1;
}

let playedsongs = []

const layers = [
  document.querySelector('.layer1'),
  document.querySelector('.layer2')
];
const volumeElement = document.getElementById("volume");
let volume = config.startVolume / 100
volumeElement.style.height = volume * 100 + "%"

layers[currentLayer].style.backgroundImage = `url('assets/${currentImage}.png')`;
layers[currentLayer].style.opacity = 1;

let tag = document.createElement("script");
tag.src = "https://www.youtube.com/iframe_api";
document.body.appendChild(tag);

let player;

function onYouTubeIframeAPIReady() {
    player = new YT.Player("player", {
        height: "1",
        width: "1",
        videoId: "", // zostaw puste, ustawimy później
        playerVars: {
            autoplay: 1,
            controls: 0,
            modestbranding: 1,
            rel: 0,
            showinfo: 0,
        },
        events: {
            onReady: () => playRandom()
        }
    });
}

function playRandom() {
    if (playedsongs.length === config.songs.length) {
        playedsongs = [];
    }

    const availableSongs = config.songs.filter(song => !playedsongs.includes(song));

    const randomIndex = Math.floor(Math.random() * availableSongs.length);
    const randomID = availableSongs[randomIndex];

    player.loadVideoById(randomID);

    playedsongs.push(randomID);

    player.setVolume(volume * 100);
}
addButtons()

let imagesshowed = []
function checkImage(fileName, callback) {
    const img = new Image();
    img.src = fileName;
    img.onload = () => callback(true, img);
    img.onerror = () => callback(false);
}

setInterval(() => {
    if (imagesshowed.length === config.ImageCount) {
        imagesshowed = [];
    }

    let newImage;
    let attempts = 0;
    const maxAttempts = 100;

    do {
        newImage = Math.floor(Math.random() * config.ImageCount) + 1;
        attempts++;
    } while (
        (newImage === currentImage || imagesshowed.includes(newImage)) &&
        attempts < maxAttempts
    );

    if (attempts >= maxAttempts) {
        imagesshowed = [];
    }

    const imagePath = `assets/${newImage}.png`;

    checkImage(imagePath, (exists, img) => {
        if (!exists) return;

        currentImage = newImage;
        imagesshowed.push(currentImage);

        const nextLayer = 1 - currentLayer;

        // Poczekaj, aż obraz się załaduje, zanim przypiszesz tło
        setTimeout(() => {
            layers[nextLayer].style.backgroundImage = `url('${imagePath}')`;
            layers[nextLayer].style.opacity = 1;

            setTimeout(() => {
                layers[currentLayer].style.opacity = 0;
                currentLayer = nextLayer;
            }, 50);
        }, 1000);
    });
}, 5000);

let screen = document.querySelector('.main');
let end = false
window.onload = () => {
	screen = document.querySelector('main');
}
window.addEventListener('message', (event) => {
    if( event.data.eventName === 'loadProgress' ){
        document.getElementById('progress').style.width = event.data.loadFraction * 100 + "%"
    }   

    const item = event.data;

    if (item.event === 'end') {
        end = true
        screen.style.opacity = 0
        var fadeout = setInterval(
          function() {
            if (volume > 0) {
                volume -= 0.01;
                volumeElement.style.height = volume * 100 + "%"
                player.setVolume(volume * 100);
            }
            else {
              clearInterval(fadeout);
            }
          }, 50);
    }
})

window.addEventListener("wheel", (event) => {
    updateVolume( event.deltaY ) 
})

function updateVolume( delta ){
    if(!end){
        if( delta > 0 && volume >= 0.1 ){
            volume -= 0.1;
        }else if( delta < 0 && volume <= 0.9 ){
            volume += 0.1;
        }
    
        volumeElement.style.height = volume * 100 + "%"
        player.setVolume( volume * 100)
    }
}


function addButtons(){
    const buttons = document.getElementById("buttons")

    config.buttons.forEach( button => {
        const buttonElement = document.createElement("div")
        buttonElement.className = "button"

        const icon = document.createElement("i")
        icon.className = "fab fa-" + button.icon + " fa-lg"

        const iconCaret = document.createElement("i")
        iconCaret.className = "fas fa-caret-down caret"

        const descElement = document.createElement("div")
        descElement.className = "description"
        descElement.innerText = button.description

        buttonElement.addEventListener("click", () => {
            window.invokeNative('openUrl', button.url )
        })

        buttonElement.append(icon)
        buttonElement.append(iconCaret)
        buttonElement.append(descElement)
        buttons.appendChild(buttonElement)
    });
}