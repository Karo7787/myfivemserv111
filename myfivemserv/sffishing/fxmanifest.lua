fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sffishing'
author 'scriptsfivem.com'
version '1.1.0'
description 'Simple fishing system.'

dependencies {
    'oxmysql',
    'ox_lib'
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

ui_page 'ui/index.html'

files {
    'config.js',
    'ui/index.html',
    'ui/bootstrap.min.css',
    'ui/style.css',
    'ui/vue.min.js',
    'ui/script.js',
    'ui/jquery.min.js',
    'ui/popper.min.js',
    'ui/bootstrap.min.js',
    'ui/alamosea.png',
    'ui/cassidy.png',
    'ui/damlake.png',
    'ui/ocean.png',
    'ui/pier.png',
    'ui/vinewood.png',
    'ui/nodata.png',
}

escrow_ignore {
    'install-need-data/*',
    'client_editable.lua',
    'server_editable.lua',
    'config.lua',
    'config.js',
}
dependency '/assetpacks'