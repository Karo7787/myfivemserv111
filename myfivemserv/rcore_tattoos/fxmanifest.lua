fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'Isigar <info@rcore.cz> & Kralik'
description 'rcore_tattoos complete tattoo system'
version '2.3.3'

ui_page 'client/html/index.html'

files {
    'client/html/style/*.css',
    'client/html/style/fonts/*.ttf',
    'client/html/style/fonts/fonts.css',
    'client/html/style/themes/*.css',
    'client/html/*.html',
    'client/html/js/*.js',
    'client/html/img/*.png',
    'assets/tattooLists/*.json',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/lib/*.lua',
    'sconfig.lua',
    'server/api/*.lua',
    'server/init/*.lua',
    'server/*.lua',
    'server/business/*.lua',
    'server/migration/**/*.lua',
}

client_scripts {
    'client/api/*.lua',
    'client/init/_framework.lua',
    'client/init/init.lua',
    'client/lib/*.lua',
    'client/lib/business/*.lua',
    'client/*.lua',
    'client/business/*.lua',
    'utils/MenuAPI/client/exports/*.lua',
    'utils/MenuAPI/client/system/*.lua',
    'utils/MenuAPI/client/module/*.lua',
    'utils/MenuAPI/client/*.lua',
}

shared_scripts {
    'config_events.lua',
    'shared/*.lua',
    'locales/*.lua',
    'config.lua',
    'config_business.lua',
    'config_permissions.lua',
}

escrow_ignore {
    'client/init/_framework.lua',
    'client/api/*.lua',
    'server/api/*.lua',
    'server/lib/*.lua',
    'client/lib/**/*.lua',
    'locales/*.lua',
    'config.lua',
    'config_business.lua',
    'config_events.lua',
    'config_permissions.lua',
    'sconfig.lua',
    'shared/*.lua',
    'server/migration/types/*.lua',
    'server/init/initBusiness.lua',
    'server/business/money.lua',
}

dependency '/assetpacks'