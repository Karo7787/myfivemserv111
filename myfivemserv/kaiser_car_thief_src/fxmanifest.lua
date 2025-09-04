fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'kaiser car thief'

version '1.0.0'

server_scripts {
	'server.lua',
	'config.lua',
	'server_your_functions.lua',
	'@mysql-async/lib/MySQL.lua',
	
}

client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { 'config.lua', 'client.lua' }

dependency '/assetpacks'
escrow_ignore {
	'client.lua',
	'config.lua',	
	'server.lua',
	'config.lua',
	'server_your_functions.lua'
}	
