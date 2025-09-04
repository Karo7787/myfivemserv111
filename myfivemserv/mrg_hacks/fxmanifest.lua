fx_version "adamant"

game "gta5"

files {
    "ui/index.html",
    "ui/assets/**/*.mp3",
    "ui/assets/**/*.ogg",
    "ui/assets/**/*.gif",
    "ui/assets/**/*.png",
    "ui/scripts/*.js",
    "ui/index.html",
    "ui/style.css"
}

ui_page "ui/index.html"

data_file "AUDIO_GAMEDATA" "sounds/dlcheist3_game.dat"
data_file "AUDIO_SOUNDDATA" "sounds/dlcheist3_sounds.dat"
data_file "AUDIO_WAVEPACK" "sounds/dlcheist3"

client_scripts {
    "client/client.lua",
    "script/**/client.lua",
}
