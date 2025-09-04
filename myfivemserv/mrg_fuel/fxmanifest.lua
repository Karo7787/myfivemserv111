fx_version 'bodacious'
game 'gta5'
description 'Miro Fuel System'
version '1.0'
lua54 'yes'
shared_script '@es_extended/imports.lua'
client_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'functions/functions_client.lua',
	'source/fuel_client.lua'
}
server_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'source/fuel_server.lua'
}
exports {
	'GetFuel',
	'SetFuel'
}
ui_page 'html/ui.html'
files {
  'html/ui.html',
  'html/*.otf',
  'html/*.png',
  'html/*.js'
}

provide 'dbl_fuel'
