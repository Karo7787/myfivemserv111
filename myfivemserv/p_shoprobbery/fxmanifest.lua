fx_version 'cerulean'
game 'gta5'
author 'pScripts - [tebex.pscripts.store]'
description 'Shop Robbery'
lua54 'yes'

client_scripts {
    'client/*.lua',
    'bridge/client/*.lua'
}

server_scripts {
    'server/*.lua',
    'bridge/server/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

files {'locales/*.json'}


escrow_ignore {
    'config.lua',
    'server/logs.lua',
    'bridge/client/esx.lua',
    'bridge/client/qb.lua',
    'bridge/server/esx.lua',
    'bridge/server/qb.lua',
    'client/target.lua'
}
dependency '/assetpacks'