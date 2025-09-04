fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sfjobtab'
author 'scriptsfivem.com'
version '1.1.6'
description 'Job tablet for your FiveM server'

dependencies {
	'oxmysql',
    'sfjob',
}

client_scripts {
    'client.lua',
}

server_scripts {
	'server.lua',
}

shared_scripts {
    'config.lua',
}

ui_page 'ui/index.html'

files {
    'config.js',
    'ui/index.html',
    'ui/bootstrap.min.css',
    'ui/style.css',
    'ui/vue.min.js',
    'ui/mirage.js',
    'ui/jquery.min.js',
    'ui/popper.min.js',
    'ui/bootstrap.min.js'
}

escrow_ignore {
    'config.lua',
    'config.js'
}
dependency '/assetpacks'