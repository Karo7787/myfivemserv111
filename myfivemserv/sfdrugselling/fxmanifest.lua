fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'scriptsfivem.com'
description 'Drug selling'
version '1.0.3'

client_scripts{
    'client.lua',
    'client_editable.lua',
}

server_script {
    'server_editable.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'client_editable.lua',
    'server_editable.lua',
    'config.lua',
}
dependency '/assetpacks'