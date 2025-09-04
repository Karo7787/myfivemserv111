-- Generated automaticly by RB Generator.
fx_version('cerulean')
games({ 'gta5' })
lua54 'yes'

shared_scripts({
    '@ox_lib/init.lua',
})

server_scripts({
    "server/main.lua"
});

ui_page 'html/index.html'

client_scripts({
    "client/main.lua",
    "client/entity_view.lua",
    "client/spectate.lua",
    "client/blips-names.lua",
    "client/noclip.lua"
});

files {
    'locales/*.json',
    'html/*'
}

dependencies {
    'oxmysql',
    'ox_lib'
}

escrow_ignore {
    "locales/*.json",
}