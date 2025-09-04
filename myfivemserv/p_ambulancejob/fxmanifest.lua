fx_version 'cerulean'
game 'gta5'
author 'pScripts - [tebex.pscripts.store]'
description 'Advanced Ambulance Job'
lua54 'yes'

ui_page 'web/index.html'

files {
    'locales/*.json',
    'web/index.html',
    'web/style.css',
    'web/mirage.js',
    'web/images/*.png',
    'web/images/*.svg',
    'web/sounds/*.ogg',
    'data/vehicles.meta',
	'data/carvariations.meta',
	'data/handling.meta'
}

shared_scripts {
    '@es_extended/imports.lua', -- YOU CAN DELETE IF YOU USE QB/QBOX
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/config.lockers.lua',
    'shared/config.beds.lua',
    'shared/config.interactions.lua',
    'shared/config.elevators.lua',
    'shared/config.spawner.lua',
    'shared/config.missions.lua',
    'shared/config.stretcher.lua',
    'shared/config.medicbag.lua',
    'shared/config.damages.lua',
    'shared/config.blood.lua',
    'shared/config.paramedic.lua',
    'shared/config.wheelchairs.lua',
    'shared/config.gps.lua'
}

client_scripts {
    'client/*.lua',
    'bridge/client/*.lua',
    'compat/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
    'bridge/server/*.lua',
}

escrow_ignore {
    'shared/config.lua',
    'shared/config.beds.lua',
    'shared/config.blood.lua',
    'shared/config.damages.lua',
    'shared/config.elevators.lua',
    'shared/config.interactions.lua',
    'shared/config.lockers.lua',
    'shared/config.medicbag.lua',
    'shared/config.missions.lua',
    'shared/config.paramedic.lua',
    'shared/config.spawner.lua',
    'shared/config.stretcher.lua',
    'shared/config.wheelchairs.lua',
    'shared/config.gps.lua',
    'bridge/client/esx.lua',
    'bridge/client/qb.lua',
    'bridge/client/qbox.lua',
    'bridge/server/esx.lua',
    'bridge/server/qb.lua',
    'bridge/server/qbox.lua',
    'server/lockers.lua',
    'server/editable.lua'
}

-- CREDITS https://www.gta5-mods.com/vehicles/wheelchair-add-on-sp-fivem
data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'
dependency '/assetpacks'