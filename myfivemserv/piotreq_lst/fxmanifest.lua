fx_version 'cerulean'
game 'gta5'
author 'pScripts'
description 'LST - General Mechanic Tablet [tebex.pscripts.store]'
lua54 'yes'

ui_page 'web/index.html'

files {
    'locales/*.json',
    'web/index.html',
    'web/script/*.js',
    'web/style.css',
    'web/img/*.png',
    'web/img/*.svg',
}

client_scripts {
    'client/main.lua',
    'client/dispatch.lua',
    'editable/client.lua'
}

server_scripts {
    'server/main.lua',
    'server/dispatch.lua',
    'editable/server.lua',
    '@oxmysql/lib/MySQL.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

escrow_ignore {
    'config.lua',
    'editable/client.lua',
    'editable/server.lua'
}

dependencies {
    'ox_lib', 
    'piotreq_jobcore',
    '/server:7290'
}
dependency '/assetpacks'