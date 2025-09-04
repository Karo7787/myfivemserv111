fx_version 'cerulean'
game 'gta5'
author 'MirageRP [TrolekGaming]'
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}
ui_page "html/index.html"
client_scripts {
    "modules/**/client.lua",
    'core/client.lua'
}

server_scripts {
    "modules/**/server.lua",
    'core/server.lua'
}

files {
    "locales/*.json",
	"html/index.html",
	"html/sounds/*.mp3"
}

dependencies {
    'ox_lib', 
}