fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version "1.0.1"

client_scripts {    
    'shared/pappu.lua',
    'shared/config.lua',
    'bridge/client/cl_core.lua',
    'bridge/client/cl_main.lua',
    'bridge/client/cl_radio.lua'
}

server_scripts {
    'shared/pappu.lua',
    'shared/config.lua',
    'bridge/server/**.lua',
}

ui_page 'nui/pappu.html'

files {
    'nui/*',
	'nui/pappu.html',
	'nui/style.css',
	'nui/index.js',
    'nui/files/*.png',
    'nui/files/*.jpg',
    'nui/fonts/*.ttf',
    'nui/fonts/*.otf'
}
