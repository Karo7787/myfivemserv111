fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sfcrafting'
author 'scriptsfivem.com'
version '1.0.6'
description 'Fully customizable and simple table for crafting new items'

dependencies {
	'oxmysql',
    'ox_lib',
}
client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { 'encrypted/craftingtables.lua' }
client_scripts {
	"client.lua",
}

server_scripts {
	"server.lua",
    "server_editable.lua",
}

shared_scripts {
    'encrypted/craftingtables.lua',
    'config.lua',
    '@ox_lib/init.lua'
}

ui_page "html/index.html"

files {
    "config.js",
    "html/index.html",
    "html/plus.png",
    "html/bootstrap.min.css",
    "html/style.css",
    "html/vue.min.js",
    "html/script.js",
    "html/jquery.min.js",
    "html/popper.min.js",
    "html/bootstrap.min.js"
}

escrow_ignore {
    'server_editable.lua',
    'config.lua',
    'config.js', 
}
dependency '/assetpacks'