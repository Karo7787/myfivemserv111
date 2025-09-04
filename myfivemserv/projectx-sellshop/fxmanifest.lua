fx_version "cerulean"
game 'gta5'
author 'Project X'
description 'Project X Sellshop'
version '0.0.1'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua',
    'locales/*.lua',
}

client_scripts {
    'opensource/client/*.lua',
    'encrypted/client/*.lua',
}

server_scripts {
    'config/logs.lua',
    'opensource/server/*.lua',
    'encrypted/server/*.lua',
}

escrow_ignore {
    'config/*.lua',
    'locales/*.lua',
    'opensource/client/*.lua',
    'opensource/server/*.lua',
}

dependency '/assetpacks'