fx_version 'cerulean'
games { 'gta5' }

shared_script '@es_extended/imports.lua'

client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { 
    'config.lua',
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    "server/*.lua"
}