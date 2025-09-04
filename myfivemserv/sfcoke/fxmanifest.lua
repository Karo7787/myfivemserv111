fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'scriptsfivem.com'
description 'Coke'
version '1.0.0'

client_scripts{
    'client.lua',
    'client_editable.lua',
} 
server_script {
    'config_server.lua',
    'server.lua',
    'server_editable.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'server_editable.lua',
    'client_editable.lua',
    'config.lua',
    'config_server.lua',
    'install-need-data/*',
}
dependency '/assetpacks'