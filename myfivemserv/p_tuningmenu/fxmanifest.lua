fx_version 'cerulean'
game 'gta5'
author 'piotreq [discord.gg/piotreqscripts]'
description 'Tuning Menu'
lua54 'yes'

ui_page 'web/index.html'

files {
    'locales/*.json',
    'web/index.html',
    'web/style.css',
    'web/app.js',
    'web/img/*.svg',
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/stations.lua'
}

client_scripts {
    'editable/client.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'editable/server.lua',
    'server/*.lua',
}

escrow_ignore {
    'shared/config.lua',
    'shared/stations.lua',
    'client/stations.lua',
    'editable/client.lua',
    'editable/server.lua',
    'shared/config_en.lua'
}
dependency '/assetpacks'