fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
}

client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { 
	'config.lua',
	'client/client.lua'
}


server_scripts {
    'config.lua',
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua'
}


ui_page 'web/index.html'

files {
    'locales/*.json',
    'web/index.html',
    'web/app.js',
    'web/style.css',
    'web/img/*.png'
}

dependency '/assetpacks'