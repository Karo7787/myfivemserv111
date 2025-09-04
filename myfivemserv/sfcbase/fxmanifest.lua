fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sfcbase'
author 'scriptsfivem.com'
version '1.0.1'
description 'Bases for the organization'

client_scripts {
	"client.lua",
	"client_editable.lua",
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua',
	'server_editable.lua',
}

shared_scripts {
	'@ox_lib/init.lua',
	"config.lua",
}

exports {
	'findGarage',
}

server_exports {
	'checkPlayerInZone',
    'getIdBase',
}

escrow_ignore {
    'config.lua',
	'client_editable.lua',
	'server_editable.lua',
	'install-need-data/*',
}
dependency '/assetpacks'