fx_version 'adamant'
game 'gta5'
shared_script '@es_extended/imports.lua'
server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server.lua'
}
client_scripts {
    'client.lua'
}
dependencies {
	'mysql-async'

}