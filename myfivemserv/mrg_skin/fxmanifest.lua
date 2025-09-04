fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '0.5.0'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua', --// Must be used for callbacks and library things
}

client_scripts {
    "locales/locales.lua",
    "locales/pl.lua",

    "shared/config.lua",
    "shared/config.clothes.lua",
    "shared/config.shops.lua",
    "shared/config.menu.lua",
    "shared/config.options.lua",
    "client/skin.lua",
    "client/main.lua",
    "client/shops.lua",
    "client/exports.lua"
}
server_scripts {
    '@oxmysql/lib/MySQL.lua', --// Use this SQL system for better optimization and functions
    "locales/locales.lua",
    "locales/pl.lua",

    "shared/config.lua",
    "shared/config.clothes.lua",
    "shared/config.shops.lua",
    "shared/config.menu.lua",
    "shared/config.options.lua",
    'server/main.lua',
    "server/commands.lua"
}

ui_page {'web/build/index.html'}

files {
	'web/build/index.html',
	'web/build/**/*',
}

dependencies {
    'oxmysql', -- Required for proper operation of tablet queries. Also supported "mysql-async".
    'ox_lib',
    '/server:4752', -- ⚠️PLEASE READ⚠️ This requires at least server build 4700 or higher
}

provide {'esx_skin', 'skinchanger', 'qb-clothing'}
