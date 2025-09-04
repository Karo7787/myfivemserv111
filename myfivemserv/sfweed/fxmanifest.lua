fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'scriptsfivem.com'
description 'Weed plants'
version '1.0.4'

client_scripts{
    'client.lua',
    'client_editable.lua',
} 
server_script {
    'places.lua',
    'server.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

exports {
    'rollWeed',
}

escrow_ignore {
    'client_editable.lua',
    'config.lua',
    'places.lua',
    'install-need-data/*',
}
dependency '/assetpacks'