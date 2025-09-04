-- Generated automaticly by RB Generator.
fx_version('cerulean')
games({ 'gta5' })
lua54 'yes'

shared_scripts({
    "Config.lua"
})

server_scripts({
    "server/main.lua"
});

client_scripts({
    "client/main.lua"
});

escrow_ignore {
    "Config.lua",
}