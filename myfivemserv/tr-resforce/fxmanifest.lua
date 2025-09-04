fx_version('cerulean')
games({ 'gta5' })

server_scripts({
    '@oxmysql/lib/MySQL.lua',
    "server.lua"
});
client_scripts({
    "client.lua"
});