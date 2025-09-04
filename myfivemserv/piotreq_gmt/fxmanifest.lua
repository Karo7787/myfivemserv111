fx_version 'cerulean'
game 'gta5'
author 'piotreq'
description 'GMT [tebex.pscripts.store]'
lua54 'yes'

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/script/*.js',
    'web/style.css',
    'web/img/*.png',
    'web/img/*.svg',
    'locales/*.json'
}

client_scripts {
    'client/main.lua',
    'client/dispatch.lua',
    'editable/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/dispatch.lua',
    'editable/server.lua',
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