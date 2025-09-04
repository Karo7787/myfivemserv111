fx_version 'adamant'

game 'gta5'

description 'HHFW AI Doc'
lua54 'yes'
version '0.1.0'


client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}

shared_scripts {
    "@ox_lib/init.lua"
}