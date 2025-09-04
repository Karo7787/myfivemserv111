fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.0.7'

client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { 
	'config/config.vehicles.lua', 
	'config/config.lua',  
	'config/config.client.lua',
	'client/client.lua',
}

server_scripts {
	'config/config.vehicles.lua',
	'config/config.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
	'config/config.server.lua',
}
ui_page 'html/ui.html'
files {
	'html/**/*.*',
	'html/*.*',
	'config/translation.js'
}
exports {
	'GeneratePlate' 
}
dependency '/assetpacks'