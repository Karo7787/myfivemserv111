fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Riisimies'
description 'https://riisimies.tebex.io'
version '1.0.2'

client_scripts {
	'client/cl_main.lua',
	'client/cl_custom.lua',
}

server_scripts {
	'server/sv_main.lua',
	'server/sv_custom.lua',
	'server/sv_functions.lua',
	'server/sv_updater.lua',
}

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua'
}

files {
	'locales/*.json',
}

escrow_ignore {
	'client/cl_custom.lua',
	'server/sv_custom.lua',
	'locales/*.json',
	'config.lua',
}

dependencies {
	'ox_lib',
}

dependency '/assetpacks'