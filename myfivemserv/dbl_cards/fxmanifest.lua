fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

escrow_ignore {
    'config.lua'
}
dependency '/assetpacks'