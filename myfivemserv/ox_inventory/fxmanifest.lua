
fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'
name 'ox_inventory'
author 'Overextended'
version '2.33.1'
repository 'https://github.com/overextended/ox_inventory'
description 'Slot-based inventory with item metadata support'

dependencies {
    '/server:6116',
    '/onesync',
    'oxmysql',
    'ox_lib',
}

shared_script '@ox_lib/init.lua'

ox_libs {
    'locale',
    'table',
    'math',
}
client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { "data/encrypted/shops.lua", "data/encrypted/items.lua" }
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'data/encrypted/shops.lua',
    "data/encrypted/items.lua",
    'init.lua'
}

client_script 'init.lua'

ui_page 'web/build/index.html'

files {
    'client.lua',
    'server.lua',
    'locales/*.json',
    'web/build/index.html',
    'web/build/assets/*.js',
    'web/images/icons/*.png',
    'web/images/icons/damage/*.png',
    'web/build/assets/*.css',
    'web/images/*.png',
    'modules/**/shared.lua',
    'modules/**/client.lua',
    'modules/bridge/**/client.lua',
    'data/*.lua',
}

escrow_ignore {
    'server.lua',
    'locales/*.json',
    'modules/**/shared.lua',
    'modules/**/client.lua',
    'modules/**/server.lua',
    'modules/**/containers.lua',
    'modules/bridge/**/client.lua',
    'data/*.lua',
    'init.lua'
}


