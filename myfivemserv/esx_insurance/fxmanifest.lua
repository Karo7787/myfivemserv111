
fx_version 'bodacious'
game 'gta5'
lua54 'yes'

client_scripts {
	'@es_extended/locale.lua',
	'locates/pl.lua',
    'client/client.lua',
    'config.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locates/pl.lua',
	'server/server.lua',
	'config.lua'
}
server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }