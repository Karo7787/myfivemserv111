-- Generated automaticly by RB Generator.
fx_version('cerulean')
games({ 'gta5' })
lua54 'yes'
ui_page "web/ui.html"

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    "config.lua",
    'client/hud.lua',
    'client/carhud.lua',
    'client/seatbelt.lua',
    'client/scoreboard.lua',
    'client/radialmenu.lua',
    'client/bodycam.lua',
    'client/main.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "config.lua",
    'server/scoreboard.lua',
    'server/clothes.lua',
    'server/bodycam.lua',
    'server/radialmenu.lua'
}

files {
    'web/*.js',
    'web/*.html',
    'web/*.css',
    'web/*.mp3',
    'web/*.ogg',
    'web/**/*.svg',
    'web/**/*.png'
}