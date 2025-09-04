fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua',
    'client_editable.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server.lua'
}

ui_page "web/build/index.html"

files {
    "web/build/index.html",
    "web/build/css/*.css",
    "web/build/js/*.js",
    "web/images/buttons/*.svg",
    "web/images/components/*.svg",
}

escrow_ignore {
       'config.lua',
       "web/build/index.html",
       "web/build/css/*.css",
       "web/build/js/*.js",
       "web/images/buttons/*.svg",
       "web/images/components/*.svg",
}
dependency '/assetpacks'