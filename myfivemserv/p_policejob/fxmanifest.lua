fx_version 'cerulean'
game 'gta5'
author 'pScripts [tebex.pscripts.store] [discord.gg/piotreqscripts]'
description 'Advanced Police Job'
version '2.5.0'
lua54 'yes'

dependencies {
    'ox_lib',
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/config.band.lua',
    'shared/config.heli.lua',
    'shared/config.bodycam.lua',
    'shared/config.evidence.lua',
    'shared/config.extras.lua',
    'shared/config.gps.lua',
    'shared/config.interactions.lua',
    'shared/config.jail.lua',
    'shared/config.mugshot.lua',
    'shared/config.objects.lua',
    'shared/config.radar.lua',
    'shared/config.speedcam.lua',
    'shared/config.trunks.lua',
    'shared/config.vests.lua',
    'shared/config.tackle.lua',
    'shared/config.cameras.lua',
    'shared/config.garage.lua',
    'shared/config.radio.lua',
    'shared/config.vehicleshop.lua',
    'shared/config.megaphone.lua',
    'shared/config.tickets.lua',
    'shared/config.clamp.lua',
    'shared/config.impound.lua',
}

client_scripts {
    'modules/inventory/client/*.lua',
    'modules/client/*.lua',
    'modules/bridge/client/*.lua',
    'modules/target/*.lua',
}

server_scripts {
    'modules/inventory/server/*.lua',
    'shared/config.webhooks.lua',
    '@oxmysql/lib/MySQL.lua',
    'modules/server/*.lua',
    'modules/bridge/server/*.lua',
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/radar.html',
    'web/app.js',
    'web/style.css',
    'web/sounds/*.ogg',
    'web/images/*.jpg',
    'web/images/*.png',
    'web/images/*.webp',
    'locales/*.json',
    'trunks.json',
    'stream/meta/*.meta'
}

escrow_ignore {
    'modules/bridge/client/esx.lua',
    'modules/bridge/client/qb.lua',
    'modules/bridge/client/qbox.lua',
    'modules/bridge/server/esx.lua',
    'modules/bridge/server/qb.lua',
    'modules/bridge/server/qbox.lua',
    'modules/client/divingsuit.lua',
    'modules/client/editable_functions.lua',
    'modules/client/handsup.lua',
    'modules/client/street.lua',
    'modules/inventory/client/ak47_inventory.lua',
    'modules/inventory/client/codem-inventory.lua',
    'modules/inventory/client/core_inventory.lua',
    'modules/inventory/client/jpr-inventory.lua',
    'modules/inventory/client/origen_inventory.lua',
    'modules/inventory/client/ox_inventory.lua',
    'modules/inventory/client/ps-inventory.lua',
    'modules/inventory/client/qb-inventory.lua',
    'modules/inventory/client/qs-inventory.lua',
    'modules/inventory/client/tgiann-inventory.lua',
    'modules/inventory/server/ak47_inventory.lua',
    'modules/inventory/server/codem-inventory.lua',
    'modules/inventory/server/core_inventory.lua',
    'modules/inventory/server/jpr-inventory.lua',
    'modules/inventory/server/origen_inventory.lua',
    'modules/inventory/server/ox_inventory.lua',
    'modules/inventory/server/ps-inventory.lua',
    'modules/inventory/server/qb-inventory.lua',
    'modules/inventory/server/qs-inventory.lua',
    'modules/inventory/server/tgiann-inventory.lua',
    'modules/server/editable_functions.lua',
    'modules/server/editable_logs.lua',
    'modules/server/interactions.lua',
    'modules/server/vehicleshop.lua',
    'modules/target/ox_target.lua',
    'modules/target/qb-target.lua',
    'shared/config.band.lua',
    'shared/config.bodycam.lua',
    'shared/config.cameras.lua',
    'shared/config.clamp.lua',
    'shared/config.evidence.lua',
    'shared/config.extras.lua',
    'shared/config.garage.lua',
    'shared/config.gps.lua',
    'shared/config.impound.lua',
    'shared/config.interactions.lua',
    'shared/config.jail.lua',
    'shared/config.lua',
    'shared/config.megaphone.lua',
    'shared/config.mugshot.lua',
    'shared/config.objects.lua',
    'shared/config.radar.lua',
    'shared/config.radio.lua',
    'shared/config.speedcam.lua',
    'shared/config.tackle.lua',
    'shared/config.tickets.lua',
    'shared/config.trunks.lua',
    'shared/config.vehicleshop.lua',
    'shared/config.vests.lua',
    'shared/config.webhooks.lua',
}

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_lumberjack_wood_pack.ytyp'
-- CREDITS TO PROPS https://bzzz.tebex.io/

data_file 'DLC_ITYP_REQUEST' 'stream/prop_trackingband_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/e_ducktape.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/e_ch.ytyp.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/clamp.ytyp'
data_file "DLC_ITYP_REQUEST" 'stream/cuffs_main.ytyp'

data_file 'WEAPONCOMPONENTSINFO_FILE' '**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' '**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' '**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' '**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE' '**/weapons.meta'

provide 'wasabi_police'
provide 'qb-smallresources'
provide 'qb-policejob'
provide 'qbx_police'
dependency '/assetpacks'