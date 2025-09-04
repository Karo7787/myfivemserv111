fx_version 'cerulean'
game 'gta5'
author 'pScripts - tebex.pscripts.store'
description 'Advanced Mechanic Job'
lua54 'yes'

ui_page 'web/index.html'

files {
    'locales/*.json',
    'web/index.html',
    'web/style.css',
    'web/app.js',
    'stream/meta/carvariations.meta',
    'stream/meta/vehicles.meta',
    'stream/def_flatbed3_props.ytyp',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/config.nitro.lua',
    'shared/config.pushcar.lua',
    'shared/config.lifters.lua',
    'shared/config.interactions.lua',
    'shared/config.stashes.lua',
    'shared/config.mileage.lua',
    'shared/config.spawner.lua'
}

client_scripts {
    'client/*.lua',
    'bridge/client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
    'bridge/server/*.lua'
}

data_file 'VEHICLE_METADATA_FILE' 'stream/meta/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'stream/meta/carvariations.meta'
data_file 'DLC_ITYP_REQUEST' 'stream/def_flatbed3_props.ytyp'

escrow_ignore {
    'shared/config.lua',
    'shared/config.interactions.lua',
    'shared/config.lifters.lua',
    'shared/config.mileage.lua',
    'shared/config.nitro.lua',
    'shared/config.pushcar.lua',
    'shared/config.spawner.lua',
    'shared/config.stashes.lua',
    'bridge/client/esx.lua',
    'bridge/client/qb.lua',
    'bridge/client/qbox.lua',
    'bridge/server/esx.lua',
    'bridge/server/qb.lua',
    'bridge/server/qbox.lua',
    'client/editable.lua',
    'server/editable.lua'
}
dependency '/assetpacks'