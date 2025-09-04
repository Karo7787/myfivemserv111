fx_version "bodacious"
game "gta5"
lua54 'yes'
loadscreen 'html/index.html'
loadscreen_cursor 'yes'

client_script 'client.lua'
files {
	'html/index.html',
	'html/*.js',
	'html/*.css',
	'html/assets/*.png',
	'html/assets/*.svg',
}
loadscreen_manual_shutdown 'yes'