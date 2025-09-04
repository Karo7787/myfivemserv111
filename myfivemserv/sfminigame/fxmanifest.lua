fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sfminigame'
author 'scriptsfivem.com'
version '1.0.0'
description 'Minigame'


client_scripts{
    'client.lua',
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
    'ui/style.css',
    'ui/script.js',
    'ui/config.js',
}

exports {
    "startGame"
}
dependency '/assetpacks'