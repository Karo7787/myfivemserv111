fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '1.0'

shared_scripts {
	'shared/sh_config.lua',
}

client_scripts {
    'client/*.lua',
}
server_scripts {
    'server/*.lua',
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
	'html/js/*.js',
	'html/css/*.css',
	'html/images/*.png',
	'html/images/*.jpg',
	'html/audios/*.mp3',
}

dependencies {
	'screenshot-basic'
}




escrow_ignore {
    'client/*.lua',
	'shared/sh_config.lua',
	
	}
dependency '/assetpacks'