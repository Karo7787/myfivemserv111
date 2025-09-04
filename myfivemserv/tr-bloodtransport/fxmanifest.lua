fx_version 'cerulean'
game 'gta5'

name "tr-bloodtransport"
description "Transport blood for ems"
author "TrolekGaming"
version "0.1Beta"
lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}
files {
	"locales/*.json"
}