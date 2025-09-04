fx_version 'cerulean'
game 'gta5'
author 'piotreq'
description 'NPC'
lua54 'yes'

client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { 'config.lua', "client/main.lua" }

server_scripts {
    'config.lua',
    'server/*.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}