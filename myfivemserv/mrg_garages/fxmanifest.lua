fx_version "cerulean"
game 'gta5'
lua54 'yes'

ui_page 'web/build/index.html'

files {
	'web/build/index.html',
	'web/build/**/*',
  'web/vehicles/*.png',
  'config.lua',
  'client/utils.lua',
}

shared_scripts {
  '@ox_lib/init.lua',
  '@es_extended/imports.lua'
}

client_scripts {
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  'client/client.lua'
}
server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua'
}