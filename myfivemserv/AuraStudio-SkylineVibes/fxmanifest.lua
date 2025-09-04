fx_version 'cerulean'
game 'gta5'

author 'Aura Studio'
description 'Skyline Vibes'
version '2.0.0'

this_is_a_map 'yes'


shared_script {
	"config.lua",
}

client_scripts {
	'client/client.lua',
}

ui_page {
	'html/index.html'
}

files {
	'html/index.html',
	'html/app.js',
	'html/main.css',
	-- 'html/sounds/*.ogg',
	'html/sound/*.mp3',
	'html/img/*.webp',
	'audio/skyline_game.dat151.rel'
}

escrow_ignore {
	'config.lua',
}  

data_file 'AUDIO_GAMEDATA' 'audio/skyline_game.dat' 

lua54 'on'

dependency '/assetpacks'