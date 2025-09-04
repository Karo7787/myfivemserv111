fx_version "cerulean"
game "gta5"
lua54 "yes"

author "XenoS, MXC"

shared_scripts {
    '@ox_lib/init.lua',
    "config.lua",
    "config_functions.lua",
    "shared/*.lua",
}

client_scripts {
    "@utility_lib/client/native.lua",
    "client/internal_api.lua",
    "client/functions/*.lua",
    "client/internal_modules/*.lua",
    "client/modules/*.lua",
    "client/events.lua",
    "client/main.lua",
}

server_scripts {
    "@utility_lib/server/native.lua",
    "server/internal_api.lua",
    "server/functions.lua",
    "server/modules/*.lua",
    "server/cooldown.lua",
    "server/main.lua",
}

files {
    "audio/*.*",
    'stream/**.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'

escrow_ignore {
    "config.lua",
    "config_functions.lua",
}
dependency '/assetpacks'