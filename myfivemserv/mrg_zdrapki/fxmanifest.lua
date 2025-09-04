fx_version "bodacious"
games {"gta5"}

client_script '@dbl_loader/c_loader.lua'
server_script '@dbl_loader/s_loader.lua'

my_data 'client_files' { 'client.lua' }

server_scripts {
    'server.lua'
}

ui_page('html/index.html')

files {
    'html/index.html',
	'html/styles.css',
	'html/scripts.js',
	'html/img/gwin1.png',
	'html/img/gwin2.png',
	'html/img/gwin3.png',
	'html/img/gwin4.png',
	'html/img/gwin5.png',
	'html/img/gwin6.png',
	'html/img/gwin7.png',
	'html/img/gloss1.png',
	'html/img/gloss2.png',
	'html/img/gloss3.png',
	'html/img/swin1.png',
	'html/img/swin2.png',
	'html/img/swin3.png',
	'html/img/swin4.png',
	'html/img/swin5.png',
	'html/img/swin6.png',
	'html/img/swin7.png',
	'html/img/sloss1.png',
	'html/img/sloss2.png',
	'html/img/sloss3.png',
}