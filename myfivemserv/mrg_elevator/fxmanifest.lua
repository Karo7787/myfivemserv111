fx_version 'adamant'
lua54 'yes'
game 'gta5'

shared_scripts {
	'@ox_lib/init.lua',
    '@es_extended/imports.lua',
	'config.lua'
}
client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { 
	'config.lua',
	'client.lua'
}