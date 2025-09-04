fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'sfctab'
author 'scriptsfivem.com'
version '1.2.7'
description 'The criminals tablet for your FiveM server'

dependencies {
	'oxmysql',
}

client_scripts {
    'client.lua',
}
client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'
my_data 'client_files' { 'client_editable.lua' }
shared_scripts {
	'@ox_lib/init.lua',
    'config.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server.lua',
    'server_editable.lua',
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

exports{
	'getMyGroup',
    'getMyGrade',
}

server_exports {
    'getGroupPlayer',
    'getGradePlayer',
    'setFailedMission',
    'setSuccessMission',
    'removeGroup',
}

escrow_ignore {
    'config.lua',
    'server_editable.lua',
    'config.js',
}
dependency '/assetpacks'