fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sftaxi'
author 'scriptsfivem.com'
version '1.0.2'
description 'Taxi job.'

dependencies {
    'oxmysql',
    'sfjob',
}

client_scripts {
	'client.lua',
    'client_editable.lua',
}

server_scripts {
    'server_editable.lua',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

escrow_ignore {
    'client_editable.lua',
    'server_editable.lua',
    'config.lua',
    'install-need-data/*',
}

dependency '/assetpacks'