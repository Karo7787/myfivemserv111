fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts {
	'@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua',
	'client/*.lua'
}

server_scripts {
    'config.lua',
    '@es_extended/imports.lua',
	'server/main.lua'
}

dependencies {
    '/server:5848',
    '/onesync',
}
---- Loads all ytyp files for custom props to stream ---
data_file 'DLC_ITYP_REQUEST' 'stream/taymckenzienz_rpemotes.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/brummie_props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/apple_1.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/kaykaymods_props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/knjgh_pizzas.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/natty_props_lollipops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/ultra_ringcase.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/pata_props.ytyp'