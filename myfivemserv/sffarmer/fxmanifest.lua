fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sffarmer'
author 'scriptsfivem.com'
version '1.0.5'
description 'Farmer job.'

dependencies {
    'oxmysql',
    'ox_lib',
    'sfjob'
}

client_scripts {
	'client.lua',
    'client_editable.lua',
}

server_scripts {
	'server.lua',
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

data_file 'DLC_ITYP_REQUEST' 'luno_props.ytyp'

dependency '/assetpacks'